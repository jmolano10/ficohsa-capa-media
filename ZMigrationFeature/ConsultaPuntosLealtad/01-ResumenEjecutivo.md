# Resumen Ejecutivo - ConsultaPuntosLealtad

## Índice de Documentación

1. [Resumen Ejecutivo](01-ResumenEjecutivo.md)
2. [Comparativa entre Regiones](02-ComparativaRegiones.md)
3. Ejemplos y Mapeos por Región:
   - [Honduras (HN01)](03-EjemplosYMapeos-HN01.md)
   - [Guatemala (GT01)](03-EjemplosYMapeos-GT01.md)
   - [Nicaragua (NI01)](03-EjemplosYMapeos-NI01.md)
   - [Panamá (PA01)](03-EjemplosYMapeos-PA01.md)
4. Diagramas de Secuencia por Región:
   - [Honduras (HN01)](04-Secuencia-HN01.mmd)
   - [Guatemala (GT01)](04-Secuencia-GT01.mmd)
   - [Nicaragua (NI01)](04-Secuencia-NI01.mmd)
   - [Panamá (PA01)](04-Secuencia-PA01.mmd)
5. [Diagrama de Flujo Multiregión](05-FlujoMultiregion.mmd)
6. [Listado de Ficheros](06-ListadoFicheros.md)

---

## 1. Propósito de la Funcionalidad

La funcionalidad **ConsultaPuntosLealtad** permite consultar el saldo de puntos de lealtad de clientes en programas de fidelización asociados a tarjetas de crédito y débito. El servicio soporta múltiples programas de lealtad:

- **Programa 1**: Mastercard Rewards (MRS) - Integración con servicio externo de Mastercard
- **Programa 2**: Vision Plus - Sistema de puntos interno de Procesa

La funcionalidad identifica automáticamente el programa de lealtad asociado a la tarjeta del cliente y consulta el saldo correspondiente, con opción de calcular el equivalente en efectivo de los puntos acumulados.

---

## 2. Entradas y Salidas Principales

### Entradas (Request)

**Estructura SOAP con Header y Body:**

**Header (RequestHeader):**
- `Region/SourceBank`: Código del país (HN01, GT01, NI01, PA01)
- Información de autenticación y trazabilidad

**Body (consultaPuntosLealtad):**
- `CUSTOMER_ID_TYPE`: Tipo de identificador del cliente
  - `CARD_NUMBER`: Número de tarjeta (principal)
  - `LEGAL_ID`: Identificación legal (alternativo)
- `CUSTOMER_ID_VALUE`: Valor del identificador
- `RETURN_CASH_EQUIVALENT`: Indicador si se requiere equivalente en efectivo (YES/NO)
- `CASH_REDEMPTION`: Información para cálculo de equivalencia (opcional)
  - `TERMINAL_ID`: ID del terminal
  - `MERCHANT_ID`: ID del comercio
  - `MERCHANT_TYPE`: Tipo de comercio
- `PROGRAM_ID`: ID del programa de lealtad (opcional, solo para casos específicos)

### Salidas (Response)

**Header (ResponseHeader):**
- `successIndicator`: Indicador de éxito (Success/ERROR)
- `messages`: Mensajes de error o validación

**Body (consultaPuntosLealtadResponse):**
- `LEGAL_ID`: Identificación legal del cliente
- `CUSTOMER_NAME`: Nombre del cliente
- `AVAILABLE_POINTS`: Puntos disponibles
- `CASH_EQUIVALENT`: Equivalente en efectivo (si se solicitó)
- `CASH_CURRENCY`: Moneda del equivalente (HNL, GTQ, USD)

---

## 3. Sistemas/Servicios OSB Involucrados

### Proxies OSB

1. **ConsultaPuntosLealtadFacade** (Facade principal)
   - Endpoint: Middleware/v2/ProxyServices/ConsultaPuntosLealtadFacade.proxy
   - Función: Punto de entrada desde T24, transforma y enruta a ProgramaLealtad

2. **Proxies Regionales:**
   - **ConsultaPuntosLealtadHN** (Honduras)
   - **ConsultaPuntosLealtadGT** (Guatemala)
   - **ConsultaPuntosLealtadNI** (Nicaragua)
   - **ConsultaPuntosLealtadPA** (Panamá)

### Business Services

1. **consultaPuntosLealtad_db** (Base de Datos CLIENTDATA)
   - Stored Procedure: `CONSULTA_PUNTOS_LEALTAD`
   - Esquema: CLIENTDATA
   - Conexión: eis/DB/ConnectionClientdata

2. **Servicios de Datos Maestros por Región:**
   - **conDatoCuenta_db** (HN, GT, PA)
   - **sjConsultaTipoTarjetaNI** (NI - Servicio Java)

3. **Servicios de Programas de Lealtad:**
   - **CustomerService** (Mastercard Rewards)
     - Operación: `getPointDetails` / `getRTRPreferences`
   - **visionPlus** (Vision Plus)
     - Operación: `PointsAdjustmentInquiry`

4. **Servicios de Conversión:**
   - **canjearPuntosEfectivo_db** (HN - ABK, GT - ABKGT, NI/PA - PXYNIC)
   - **consultaProgramaLealtad_db** (INTFC)
   - **obtenerTipoProgramaLealtad_db** (INTFC - solo NI)

5. **Servicios de Parametrización:**
   - **ObtenerParametrizacion** (Configuración MRS)

6. **Servicios de Registro:**
   - **registraPuntosLealtad_db** (CLIENTDATA)

### Servicios Externos

1. **Mastercard Rewards Service (MRS)**
   - Proveedor: Mastercard
   - Protocolo: SOAP/HTTPS
   - Autenticación: Header personalizado con Institution Name y AppID

2. **Vision Plus**
   - Proveedor: Procesa
   - Protocolo: SOAP
   - Sistema de puntos interno

---

## 4. Riesgos/Limitaciones Conocidas

### Riesgos Identificados

1. **Dependencia de Servicios Externos:**
   - Mastercard Rewards: Disponibilidad y tiempos de respuesta fuera de control
   - Vision Plus: Dependencia del sistema Procesa

2. **Complejidad de Enrutamiento:**
   - Lógica diferente por región para determinar programa de lealtad
   - Múltiples puntos de fallo en la cadena de llamadas

3. **Gestión de Errores:**
   - Errores de servicios externos no siempre se propagan correctamente
   - Manejo de timeouts no estandarizado

4. **Datos Maestros:**
   - Dependencia crítica de servicios de datos maestros (conDatoCuenta)
   - Inconsistencias en datos de tarjetas pueden causar fallos

### Limitaciones Conocidas

1. **Tipos de Identificación:**
   - Solo soporta `CARD_NUMBER` para consultas
   - `LEGAL_ID` no implementado completamente en todas las regiones

2. **Programas de Lealtad:**
   - Solo soporta 2 programas (MRS y Vision Plus)
   - No hay soporte para otros programas de terceros

3. **Equivalencia en Efectivo:**
   - Cálculo solo disponible si hay puntos disponibles
   - Requiere información adicional de comercio/terminal

4. **Tarjetas de Débito:**
   - En Nicaragua: Solo tarjetas activas pueden consultar puntos
   - Validación adicional de BIN para determinar programa

5. **Caché y Persistencia:**
   - No hay caché de consultas
   - Registro en BD solo si la consulta al SP principal falla

---

## 5. Métricas o SLAs

### Métricas Operacionales

**No se encontraron SLAs explícitos en el código**, pero se identifican las siguientes configuraciones:

1. **Logging:**
   - Nivel: Debug habilitado en todos los proxies
   - Reporting: Habilitado

2. **Alerting:**
   - SLA Alerting: Habilitado (nivel normal)
   - Pipeline Alerting: Habilitado (nivel normal)

3. **Monitoring:**
   - Aggregation Interval: 10 segundos
   - Pipeline Monitoring Level: Pipeline

4. **Throttling:**
   - Deshabilitado en todos los servicios

5. **Retry Configuration:**
   - Retry Count: 0 (sin reintentos automáticos)
   - Retry Interval: 0

### Recomendaciones de SLAs

Basado en la arquitectura identificada, se recomienda establecer:

1. **Tiempo de Respuesta:**
   - Target: < 3 segundos (95 percentil)
   - Máximo: < 5 segundos

2. **Disponibilidad:**
   - Target: 99.5% (considerando dependencias externas)

3. **Tasa de Error:**
   - Target: < 1% de transacciones

4. **Reintentos:**
   - Implementar política de reintentos para servicios externos (1-2 reintentos)

---

## 6. Regiones Detectadas

Las siguientes regiones fueron identificadas en el código:

| Código | País | Proxy Regional | Moneda |
|--------|------|----------------|--------|
| **HN01** | Honduras | ConsultaPuntosLealtadHN.proxy | HNL |
| **GT01** | Guatemala | ConsultaPuntosLealtadGT.proxy | GTQ |
| **NI01** | Nicaragua | ConsultaPuntosLealtadNI.proxy | USD |
| **PA01** | Panamá | ConsultaPuntosLealtadPA.proxy | USD |

---

## 7. Flujo General de la Funcionalidad

```
1. Cliente → ConsultaPuntosLealtadFacade (desde T24)
2. Facade → ProgramaLealtad (enrutamiento interno)
3. ProgramaLealtad → ConsultaPuntosLealtad[Region] (según SourceBank)
4. Proxy Regional:
   a. Validación XSD
   b. Consulta BD (consultaPuntosLealtad_db)
   c. Si no hay datos en BD:
      - Consulta Datos Maestros (conDatoCuenta/sjConsultaTipoTarjeta)
      - Obtiene Parametrización (si aplica)
      - Determina Programa Lealtad (consultaProgramaLealtad_db)
      - Consulta Puntos según programa:
        * Programa 1: Mastercard CustomerService
        * Programa 2: Vision Plus PointsAdjustmentInquiry
      - Calcula Equivalencia Efectivo (si se solicitó)
      - Registra en BD (registraPuntosLealtad_db)
5. Respuesta → Cliente
```

---

## 8. Consideraciones de Migración

### Puntos Críticos

1. **Conexiones a Base de Datos:**
   - Validar conexiones JNDI: `eis/DB/ConnectionClientdata`
   - Verificar permisos de ejecución de SPs

2. **Servicios Externos:**
   - Configurar endpoints de Mastercard Rewards
   - Validar credenciales y certificados
   - Configurar endpoints de Vision Plus

3. **Transformaciones XQuery:**
   - Revisar compatibilidad de funciones XQuery
   - Validar namespaces y prefijos

4. **Manejo de Errores:**
   - Estandarizar códigos de error
   - Implementar logging centralizado

5. **Configuración Regional:**
   - Validar parámetros por región
   - Configurar monedas y factores de conversión

---

**Fecha de Análisis:** 2024
**Versión del Documento:** 1.0
**Analista:** Amazon Q Developer
