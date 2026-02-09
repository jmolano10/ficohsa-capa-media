# Historia de Usuario: ConsultaEstadoLote

> **Como** Equipo de Integración  
> **Quiero** Consultar el estado de un lote de pagos masivos  
> **Para** Permitir a los canales verificar el estado de procesamiento de lotes de pagos masivos en tiempo real

## Criterios de Aceptación

### 1. Campos de Entrada del Servicio

| Campo | Descripción | Requerido | Tipo/Formato |
|-------|-------------|-----------|--------------|
| **consultaEstadoLote** | Elemento raíz del request | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **CUSTOMER_ID** | Identificador del cliente | **Sí** | string (minLength=1) |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **BANK_BATCH_ID** | Identificador del lote en el banco | **Sí** | integer |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ **UPLOAD_DATE** | Fecha de carga del lote | No | date |

> **Validaciones:**
> - CUSTOMER_ID debe tener al menos 1 carácter
> - BANK_BATCH_ID debe ser un número entero válido
> - UPLOAD_DATE debe ser una fecha válida en formato ISO (YYYY-MM-DD)
> - Se valida la estructura del mensaje contra el esquema XSD pagosMasivosTypes.xsd
> - Se aplica validación de servicio regional con código FICBCO0231

### 2. Campos de Salida del Servicio

| Campo | Descripción | Requerido | Tipo |
|-------|-------------|-----------|------|
| **consultaEstadoLoteResponse** | Respuesta del servicio de consulta de estado de lote | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **BANK_BATCH_ID** | Identificador del lote en el banco | No | string (minLength=1) |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **CUSTOMER_ID** | Identificador del cliente | No | string (minLength=1) |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **CUSTOMER_NAME** | Nombre del cliente | No | string (minLength=1) |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **STATUS** | Estado del lote | No | string (minLength=1) |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **STATUS_DESC** | Descripción del estado | No | string (minLength=1) |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **OPTIMISTIC** | Indicador de procesamiento optimista | No | yesNoType (YES/NO) |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **ACCOUNTS** | Cuentas involucradas en el lote | No | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─ **ACCOUNT** | Información de cuenta | No | accountType (unbounded) |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **DEBIT_ACCOUNT** | Cuenta de débito | No | string (minLength=1) |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **AMOUNT** | Monto | No | decimal |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─ **CURRENCY** | Moneda | No | string (minLength=1) |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **PAYMENTS** | Pagos del lote | No | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─ **PAYMENT** | Información de pago | No | paymentType (unbounded) |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **CURRENCY** | Moneda del pago | No | string (minLength=1) |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **TOTAL_AMOUNT** | Monto total | No | decimal |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─ **EXCHANGE_RATE** | Tasa de cambio | No | decimal |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **TOTAL_AMOUNT** | Monto total del lote | No | decimal |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **TOTAL_AMOUNT_ERROR** | Monto total con error | No | decimal |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **NUMBER_OF_TRANSACTIONS** | Número total de transacciones | No | integer |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **NUMBER_OF_TRANSACTIONS_SUCCESS** | Número de transacciones exitosas | No | integer |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **NUMBER_OF_TRANSACTIONS_ERROR** | Número de transacciones con error | No | integer |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **APPLICATION_DATE** | Fecha de aplicación | No | dateTime |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ **PROCESS_INFO** | Información del proceso | No | string |

> **Nota:** Todos los campos de salida están validados contra el esquema XSD pagosMasivosTypes.xsd

## Tareas Técnicas

### 1. Códigos de Error

#### 1.1. Códigos de error del Proveedor

| Código Error | Descripción | Tipo Error |
|--------------|-------------|------------|
| MW-0008 | SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY | Técnico |
| ERROR | Error en validación de servicio regional | Técnico |
| Error | Error en validación de acceso PMS | Negocio |
| OSB-382033 | Error de validación XSD | Técnico |

> **Nota:** Los errores son mapeados a través del servicio MapeoErrores con código de servicio FICBCO0231

### 2. Configuración de Timeout

- **Timeout proveedor consultarEstadoLote_db (HN01):** Sin timeout configurado (0 segundos = sin límite)
- **Timeout proveedor consultorLote (PA01/GT01/NI01):** Sin timeout configurado (0 segundos = sin límite)
- **Timeout operación del OSB:** Configurado según políticas del servidor
- **Retry count:** 0 (sin reintentos automáticos)
- **Retry interval:** 30 segundos (HN01), 0 segundos (otros países)

### 3. Datos de Prueba

> **Nota:** Los siguientes son datos de ejemplo no reales, utilizados únicamente para propósitos de testing y documentación.

- **CUSTOMER_ID:** "12345678"
- **BANK_BATCH_ID:** 100001
- **UPLOAD_DATE:** "2024-01-15"

### 4. Datos de Contacto

**Contacto responsable OSB:**
- **David Ruiz** - david.ruiz@ficohsa.com
- **Wilmer Fernandez** - wilmer.fernandez@ficohsa.com  
- **Francia Avila** - francia.avila@ficohsa.com
- **Diego Gomez** - diego.gomez@ficohsa.com

### 5. Lógica Importante

**Flujo Principal del Servicio:**
1. **Validación XSD:** Se valida la estructura del mensaje contra el esquema pagosMasivosTypes.xsd
2. **Validación Regional:** Se ejecuta ValidaServicioRegional con serviceId "FICBCO0231" para verificar disponibilidad por región
3. **Regionalización por País:** El servicio se enruta según el país de origen (SourceBank):
   - **HN01 (Honduras):** 
     - Valida acceso PMS mediante validaAccesoPMS_db
     - Si la validación es exitosa, consulta el estado del lote en la base de datos local mediante consultarEstadoLote_db
     - Transforma la respuesta usando consultaEstadoLoteOut.xq y consultaEstadoLoteHeaderOut.xq
   - **PA01 (Panamá):** 
     - Invoca el servicio web consultorLote del proveedor MTR
     - Transforma el request usando consultaEstadoLotePAIn.xq
     - Transforma la respuesta usando consultaEstadoLotePAOut.xq y consultaEstadoLotePAHeaderOut.xq
   - **GT01 (Guatemala):** 
     - Invoca el servicio web consultorLote del proveedor MTR
     - Transforma el request usando consultaEstadoLoteGTIn.xq
     - Transforma la respuesta usando consultaEstadoLoteGTOut.xq y consultaEstadoLoteGTHeaderOut.xq
   - **NI01 (Nicaragua):** 
     - Invoca el servicio web consultorLote del proveedor MTR
     - Transforma el request usando consultaEstadoLoteNIIn.xq
     - Transforma la respuesta usando consultaEstadoLoteNIOut.xq y consultaEstadoLoteNIHeaderOut.xq
   - **Default:** Retorna error MW-0008 "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"
4. **Validación de Respuesta:** Se verifica el successIndicator en el ResponseHeader
5. **Transformación de Respuesta:** Se construye la respuesta según el país de origen
6. **Manejo de Errores:** Se aplica mapeo de errores mediante el servicio MapeoErrores

**Servicios Dependientes Analizados:**
- **ValidaServicioRegional:** Valida que el servicio esté disponible para la región solicitada
- **validaAccesoPMS_db (HN01):** Valida que el usuario tenga acceso al sistema de pagos masivos
- **consultarEstadoLote_db (HN01):** Consulta el estado del lote en la base de datos ProxyAbanksHN
- **consultorLote (PA01/GT01/NI01):** Servicio web del proveedor MTR para consultar estado de lotes
- **MapeoErrores:** Mapea códigos de error técnicos a mensajes de negocio

**Arquitectura Multi-Core:** El servicio soporta múltiples países con diferentes implementaciones backend:
- Honduras utiliza base de datos local (ProxyAbanksHN)
- Panamá, Guatemala y Nicaragua utilizan el servicio web MTR

**Seguridad por Usuario:** Para Honduras, se valida el acceso del usuario mediante validaAccesoPMS_db usando CUSTOMER_ID y UserName del header

### 6. Datos Relevantes

- El servicio **no requiere** reintentos automáticos (retry-count=0)
- El servicio **no requiere** reversos
- El servicio es regional y soporta 4 países (HN01, PA01, GT01, NI01)
- Para Honduras, se valida el acceso del usuario antes de consultar el estado del lote
- Los países PA01, GT01 y NI01 utilizan el mismo backend (MTR) pero con transformaciones diferentes

### 7. Información del Inventario de Servicios

**Nombre del Servicio:** ConsultaEstadoLote

**Ruta:** Middleware\v2\ProxyServices\ConsultaEstadoLote

**URI:** local

**Código FICBCO:** FICBCO0231

**WSDL:** N/A

**Grupo Asignado:** No especificado en Inventario.csv

### 8. Servicios Dependientes (Árbol Proxy-Biz)

Según el análisis del archivo Arbol_Proxy_Biz.csv, el servicio ConsultaEstadoLote tiene las siguientes dependencias:

| Proxy Padre | Proxy Referencia | Business Service | URI |
|-------------|------------------|------------------|-----|
| Middleware\v2\ProxyServices\ConsultaEstadoLote | Middleware\v2\ProxyServices\MapeoErrores | Middleware\v2\BusinessServices\MDW\guardarBitacoraMapeoErrores\biz\guardarBitacoraMapeoErrores_db | jca://eis/DB/ConnectionMiddleware |
| Middleware\v2\ProxyServices\ConsultaEstadoLote | Middleware\v2\ProxyServices\ConsultaEstadoLote | Middleware\v2\BusinessServices\PMSV\validaAccesoPMS\biz\validaAccesoPMS_db | jca://eis/DB/ConnectionProxyAbanksHN |
| Middleware\v2\ProxyServices\ConsultaEstadoLote | Middleware\v2\ProxyServices\MapeoErrores | Middleware\v2\BusinessServices\MapeoErrores\biz\mapeodeErrores_db | jca://eis/DB/ConnectionMiddleware |

### 9. Validación XSD

**Referencia:** Ver documento de Análisis Técnico para detalles completos de la validación XSD.

El servicio valida los mensajes de entrada y salida contra el esquema XSD:
- **Esquema:** pagosMasivosTypes.xsd
- **Namespace:** http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes
- **Elementos validados:** consultaEstadoLote (request) y consultaEstadoLoteResponse (response)

### 10. Transformaciones por País

| País | Código | XQuery Request | XQuery Response |
|------|--------|----------------|-----------------|
| Honduras | HN01 | Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteIn.xq | Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteOut.xq, consultaEstadoLoteHeaderOut.xq |
| Panamá | PA01 | Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLotePAIn.xq | Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLotePAOut.xq, consultaEstadoLotePAHeaderOut.xq |
| Guatemala | GT01 | Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteGTIn.xq | Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteGTOut.xq, consultaEstadoLoteGTHeaderOut.xq |
| Nicaragua | NI01 | Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteNIIn.xq | Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteNIOut.xq, consultaEstadoLoteNIHeaderOut.xq |

### 11. Tipo de Servicio

**Tipo:** Servicio Regional Multi-Core

**Características:**
- No utiliza router dinámico (no tiene `<con3:dynamic-route>`)
- Implementa regionalización mediante branch-node por país
- Cada país tiene su propio pipeline de request y response
- Honduras utiliza base de datos local
- Otros países utilizan servicio web externo (MTR)

### 12. Canales que utilizan la capacidad

**Canales:** No se encontró información de canales para esta capacidad (GRUPO_ASIGNADO: No especificado)

**URIs:** N/A

**Número de canales:** 0

> **Nota:** El servicio no tiene GRUPO_ASIGNADO especificado en el Inventario.csv, por lo que no se pudo determinar los canales que utilizan esta capacidad desde el archivo Servicios-Priorizados.csv.

---

## Referencias

- **Análisis Técnico:** [ConsultaEstadoLote_AnalisisTecnico.md](./ConsultaEstadoLote_AnalisisTecnico.md)
- **Entregables:** [ConsultaEstadoLote_Entregables.md](./ConsultaEstadoLote_Entregables.md)
- **Proxy Service:** MasterNuevo/Middleware/v2/ProxyServices/ConsultaEstadoLote.proxy
- **WSDL:** MasterNuevo/Middleware/v2/Resources/ConsultaEstadoLote/wsdl/consultaEstadoLotePS.wsdl
- **XSD:** MasterNuevo/Middleware/v2/Resources/PagosMasivos/xsd/pagosMasivosTypes.xsd
