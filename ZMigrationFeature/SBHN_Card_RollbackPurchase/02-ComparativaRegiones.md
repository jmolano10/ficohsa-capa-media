# Comparativa entre Regiones - SBHN_Card_RollbackPurchase

## Regiones Identificadas

- **HN01** - Honduras
- **GT01** - Guatemala

---

## Tabla de Comparación

| Aspecto | HN01 (Honduras) | GT01 (Guatemala) |
|---------|-----------------|------------------|
| **Endpoint OSB REST** | `/honduras/card/rest/rollbackPurchase/v1` | `/guatemala/card/rest/rollbackPurchase/v1` (asumido) |
| **Endpoint OSB SOAP** | `/honduras/card/soap/rollbackPurchase/v1` | `/guatemala/card/soap/rollbackPurchase/v1` (asumido) |
| **Nombre de Base de Datos** | PAGOSWSTC | PAGOSWSTC |
| **Esquema BD** | PAGOSWSTC | PAGOSWSTC |
| **Package BD - Consulta Ticket** | OSB_K_RECAUDO_BROKER_HN | OSB_K_RECAUDO_BROKER_GT |
| **Package BD - Actualización Ticket** | OSB_K_RECAUDO_BROKER_HN | OSB_K_RECAUDO_BROKER_GT |
| **Store Procedure - Consulta** | OSB_CONS_BROKER_RECAUDO_TICKET | OSB_CONS_BROKER_RECAUDO_TICKET |
| **Store Procedure - Actualización** | OSB_ACT_BROKER_RECAUDO_TICKET | OSB_ACT_BROKER_RECAUDO_TICKET |
| **Conexión BD** | jca://eis/DB/ConnectionPagosWSTC | jca://eis/DB/ConnectionPagosWSTC |
| **Endpoint Vision+** | http://172.28.1.145:7802/OTWS/v4 | http://172.28.1.146:7802/OTWS/v4 |
| **Operación Vision+** | OnlineUpdateCard | OnlineUpdateCard |
| **Timeout Vision+** | 70 segundos | 70 segundos |
| **Connection Timeout Vision+** | 65 segundos | 65 segundos |
| **Retry Count BD** | 4 intentos | 4 intentos |
| **Retry Backoff BD** | 2 segundos | 2 segundos |
| **Retry Max Interval BD** | 120 segundos | 120 segundos |
| **Retry Application Errors BD** | true | false |
| **Dispatch Policy** | SBCardManager | SBCardManager |
| **Política de Seguridad** | oracle/http_basic_auth_over_ssl_service_policy | oracle/http_basic_auth_over_ssl_service_policy |
| **Template Común** | HondurasCardTemplate | GuatemalaCardTemplate (asumido) |
| **Servicio de Logging** | SBHN_Card_Commons/BS/LoggingRegionalRestBS | SBGT_Card_Commons/BS/LoggingRegionalRestBS (asumido) |
| **Servicio de Errores** | SBHN_Card_Commons/BS/GetCustomErrorByStackTraceRegionalRestBS | SBGT_Card_Commons/BS/GetCustomErrorByStackTraceRegionalRestBS (asumido) |

---

## Sección por Región

### HN01 - Honduras

#### Endpoints OSB

**REST:**
- URI: `/honduras/card/rest/rollbackPurchase/v1`
- Protocolo: HTTPS
- Método: POST
- Política: `oracle/http_basic_auth_over_ssl_service_policy`

**SOAP:**
- URI: `/honduras/card/soap/rollbackPurchase/v1`
- Protocolo: HTTPS
- Política: `oracle/http_basic_auth_over_ssl_service_policy`
- WSDL: `SBHN_Card_RollbackPurchase/Resources/RollbackPurchase.wsdl`
- Binding: `rollbackPurchaseBind`
- Namespace: `https://www.ficohsa.com/honduras/card`

#### Conexiones a Base de Datos

**DBGetStatusTicketAdapter:**
- Conexión JCA: `jca://eis/DB/ConnectionPagosWSTC`
- Esquema: PAGOSWSTC
- Package: OSB_K_RECAUDO_BROKER_HN
- Stored Procedure: OSB_CONS_BROKER_RECAUDO_TICKET
- Parámetros de entrada:
  - PV_TICKET (VARCHAR2)
- Parámetros de salida: 29 campos incluyendo PV_SUCCESSINDICATOR, PV_MESSAGES, datos de la transacción
- Retry: 4 intentos, backoff 2s, max interval 120s
- Retry Application Errors: true

**DBActTicketAdapter:**
- Conexión JCA: `jca://eis/DB/ConnectionPagosWSTC`
- Esquema: PAGOSWSTC
- Package: OSB_K_RECAUDO_BROKER_HN
- Stored Procedure: OSB_ACT_BROKER_RECAUDO_TICKET
- Parámetros de entrada:
  - PV_TICKET (VARCHAR2)
  - PV_ESTADO_TICKET (VARCHAR2) - Valor: 'R' para reversado
- Parámetros de salida:
  - PV_SUCCESSINDICATOR (VARCHAR2)
  - PV_MESSAGES (VARCHAR2)
- Retry: 4 intentos, backoff 2s, max interval 120s
- Retry Application Errors: true

#### Conexión a Vision+

**onlineTransactions_v4:**
- Endpoint: `http://172.28.1.145:7802/OTWS/v4`
- Protocolo: SOAP 1.1
- Operación: OnlineUpdateCard
- Namespace: `http://www.procesa.com/fdcs/ot/v4`
- Timeout: 70 segundos
- Connection Timeout: 65 segundos
- Retry: 0 (sin reintentos)
- Retry Application Errors: true

#### Transformaciones Clave

**RollbackPurchaseToPagosWS.xqy:**
- Entrada: getStatusTicket (Ticket)
- Salida: InputParameters para DBGetStatusTicketAdapter
- Mapeo: Ticket → PV_TICKET

**RollbackPurchaseToOnlinePayment.xqy:**
- Entrada: Datos del ticket consultado
- Salida: OnlinePaymentV4Request para Vision+
- Mapeos clave:
  - sequence → RRN37 (generado con fecha/hora actual)
  - org → OrgId
  - requestType → RequestType ('R' para reversión)
  - creditCard → CardNumber
  - merchant → MerchantNumber
  - expiration → CardExpirationDate
  - payment → TotalSalesAmount
  - Valores fijos: POSUserData='ATX', NumberOfInstallments='00', MCCType='6010'

**RollbackPurchaseToActTicket.xqy:**
- Entrada: getStatusTicket (Ticket)
- Salida: InputParameters para DBActTicketAdapter
- Mapeos:
  - Ticket → PV_TICKET
  - statusTicket ('R') → PV_ESTADO_TICKET

**PagosWSToRollbackPurchase.xqy:**
- Entrada: OutputParameters de DBGetStatusTicketAdapter
- Salida: getStatusTicketResponse (respuesta exitosa)
- Mapeos:
  - PV_SUCCESSINDICATOR → StatusInfo/Status
  - globalId → StatusInfo/GlobalId
  - Fecha/hora actual → ValueDate, DateTime

**ErrorToRollbackPurchase.xqy:**
- Entrada: errorMappingRegionalOutput, datos de error
- Salida: getStatusTicketResponse (respuesta con error)
- Mapeos:
  - ErrorToRollback/code → ErrorInfo/Code
  - ErrorToRollback/error → ErrorInfo/Error
  - ErrorToRollback/description → ErrorInfo/Description
  - messageError o messaggeOnlinePayment → ErrorInfo/Details/Messages

#### Validaciones

1. **Validación de Ticket:**
   - Condición: `$codeErrorGetTicket = 'SUCCESS' and $messageErrorService = ''`
   - Si falla: No se ejecuta reversión en Vision+

2. **Validación de Reversión en Vision+:**
   - Condición: `fn-bea:trim($ActionDescription) = 'APPROVED'`
   - Si falla: No se actualiza el estado del ticket en BD

3. **Validación de Actualización de Ticket:**
   - Condición: `$codeErrorService = 'SUCCESS'`
   - Si falla: Se retorna error pero reversión en Vision+ ya fue ejecutada

#### Manejo de Errores

- Todos los errores se capturan en el error handler del template
- Se invoca GetCustomErrorByStackTraceRegionalRestBS para mapear errores
- Se registra log de error mediante LoggingRegionalRestBS
- Se construye respuesta de error con ErrorToRollbackPurchase.xqy

#### Políticas OSB

- Dispatch Policy: SBCardManager (todos los componentes)
- Security Policy: oracle/http_basic_auth_over_ssl_service_policy
- Load Balancing: round-robin
- Compression: Deshabilitada

---

### GT01 - Guatemala

#### Endpoints OSB

**REST:**
- URI: `/guatemala/card/rest/rollbackPurchase/v1` (asumido por convención)
- Protocolo: HTTPS
- Método: POST
- Política: `oracle/http_basic_auth_over_ssl_service_policy`

**SOAP:**
- URI: `/guatemala/card/soap/rollbackPurchase/v1` (asumido por convención)
- Protocolo: HTTPS
- Política: `oracle/http_basic_auth_over_ssl_service_policy`
- WSDL: `SBGT_Card_RollbackPurchase/Resources/RollbackPurchase.wsdl`
- Binding: `rollbackPurchaseBind`
- Namespace: `https://www.ficohsa.com/guatemala/card` (asumido)

#### Conexiones a Base de Datos

**DBGetStatusTicketAdapter:**
- Conexión JCA: `jca://eis/DB/ConnectionPagosWSTC`
- Esquema: PAGOSWSTC
- Package: **OSB_K_RECAUDO_BROKER_GT** (diferencia con HN)
- Stored Procedure: OSB_CONS_BROKER_RECAUDO_TICKET
- Parámetros: Mismos que HN01
- Retry: 4 intentos, backoff 2s, max interval 120s
- **Retry Application Errors: false** (diferencia con HN)

**DBActTicketAdapter:**
- Conexión JCA: `jca://eis/DB/ConnectionPagosWSTC`
- Esquema: PAGOSWSTC
- Package: **OSB_K_RECAUDO_BROKER_GT** (diferencia con HN)
- Stored Procedure: OSB_ACT_BROKER_RECAUDO_TICKET
- Parámetros: Mismos que HN01
- Retry: 4 intentos, backoff 2s, max interval 120s
- **Retry Application Errors: false** (diferencia con HN)

#### Conexión a Vision+

**onlineTransactions_v4:**
- Endpoint: **`http://172.28.1.146:7802/OTWS/v4`** (IP diferente: .146 vs .145)
- Protocolo: SOAP 1.1
- Operación: OnlineUpdateCard
- Namespace: `http://www.procesa.com/fdcs/ot/v4`
- Timeout: 70 segundos
- Connection Timeout: 65 segundos
- Retry: 0 (sin reintentos)
- **Retry Application Errors: false** (diferencia con HN)

#### Transformaciones Clave

Las transformaciones son idénticas a HN01 en lógica, solo cambian los nombres de archivos:
- RollbackToPagosWS.xqy (vs RollbackPurchaseToPagosWS.xqy)
- RollbackToOnlinePayment.xqy (vs RollbackPurchaseToOnlinePayment.xqy)
- RollbackToActTicket.xqy (vs RollbackPurchaseToActTicket.xqy)
- PagosWSToRollback.xqy (vs PagosWSToRollbackPurchase.xqy)
- ErrorToRollback.xqy (vs ErrorToRollbackPurchase.xqy)

#### Validaciones

Idénticas a HN01

#### Manejo de Errores

Idéntico a HN01, pero usando servicios comunes de SBGT_Card_Commons

#### Políticas OSB

Idénticas a HN01

---

## Diferencias Clave entre Regiones

### 1. Infraestructura

| Componente | HN01 | GT01 |
|------------|------|------|
| IP Vision+ | 172.28.1.145 | 172.28.1.146 |
| Package BD | OSB_K_RECAUDO_BROKER_HN | OSB_K_RECAUDO_BROKER_GT |

### 2. Configuración de Retry

| Servicio | HN01 | GT01 |
|----------|------|------|
| DBGetStatusTicketAdapter - Retry App Errors | true | false |
| DBActTicketAdapter - Retry App Errors | true | false |
| onlineTransactions_v4 - Retry App Errors | true | false |

**Impacto:** En HN01, los errores de aplicación (no de red) también se reintentarán, mientras que en GT01 solo se reintentarán errores de red/conexión.

### 3. Nombres de Archivos

| Tipo | HN01 | GT01 |
|------|------|------|
| Transformaciones | RollbackPurchaseTo*.xqy | RollbackTo*.xqy |
| Carpeta | Transformations | Transformatios (typo) |

### 4. Servicios Comunes

| Servicio | HN01 | GT01 |
|----------|------|------|
| Logging | SBHN_Card_Commons | SBGT_Card_Commons |
| Error Mapping | SBHN_Card_Commons | SBGT_Card_Commons |
| Template | HondurasCardTemplate | GuatemalaCardTemplate (asumido) |

---

## Campos Diferenciadores

### En Request
- **GeneralInfo/SourceBank**: Identifica la región (HN01 o GT01)
- **GeneralInfo/DestinationBank**: Identifica la región destino

### En Response
- No hay campos específicos que diferencien la región en la respuesta
- La diferencia está en el procesamiento interno (package BD, endpoint Vision+)

---

## Errores/Excepciones

### Errores Comunes (Ambas Regiones)

| Código | Descripción | Origen |
|--------|-------------|--------|
| SUCCESS | Operación exitosa | BD/Vision+ |
| ERROR | Error genérico | OSB |
| APPROVED | Reversión aprobada | Vision+ |

### Manejo de Errores Específicos

**Ticket no encontrado:**
- Origen: DBGetStatusTicketAdapter
- Condición: PV_SUCCESSINDICATOR != 'SUCCESS' o PV_MESSAGES != ''
- Acción: No se ejecuta reversión, se retorna error

**Reversión rechazada por Vision+:**
- Origen: onlineTransactions_v4
- Condición: ActionDescription != 'APPROVED'
- Acción: No se actualiza ticket, se retorna error

**Error al actualizar ticket:**
- Origen: DBActTicketAdapter
- Condición: PV_SUCCESSINDICATOR != 'SUCCESS'
- Acción: Se retorna error (pero reversión en Vision+ ya ejecutada)

**Error de comunicación:**
- Origen: Timeout o error de red
- Acción: Se captura en error handler, se mapea error, se registra log

---

## Timeouts/Retries

### HN01

| Componente | Timeout | Retry Count | Retry Interval | Retry App Errors |
|------------|---------|-------------|----------------|------------------|
| Vision+ | 70s | 0 | N/A | true |
| Vision+ Connection | 65s | 0 | N/A | true |
| DBGetStatusTicketAdapter | N/A | 4 | 1-120s (backoff 2) | true |
| DBActTicketAdapter | N/A | 4 | 1-120s (backoff 2) | true |

### GT01

| Componente | Timeout | Retry Count | Retry Interval | Retry App Errors |
|------------|---------|-------------|----------------|------------------|
| Vision+ | 70s | 0 | N/A | false |
| Vision+ Connection | 65s | 0 | N/A | false |
| DBGetStatusTicketAdapter | N/A | 4 | 1-120s (backoff 2) | false |
| DBActTicketAdapter | N/A | 4 | 1-120s (backoff 2) | false |

---

## Dependencias Internas

### HN01
1. **SBHN_Card_Commons/BS/GetCustomErrorByStackTraceRegionalRestBS**
   - Mapeo de errores técnicos a errores de negocio
   
2. **SBHN_Card_Commons/BS/LoggingRegionalRestBS**
   - Registro de logs de entrada/salida
   
3. **SBHN_Card_Commons/PP/HondurasCardTemplate**
   - Template base con flujo común de request/response/error
   
4. **SBHN_Card_Commons/Transformations/ServicesToError**
   - Transformación para construir request de error mapping
   
5. **SBHN_Card_Commons/Transformations/ServiceToLog**
   - Transformación para construir request de logging
   
6. **SBHN_Card_Commons/Schemas/CommonTypes.xsd**
   - Tipos comunes: GeneralInfoType, StatusInfoType, ErrorInfoType

### GT01
1. **SBGT_Card_Commons/BS/GetCustomErrorByStackTraceRegionalRestBS** (asumido)
2. **SBGT_Card_Commons/BS/LoggingRegionalRestBS** (asumido)
3. **SBGT_Card_Commons/PP/GuatemalaCardTemplate** (asumido)
4. **SBGT_Card_Commons/Transformations/ServicesToError** (asumido)
5. **SBGT_Card_Commons/Transformations/ServiceToLog** (asumido)
6. **SBGT_Card_Commons/Schemas/CommonTypes.xsd** (asumido)

---

## Conclusiones

### Similitudes
- Misma lógica de negocio
- Mismos stored procedures (nombres)
- Misma estructura de request/response
- Mismos timeouts
- Misma política de seguridad

### Diferencias Principales
1. **IP de Vision+**: Cada región tiene su propia instancia
2. **Package de BD**: Sufijo regional (_HN vs _GT)
3. **Retry de errores de aplicación**: HN reintentar, GT no
4. **Servicios comunes**: Cada región tiene su propio módulo Commons

### Recomendaciones para Migración
1. Verificar conectividad a ambas instancias de Vision+ (.145 y .146)
2. Validar que los packages de BD existan en ambas regiones
3. Considerar unificar la política de retry (actualmente inconsistente)
4. Validar que los servicios comunes estén disponibles en ambas regiones
5. Revisar si la diferencia en retry de errores de aplicación es intencional
