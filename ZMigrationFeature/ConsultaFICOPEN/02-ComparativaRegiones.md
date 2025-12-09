# Comparativa entre Regiones - ConsultaFICOPEN

## Tabla de Comparación

| Aspecto | HN01 (Honduras) | GT01 (Guatemala) | PA01 (Panamá) | NI01 (Nicaragua) |
|---------|-----------------|------------------|---------------|------------------|
| **Estado de Implementación** | ✅ Implementado | ❌ No Implementado | ❌ No Implementado | ❌ No Implementado |
| **Endpoint OSB** | `/SMiddleware/OperationsAndExecution/BundledProducts/ConsultaFICOPEN_v2` | `/SMiddleware/OperationsAndExecution/BundledProducts/ConsultaFICOPEN_v2` | `/SMiddleware/OperationsAndExecution/BundledProducts/ConsultaFICOPEN_v2` | `/SMiddleware/OperationsAndExecution/BundledProducts/ConsultaFICOPEN_v2` |
| **Enrutamiento Regional** | `SourceBank = 'HN01'` | Default Branch | Default Branch | Default Branch |
| **Base de Datos** | ConnectionMiddleware | ConnectionMiddleware | ConnectionMiddleware | ConnectionMiddleware |
| **Esquema BD** | No especificado | No especificado | No especificado | No especificado |
| **Stored Procedure** | `MW_P_VALIDA_SERVICIO_REGIONAL` | `MW_P_VALIDA_SERVICIO_REGIONAL` | `MW_P_VALIDA_SERVICIO_REGIONAL` | `MW_P_VALIDA_SERVICIO_REGIONAL` |
| **Nombre de Conexión BD** | `eis/DB/ConnectionMiddleware` | `eis/DB/ConnectionMiddleware` | `eis/DB/ConnectionMiddleware` | `eis/DB/ConnectionMiddleware` |
| **Business Service Backend** | `getFicopen12c` | N/A | N/A | N/A |
| **Endpoint Backend** | `https://dynamoosbdev:8004/regional/pension/soap/getFICOPEN/v11g` | N/A | N/A | N/A |
| **Protocolo Backend** | SOAP/HTTPS | N/A | N/A | N/A |
| **Timeout Request** | 70 segundos | N/A | N/A | N/A |
| **Timeout Conexión** | 65 segundos | N/A | N/A | N/A |
| **Retry Count** | 0 | N/A | N/A | N/A |
| **Transformaciones Request** | `getFICOPENIn.xq`, `getFICOPENHeaderIn.xq` | N/A | N/A | N/A |
| **Transformaciones Response** | `getFICOPENOut.xq` | N/A | N/A | N/A |
| **Campos Diferenciadores** | Ninguno (estructura estándar) | N/A | N/A | N/A |
| **Validación XSD** | `consultaFICOPENTypes.xsd` | `consultaFICOPENTypes.xsd` | `consultaFICOPENTypes.xsd` | `consultaFICOPENTypes.xsd` |
| **Autenticación Backend** | OSB12AUTH (credenciales desde servicio de seguridad) | N/A | N/A | N/A |
| **Manejo de Errores** | MapeoErrores (FICBCO0110) | Error MW-0008 | Error MW-0008 | Error MW-0008 |
| **Código de Error No Implementado** | N/A | MW-0008 | MW-0008 | MW-0008 |
| **Mensaje de Error No Implementado** | N/A | "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY" | "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY" | "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY" |
| **Service ID** | FICBCO0110 | FICBCO0110 | FICBCO0110 | FICBCO0110 |
| **Logging Level** | Debug | Debug | Debug | Debug |
| **Monitoring** | Habilitado (360s) | Habilitado (360s) | Habilitado (360s) | Habilitado (360s) |
| **Throttling** | Deshabilitado | Deshabilitado | Deshabilitado | Deshabilitado |
| **Dependencias Internas** | ValidaServicioRegional_db, MapeoErrores | ValidaServicioRegional_db, MapeoErrores | ValidaServicioRegional_db, MapeoErrores | ValidaServicioRegional_db, MapeoErrores |

---

## Detalle por Región

### 1. HN01 (Honduras) - IMPLEMENTADO ✅

#### 1.1 Descripción General
Honduras es la única región con implementación completa del servicio ConsultaFICOPEN. El servicio se conecta al sistema de Fondos de Pensiones Complementarias (FPC) para consultar información de cuentas de inversión.

#### 1.2 Endpoints y Conexiones

**Endpoint OSB (Entrada):**
- URL: `/SMiddleware/OperationsAndExecution/BundledProducts/ConsultaFICOPEN_v2`
- Protocolo: SOAP 1.1 / HTTP
- Binding: Document/Literal
- WSDL: `Middleware/v2/Resources/ConsultaFICOPEN/wsdl/consultaFICOPENPS.wsdl`

**Endpoint Backend (Salida):**
- URL: `https://dynamoosbdev:8004/regional/pension/soap/getFICOPEN/v11g`
- Protocolo: SOAP / HTTPS
- Business Service: `Middleware/v2/BusinessServices/FPC/getFicopen12c/biz/getFicopen12c.biz`
- Timeout: 70 segundos
- Connection Timeout: 65 segundos
- Retry: 0 (sin reintentos)

**Conexión a Base de Datos:**
- JNDI: `eis/DB/ConnectionMiddleware`
- Tipo: Database Adapter (JCA)
- Stored Procedure: `MW_P_VALIDA_SERVICIO_REGIONAL`
- Parámetros IN:
  - `PV_SERVICIO`: "FICBCO0110"
  - `PV_ORIGEN`: Valor de `SourceBank` (ej: "HN01")
  - `PV_DESTINO`: Valor de `DestinationBank` (o `SourceBank` si está vacío)
- Parámetros OUT:
  - `PV_CODIGO_ERROR`: Código de resultado ("SUCCESS" o código de error)
  - `PV_MENSAJE_ERROR`: Mensaje descriptivo del error

#### 1.3 Flujo de Procesamiento

**Pipeline: ValidacionesGenerales**
1. **Stage: ValidacionXSD**
   - Valida el request contra `consultaFICOPENTypes.xsd`
   - Elemento validado: `consultaFICOPEN`
   - Campos obligatorios:
     - `INVESTMENT_CODE` (mínimo 1 carácter)
     - `START_DATE` (exactamente 8 caracteres)
     - `END_DATE` (exactamente 8 caracteres)

2. **Stage: ValidacionServicioRegional**
   - Invoca SP `MW_P_VALIDA_SERVICIO_REGIONAL`
   - Si `PV_CODIGO_ERROR != 'SUCCESS'`:
     - Retorna error inmediatamente
     - No invoca backend
   - Si `PV_CODIGO_ERROR = 'SUCCESS'`:
     - Aplica valores por defecto de región con `aplicarValoresPorDefectoRegion.xq`
     - Continúa al siguiente stage

**Branch: RegionalizacionPaisEmpresa**
- Condición: `./aut:RequestHeader/Region/SourceBank = 'HN01'`
- Enruta a: Pipeline `HNBanco_ConsultaFICOPEN`

**Pipeline: HNBanco_ConsultaFICOPEN_request**

**Stage: FlujoEntrada**
1. **Construcción del Header:**
   - XQuery: `getFICOPENHeaderIn.xq`
   - Obtiene credenciales de: `Middleware/Security/OSB12AUTH`
   - Función: `fn-bea:lookupBasicCredentials()`
   - Construye header con:
     - `UserName`: Credencial obtenida o fallback a 'OSB12AUTH'
     - `Password`: Credencial obtenida o fallback a 'OSB12AUTH'
     - `SourceBank`: Del request original
     - `DestinationBank`: Del request original o `SourceBank` si está vacío

2. **Transformación del Body:**
   - XQuery: `getFICOPENIn.xq`
   - Mapeo directo (pass-through):
     - `INVESTMENT_CODE` → `INVESTMENT_CODE`
     - `START_DATE` → `START_DATE`
     - `END_DATE` → `END_DATE`

3. **Invocación del Business Service:**
   - Service: `getFicopen12c`
   - Operation: `consultaFICOPEN`
   - Request: `$REQconsultaFICOPEN` (body) + `$REQHeaderConsultaFICOPEN` (header)
   - Response: `$RSPconsultaFICOPEN` (body) + `$RSPHeaderConsultaFICOPEN` (header)

4. **Captura de Variables:**
   - `$errorCode` = `$RSPHeaderConsultaFICOPEN/aut:ResponseHeader/successIndicator`
   - `$message` = `$RSPHeaderConsultaFICOPEN/aut:ResponseHeader/messages`

**Pipeline: HNBanco_ConsultaFICOPEN_response**

**Stage: FlujoSalida**
1. **Evaluación de Resultado:**
   - Si `upper-case($errorCode) = 'SUCCESS'`:
     - Header: `<successIndicator>SUCCESS</successIndicator>`
     - Body: Transformado con `getFICOPENOut.xq`
   - Si error:
     - Header: `<successIndicator>ERROR</successIndicator>` + mensaje
     - Body: `<consultaFICOPENResponse/>` (vacío)

2. **Transformación Response Exitoso:**
   - XQuery: `getFICOPENOut.xq`
   - Mapeo completo de todos los campos:
     - Información del cliente (CUSTOMER_LEGAL_ID, CUSTOMER_NAME)
     - Información de cuenta (ACCOUNT_NUMBER, ACCOUNT_CURRENCY)
     - Información de contrato (CONTRACT_NUMBER, CONTRACT_TYPE, COMPANY, START_DATE)
     - Array de balances (consultaFICOPENResponseType/consultaFICOPENResponseRecordType)
       - BALANCE_TYPE
       - PREVIOUS_BALANCE
       - GROSS_CONTRIBUTIONS_AMOUNT
       - INTEREST_AMOUNT
       - WITHDRAWALS_AMOUNT
       - FEE_AMOUNT
       - INSURANCE_AMOUNT
       - CURRENT_BALANCE

**Stage: MapeoError**
1. **Condición:** Si `successIndicator != "SUCCESS"`
2. **Invocación MapeoErrores:**
   - Service: `Middleware/v2/ProxyServices/MapeoErrores`
   - Operation: `mapeoErrores`
   - Request:
     - `CODIGO_ERROR`: `successIndicator` en mayúsculas
     - `MENSAJE_ERROR`: `"FICBCO0110$#$" + messages`
   - Response: Mensaje de error estandarizado
3. **Actualización del Header:**
   - Reemplaza el header con el mensaje mapeado

#### 1.4 Manejo de Errores

**Error Handler: _onErrorHandler**

**Stage: ManejoError**
1. **Evaluación del Tipo de Error:**
   - Si `$fault/ctx:errorCode = "BEA-382505"` (error de validación XSD):
     - Transforma con `mapeoErrorValidate.xq`
   - Otros errores:
     - Construye mensaje genérico: `errorCode + ": " + reason`

2. **Mapeo de Error:**
   - Invoca `MapeoErrores` con:
     - Service ID: "FICBCO0110"
     - Código y mensaje del error

3. **Response de Error:**
   - Body: `<consultaFICOPENResponse/>` (vacío)
   - Header: `successIndicator=ERROR` + mensaje mapeado

#### 1.5 Políticas de Seguridad

**Autenticación OSB:**
- Tipo: Custom Token Authentication
- Username Selector: `./aut:RequestHeader/Authentication/UserName/text()`
- Password Selector: `./aut:RequestHeader/Authentication/Password/text()`
- Variable: `header`

**Autenticación Backend:**
- Credenciales obtenidas dinámicamente de: `Middleware/Security/OSB12AUTH`
- Método: `fn-bea:lookupBasicCredentials()`
- Fallback: Si no se encuentran credenciales, usa 'OSB12AUTH' como valor

#### 1.6 Configuración de Monitoreo

- **Monitoring**: Habilitado
- **Aggregation Interval**: 360 segundos
- **Pipeline Monitoring Level**: Action
- **Logging**: Habilitado (Debug)
- **SLA Alerting**: Habilitado (Normal)
- **Pipeline Alerting**: Habilitado (Normal)
- **Message Tracing**: Deshabilitado
- **Reporting**: Habilitado

#### 1.7 Validaciones Específicas

**Validación XSD:**
- `INVESTMENT_CODE`: Mínimo 1 carácter
- `START_DATE`: Exactamente 8 caracteres (formato YYYYMMDD)
- `END_DATE`: Exactamente 8 caracteres (formato YYYYMMDD)

**Validación Regional:**
- Service ID: "FICBCO0110"
- Debe estar registrado en BD para región HN01
- Si falla, retorna error antes de invocar backend

#### 1.8 Campos Diferenciadores

**No hay campos diferenciadores específicos para HN01.** La estructura del request y response es estándar y podría ser reutilizada por otras regiones.

---

### 2. GT01 (Guatemala) - NO IMPLEMENTADO ❌

#### 2.1 Estado Actual
El servicio **NO está implementado** para Guatemala. Cuando se invoca con `SourceBank = 'GT01'`, el flujo entra en el branch `Default` que retorna un error.

#### 2.2 Comportamiento

**Branch: Default_ConsultaFICOPEN**
- Pipeline: `Default_ConsultaFICOPEN_request` (vacío)
- Pipeline: `Default_ConsultaFICOPEN_response`
  - **Stage: FlujoSalida**
    - Genera error:
      - Código: `MW-0008`
      - Mensaje: `"SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"`

#### 2.3 Validaciones Aplicadas

**Validaciones Comunes:**
- ✅ Validación XSD (igual que HN01)
- ✅ Validación de Servicio Regional (debe estar registrado en BD)

**Validaciones Específicas:**
- ❌ No hay validaciones específicas de GT01

#### 2.4 Endpoints y Conexiones

**Endpoint OSB:**
- ✅ Mismo endpoint que HN01: `/SMiddleware/OperationsAndExecution/BundledProducts/ConsultaFICOPEN_v2`

**Backend:**
- ❌ No hay Business Service configurado
- ❌ No hay endpoint backend
- ❌ No hay transformaciones específicas

#### 2.5 Requerimientos para Implementación

Para implementar el servicio en Guatemala se requeriría:

1. **Business Service Backend:**
   - Identificar el sistema de fondos de pensiones en Guatemala
   - Configurar endpoint SOAP/REST
   - Definir timeouts y políticas de retry

2. **Transformaciones:**
   - Crear XQuery de mapeo si el formato difiere de HN01
   - O reutilizar las transformaciones existentes si el formato es compatible

3. **Validación Regional:**
   - Registrar el servicio FICBCO0110 para GT01 en la BD de middleware

4. **Pipeline Específico:**
   - Crear branch `GTBanco` en `RegionalizacionPaisEmpresa`
   - Implementar pipelines `GTBanco_ConsultaFICOPEN_request` y `GTBanco_ConsultaFICOPEN_response`

5. **Credenciales:**
   - Configurar credenciales de autenticación para el backend de Guatemala

---

### 3. PA01 (Panamá) - NO IMPLEMENTADO ❌

#### 3.1 Estado Actual
El servicio **NO está implementado** para Panamá. Comportamiento idéntico a Guatemala.

#### 3.2 Comportamiento
- Mismo comportamiento que GT01
- Entra en branch `Default`
- Retorna error `MW-0008`: "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"

#### 3.3 Validaciones Aplicadas
- ✅ Validación XSD (igual que HN01)
- ✅ Validación de Servicio Regional (debe estar registrado en BD)

#### 3.4 Requerimientos para Implementación
Mismos requerimientos que GT01 (ver sección 2.5)

---

### 4. NI01 (Nicaragua) - NO IMPLEMENTADO ❌

#### 4.1 Estado Actual
El servicio **NO está implementado** para Nicaragua. Comportamiento idéntico a Guatemala y Panamá.

#### 4.2 Comportamiento
- Mismo comportamiento que GT01 y PA01
- Entra en branch `Default`
- Retorna error `MW-0008`: "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"

#### 4.3 Validaciones Aplicadas
- ✅ Validación XSD (igual que HN01)
- ✅ Validación de Servicio Regional (debe estar registrado en BD)

#### 4.4 Requerimientos para Implementación
Mismos requerimientos que GT01 (ver sección 2.5)

---

## Resumen de Diferencias

### Diferencias Principales

| Aspecto | HN01 | GT01, PA01, NI01 |
|---------|------|------------------|
| **Implementación** | Completa | No implementada |
| **Backend** | Sistema FPC (Fondos de Pensiones) | N/A |
| **Transformaciones** | 3 XQuery (In, Out, HeaderIn) | N/A |
| **Manejo de Errores** | Completo con MapeoErrores | Solo error genérico MW-0008 |
| **Timeout** | 70s request, 65s conexión | N/A |
| **Autenticación Backend** | OSB12AUTH | N/A |

### Similitudes

| Aspecto | Todas las Regiones |
|---------|-------------------|
| **Endpoint OSB** | `/SMiddleware/OperationsAndExecution/BundledProducts/ConsultaFICOPEN_v2` |
| **Validación XSD** | `consultaFICOPENTypes.xsd` |
| **Validación Regional** | `MW_P_VALIDA_SERVICIO_REGIONAL` |
| **Service ID** | FICBCO0110 |
| **Estructura Request** | Idéntica (INVESTMENT_CODE, START_DATE, END_DATE) |
| **Estructura Response** | Idéntica (definida en XSD) |
| **Autenticación OSB** | Custom Token (Username/Password en header) |
| **Monitoring** | Habilitado (360s) |
| **Logging** | Debug |

---

## Conclusiones

1. **Solo HN01 está operativo**: Honduras es la única región con implementación completa y funcional.

2. **Arquitectura preparada para multiregión**: La estructura del proxy con branch por región está diseñada para soportar múltiples países, pero solo HN01 está implementado.

3. **Reutilización potencial**: Las transformaciones y estructura de datos son genéricas y podrían reutilizarse para otras regiones si los backends tienen contratos similares.

4. **Validación regional centralizada**: Todas las regiones comparten el mismo mecanismo de validación mediante SP en BD.

5. **Sin diferencias en contrato**: El contrato SOAP (request/response) es idéntico para todas las regiones, lo que facilita la implementación futura de otras regiones.

6. **Dependencia de backend específico**: La implementación de nuevas regiones depende de la disponibilidad de sistemas de fondos de pensiones en cada país.

---

**Nota**: Para implementar el servicio en GT01, PA01 o NI01, se requiere:
- Identificar y conectar con el sistema de fondos de pensiones del país
- Configurar Business Service con endpoint correspondiente
- Crear o adaptar transformaciones XQuery
- Registrar el servicio en la BD de validación regional
- Configurar credenciales de autenticación
