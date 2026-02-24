# Resumen Ejecutivo - PagoPrestamo

## Índice de Documentación

1. [Resumen Ejecutivo](01-ResumenEjecutivo.md)
2. [Comparación entre Regiones](02-ComparativaRegiones.md)
3. [Ejemplos y Mapeos - HN01](03-EjemplosYMapeos-HN01.md)
4. [Ejemplos y Mapeos - GT01](03-EjemplosYMapeos-GT01.md)
5. [Ejemplos y Mapeos - PA01](03-EjemplosYMapeos-PA01.md)
6. [Ejemplos y Mapeos - NI01](03-EjemplosYMapeos-NI01.md)
7. [Diagrama de Secuencia - HN01](04-Secuencia-HN01.mmd)
8. [Diagrama de Secuencia - GT01](04-Secuencia-GT01.mmd)
9. [Diagrama de Secuencia - PA01](04-Secuencia-PA01.mmd)
10. [Diagrama de Secuencia - NI01](04-Secuencia-NI01.mmd)
11. [Diagrama de Flujo Multiregión](05-FlujoMultiregión.mmd)
12. [Listado de Ficheros](06-ListadoFicheros.md)

---

## 1. Propósito de la Funcionalidad

La funcionalidad **PagoPrestamo** permite realizar pagos a préstamos bancarios a través de diferentes métodos de pago, incluyendo:

- **Débito de cuenta** (ACCOUNT_DEBIT)
- **Efectivo** (CASH)
- **Cheque de otro banco** (OTHER_BANK_CHEQUE)
- **Cheque propio** (OWN_CHEQUE) - No disponible

El servicio está diseñado para operar en un entorno multiregional, soportando las operaciones bancarias de Honduras (HN01), Guatemala (GT01), Panamá (PA01) y Nicaragua (NI01), con diferentes sistemas core bancarios según la región.

---

## 2. Entradas y Salidas Principales

### 2.1. Request OSB (Entrada)

**Endpoint:** `/SMiddleware/OperationsAndExecution/Payments/PagoPrestamo_v2`

**Protocolo:** SOAP/HTTPS

**Campos Principales:**

```xml
<pagoPrestamo>
    <LOAN_NUMBER>string</LOAN_NUMBER>              <!-- Número de préstamo -->
    <PAYMENT_AMOUNT>string</PAYMENT_AMOUNT>        <!-- Monto del pago -->
    <PAYMENT_TYPE>string</PAYMENT_TYPE>            <!-- Tipo de pago: ACCOUNT_DEBIT, CASH, OTHER_BANK_CHEQUE -->
    <DEBIT_ACCOUNT>string</DEBIT_ACCOUNT>          <!-- Cuenta de débito (opcional) -->
    <CHEQUE_NUMBER>string</CHEQUE_NUMBER>          <!-- Número de cheque (opcional) -->
    <BANK_CODE>string</BANK_CODE>                  <!-- Código de banco (opcional) -->
    <INTERFACE_REFERENCE_NO>string</INTERFACE_REFERENCE_NO> <!-- Referencia de interfaz (opcional) -->
    <DEBIT_CREDIT>string</DEBIT_CREDIT>            <!-- DEBIT o CREDIT (opcional) -->
</pagoPrestamo>
```

**Header:**
```xml
<RequestHeader>
    <Authentication>
        <UserName>string</UserName>
        <Password>string</Password>
    </Authentication>
    <Region>
        <SourceBank>string</SourceBank>            <!-- HN01, GT01, PA01, NI01 -->
        <DestinationBank>string</DestinationBank>
    </Region>
</RequestHeader>
```

### 2.2. Response OSB (Salida)

```xml
<pagoPrestamoResponse>
    <DATE_TIME>string</DATE_TIME>                  <!-- Fecha y hora de la transacción -->
    <LOAN_NUMBER>string</LOAN_NUMBER>              <!-- Número de préstamo -->
    <DUE_ID>string</DUE_ID>                        <!-- ID de cuota -->
    <PAYMENT_AMOUNT>string</PAYMENT_AMOUNT>        <!-- Monto pagado -->
</pagoPrestamoResponse>
```

**Header:**
```xml
<ResponseHeader>
    <successIndicator>string</successIndicator>    <!-- SUCCESS o ERROR -->
    <messages>string</messages>                    <!-- Mensajes de respuesta -->
</ResponseHeader>
```

---

## 3. Sistemas/Servicios OSB Involucrados

### 3.1. Servicios Comunes (Todas las Regiones)

| Servicio | Propósito | Tipo |
|----------|-----------|------|
| **ValidaServicioRegional** | Valida que el servicio esté habilitado para la región | DB Adapter |
| **MapeoErrores** | Mapea códigos de error a mensajes estándar | Proxy Service |
| **ReversarTransaccion** | Reversa transacciones en caso de error | Proxy Service |

### 3.2. Servicios por Región

#### HN01 (Honduras)

| Sistema | Servicio | Propósito |
|---------|----------|-----------|
| **ABANKS** | consultaGeneralPrestamo | Consulta información del préstamo |
| **ABANKS** | sjConsultaProductos | Valida cuenta y préstamo |
| **ABANKS** | ObtenerParametrizacion | Obtiene parámetros de configuración |
| **ABANKS** | transferenciasBS | Realiza transferencia entre cuentas |
| **ABANKS** | debitoPrestamoBS | Realiza débito en efectivo |
| **ABANKS** | depositoCombinadoBS | Realiza depósito con cheque |
| **ABANKS** | pagoPrestamoT24BS | Registra pago en ABANKS |
| **T24** | consultaCuentasBS | Consulta detalles de cuenta |
| **T24** | PrestamosT24BS | Procesa pago de préstamo |
| **T24** | pagoPrestamoT24 | Registra pago en T24 |

#### GT01 (Guatemala)

| Sistema | Servicio | Propósito |
|---------|----------|-----------|
| **ABANKS GT** | PagoPrestamo_db | Stored Procedure: OSB_P_PAGO_PRESTAMO |

#### PA01 (Panamá)

| Sistema | Servicio | Propósito |
|---------|----------|-----------|
| **ABANKS PA** | pagoPrestamo_db | Stored Procedure: OSB_P_PAGO_PRESTAMO |

#### NI01 (Nicaragua)

| Sistema | Servicio | Propósito |
|---------|----------|-----------|
| **COBIS** | prestamo | Servicio SOAP: OpPagarPrestamo |

---

## 4. Riesgos/Limitaciones Conocidas

### 4.1. Riesgos Identificados

1. **Complejidad de Reversión:**
   - En HN01, si falla el registro en ABANKS después de la transferencia, se debe reversar la transacción
   - El proceso de reversión puede fallar, dejando inconsistencias

2. **Dependencia de Múltiples Sistemas:**
   - HN01 requiere coordinación entre T24 y ABANKS
   - Fallas en cualquiera de los sistemas pueden afectar la transacción completa

3. **Validaciones Regionales:**
   - Cada región tiene diferentes validaciones y flujos
   - Errores de configuración regional pueden causar fallos

4. **Tipos de Pago Limitados:**
   - GT01, PA01 y NI01 solo soportan ACCOUNT_DEBIT
   - OWN_CHEQUE no está implementado en ninguna región

### 4.2. Limitaciones Técnicas

1. **Timeout:**
   - No se especifican timeouts explícitos en la mayoría de servicios
   - Puede causar bloqueos en transacciones largas

2. **Manejo de Concurrencia:**
   - No se identifican mecanismos de bloqueo optimista/pesimista
   - Posibles problemas con pagos simultáneos al mismo préstamo

3. **Auditoría:**
   - No se identifica un mecanismo centralizado de auditoría
   - Cada región registra de forma independiente

4. **Monitoreo:**
   - Logging habilitado en nivel DEBUG
   - Puede generar gran volumen de logs en producción

---

## 5. Métricas o SLAs

### 5.1. Configuración de Monitoreo

- **Aggregation Interval:** 720 minutos (12 horas)
- **Pipeline Monitoring Level:** Action
- **Logging Level:** Debug
- **SLA Alerting:** Habilitado (nivel normal)
- **Pipeline Alerting:** Habilitado (nivel normal)

### 5.2. Retry Configuration

**HN01 - ABANKS:**
- **Retry Count:** 1
- **Retry Interval:** 30 segundos
- **Retry Application Errors:** true

**Otras Regiones:**
- No se especifican configuraciones de retry explícitas

### 5.3. Métricas Esperadas (No Encontradas en Código)

Las siguientes métricas deberían ser monitoreadas pero no se encontraron en el código:

- Tiempo promedio de respuesta por región
- Tasa de éxito/fallo por tipo de pago
- Volumen de transacciones por región
- Tasa de reversiones
- Disponibilidad del servicio

---

## 6. Regiones Detectadas

| Código | País | Sistema Core | Estado |
|--------|------|--------------|--------|
| **HN01** | Honduras | T24 + ABANKS | Activo |
| **GT01** | Guatemala | ABANKS | Activo |
| **PA01** | Panamá | ABANKS | Activo |
| **NI01** | Nicaragua | COBIS | Activo |

---

## 7. Flujo General de Operación

### 7.1. Validaciones Iniciales

1. Validación de esquema XSD
2. Validación de servicio regional (FICBCO0076)
3. Aplicación de valores por defecto de región
4. Validación de tipo de préstamo (ABANKS o T24 para HN01)
5. Validación de cruce país-empresa

### 7.2. Procesamiento por Tipo de Pago

#### ACCOUNT_DEBIT (Débito de Cuenta)

1. Consulta de productos (préstamo y cuenta)
2. Validación de monedas
3. Obtención de parámetros de configuración
4. Generación de UUID para transacción
5. Ejecución de transferencia entre cuentas
6. Registro de pago en sistema core
7. Reversión en caso de error

#### CASH (Efectivo)

1. Consulta general de préstamo
2. Validación de moneda (HNL o USD)
3. Generación de UUID
4. Depósito en efectivo según moneda
5. Registro de pago en sistema core
6. Reversión en caso de error

#### OTHER_BANK_CHEQUE (Cheque de Otro Banco)

1. Consulta general de préstamo
2. Obtención de cuenta de depósito según moneda
3. Generación de UUID
4. Depósito combinado (cheque)
5. Registro de pago en sistema core
6. Reversión en caso de error

### 7.3. Manejo de Errores

1. Captura de errores en pipeline de error
2. Mapeo de errores a códigos estándar
3. Construcción de respuesta de error
4. Reversión de transacciones si es necesario
5. Registro en logs

---

## 8. Consideraciones de Migración

### 8.1. Puntos Críticos

1. **Diferencias Regionales:**
   - Cada región tiene su propia implementación
   - Migración debe considerar estas diferencias

2. **Dependencias de Base de Datos:**
   - Stored Procedures específicos por región
   - Esquemas de base de datos diferentes

3. **Integración con Sistemas Core:**
   - T24 (HN01)
   - ABANKS (HN01, GT01, PA01)
   - COBIS (NI01)

4. **Manejo de Transacciones:**
   - Mecanismos de reversión
   - Consistencia transaccional

### 8.2. Recomendaciones

1. Migrar región por región
2. Implementar pruebas exhaustivas de reversión
3. Validar integración con sistemas core
4. Establecer métricas y SLAs claros
5. Implementar monitoreo robusto
6. Documentar diferencias regionales

---

**Fecha de Análisis:** 2024
**Versión del Servicio:** v2
**Service ID:** FICBCO0076
