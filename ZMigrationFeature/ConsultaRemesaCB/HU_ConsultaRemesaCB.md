# Historia de Usuario: ConsultaRemesaCB

> **Como** Equipo de Integración  
> **Quiero** Consultar remesas de corresponsales bancarios con validaciones de seguridad y límites transaccionales  
> **Para** Permitir a los canales digitales consultar información de remesas internacionales de forma segura

## Criterios de Aceptación

### 1. Campos de Entrada del Servicio

| Campo | Descripción | Requerido | Tipo/Formato |
|-------|-------------|-----------|--------------|
| **consultaRemesas** | Elemento raíz del request | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ REMITTANCE_ID | Identificador único de la remesa | Si | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ REMITTER_FIRSTNAME | Primer nombre del remitente | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ REMITTER_MIDDLENAME | Segundo nombre del remitente | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ REMITTER_FIRSTSURNAME | Primer apellido del remitente | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ REMITTER_SECONDSURNAME | Segundo apellido del remitente | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ BENEFICIARY_FIRSTNAME | Primer nombre del beneficiario | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ BENEFICIARY_MIDDLENAME | Segundo nombre del beneficiario | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ BENEFICIARY_FIRSTSURNAME | Primer apellido del beneficiario | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ BENEFICIARY_SECONDSURNAME | Segundo apellido del beneficiario | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ CORRESPONSAL_BRANCHCODE | Código de sucursal del corresponsal | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ ADDITIONAL_INFO | Información adicional | No | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─ INFO | Elemento repetible de información | No | Complex Type (0..unbounded) |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ NAME | Nombre del parámetro (ID, LOGINUSER, LOGINPASS) | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─ VALUE | Valor del parámetro | No | string |

> **Validaciones:**
> - Se valida la estructura del mensaje contra el esquema XSD consultaRemesasCBTypes.xsd
> - Se valida el corresponsal bancario mediante consultarCorresponsalB
> - Se descifran credenciales LOGINUSER y LOGINPASS si están presentes
> - Los campos LOGINUSER y LOGINPASS se cifran con RSA usando alias "ONE-TIME-PASSWORD"

### 2. Campos de Salida del Servicio

| Campo | Descripción | Requerido | Tipo |
|-------|-------------|-----------|------|
| **consultaRemesasResponse** | Respuesta del servicio de consulta de remesas | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ consultaRemesasResponseType | Tipo de respuesta | No | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─ consultaRemesasResponseRecordType | Registro de respuesta | No | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─ consultaRemesasResponseRecordType | Array de remesas encontradas | No | Complex Type (0..unbounded) |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ REMITTANCE_ID | Identificador de la remesa | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ REMITTER_ID | Identificador del remitente | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ REMITTER_NAME | Nombre completo del remitente | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ BENEFICIARY_NAME | Nombre completo del beneficiario | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ BRANCH_NAME | Nombre de la sucursal | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ PAYMENT_DATE | Fecha de pago | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ CURRENCY | Moneda de la remesa | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ EXCHANGE_RATE | Tasa de cambio aplicada | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ REMITTANCE_STATUS | Estado de la remesa | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ REMITTANCE_AMOUNT | Monto de la remesa | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ REMITTANCE_SOURCE_AMOUNT | Monto original en moneda de origen | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─ ORIGIN_COUNTRY | País de origen de la remesa | No | string |

> **Nota:** Todos los campos de salida están validados contra el esquema XSD consultaRemesasCBTypes.xsd

## Tareas Técnicas

### 1. Códigos de Error

#### 1.1. Códigos de error del Proveedor

| Código Error | Descripción | Tipo Error |
|--------------|-------------|------------|
| SUCCESS | Consulta exitosa | Negocio |
| ERROR | Error en validación de corresponsal | Negocio |
| TIMEOUT | Timeout en conexión con servicios backend | Técnico |
| INVALID_CREDENTIALS | Credenciales inválidas o no descifradas | Técnico |

> **Nota:** Los errores se manejan mediante el pipeline de error _onErrorHandler que construye un ResponseHeader con successIndicator="ERROR"

### 2. Configuración de Timeout

- **Timeout operación del OSB:** 120 segundos
- **Timeout servicio ConsultaRemesas:** 120 segundos
- **Timeout OperacionesCriptograficas:** 30 segundos

### 3. Datos de Prueba

> **Nota:** Los siguientes son datos de ejemplo no reales, utilizados únicamente para propósitos de testing y documentación.

- **REMITTANCE_ID:** REM123456789
- **REMITTER_FIRSTNAME:** Juan
- **REMITTER_FIRSTSURNAME:** Perez
- **BENEFICIARY_FIRSTNAME:** Maria
- **BENEFICIARY_FIRSTSURNAME:** Lopez
- **CORRESPONSAL_BRANCHCODE:** 001

### 4. Datos de Contacto

**Contacto responsable OSB:**
- **David Ruiz** - david.ruiz@ficohsa.com
- **Wilmer Fernandez** - wilmer.fernandez@ficohsa.com  
- **Francia Avila** - francia.avila@ficohsa.com
- **Diego Gomez** - diego.gomez@ficohsa.com

### 5. Lógica Importante

**Flujo Principal del Servicio:**
1. **Validación XSD:** Se valida la estructura del mensaje contra el esquema consultaRemesasCBTypes.xsd
2. **Validación de Corresponsal:** Se ejecuta consultarCorresponsalB para validar el código de corresponsal bancario con tipo de transacción "9"
3. **Operaciones Criptográficas:** Si existen campos LOGINUSER y LOGINPASS en ADDITIONAL_INFO:
   - Se descifran usando el servicio OperacionesCriptograficas con operación cifrarDatos
   - Se utiliza el alias "ONE-TIME-PASSWORD" y cifrado RSA
   - Se reconstruye ADDITIONAL_INFO con los valores descifrados
4. **Consulta de Remesas:** Se invoca el servicio ConsultaRemesas con las transformaciones aplicadas
5. **Registro de Límite Transaccional:** Si la respuesta es exitosa (successIndicator="SUCCESS"):
   - Se registra el límite transaccional mediante limiteTrxRegistrar
   - Se utiliza el IdCliente extraído de ADDITIONAL_INFO
6. **Transformación de Respuesta:** Se aplica consultaRemesaCBOut.xq para construir la respuesta final
7. **Manejo de Errores:** Pipeline de error que captura excepciones y construye respuesta de error estándar

**Servicios Dependientes Analizados:**
- **ConsultaRemesas:** Servicio principal que ejecuta la consulta de remesas en múltiples remesadoras
- **OperacionesCriptograficas:** Descifrado de credenciales sensibles
- **consultarCorresponsalB:** Validación de corresponsal bancario
- **limiteTrxRegistrar:** Registro de límites transaccionales
- **ValidaServicioRegional:** Validación de disponibilidad del servicio por región

**Seguridad por Usuario:** El servicio implementa Custom Token Authentication extrayendo UserName y Password del RequestHeader

### 6. Datos Relevantes

- El servicio requiere validación de corresponsal bancario antes de procesar la consulta
- El servicio maneja descifrado de credenciales para autenticación en sistemas externos
- Se registran límites transaccionales solo en consultas exitosas
- El servicio no requiere reintentos automáticos
- El servicio no requiere reversos
- Soporta consulta por múltiples criterios: ID de remesa, nombres de remitente/beneficiario
- Integra con múltiples remesadoras a través del servicio ConsultaRemesas
- Se implementará el servicio conectado a la implementación de ConsultaRemesas, a través de consumo de dicho servicio web Soap, esto mientras se aborda la implementación de los servicios de remesas a nueva arquitectura

### 7. Detalles Técnicos de Conexión

- **Conexión a ConsultaRemesas:** Por SOAP/HTTP - Proxy Service interno
- **Conexión a OperacionesCriptograficas:** Por SOAP/HTTP - Proxy Service interno
- **Conexión a consultarCorresponsalB:** Por JCA - Base de datos Middleware
- **Conexión a limiteTrxRegistrar:** Por JCA - Base de datos Middleware

### 8. Dependencias del Servicio

**Servicios Internos:**
- ConsultaRemesas - Consulta de remesas en múltiples remesadoras
- OperacionesCriptograficas - Descifrado de credenciales
- MapeoErrores - Mapeo de códigos de error
- EvaluaListasCliente - Evaluación de listas restrictivas
- ListadoErroresResiliencia - Manejo de resiliencia

**Servicios Externos:**
- consultarCorresponsalB_db - Validación de corresponsal bancario
- limiteTrxRegistrar_db - Registro de límites transaccionales
- ValidaServicioRegional_db - Validación regional del servicio

## 9. Datos del Servicio

| Campo | Valor |
|-------|-------|
| **RUTA** | Middleware\v2\ProxyServices\ConsultaRemesaCB |
| **URI** | /Middleware/OperationsAndExecution/Payments/ConsultaRemesaCB |
| **NUMERO_OPERACIONES** | 1 |
| **OPERACIONES** | consultaRemesasCB |
| **CODIGO** | (vacío) |
| **GRUPO_ASIGNADO** | ConsultaRemesas |

## 10. Información del Inventario de Servicios

Servicios relacionados con ConsultaRemesaCB encontrados en el inventario (GRUPO_ASIGNADO = "ConsultaRemesas"):

| NOMBRE_SERVICIO | RUTA | URI | NUMERO_OPERACIONES | OPERACIONES | CODIGO | WSDL | GRUPO_ASIGNADO |
|-----------------|------|-----|-------------------|-------------|--------|------|----------------|
| ConsultaRemesaCB | Middleware\v2\ProxyServices\ConsultaRemesaCB | /Middleware/OperationsAndExecution/Payments/ConsultaRemesaCB | 1 | consultaRemesasCB | (vacío) | Middleware/v2/Resources/ConsultaRemesasCB/wsdl/consultaRemesaCB | ConsultaRemesas |

## 11. Servicios Dependientes (Árbol Proxy-Biz)

Servicios que tienen como PROXY_PADRE "Middleware\v2\ProxyServices\ConsultaRemesaCB":

| PROXY_REFERENCIA | BIZ | URI |
|------------------|-----|-----|
| Middleware\v2\ProxyServices\OperacionesCriptograficas | \Middleware\v2\BusinessServices\FTP\readWebServicesKeyStore\biz\readWebServicesKeyStore_ftp | [jca://eis/Ftp/ConnectionReadKeyStore] |
| Middleware\v2\ProxyServices\ListadoErroresResiliencia | \Middleware\v2\BusinessServices\MDW\listadoErroresResiliencia\biz\listadoErroresResiliencia_db | [jca://eis/DB/ConnectionMiddleware] |
| Middleware\v2\ProxyServices\OperacionesCriptograficas | \Middleware\v2\BusinessServices\ValidaServicioRegional\biz\ValidaServicioRegional_db | [jca://eis/DB/ConnectionMiddleware] |
| Middleware\v2\ProxyServices\ConsultaRemesas | \Middleware\v2\BusinessServices\consultarRemFRemXPagador\biz\consultarRemFRemXPagador_db | [jca://eis/DB/ConnectionConvenios] |
| Middleware\v2\BusinessServices\SJS\consultaMultipleRemesadoras\flow\sjConsultaMultipleRemesadoras | \Middleware\v2\BusinessServices\enrutadorConvenios\biz\enrutadorConvenios | [http://192.9.200.176:8003/Middleware/OperationsAndExecution/BillingServices/EnrutadorConvenios] |
| Middleware\v2\BusinessServices\SJS\consultaMultipleRemesadoras\flow\sjConsultaMultipleRemesadoras | \Middleware\v2\BusinessServices\armarMensajeRecaudo\biz\armarMensajeRecaudo_db | [jca://eis/DB/ConnectionConvenios] |
| Middleware\v2\ProxyServices\ConsultaRemesas | \Middleware\v2\BusinessServices\Remesas\biz\sjConsultaRemesaResiliencia | [flow:Middleware/v2/BusinessServices/Remesas/flow/sjConsultaRemesaResiliencia] |
| Middleware\v2\ProxyServices\ConsultaRemesaCB | \Middleware\v2\BusinessServices\MDW\consultarCorresponsalB\biz\consultarCorresponsalB_db | [jca://eis/DB/ConnectionMiddleware] |
| Middleware\v2\ProxyServices\ConsultaRemesas | \Middleware\v2\BusinessServices\MDW\obtenerTipoRemesadora\biz\ObtenerTipoRemesadora_db | [jca://eis/DB/ConnectionMiddleware] |
| Middleware\v2\ProxyServices\ConsultaRemesas | \Middleware\v2\BusinessServices\SJS\consultaMultipleRemesadoras\biz\sjConsultaMultipleRemesadoras | [flow:Middleware/v2/BusinessServices/SJS/consultaMultipleRemesadoras/flow/sjConsultaMultipleRemesadoras] |
| Middleware\v2\ProxyServices\ConsultaRemesas | \Middleware\v2\BusinessServices\ValidaServicioRegional\biz\ValidaServicioRegional_db | [jca://eis/DB/ConnectionMiddleware] |
| Middleware\v2\ProxyServices\EvaluaListasCliente | \Middleware\v2\BusinessServices\MDW\consultaRutaRegional\biz\consultaRutaRegional_db | [jca://eis/DB/ConnectionMiddleware] |
| Middleware\v2\ProxyServices\MapeoErrores | \Middleware\v2\BusinessServices\MapeoErrores\biz\mapeodeErrores_db | [jca://eis/DB/ConnectionMiddleware] |
| Middleware\v2\ProxyServices\MapeoErrores | \Middleware\v2\BusinessServices\MDW\guardarBitacoraMapeoErrores\biz\guardarBitacoraMapeoErrores_db | [jca://eis/DB/ConnectionMiddleware] |
| Middleware\v2\ProxyServices\OperacionesCriptograficas | \Middleware\Business_Resources\general\Resources\ObtenerParametrizacion\ObtenerParametrizacion | [jca://eis/DB/ConnectionMiddleware] |
| Middleware\v2\ProxyServices\ConsultaRemesas | \Middleware\Business_Resources\general\Resources\ObtenerParametrizacion\ObtenerParametrizacion | [jca://eis/DB/ConnectionMiddleware] |
| Middleware\v2\ProxyServices\ConsultaRemesas | \Middleware\v2\BusinessServices\registraRelConsPagoRem\biz\ingresoRelConsPagoRem_db | [jca://eis/DB/ConnectionConvenios] |
| Middleware\v2\BusinessServices\Remesas\flow\sjConsultaRemesaResiliencia | \Middleware\Business_Resources\remesas\Resoruces\Remesas | [http://10.9.104.55:7004/svcRemesas/services, http://10.9.104.55:7005/svcRemesas/services, http://10.9.104.55:7006/svcRemesas/services] |
| Middleware\v2\ProxyServices\ConsultaRemesas | \Middleware\v2\BusinessServices\ConsultarRemLocalId\biz\consultarRemLocalId_db | [jca://eis/DB/ConnectionConvenios] |
| Middleware\v2\ProxyServices\ConsultaRemesas | \Middleware\v2\BusinessServices\MDW\obtenerCamposRemesasRel\biz\obtenerCamposRemesasRel_db | [jca://eis/DB/ConnectionMiddleware] |
| Middleware\v2\BusinessServices\Remesas\flow\sjConsultaRemesaResiliencia | \Middleware\Business_Resources\general\Resources\ObtenerParametrizacion\ObtenerParametrizacion | [jca://eis/DB/ConnectionMiddleware] |

## 12. Canales que utilizan la capacidad

**Canales:** LACOLONIA, SARA, TENGO

**URIs:** /Middleware/OperationsAndExecution/Payments/ConsultaRemesaCB, /Middleware/OperationsAndExecution/Payments/ConsultaRemesas_v2

**Número de canales:** 3

---

## Historial de Cambios

| Fecha | Versión | Autor | Descripción |
|-------|---------|-------|-------------|
| 2024-01-15 | 1.0 | ARQ FICOHSA | Creación inicial |
