# Resumen Ejecutivo - PagoPrestamoCB

## Índice de Documentación

1. [Resumen Ejecutivo](01-ResumenEjecutivo.md)
2. [Comparativa entre Regiones](02-ComparativaRegiones.md)
3. [Ejemplos y Mapeos - HN01](03-EjemplosYMapeos-HN01.md)
4. [Diagrama de Secuencia - HN01](04-Secuencia-HN01.mmd)
5. [Flujo Multiregión](05-FlujoMultiregión.mmd)
6. [Listado de Ficheros](06-ListadoFicheros.md)

---

## 1. Propósito de la Funcionalidad

**PagoPrestamoCB** es un servicio de Oracle Service Bus (OSB) diseñado para procesar pagos de préstamos a través de corresponsales bancarios (Banking Correspondents). El servicio actúa como intermediario entre canales externos (aplicaciones móviles, web, corresponsales) y el sistema de caja interno (MiddlewareCaja) que ejecuta las transacciones de pago de préstamos en el core bancario.

### Funcionalidades Principales:
- Recepción de solicitudes de pago de préstamos desde corresponsales bancarios
- Validación de servicios regionales y parametrización de corresponsales
- Control de cuotas de uso de servicio por usuario
- Registro y actualización de estados de transacciones
- Transformación de mensajes entre el formato de entrada y el formato interno de caja
- Enrutamiento regional basado en el país de origen (HN01, GT01, PA01)
- Manejo centralizado de errores con mapeo de códigos

---

## 2. Entradas y Salidas Principales

### 2.1. Entrada Principal (Request)

**Endpoint OSB:**
```
/SMiddleware/OperationsAndExecution/Payments/PagoPrestamoCB
```

**Protocolo:** SOAP/HTTPS

**Estructura del Request:**

**Header (RequestHeader):**
```xml
<RequestHeader>
    <Authentication>
        <UserName>string</UserName>
        <Password>string</Password>
    </Authentication>
    <Region>
        <SourceBank>string (HN01, GT01, PA01)</SourceBank>
    </Region>
    <BankingCorrespondent>
        <Id>string</Id>
        <PointOfSale>string</PointOfSale>
        <SubPointOfSale>string</SubPointOfSale>
    </BankingCorrespondent>
</RequestHeader>
```

**Body (pagoPrestamo):**
```xml
<pagoPrestamo>
    <LOAN_NUMBER>string (Número de préstamo)</LOAN_NUMBER>
    <PAYMENT_AMOUNT>string (Monto del pago)</PAYMENT_AMOUNT>
    <PAYMENT_CURRENCY>string (Moneda: HNL, GTQ, USD, etc.)</PAYMENT_CURRENCY>
    <PAYMENT_TYPE>string (Tipo de pago: CASH, ACCOUNT_DEBIT, etc.)</PAYMENT_TYPE>
    <DEBIT_ACCOUNT>string (Opcional - Cuenta de débito)</DEBIT_ACCOUNT>
    <CHEQUE_NUMBER>string (Opcional - Número de cheque)</CHEQUE_NUMBER>
    <BANK_CODE>string (Opcional - Código de banco)</BANK_CODE>
    <INTERFACE_REFERENCE_NO>string (Opcional - Referencia de interfaz)</INTERFACE_REFERENCE_NO>
    <TRANSACTION_ID_BC>string (ID de transacción del corresponsal)</TRANSACTION_ID_BC>
</pagoPrestamo>
```

### 2.2. Salida Principal (Response)

**Header (ResponseHeader):**
```xml
<ResponseHeader>
    <successIndicator>string (SUCCESS, ERROR)</successIndicator>
    <messages>string (Mensaje descriptivo)</messages>
    <transactionId>string (ID de transacción generado)</transactionId>
</ResponseHeader>
```

**Body (pagoPrestamoResponse):**
```xml
<pagoPrestamoResponse>
    <DATE_TIME>string</DATE_TIME>
    <LOAN_NUMBER>string</LOAN_NUMBER>
    <DUE_ID>string</DUE_ID>
    <PAYMENT_CURRENCY>string</PAYMENT_CURRENCY>
    <PAYMENT_AMOUNT>string</PAYMENT_AMOUNT>
    <PAYMENT_SUBTOTAL_AMOUNT>string</PAYMENT_SUBTOTAL_AMOUNT>
    <PAYMENT_ADVANCE>string</PAYMENT_ADVANCE>
    <LOAN_CUSTOMER_NAME>string</LOAN_CUSTOMER_NAME>
    <INTEREST_RATE>string</INTEREST_RATE>
    <EFFECTIVE_DATE>string</EFFECTIVE_DATE>
    <MATURITY_DATE>string</MATURITY_DATE>
    <INTEREST_BALANCE>string</INTEREST_BALANCE>
    <CURRENT_PRINCIPAL_BALANCE>string</CURRENT_PRINCIPAL_BALANCE>
    <PREVIOUS_PRINCIPAL_BALANCE>string</PREVIOUS_PRINCIPAL_BALANCE>
    <BILL_NUMBER>string</BILL_NUMBER>
    <RTEFORM>string</RTEFORM>
    <PAYMENT_DETAILS>
        <DETAIL_RECORD>
            <LABEL>string</LABEL>
            <VALUE>string</VALUE>
        </DETAIL_RECORD>
        <!-- Múltiples registros de detalle -->
    </PAYMENT_DETAILS>
</pagoPrestamoResponse>
```

---

## 3. Sistemas/Servicios OSB Involucrados

### 3.1. Proxy Services

| Servicio | Ruta | Descripción |
|----------|------|-------------|
| **PagoPrestamoCB** | `Middleware/v2/SProxyServices/PagoPrestamoCB.proxy` | Proxy principal que expone el servicio de pago de préstamos |

### 3.2. Business Services

| Servicio | Ruta | Tipo | Descripción |
|----------|------|------|-------------|
| **PagoPrestamoCB** | `Middleware/v2/BusinessServices/OSB/PagoPrestamoCB/biz/PagoPrestamoCB.biz` | SOAP/HTTP | Servicio que invoca al sistema de caja para ejecutar el pago |
| **actualizaEstadoTransaccion_db** | `Middleware/v2/BusinessServices/MDW/ActualizaEstadoTransaccion/biz/actualizaEstadoTransaccion_db.biz` | DB Adapter | Actualiza el estado de la transacción en BD |
| **registraEstadoTransaccion_db** | `Middleware/v2/BusinessServices/MDW/registraEstadoTransaccion/biz/registraEstadoTransaccion_db.biz` | DB Adapter | Registra la transacción inicial en BD |
| **ValidaServicioRegional_db** | `Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db.biz` | DB Adapter | Valida que el servicio esté habilitado para la región |
| **consultarCorresponsalB_db** | `Middleware/v2/BusinessServices/MDW/consultarCorresponsalB/biz/consultarCorresponsalB_db.biz` | DB Adapter | Consulta la parametrización del corresponsal bancario |
| **registrarUsoServicio_db** | `Middleware/Business_Resources/general/Resources/RegistrarUsoServicio/registrarUsoServicio_db.biz` | DB Adapter | Registra y controla el uso del servicio por usuario |
| **MapeoErrores** | `Middleware/v2/ProxyServices/MapeoErrores.proxy` | Proxy Service | Mapea códigos de error internos a mensajes de usuario |

### 3.3. Bases de Datos y Stored Procedures

| Base de Datos | Esquema | Package | Stored Procedure | Descripción |
|---------------|---------|---------|------------------|-------------|
| **ConnectionCollections** | COLLECTIONS | OSB_P_MANEJO_TRANSACCIONES | REGISTRA_TRANSACCION_CANAL | Registra la transacción en el canal |
| **ConnectionCollections** | COLLECTIONS | OSB_P_MANEJO_TRANSACCIONES | ACTUALIZA_ESTADO_TRANSACCION | Actualiza el estado de la transacción |
| **ConnectionMiddleware** | (Default) | - | MW_P_VALIDA_SERVICIO_REGIONAL | Valida que el servicio esté habilitado para la región |
| **ConnectionMiddleware** | (Default) | - | MW_P_VALIDA_CORBAN | Valida la parametrización del corresponsal bancario |
| **ConnectionMiddleware** | (Default) | - | MW_P_REGISTRAR_USO_SERVICIO | Registra y controla cuotas de uso del servicio |

### 3.4. Servicios Externos

| Servicio | Endpoint | Protocolo | Descripción |
|----------|----------|-----------|-------------|
| **PagoPrestamoCaja** | `http://mwinterbanca:8003/MiddlewareCaja/PagoPrestamoCaja` | SOAP/HTTP | Sistema de caja que ejecuta el pago del préstamo en el core bancario |

---

## 4. Riesgos/Limitaciones Conocidas

### 4.1. Riesgos Identificados

1. **Dependencia del Sistema de Caja:**
   - El servicio depende completamente de la disponibilidad del sistema MiddlewareCaja
   - No hay mecanismo de retry automático en caso de fallo
   - Timeout configurado en 0 (sin límite), lo que puede causar bloqueos prolongados

2. **Validación de Tipo de Pago:**
   - Solo se permite el tipo de pago "CASH" en la implementación actual
   - Otros tipos de pago generan error MW-0002
   - Limitación en la flexibilidad de métodos de pago

3. **Manejo de Transacciones:**
   - El registro de transacción se realiza antes de la validación completa
   - Posibles registros huérfanos en caso de validaciones fallidas posteriores
   - No hay mecanismo de compensación automática

4. **Control de Cuotas:**
   - El control de uso de servicio puede bloquear transacciones legítimas si se excede la cuota
   - No hay mecanismo de liberación automática de cuotas en caso de error

5. **Seguridad:**
   - Las credenciales se buscan en el servicio de seguridad LDAP
   - Existe un mecanismo de fail-over que usa las credenciales del request si no se encuentran en LDAP
   - Potencial riesgo de seguridad si las credenciales no están correctamente configuradas

### 4.2. Limitaciones Técnicas

1. **Regionalización:**
   - Solo implementado para HN01 (Honduras)
   - GT01 (Guatemala) y PA01 (Panamá) tienen pipelines vacíos
   - Cualquier otra región genera error MW-0008

2. **Formato de Número de Préstamo:**
   - Se aplica un formateo específico mediante Java Callout (Utilities.FormatearPrestamo)
   - Dependencia de librería Java externa
   - Posible punto de fallo si la librería no está disponible

3. **Transformación de Datos:**
   - El campo DESCRIPTION se sobrescribe con "CODIGO_CORRESPONSAL"
   - El campo REPAY_TYPE se sobrescribe con TRANSACTION_ID_BC
   - Pérdida de información original del request

4. **Manejo de Errores:**
   - Errores específicos (BEA-382505, MW-0001, MW-0002) tienen tratamiento especial
   - Otros errores siguen flujo genérico
   - Posible inconsistencia en el manejo de errores

### 4.3. Limitaciones de Configuración

1. **Endpoint Hardcodeado:**
   - El endpoint del servicio de caja está hardcodeado en el Business Service
   - Dificulta la migración entre ambientes

2. **Timeouts:**
   - Timeout de conexión: 0 (sin límite)
   - Timeout de request: 0 (sin límite)
   - Riesgo de bloqueos indefinidos

3. **Retry:**
   - Retry count: 0 (sin reintentos)
   - Retry interval: 0
   - No hay recuperación automática ante fallos transitorios

---

## 5. Métricas o SLAs

### 5.1. Métricas Configuradas

| Métrica | Valor | Descripción |
|---------|-------|-------------|
| **Monitoring** | Deshabilitado | No se recopilan métricas de rendimiento |
| **Aggregation Interval** | 10 segundos | Intervalo de agregación (si se habilita) |
| **Pipeline Monitoring Level** | Pipeline | Nivel de monitoreo de pipeline |
| **Reporting** | Habilitado | Se generan reportes de uso |
| **Logging Level** | Debug | Nivel de logging detallado |
| **SLA Alerting** | Habilitado (Normal) | Alertas de SLA habilitadas |
| **Pipeline Alerting** | Habilitado (Normal) | Alertas de pipeline habilitadas |

### 5.2. SLAs Implícitos

Aunque no hay SLAs explícitos configurados en el código, se pueden inferir los siguientes requisitos:

1. **Disponibilidad:**
   - El servicio debe estar disponible 24/7 para corresponsales bancarios
   - Dependencia crítica del sistema de caja

2. **Tiempo de Respuesta:**
   - No hay timeout configurado, lo que sugiere que no hay SLA de tiempo de respuesta
   - Recomendación: Establecer timeout de 30-60 segundos

3. **Tasa de Éxito:**
   - No hay métricas configuradas para medir tasa de éxito
   - Recomendación: Implementar monitoreo de tasa de éxito

4. **Capacidad:**
   - Control de cuotas de uso por usuario/servicio
   - Límite no especificado en el código (configurado en BD)

### 5.3. Puntos de Control de Calidad

1. **Validación de Request:**
   - Validación de esquema XML contra XSD
   - Validación de campos obligatorios

2. **Validación de Negocio:**
   - Validación de servicio regional
   - Validación de corresponsal bancario
   - Validación de moneda permitida
   - Validación de tipo de pago

3. **Trazabilidad:**
   - Registro de transacción con estado inicial
   - Actualización de estado al finalizar
   - Logging en nivel debug

4. **Manejo de Errores:**
   - Mapeo de errores a códigos de usuario
   - Liberación de cuotas en caso de error
   - Actualización de estado de transacción en error

---

## 6. Flujo General de Procesamiento

### 6.1. Flujo Exitoso (Happy Path)

1. **Recepción de Request** → Cliente envía solicitud SOAP
2. **Validación de Esquema** → Se valida el XML contra el XSD
3. **Registro de Transacción** → Se registra en BD con estado "REGISTRADO"
4. **Validación Regional** → Se valida que el servicio esté habilitado para la región
5. **Validación de Corresponsal** → Se valida la parametrización del corresponsal
6. **Control de Cuotas** → Se registra el uso del servicio (operación 1 = tomar cuota)
7. **Enrutamiento Regional** → Se enruta según SourceBank (HN01, GT01, PA01)
8. **Transformación de Request** → Se transforma al formato de caja
9. **Invocación a Caja** → Se invoca al servicio PagoPrestamoCaja
10. **Actualización de Estado** → Se actualiza el estado a "TRANSACCION_EXITOSA"
11. **Liberación de Cuota** → Se libera la cuota del servicio (operación 2 = liberar cuota)
12. **Mapeo de Errores** → Se mapean errores si los hay
13. **Respuesta al Cliente** → Se devuelve la respuesta

### 6.2. Flujo de Error

1. **Error en Validación** → Se devuelve error sin tomar cuota
2. **Error en Validación Regional** → Se devuelve error sin tomar cuota
3. **Error en Validación de Corresponsal** → Se devuelve error sin tomar cuota
4. **Error de Cuota Excedida** → Se devuelve error MW-0001 sin liberar cuota
5. **Error en Invocación a Caja** → Se actualiza estado, se libera cuota, se mapea error
6. **Error Genérico** → Se actualiza estado, se libera cuota, se mapea error

---

## 7. Consideraciones para Migración

### 7.1. Puntos Críticos

1. **Implementación Regional:**
   - Solo HN01 está completamente implementado
   - GT01 y PA01 requieren implementación completa

2. **Dependencias Externas:**
   - Sistema de caja (MiddlewareCaja)
   - Base de datos COLLECTIONS
   - Base de datos Middleware
   - Servicio LDAP de seguridad

3. **Configuración de Ambiente:**
   - Endpoints de servicios
   - Cadenas de conexión a BD
   - Credenciales LDAP

### 7.2. Recomendaciones

1. **Implementar Timeouts:**
   - Configurar timeout de conexión: 10 segundos
   - Configurar timeout de request: 60 segundos

2. **Implementar Retry:**
   - Configurar retry count: 2
   - Configurar retry interval: 5 segundos

3. **Habilitar Monitoreo:**
   - Habilitar monitoring para recopilar métricas
   - Configurar alertas de SLA

4. **Completar Implementación Regional:**
   - Implementar lógica para GT01 y PA01
   - Validar diferencias regionales

5. **Mejorar Manejo de Transacciones:**
   - Implementar mecanismo de compensación
   - Mejorar trazabilidad de transacciones

---

## 8. Identificación de Regiones

Basado en el análisis del código fuente, se han identificado las siguientes regiones:

| Código | País | Estado de Implementación | Observaciones |
|--------|------|--------------------------|---------------|
| **HN01** | Honduras | ✅ Completamente Implementado | Pipeline completo con toda la lógica de negocio |
| **GT01** | Guatemala | ⚠️ Parcialmente Implementado | Pipeline vacío, solo enrutamiento |
| **PA01** | Panamá | ⚠️ Parcialmente Implementado | Pipeline vacío, solo enrutamiento |
| **NI01** | Nicaragua | ❌ No Implementado | No hay enrutamiento configurado |

**Nota:** Cualquier región diferente a HN01, GT01 o PA01 genera el error MW-0008: "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"

---

## 9. Código de Servicio

**Service ID:** `FICBCO0211`

Este código identifica el servicio en:
- Validación regional
- Control de cuotas de uso
- Mapeo de errores
- Registro de transacciones

---

**Fecha de Análisis:** 2024
**Versión del Documento:** 1.0
**Analista:** Amazon Q Developer
