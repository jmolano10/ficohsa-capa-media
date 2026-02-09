# Resumen Ejecutivo - ConsultaEstadoLoteSoapPS

## Índice de Documentación

1. [Resumen Ejecutivo](01-ResumenEjecutivo.md)
2. [Comparativa entre Regiones](02-ComparativaRegiones.md)
3. [Ejemplos y Mapeos - HN](03-EjemplosYMapeos-HN.md)
4. [Ejemplos y Mapeos - GT](03-EjemplosYMapeos-GT.md)
5. [Ejemplos y Mapeos - NI](03-EjemplosYMapeos-NI.md)
6. [Ejemplos y Mapeos - PA](03-EjemplosYMapeos-PA.md)
7. [Diagrama de Secuencia - HN](04-Secuencia-HN.mmd)
8. [Diagrama de Secuencia - GT](04-Secuencia-GT.mmd)
9. [Diagrama de Secuencia - NI](04-Secuencia-NI.mmd)
10. [Diagrama de Secuencia - PA](04-Secuencia-PA.mmd)
11. [Diagrama de Flujo Multiregión](05-FlujoMultiregión.mmd)
12. [Listado de Ficheros](06-ListadoFicheros.md)

---

## 1. Propósito de la Funcionalidad

**ConsultaEstadoLoteSoapPS** es un servicio SOAP del Oracle Service Bus (OSB) que permite consultar el estado de un lote de pagos masivos. Este servicio actúa como una capa de virtualización (11g) que recibe solicitudes de clientes y las enruta hacia el servicio regional correspondiente (v2) según el banco de origen especificado en el header de autenticación.

El servicio proporciona información detallada sobre:
- Estado del lote de pagos
- Información del cliente
- Cuentas de débito involucradas
- Resumen de pagos por moneda
- Totales de transacciones (exitosas, errores)
- Fecha de aplicación
- Información de procesamiento

## 2. Entradas y Salidas Principales

### 2.1. Entrada Principal (Request)

**Endpoint OSB Virtual 11g:**
```
https://<host>:<port>/regional/massivePayment/soap/getBatchStatus/v11g
```

**Protocolo:** SOAP 1.1 con WSS (WS-Security)

**Estructura del Request:**

**SOAP Header:**
```xml
<RequestHeader xmlns="http://www.ficohsa.com.hn/middleware.services/autType">
    <Authentication>
        <UserName>usuario</UserName>
        <Password>password</Password>
    </Authentication>
    <Region>
        <SourceBank>HN01</SourceBank>
        <DestinationBank>HN01</DestinationBank>
    </Region>
</RequestHeader>
```

**SOAP Body:**
```xml
<consultaEstadoLote xmlns="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes">
    <CUSTOMER_ID>12345</CUSTOMER_ID>
    <BANK_BATCH_ID>98765</BANK_BATCH_ID>
    <UPLOAD_DATE>2024-01-15</UPLOAD_DATE>
</consultaEstadoLote>
```

**Campos de Entrada:**
- `CUSTOMER_ID` (obligatorio): Identificador del cliente
- `BANK_BATCH_ID` (obligatorio): Identificador del lote en el banco
- `UPLOAD_DATE` (opcional): Fecha de carga del lote

### 2.2. Salida Principal (Response)

**SOAP Header:**
```xml
<ResponseHeader xmlns="http://www.ficohsa.com.hn/middleware.services/autType">
    <successIndicator>SUCCESS</successIndicator>
    <messageId>OK</messageId>
    <messages>Operación exitosa</messages>
</ResponseHeader>
```

**SOAP Body:**
```xml
<consultaEstadoLoteResponse xmlns="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes">
    <BANK_BATCH_ID>98765</BANK_BATCH_ID>
    <CUSTOMER_ID>12345</CUSTOMER_ID>
    <CUSTOMER_NAME>Empresa XYZ S.A.</CUSTOMER_NAME>
    <STATUS>PROCESSED</STATUS>
    <STATUS_DESC>Procesado</STATUS_DESC>
    <OPTIMISTIC>YES</OPTIMISTIC>
    <ACCOUNTS>
        <ACCOUNT>
            <DEBIT_ACCOUNT>1234567890</DEBIT_ACCOUNT>
            <AMOUNT>50000.00</AMOUNT>
            <CURRENCY>HNL</CURRENCY>
        </ACCOUNT>
    </ACCOUNTS>
    <PAYMENTS>
        <PAYMENT>
            <CURRENCY>HNL</CURRENCY>
            <TOTAL_AMOUNT>50000.00</TOTAL_AMOUNT>
            <EXCHANGE_RATE>1.00</EXCHANGE_RATE>
        </PAYMENT>
    </PAYMENTS>
    <TOTAL_AMOUNT>50000.00</TOTAL_AMOUNT>
    <TOTAL_AMOUNT_ERROR>0.00</TOTAL_AMOUNT_ERROR>
    <NUMBER_OF_TRANSACTIONS>100</NUMBER_OF_TRANSACTIONS>
    <NUMBER_OF_TRANSACTIONS_SUCCESS>98</NUMBER_OF_TRANSACTIONS_SUCCESS>
    <NUMBER_OF_TRANSACTIONS_ERROR>2</NUMBER_OF_TRANSACTIONS_ERROR>
    <APPLICATION_DATE>2024-01-15T10:30:00</APPLICATION_DATE>
    <PROCESS_INFO>Lote procesado correctamente</PROCESS_INFO>
</consultaEstadoLoteResponse>
```

## 3. Sistemas/Servicios OSB Involucrados

### 3.1. Capa Virtual 11g (Entrada)

**Proxy Service:**
- `ConsultaEstadoLoteSoapPS.proxy`
  - Ubicación: `SBRG_MassivePayment_Commons_Virtual/PS/PagosMasivos/`
  - URI: `/regional/massivePayment/soap/getBatchStatus/v11g`
  - Protocolo: HTTPS con WSS
  - Dispatch Policy: `SBMassivePaymentManager`

**Pipeline:**
- `ConsultaEstadoLotePP.pipeline`
  - Ubicación: `SBRG_MassivePayment_Commons_Virtual/PP/PagosMasivos/`
  - Template: `MassivePaymentRegional11gFicohsaTemplatePG16857`

**Business Service (Salida de Virtual 11g):**
- `GetBatchStatusSoapBS.bix`
  - Ubicación: `SBRG_MassivePayment_Commons_Virtual/BS/PagosMasivos/`
  - URI: `https://mwservices.gfficohsa.hn:8020/regional/massivePayment/soap/getBatchStatus/v1`
  - Timeout: 40 segundos
  - Connection Timeout: 35 segundos

### 3.2. Capa Regional v2 (Intermedia)

**Proxy Service:**
- `GetBatchStatusSoapPS.proxy`
  - Ubicación: `SBRG_MassivePayment_GetBatchStatus/PS/v2/`
  - URI: `/regional/massivePayment/soap/getBatchStatus/v2`
  - Protocolo: HTTPS con Basic Auth over SSL
  - Policy: `oracle/http_basic_auth_over_ssl_service_policy`

**Pipeline:**
- `GetBatchStatusPP.pipeline`
  - Ubicación: `SBRG_MassivePayment_GetBatchStatus/PP/v2/`
  - Template: `MassivePaymentRegionalFicohsaTemplatePG16857`

**Business Service (Salida a País):**
- `GetBatchStatusCountryGenericRestBS.bix`
  - Ubicación: `SBRG_MassivePayment_GetBatchStatus/BS/v2/`
  - URI: `https://mwservices.gfficohsa.hn:8020/country/massivePayment/rest/getBatchStatus/v2`
  - Protocolo: REST con Basic Auth over SSL
  - Timeout: 70 segundos
  - Connection Timeout: 65 segundos

### 3.3. Servicios Auxiliares

**Regionalización:**
- `GetCountryURLByNameRegionalRestBS`
  - Propósito: Obtener la URL del servicio del país según el banco destino
  - Operación: `GetCountryURLByName`

**Logging:**
- `LoggingRegionalRestBS`
  - Propósito: Registrar logs de entrada/salida en filesystem
  - Operación: `SaveLogInFileSystem`

**Manejo de Errores:**
- `GetCustomErrorByStackTraceRegionalRestBS`
  - Propósito: Mapear errores técnicos a errores de negocio
  - Operación: `process`

## 4. Riesgos/Limitaciones Conocidas

### 4.1. Riesgos Identificados

1. **Dependencia de Múltiples Capas:**
   - El servicio atraviesa 3 capas (Virtual 11g → Regional v2 → Country v2)
   - Cada capa añade latencia y puntos de falla potenciales
   - Riesgo de timeout en cadena si algún servicio downstream es lento

2. **Autenticación en Múltiples Niveles:**
   - Virtual 11g: WSS (WS-Security)
   - Regional v2: Basic Auth over SSL
   - Country v2: Basic Auth over SSL
   - Riesgo de falla si las credenciales no están sincronizadas

3. **Transformaciones de Datos:**
   - Múltiples transformaciones XQuery entre capas
   - Riesgo de pérdida de información si los mapeos no son completos
   - Diferencias en estructura de datos entre versiones (11g vs v2)

4. **Enrutamiento Regional:**
   - El enrutamiento depende del campo `SourceBank` en el header
   - Si el valor no coincide con HN, GT, NI o PA, se genera error "INVALID REGION REQUEST"
   - No hay validación previa del formato del código de región

5. **Manejo de Errores:**
   - Los errores se transforman en múltiples puntos
   - Puede ser difícil rastrear el origen real de un error
   - Los mensajes de error pueden perder contexto en las transformaciones

### 4.2. Limitaciones Técnicas

1. **Timeouts Configurados:**
   - Virtual 11g → Regional v2: 40 segundos
   - Regional v2 → Country v2: 70 segundos
   - No hay retry automático configurado

2. **Caché de Resultados:**
   - Habilitado en Business Services (`resultCachingEnabled=true`)
   - No se especifica TTL del caché
   - Puede devolver datos desactualizados

3. **Validación de Esquema:**
   - Solo se valida en la capa Regional v2
   - La capa Virtual 11g no valida el esquema de entrada
   - Errores de formato pueden propagarse hasta capas inferiores

4. **Concurrencia:**
   - Dispatch Policy: `SBMassivePaymentManager`
   - No se especifican límites de concurrencia
   - Riesgo de sobrecarga en picos de demanda

5. **Logging:**
   - Los logs se escriben de forma asíncrona (route, no wsCallout)
   - Si el servicio de logging falla, no afecta la transacción principal
   - Pero puede haber pérdida de trazabilidad

### 4.3. Limitaciones de Negocio

1. **Regiones Soportadas:**
   - Solo soporta: HN (Honduras), GT (Guatemala), NI (Nicaragua), PA (Panamá)
   - Cualquier otra región genera error
   - No hay soporte para multi-región en una sola consulta

2. **Formato de Fecha:**
   - `UPLOAD_DATE` es opcional pero si se envía debe ser formato `xs:date`
   - `APPLICATION_DATE` en respuesta es `xs:dateTime`
   - Inconsistencia en formatos de fecha entre entrada y salida

3. **Paginación:**
   - No hay soporte para paginación en la respuesta
   - Si un lote tiene muchas cuentas o pagos, la respuesta puede ser muy grande
   - Riesgo de timeout o problemas de memoria

4. **Información Limitada:**
   - No devuelve detalle de transacciones individuales
   - Solo devuelve resumen agregado
   - Para detalle se debe usar otro servicio (ConsultaDetalleLote)

## 5. Métricas o SLAs

### 5.1. Métricas Técnicas Detectadas

**Timeouts Configurados:**
- Virtual 11g → Regional v2:
  - Request Timeout: 40 segundos
  - Connection Timeout: 35 segundos
  
- Regional v2 → Country v2:
  - Request Timeout: 70 segundos
  - Connection Timeout: 65 segundos

**Retry Configuration:**
- Retry Count: 0 (sin reintentos automáticos)
- Retry Interval: 0 segundos (Virtual 11g) / 30 segundos (Regional v2)
- Retry Application Errors: false

**Dispatch Policy:**
- `SBMassivePaymentManager` (configuración de thread pool no visible en código)

### 5.2. SLAs Inferidos

Basado en la configuración técnica, se pueden inferir los siguientes SLAs:

**Tiempo de Respuesta Máximo:**
- Escenario exitoso: < 70 segundos (timeout de Regional v2)
- Escenario con error: < 40 segundos (timeout de Virtual 11g)

**Disponibilidad:**
- No se especifica en el código
- Depende de la disponibilidad de 3 capas en cascada
- Disponibilidad estimada: Producto de disponibilidades individuales

**Throughput:**
- No se especifica límite de concurrencia
- Controlado por Dispatch Policy `SBMassivePaymentManager`
- Sin throttling configurado

### 5.3. Métricas de Logging

**Puntos de Logging Identificados:**

1. **Request Logging (Regional v2):**
   - Momento: Antes de validación
   - Información: Body completo, headers, usuario, región
   - Destino: Filesystem vía `LoggingRegionalRestBS`

2. **Response Logging (Regional v2):**
   - Momento: Después de recibir respuesta de Country
   - Información: Body completo, estado, códigos de error
   - Destino: Filesystem vía `LoggingRegionalRestBS`

3. **Error Logging (Regional v2):**
   - Momento: En pipeline de error
   - Información: Fault completo, stack trace, contexto
   - Destino: Filesystem vía `LoggingRegionalRestBS`

4. **Report Logging (Virtual 11g):**
   - Momento: En pipeline de error
   - Información: Error code, reason, UUID
   - Destino: OSB Reports

**Campos Loggeados:**
- `GlobalId` (UUID de transacción)
- `SourceBank` / `DestinationBank`
- `User` / `Channel`
- `Service` / `Operation` / `Version`
- `State` (Success/Error)
- `CodeError` / `MessageError`
- `Endpoint` / `Method` (SOAP/REST)
- `Body` (Request/Response completo)
- `ErrorDetails` (Stack trace serializado)

### 5.4. Métricas No Disponibles

Las siguientes métricas NO están disponibles en el código fuente:

- Límites de throughput (TPS/RPS)
- Percentiles de latencia (P50, P95, P99)
- Tasa de error objetivo
- Uptime/Disponibilidad objetivo
- Límites de tamaño de payload
- Límites de concurrencia por usuario/cliente
- SLAs contractuales con clientes

**Recomendación:** Estas métricas deberían obtenerse de:
- Documentación de arquitectura
- Contratos de servicio (SLA documents)
- Monitoreo de producción (APM tools)
- Configuración de OSB Console

---

## Notas Adicionales

- Este servicio es parte del módulo de Pagos Masivos (Massive Payment)
- Implementa patrón de virtualización para compatibilidad con clientes legacy (11g)
- La arquitectura sigue el patrón: Virtual → Regional → Country
- Cada región (país) puede tener implementaciones específicas en la capa Country
- El servicio está preparado para manejar múltiples monedas y tipos de cambio
