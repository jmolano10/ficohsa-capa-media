# Historia de Usuario: RollbackPurchaseRestPS

> **Como** Equipo de Integración  
> **Quiero** implementar el servicio de reverso de compras con tarjeta de crédito  
> **Para** permitir la anulación de transacciones de compra realizadas con tarjetas de crédito en los diferentes países de la región

## Criterios de Aceptación

### 1. Campos de Entrada del Servicio

| Campo | Descripción | Requerido | Tipo/Formato |
|-------|-------------|-----------|-----------------|
| **getStatusTicket** | Elemento raíz del request | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **GeneralInfo** | Información general de la transacción | **Sí** | GeneralInfoType |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ SourceBank | Banco origen de la transacción | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ DestinationBank | Banco destino de la transacción | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ GlobalId | Identificador único global de la transacción | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ ApplicationId | Identificador de la aplicación | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ ApplicationUser | Usuario de la aplicación | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ BranchId | Identificador de la sucursal | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ TransactionDate | Fecha de la transacción | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─ Language | Idioma de la respuesta (es/en) | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **Ticket** | Número de ticket de la transacción a reversar | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ **TransactionType** | Tipo de transacción | **Sí** | string |

> **Validaciones:**
> - Se valida la estructura del mensaje contra el esquema XSD RollbackPurchaseTypes.xsd
> - El campo Ticket es obligatorio y debe corresponder a una transacción existente
> - El campo TransactionType debe ser válido según el catálogo de tipos de transacción
> - Se valida el servicio regional para determinar disponibilidad por país

### 2. Campos de Salida del Servicio

| Campo | Descripción | Requerido | Tipo |
|-------|-------------|-----------|------|
| **getStatusTicketResponse** | Respuesta del servicio de reverso de compra | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **StatusInfo** | Información del estado de la transacción | **Sí** | StatusInfoType |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ Status | Estado de la operación | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ TransactionId | Identificador de la transacción | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ ValueDate | Fecha valor | No | date |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ DateTime | Fecha y hora de procesamiento | No | dateTime |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─ GlobalId | Identificador único global | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **ErrorInfo** | Información de errores | **Sí** | ErrorInfoType |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ Code | Código de error | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ Error | Tipo de error | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ Description | Descripción del error | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ ShortDescription | Descripción corta del error | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ DateTime | Fecha y hora del error | No | dateTime |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ GlobalId | Identificador único global | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─ Details | Detalles adicionales del error | No | Complex Type (0..unbounded) |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ Status | Estado del ticket | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ OriginalAgency | Agencia original de la transacción | **Sí** | decimal |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ MerchantNumber | Número de comercio | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ CreditCard | Número de tarjeta de crédito | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ OperationType | Tipo de operación | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ BalanceCurrency | Moneda del balance | **Sí** | decimal |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ Organizations | Organización | **Sí** | decimal |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ TransactionCurrency | Moneda de la transacción | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ ExchangeRate | Tasa de cambio | **Sí** | decimal |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ TransactionType | Tipo de transacción | **Sí** | decimal |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ User | Usuario que realizó la transacción | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ MovementSequence | Secuencia del movimiento | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ OriginalSequence | Secuencia original | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ PaymentAmount | Monto del pago | **Sí** | decimal |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ CheckValue | Valor del cheque | **Sí** | decimal |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ DocumentNumber | Número de documento | **Sí** | decimal |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ CardExpirationDate | Fecha de expiración de la tarjeta | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ CheckType | Tipo de cheque | **Sí** | decimal |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ OriginalBank | Banco original | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ DestinationBank | Banco destino | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ Description | Descripción de la transacción | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ Channel | Canal de la transacción | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ AutorizationNumber | Número de autorización | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ Applied | Indicador de aplicación | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ AppliedOnLine | Indicador de aplicación en línea | **Sí** | string |

> **Nota:** Todos los campos de salida están validados contra el esquema XSD RollbackPurchaseTypes.xsd

## Tareas Técnicas

### 1. Códigos de Error

#### 1.1. Códigos de error del Proveedor

| Código Error | Descripción | Tipo Error |
|--------------|-------------|------------|
| MW-0008 | SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY | Técnico |
| T001 | Connection timeout | Técnico |
| T002 | Read timeout | Técnico |
| T004 | Service unavailable | Técnico |
| B001 | Ticket no encontrado | Negocio |
| B002 | Transacción ya reversada | Negocio |
| B003 | Tipo de transacción inválido | Negocio |

> **Nota:** Los errores son mapeados a través del servicio GetCustomErrorByStackTraceRegionalRestBS y transformados mediante ErrorToRollback.Xquery

### 2. Configuración de Timeout

- **Timeout Business Service:** 70 segundos
- **Timeout de conexión:** 65 segundos
- **Retry count:** 0 (sin reintentos automáticos)

### 3. Datos de Prueba

> **Nota:** Los siguientes son datos de ejemplo no reales, utilizados únicamente para propósitos de testing y documentación.

- **Ticket:** "TKT123456789"
- **TransactionType:** "PURCHASE"
- **SourceBank:** "FICOHSA"
- **DestinationBank:** "FICOHSA"
- **ApplicationUser:** "testuser"
- **BranchId:** "001"

### 4. Datos de Contacto

**Contacto responsable OSB:**
- **David Ruiz** - david.ruiz@ficohsa.com
- **Wilmer Fernandez** - wilmer.fernandez@ficohsa.com  
- **Francia Avila** - francia.avila@ficohsa.com
- **Diego Gomez** - diego.gomez@ficohsa.com

### 5. Lógica Importante

**Flujo Principal del Servicio Regional (SBRG):**
1. **Validación XSD:** Se valida la estructura del mensaje contra el esquema RollbackPurchaseTypes.xsd
2. **Enriquecimiento de GeneralInfo:** El template CardTemplateRG enriquece la información general con datos del contexto (usuario, GlobalId, idioma)
3. **Logging de Request:** Se registra el request mediante el servicio LoggingRegionalRestBS
4. **Validación XSD Específica:** Se valida contra el esquema GetStatusTicketTypes (referenciado en el pipeline)
5. **Regionalización:** Se consulta el servicio GetCountryURLByNameRestBS para obtener la URL del país destino basado en:
   - Servicio: "Card/RollbackPurchase"
   - Versión: "v1"
   - Key: "Ticket"
   - DestinationBank del request
6. **Validación de Disponibilidad:** Si el servicio no está implementado para el país (responseRegional = "N/A"), se genera error MW-0008
7. **Invocación al Backend:** Se invoca el Business Service RollbackPurchaseRestBS con routing dinámico usando la URL obtenida
8. **Extracción de Estado:** Se extraen los campos StatusInfo/Status, ErrorInfo/Code y ErrorInfo/Description del response
9. **Logging de Response:** Se registra el response mediante LoggingRegionalRestBS
10. **Manejo de HTTP Status Code:** Si el método es REST y el estado no es SUCCESS, se establece el código HTTP del error
11. **Manejo de Errores:** En caso de error:
    - Se registra en logs mediante report
    - Se consulta GetCustomErrorByStackTraceRegionalRestBS para mapeo de errores
    - Se transforma el error mediante ErrorToRollback.Xquery
    - Se establece el código HTTP de error en el response
    - Se registra el error en logs

**Flujo Específico de Honduras (SBHN):**

El servicio de Honduras implementa una lógica más compleja con 3 pasos principales:

1. **Consulta de Ticket en Base de Datos (DBGetStatusTicketAdapter):**
   - Transforma el request mediante RollbackPurchaseToPagosWS.Xquery
   - Consulta la información del ticket en la base de datos
   - Extrae: PV_SUCCESSINDICATOR, PV_MESSAGES, PV_SECUENCIAMOVIMIENTO, PN_ORGANIZACION, PV_MERCHANTNUMBER, PN_VALOREFECTIVO, PV_FECHAEXPTC, PV_NUMEROTARJETA
   - **Validación:** Si codeErrorGetTicket = 'SUCCESS' y messageErrorService = '', continúa al paso 2
   - **Si falla:** Establece codeErrorService = 'ERROR' y salta al manejo de errores

2. **Reverso en Vision+ (onlineTransactions_v4):**
   - Transforma el request mediante RollbackPurchaseToOnlinePayment.Xquery con parámetros:
     - sequence: Secuencia del movimiento de la BD
     - requestType: 'R' (Reverso)
     - org: Organización
     - merchant: Número de comercio
     - payment: Valor efectivo
     - expiration: Fecha expiración TC
     - creditCard: Número de tarjeta
   - Invoca operación OnlineUpdateCard del servicio onlineTransactions_v4
   - Extrae ActionDescription del response
   - **Validación:** Si ActionDescription = 'APPROVED', continúa al paso 3
   - **Si falla:** Establece statusService = 'ERROR' y codeErrorService = 'ERROR'

3. **Actualización de Estado del Ticket (DBActTicketAdapter):**
   - Transforma el request mediante RollbackPurchaseToActTicket.Xquery con:
     - RollbackPurchase: Request original
     - statusTicket: 'R' (Reversado)
   - Actualiza el estado del ticket en la base de datos
   - Extrae: PV_SUCCESSINDICATOR, PV_MESSAGES
   - **Validación:** Si codeErrorService = 'SUCCESS', construye response exitoso
   - **Si falla:** Establece statusService = 'ERROR' y codeErrorService = 'ERROR'

4. **Construcción de Response:**
   - **Caso Exitoso:** Transforma mediante PagosWSToRollbackPurchase.Xquery usando los datos de la BD
   - **Caso Error:** 
     - Consulta GetCustomErrorByStackTraceRegionalRestBS para mapeo de errores
     - Transforma mediante ErrorToRollbackPurchase.Xquery con parámetros:
       - messaggeOnlinePayment: Mensaje de Vision+
       - ErrorToRollback: Error mapeado
       - globalId: ID de la transacción
       - messageError: Mensaje de error del servicio
       - targetSystem: 'Vision+' o 'OSB'
       - status: Estado del servicio

**Flujo Específico de Guatemala (SBGT):**

El servicio de Guatemala implementa la misma lógica de 3 pasos que Honduras con diferencias menores:

1. **Consulta de Ticket en Base de Datos (DBGetStatusTicketAdapter):**
   - Transforma el request mediante RollbackToPagosWS.Xquery (nombre diferente)
   - Misma lógica de consulta y validación que Honduras
   - Extrae los mismos campos de la BD

2. **Reverso en Vision+ (onlineTransactions_v4):**
   - Transforma el request mediante RollbackToOnlinePayment.Xquery
   - **Diferencia clave:** Invoca operación **OnlinePaymentV4** (vs OnlineUpdateCard en Honduras)
   - Mismos parámetros: sequence, requestType='R', org, merchant, payment, expiration, creditCard
   - Extrae ActionDescription del response
   - **Validación:** Si ActionDescription = 'APPROVED', continúa al paso 3

3. **Actualización de Estado del Ticket (DBActTicketAdapter):**
   - Transforma el request mediante RollbackToActTicket.Xquery
   - **Diferencia:** Incluye parámetro adicional **numeroAutorizacion** del response de Vision+
   - Actualiza el estado del ticket con statusTicket='R'
   - Misma validación que Honduras

4. **Construcción de Response:**
   - **Caso Exitoso:** Transforma mediante PagosWSToRollback.Xquery (nombre diferente)
   - **Caso Error:** Transforma mediante ErrorToRollback.Xquery
   - Usa GetCustomErrorByStackTraceRegionalRestBS de SBGT_Card_Commons

**Servicios Dependientes Analizados:**

**Regional (SBRG):**
- **GetCountryURLByNameRestBS:** Servicio de regionalización que determina la URL del backend según el país
- **RollbackPurchaseRestBS:** Business Service que invoca el backend de Vision+ para ejecutar el reverso
- **LoggingRegionalRestBS:** Servicio de logging para registrar requests y responses
- **GetCustomErrorByStackTraceRegionalRestBS:** Servicio de mapeo de errores técnicos a errores de negocio

**Honduras (SBHN):**
- **DBGetStatusTicketAdapter:** Adaptador de base de datos para consultar información del ticket
- **onlineTransactions_v4:** Servicio de Vision+ para ejecutar el reverso de la transacción (operación OnlineUpdateCard)
- **DBActTicketAdapter:** Adaptador de base de datos para actualizar el estado del ticket
- **GetCustomErrorByStackTraceRegionalRestBS:** Servicio de mapeo de errores (SBHN_Card_Commons)

**Guatemala (SBGT):**
- **DBGetStatusTicketAdapter:** Adaptador de base de datos para consultar información del ticket
- **onlineTransactions_v4:** Servicio de Vision+ para ejecutar el reverso (operación OnlinePaymentV4)
- **DBActTicketAdapter:** Adaptador de base de datos para actualizar el estado del ticket
- **GetCustomErrorByStackTraceRegionalRestBS:** Servicio de mapeo de errores (SBGT_Card_Commons)

**Transformaciones XQuery Honduras:**
- **RollbackPurchaseToPagosWS:** Transforma request a formato de consulta de BD
- **RollbackPurchaseToOnlinePayment:** Transforma a formato de Vision+ OnlineUpdateCard
- **RollbackPurchaseToActTicket:** Transforma a formato de actualización de ticket
- **PagosWSToRollbackPurchase:** Transforma response de BD a formato de respuesta del servicio
- **ErrorToRollbackPurchase:** Transforma errores a formato de respuesta

**Transformaciones XQuery Guatemala:**
- **RollbackToPagosWS:** Transforma request a formato de consulta de BD
- **RollbackToOnlinePayment:** Transforma a formato de Vision+ OnlinePaymentV4
- **RollbackToActTicket:** Transforma a formato de actualización de ticket (incluye numeroAutorizacion)
- **PagosWSToRollback:** Transforma response de BD a formato de respuesta del servicio
- **ErrorToRollback:** Transforma errores a formato de respuesta

**Arquitectura Regional:** El servicio implementa un patrón de Router Regional que:
- **SBRG (Regional):** Router que determina el país y enruta dinámicamente
- **SBHN (Honduras):** Implementación específica con lógica de 3 pasos (BD → Vision+ OnlineUpdateCard → BD)
- **SBGT (Guatemala):** Implementación específica con lógica de 3 pasos (BD → Vision+ OnlinePaymentV4 → BD)
- Soporta múltiples países (Honduras, Guatemala - Panamá y Nicaragua no implementados)
- Enruta dinámicamente según el DestinationBank
- Utiliza templates específicos por país (CardTemplateRG, HondurasCardTemplate, CardTemplateCollectorGTFICOHSA)
- Implementa logging centralizado
- Maneja errores de forma unificada

**Diferencias Clave entre Regional, Honduras y Guatemala:**

| Aspecto | Regional (SBRG) | Honduras (SBHN) | Guatemala (SBGT) |
|---------|-----------------|-----------------|------------------|
| **Patrón** | Routing simple | Lógica 3 pasos | Lógica 3 pasos |
| **Template** | CardTemplateRG | HondurasCardTemplate | CardTemplateCollectorGTFICOHSA |
| **Namespace** | https://www.ficohsa.com/regional/card | https://www.ficohsa.com/honduras/card | https://www.ficohsa.com/guatemala/card |
| **URI** | /regional/card/rest/rollbackPurchase/v1 | /honduras/card/rest/rollbackPurchase/v1 | /guatemala/card/rest/rollbackPurchase/v1 |
| **Operación Vision+** | N/A | OnlineUpdateCard | OnlinePaymentV4 |
| **XQuery Request BD** | N/A | RollbackPurchaseToPagosWS | RollbackToPagosWS |
| **XQuery Request Vision+** | N/A | RollbackPurchaseToOnlinePayment | RollbackToOnlinePayment |
| **XQuery Actualizar Ticket** | N/A | RollbackPurchaseToActTicket | RollbackToActTicket |
| **XQuery Response Exitoso** | N/A | PagosWSToRollbackPurchase | PagosWSToRollback |
| **XQuery Response Error** | ErrorToRollback | ErrorToRollbackPurchase | ErrorToRollback |
| **Parámetro Adicional** | N/A | No | numeroAutorizacion (en ActTicket) |
| **Commons** | SBRG_Card_Commons | SBHN_Card_Commons | SBGT_Card_Commons |

**Seguridad:** 
- **Proxy Service:** HTTP Basic Authentication over SSL (oracle/http_basic_auth_over_ssl_service_policy)
- **Business Service:** HTTP Basic Authentication over SSL (oracle/http_basic_auth_over_ssl_client_policy)
- **Protocolo:** HTTPS obligatorio
- **Dispatch Policy:** SBCardManager

### 6. Datos Relevantes

- El servicio NO requiere reintentos automáticos (retry-count: 0)
- El servicio SÍ requiere reversos (es un servicio de reverso de compras)
- Soporta tanto protocolo REST como SOAP (dual binding)
- Implementa validación XSD estricta en el request
- El servicio backend es Vision+ (sistema de tarjetas)
- Utiliza routing dinámico basado en regionalización
- Implementa logging completo de requests y responses
- Maneja errores con transformación personalizada
- El GlobalId se genera automáticamente si no se proporciona (fn-bea:uuid())
- El idioma por defecto es "es" (español) si no se especifica
- El DestinationBank toma el valor de SourceBank si no se proporciona

### 7. Detalles Técnicos de Conexión

- **Conexión a Vision+:** Por HTTPS/REST - Servicio backend de tarjetas que procesa el reverso de compras
- **Conexión a Regionalización:** Por HTTPS/REST - Servicio que determina la URL del backend según país
- **Conexión a Logging:** Por HTTPS/REST - Servicio de registro de transacciones
- **Conexión a Mapeo de Errores:** Por HTTPS/REST - Servicio de traducción de errores técnicos

### 8. Dependencias del Servicio

**Servicios Internos:**
- SBRG_Card_Commons/BS/GetCountryURLByNameRestBS - Servicio de regionalización
- SBRG_Card_Commons/BS/LoggingRegionalRestBS - Servicio de logging
- SBRG_Card_Commons/BS/GetCustomErrorByStackTraceRegionalRestBS - Servicio de mapeo de errores
- SBRG_Card_RollbackPurchase/BS/RollbackPurchaseRestBS - Business Service del backend

**Servicios Externos:**
- Vision+ (Backend de Tarjetas) - Sistema que ejecuta el reverso de compras

**Transformaciones:**
- SBRG_Card_Commons/Transformations/ServiceToRegionalizacion - Construcción del request de regionalización
- SBRG_Card_Commons/Transformations/ServiceToLog - Construcción del request de logging
- SBRG_Card_Commons/Transformations/ServicesToError - Construcción del request de mapeo de errores
- SBRG_Card_RollbackPurchase/Transformations/ErrorToRollback - Transformación de errores a formato de respuesta

**Templates:**
- SBRG_Card_Commons/PP/CardTemplateRG - Template común para servicios de tarjetas regionales

## 9. Datos del Servicio

| Campo | Valor |
|-------|-------|
| **RUTA** | SBRG_Card_RollbackPurchase\PS\RollbackPurchaseRestPS |
| **URI** | /regional/card/rest/rollbackPurchase/v1 |
| **NUMERO_OPERACIONES** | 1 |
| **OPERACIONES** | rollbackPurchase |
| **CODIGO** | No especificado |
| **GRUPO_ASIGNADO** | No especificado |

## 10. Información del Inventario de Servicios

Servicios relacionados con RollbackPurchaseRestPS encontrados en el inventario:

| URI | NUMERO_OPERACIONES | OPERACIONES | CODIGO | GRUPO_ASIGNADO | RUTA |
|-----|-------------------|-------------|--------|-----------------|------|
| /guatemala/card/rest/rollbackPurchase/v1 | 1 | rollbackPurchase | - | - | SBGT_Card_RollbackPurchase\PS\RollbackPurchaseRestPS |
| /honduras/card/rest/rollbackPurchase/v1 | 1 | rollbackPurchase | - | - | SBHN_Card_RollbackPurchase\PS\RollbackPurchaseRestPS |
| /regional/card/rest/rollbackPurchase/v1 | 1 | rollbackPurchase | - | - | SBRG_Card_RollbackPurchase\PS\RollbackPurchaseRestPS |

> **Nota:** El servicio regional (SBRG) actúa como router que enruta a los servicios específicos de cada país (SBGT, SBHN, etc.)

## 11. Servicios Dependientes (Árbol Proxy-Biz)

No se encontraron dependencias directas en el archivo Arbol_Proxy_Biz.csv para este servicio.

El servicio utiliza las siguientes dependencias identificadas en el código:
- **Business Service:** SBRG_Card_RollbackPurchase/BS/RollbackPurchaseRestBS
- **Servicios Comunes:** SBRG_Card_Commons (GetCountryURLByNameRestBS, LoggingRegionalRestBS, GetCustomErrorByStackTraceRegionalRestBS)

## 12. Canales que utilizan la capacidad

**Canales:** No se encontró información de canales para esta capacidad (GRUPO_ASIGNADO: No especificado)

**URIs:** N/A

**Número de canales:** 0

> **Nota:** El GRUPO_ASIGNADO no está especificado en el Inventario.csv para este servicio. Se requiere actualización del inventario para identificar los canales que utilizan esta capacidad.

---

## Historial de Cambios

| Fecha | Versión | Autor | Descripción |
|-------|---------|-------|-------------|
| 2024-01-XX | 1.0 | ARQ FICOHSA | Creación inicial |
