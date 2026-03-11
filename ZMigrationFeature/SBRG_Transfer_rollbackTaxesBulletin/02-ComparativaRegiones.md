# Comparativa entre Regiones - RollbackTaxesBulletin

## Resumen de Regiones Detectadas

Basado en el análisis exhaustivo del código fuente, se ha identificado que esta funcionalidad está implementada **exclusivamente para Honduras (HN01)**. No se encontraron variantes para otras regiones (GT01, PA01, NI01).

### Evidencias de Región Única
1. **Prefijo de módulo**: `SBHN_Transfer` (HN = Honduras)
2. **Endpoints**: Contienen `/honduras/` en la ruta
3. **No se encontraron**: Carpetas o módulos equivalentes para GT, PA o NI en el proyecto
4. **Template común**: Usa TransferHondurasFicohsaTemplate específico de Honduras

---

## Tabla Comparativa por Región

| Aspecto | HN01 (Honduras) | GT01 (Guatemala) | PA01 (Panamá) | NI01 (Nicaragua) |
|---------|-----------------|------------------|---------------|------------------|
| **Endpoint OSB SOAP** | `/honduras/transfer/soap/rollbackTaxesBulletin/v1` | No implementado | No implementado | No implementado |
| **Endpoint OSB REST** | `/honduras/transfer/rest/rollbackTaxesBulletin/v1` | No implementado | No implementado | No implementado |
| **Nombre de Base de Datos** | T24 (Core Bancario) | N/A | N/A | N/A |
| **Esquemas** | T24WebServicesImpl | N/A | N/A | N/A |
| **Store Procedure** | No aplica (Web Service) | N/A | N/A | N/A |
| **Operación T24** | rollbackTaxesBulletin | N/A | N/A | N/A |
| **Nombre de Conexión** | ReversarTransaccionSoapT24BS | N/A | N/A | N/A |
| **URL Backend** | http://172.23.13.19:7003/RollbackTaxesBulletin/services | N/A | N/A | N/A |
| **Transformaciones Clave** | - RollbackTaxesBulletinToT24.xqy<br/>- T24ToRollbackTaxesBulletin.xqy<br/>- ErrorToRollbackTaxesBulletin.xqy | N/A | N/A | N/A |
| **Campos Diferenciadores** | TransactionId (único campo de negocio) | N/A | N/A | N/A |
| **Errores/Excepciones** | - Success<br/>- TWSError<br/>- T24Error<br/>- T24Override<br/>- T24Offline | N/A | N/A | N/A |
| **Timeouts** | 0 (sin límite) | N/A | N/A | N/A |
| **Retrys** | 0 (sin reintentos) | N/A | N/A | N/A |
| **Política de Seguridad** | oracle/http_basic_auth_over_ssl_service_policy | N/A | N/A | N/A |
| **Extracción de Credenciales** | LDAP: SB_Security/Common/{ApplicationId} | N/A | N/A | N/A |
| **Dispatch Policy** | SBTransferManager | N/A | N/A | N/A |
| **Dependencias Internas** | - SBHN_Transfer_Commons<br/>- ExtractCredentials<br/>- GetCustomErrorByStackTraceRegionalRestBS<br/>- LoggingRegionalRestBS | N/A | N/A | N/A |

---

## Detalles por Región

### HN01 - Honduras (IMPLEMENTADO)

#### Endpoints
- **SOAP**: `https://{host}/honduras/transfer/soap/rollbackTaxesBulletin/v1`
- **REST**: `https://{host}/honduras/transfer/rest/rollbackTaxesBulletin/v1`

#### Mapeos de Datos

**Request OSB → T24:**
- `TransactionId` → `FUNDSTRANSFERREFCOLLACTRFREVCOPYType/transactionId`
- `ApplicationId` (de GeneralInfo) → Extracción de credenciales LDAP → `WebRequestCommon/userName` y `password`
- `company` → Campo vacío en T24

**Response T24 → OSB:**
- `Status/successIndicator` → `StatusInfo/Status`
- Fecha actual → `StatusInfo/ValueDate` (formato: YYYY-MM-DD)
- Fecha/hora actual → `StatusInfo/DateTime` (formato: YYYY-MM-DDTHH:mm:ss)
- `GlobalId` (del request) → `StatusInfo/GlobalId`

#### Validaciones
1. **Validación de esquema XML**: Automática por OSB
2. **Validación de seguridad**: HTTP Basic Auth over SSL
3. **Validación de credenciales**: Lookup en LDAP

#### Políticas OSB
- **Seguridad**: OWSM Policy - oracle/http_basic_auth_over_ssl_service_policy
- **Transporte**: HTTPS obligatorio
- **Compresión**: Deshabilitada
- **WSS Header Processing**: Habilitado

#### Handlers de Error
1. **Error de T24**: Si `successIndicator != 'Success'`
   - Invoca GetCustomErrorByStackTraceRegionalRestBS
   - Mapea error usando ServicesToError.xqy
   - Construye respuesta con ErrorToRollbackTaxesBulletin.xqy
   
2. **Error de Pipeline**: Capturado por error handler del template
   - Registra en logs
   - Mapea error regional
   - Retorna respuesta estructurada con ErrorInfo

#### Reglas de Negocio
1. **Extracción de credenciales**: 
   - Ubicación: ExtractCredentials.xqy
   - Lógica: `fn-bea:lookupBasicCredentials(concat("SB_Security/Common/", upper-case($LDAPId)))`
   - Failover: Si no encuentra credenciales, usa el ApplicationId directamente

2. **Evaluación de éxito**:
   - Ubicación: RollbackTaxesBulletinPP.pipeline (StageTargetSystemToRegional)
   - Condición: `$codeErrorService = 'Success'`
   - Fragmento: `<con2:xqueryText>$codeErrorService= 'Success'</con2:xqueryText>`

3. **Construcción de fechas**:
   - Ubicación: T24ToRollbackTaxesBulletin.xqy
   - ValueDate: `fn:substring(fn:string(fn:current-dateTime()),0,11)` (primeros 10 caracteres)
   - DateTime: `fn:substring(fn:string(fn:current-dateTime()),0,20)` (primeros 19 caracteres)

4. **Logging condicional**:
   - Ubicación: TransferHondurasFicohsaTemplate.ptx (StageLoggingInput)
   - Si `$security = 'Y'`, el request se oculta en logs
   - Fragmento: `<con2:xqueryText>$security= 'Y'</con2:xqueryText>`

#### Configuración de Conexión T24
- **URL**: http://172.23.13.19:7003/RollbackTaxesBulletin/services
- **Puerto**: T24WebServicesImplPort
- **Namespace**: T24WebServicesImpl
- **Método HTTP**: POST
- **Timeout de conexión**: 0 (sin límite)
- **Timeout de lectura**: 0 (sin límite)
- **Retry count**: 0
- **Retry interval**: 30 segundos
- **Load balancing**: round-robin
- **Follow redirects**: false
- **Chunked streaming**: true

---

### GT01 - Guatemala (NO IMPLEMENTADO)

No se encontró implementación de esta funcionalidad para Guatemala. 

**Búsqueda realizada:**
- Módulos con prefijo `SBGT_Transfer`
- Endpoints con `/guatemala/`
- Referencias a GT01 en configuraciones

**Resultado:** Sin coincidencias

---

### PA01 - Panamá (NO IMPLEMENTADO)

No se encontró implementación de esta funcionalidad para Panamá.

**Búsqueda realizada:**
- Módulos con prefijo `SBPA_Transfer`
- Endpoints con `/panama/`
- Referencias a PA01 en configuraciones

**Resultado:** Sin coincidencias

---

### NI01 - Nicaragua (NO IMPLEMENTADO)

No se encontró implementación de esta funcionalidad para Nicaragua.

**Búsqueda realizada:**
- Módulos con prefijo `SBNI_Transfer`
- Endpoints con `/nicaragua/`
- Referencias a NI01 en configuraciones

**Resultado:** Sin coincidencias

---

## Conclusiones

1. **Funcionalidad mono-región**: RollbackTaxesBulletin está implementada exclusivamente para Honduras (HN01)

2. **Sin diferencias regionales**: Al ser una implementación única, no existen variantes o diferencias entre regiones

3. **Posible expansión futura**: Si se requiere implementar para otras regiones, se deberá:
   - Crear módulos específicos (SBGT_Transfer, SBPA_Transfer, SBNI_Transfer)
   - Configurar endpoints regionales
   - Adaptar conexiones a los core bancarios de cada país
   - Ajustar transformaciones según contratos locales

4. **Patrón de nomenclatura**: El proyecto sigue el patrón `SB{PAÍS}_Transfer` para módulos regionales
