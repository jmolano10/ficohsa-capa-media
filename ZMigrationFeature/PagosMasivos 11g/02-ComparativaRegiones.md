# Comparativa entre Regiones - PagosMasivos

## Tabla de Comparación General

| Aspecto | HN01 (Honduras) | GT01 (Guatemala) | PA01 (Panamá) | NI01 (Nicaragua) |
|---------|-----------------|------------------|---------------|------------------|
| **Endpoint OSB** | `/Middleware/OperationsAndExecution/Payments/PagosMasivos` | `/Middleware/OperationsAndExecution/Payments/PagosMasivos` | `/Middleware/OperationsAndExecution/Payments/PagosMasivos` | `/Middleware/OperationsAndExecution/Payments/PagosMasivos` |
| **Proxy Interno** | PagosMasivosInterno.proxy | PagosMasivosInternoGT.proxy | PagosMasivosInternoPA.proxy | PagosMasivosInterno.proxy |
| **Servicio Backend Principal** | sjPagosMasivosInterno (SJS) | cargadorArchivoLote (MTR) | cargadorArchivoLote (MTR) | cargadorArchivoLote (MTR) |
| **Tipo de Servicio** | Java Service (local) | Web Service SOAP (externo) | Web Service SOAP (externo) | Web Service SOAP (externo) |
| **Base de Datos Bitácora** | PMSV (registraBitacoraPagosMasivos) | PMSV (registraBitacoraPagosMasivosRG) | PMSV (registraBitacoraPagosMasivosRG) | No implementado |
| **Esquema BD** | PMSV | PMSV | PMSV | N/A |
| **Stored Procedure Bitácora** | registraBitacoraPagosMasivos | registraBitacoraPagosMasivosRG | registraBitacoraPagosMasivosRG | N/A |
| **Validación de Acceso** | validaAccesoPMS_db (PMSV) | validaAccesoPMS (MTR Web Service) | validaAccesoPMS (MTR Web Service) | No detectado |
| **Transformaciones Request** | sjPagosMasivosInternoIn.xq | pagosMasivosInternoGTIn.xq | pagosMasivosInternoPAIn.xq | pagosMasivosInternoNIIn.xq |
| **Transformaciones Response** | pagosMasivosInternoOut.xq | pagosMasivosInternoGTOut.xq | pagosMasivosInternoPAOut.xq | pagosMasivosInternoNIOut.xq |
| **Transformaciones Header** | N/A | pagosMasivosInternoGTHeaderOut.xq | pagosMasivosInternoPAHeaderOut.xq | pagosMasivosInternoNIHeaderOut.xq |
| **Validación Regional** | ValidaServicioRegional_db (FICBCO0231) | ValidaServicioRegional_db (FICBCO0231) | ValidaServicioRegional_db (FICBCO0231) | ValidaServicioRegional_db (FICBCO0231) |
| **Manejo de Errores** | MapeoErrores.proxy | MapeoErrores.proxy | MapeoErrores.proxy | MapeoErrores.proxy |
| **Código de Servicio** | FICBCO0231 | FICBCO0231 | FICBCO0231 | FICBCO0231 |
| **Timeout/Retry** | No configurado explícitamente | No configurado explícitamente | No configurado explícitamente | No configurado explícitamente |
| **Dependencias Internas** | SJS, PMSV DB, MapeoErrores | MTR, PMSV DB, MapeoErrores | MTR, PMSV DB, MapeoErrores | MTR, MapeoErrores |

---

## Detalle por Región

### HN01 - Honduras

#### Características Específicas

**Arquitectura:**
- Usa servicios Java locales (SJS - Service Java Service)
- Procesamiento interno sin dependencias externas HTTP
- Mayor control sobre la lógica de negocio

**Flujo de Procesamiento:**
1. Validación XSD del request
2. Validación de servicio regional (BD)
3. Bitácora de request en BD
4. Validación de acceso cliente (Stored Procedure)
5. Invocación a sjPagosMasivosInterno (Java)
6. Transformación de respuesta
7. Bitácora de response en BD
8. Mapeo de errores si aplica

**Servicios de Base de Datos:**
- **Conexión**: PMSV
- **SP Bitácora**: `registraBitacoraPagosMasivos`
  - Parámetros: id, requestId, recordDate, recordType, operation, customerId, username, authUsername, requestHost, soapContent, responseCode, responseMessage, globalId
- **SP Validación Acceso**: `validaAccesoPMS`
  - Parámetros: CUSTOMER_ID, USER_NAME
  - Retorna: ERROR_MESSAGE

**Transformaciones XQuery:**
- `sjPagosMasivosInternoIn.xq`: Mapea request OSB → SJS
- `pagosMasivosInternoOut.xq`: Mapea response SJS → OSB
- `registrarBitacoraPagosMasivosIn.xq`: Prepara datos para bitácora
- `validarAccesoPMSIn.xq`: Prepara validación de acceso

**Campos Diferenciadores:**
- Usa campo `validationMessage` para control de flujo
- No requiere transformación de header en response
- Procesamiento síncrono con Java

**Manejo de Errores:**
- Error handler: `_onErrorHandler-2505472247673107556-63174895.1566ba355e3.-64f8`
- Captura errorCode y errorMessage del fault
- Invoca MapeoErrores con código FICBCO0231
- Registra error en bitácora antes de responder

---

### GT01 - Guatemala

#### Características Específicas

**Arquitectura:**
- Usa servicios web externos MTR (Middleware Transaccional Regional)
- Comunicación SOAP con sistema externo
- Bitácora regional separada

**Flujo de Procesamiento:**
1. Bitácora de request en BD (RG)
2. Validación de acceso (Web Service MTR)
3. Carga de lotes (Web Service MTR)
4. Transformación de header y body
5. Bitácora de response en BD (RG)

**Servicios de Base de Datos:**
- **Conexión**: PMSV
- **SP Bitácora**: `registraBitacoraPagosMasivosRG`
  - Parámetros adicionales: countryCode
  - Diferencia: incluye código de país en registro

**Servicios Web Externos:**
- **Servicio**: cargadorArchivoLote (MTR)
- **Endpoint**: Middleware/v2/BusinessServices/MTR/cargadorArchivoLote/biz/cargadorArchivoLote
- **Operación**: cargarLotes
- **WSDL**: cargadorArchivoLoteEndpoint.wsdl
- **Namespace**: http://servicio.cargararchivolotews.mtrpmsv.cidenet.com.co/

**Validación de Acceso:**
- **Servicio**: validaAccesoPMS (MTR)
- **Endpoint**: Middleware/v2/BusinessServices/MTR/validaAccesoPMS/biz/validaAccesoPMS
- **Operación**: validaAccesoPMS
- **Request**: customerId, userName
- **Response**: status (00000 = SUCCESS), message

**Transformaciones XQuery:**
- `pagosMasivosInternoGTIn.xq`: Mapea request OSB → MTR
- `pagosMasivosInternoGTOut.xq`: Mapea response MTR → OSB
- `pagosMasivosInternoGTHeaderOut.xq`: Construye header de respuesta
- `registrarBitacoraPagosMasivosRGIn.xq`: Bitácora regional
- `validarAccesoPMSRGIn.xq`: Validación regional

**Campos Diferenciadores:**
- Usa `errorCode` y `validationMessage` como variables de control
- Response MTR incluye: `respuestaHostToHost/cabeceraRespuesta/codigo` y `mensaje`
- Validación retorna status numérico (00000 = éxito)
- Incluye countryCode en bitácora

**Manejo de Errores:**
- Error handler: `_onErrorHandler-3717251208944543217-1dfaf105.1731a470050.-78d7`
- Bitácora de error con uuidBitacoraError
- Mapeo de errores con FICBCO0231

---

### PA01 - Panamá

#### Características Específicas

**Arquitectura:**
- Idéntica a GT01 en estructura
- Usa mismos servicios MTR
- Bitácora regional

**Flujo de Procesamiento:**
1. Bitácora de request en BD (RG)
2. Validación de acceso (Web Service MTR)
3. Carga de lotes (Web Service MTR)
4. Transformación de header y body
5. Bitácora de response en BD (RG)

**Servicios de Base de Datos:**
- **Conexión**: PMSV
- **SP Bitácora**: `registraBitacoraPagosMasivosRG`
- Misma estructura que GT01

**Servicios Web Externos:**
- **Servicio**: cargadorArchivoLote (MTR)
- Misma configuración que GT01

**Validación de Acceso:**
- **Servicio**: validaAccesoPMS (MTR)
- Misma configuración que GT01

**Transformaciones XQuery:**
- `pagosMasivosInternoPAIn.xq`: Mapea request OSB → MTR
- `pagosMasivosInternoPAOut.xq`: Mapea response MTR → OSB
- `pagosMasivosInternoPAHeaderOut.xq`: Construye header de respuesta
- `registrarBitacoraPagosMasivosRGIn.xq`: Bitácora regional
- `validarAccesoPMSRGIn.xq`: Validación regional

**Campos Diferenciadores:**
- Usa `validationMessage ` (con espacio) como nombre de variable
- Misma estructura de response que GT01
- Incluye countryCode = PA01 en bitácora

**Manejo de Errores:**
- Error handler: `_onErrorHandler-3717251208944543217-1dfaf105.1731a470050.-7c75`
- Estructura idéntica a GT01

---

### NI01 - Nicaragua

#### Características Específicas

**Arquitectura:**
- Usa servicios MTR como GT01 y PA01
- Implementado dentro de PagosMasivosInterno.proxy (no proxy separado)
- Sin bitácora de base de datos

**Flujo de Procesamiento:**
1. Validación XSD del request
2. Validación de servicio regional (BD)
3. Carga de lotes (Web Service MTR) - SIN validación de acceso previa
4. Transformación de header y body
5. Sin bitácora de response

**Servicios de Base de Datos:**
- **No implementado**: No registra bitácora

**Servicios Web Externos:**
- **Servicio**: cargadorArchivoLote (MTR)
- **Endpoint**: Middleware/v2/BusinessServices/MTR/cargadorArchivoLote/biz/cargadorArchivoLote
- **Operación**: cargarLotes
- Misma configuración que GT01/PA01

**Validación de Acceso:**
- **No implementado**: No valida acceso antes de procesar

**Transformaciones XQuery:**
- `pagosMasivosInternoNIIn.xq`: Mapea request OSB → MTR
- `pagosMasivosInternoNIOut.xq`: Mapea response MTR → OSB
- `pagosMasivosInternoNIHeaderOut.xq`: Construye header de respuesta

**Campos Diferenciadores:**
- **Sin validación de acceso**: Procesa directamente
- **Sin bitácora**: No registra en base de datos
- Response estructura similar a GT01/PA01
- Implementado como pipeline dentro de PagosMasivosInterno.proxy

**Manejo de Errores:**
- Usa error handler general de PagosMasivosInterno.proxy
- Sin bitácora de errores

---

## Diferencias Clave Identificadas

### 1. Arquitectura de Backend

| Región | Tipo | Proveedor | Características |
|--------|------|-----------|-----------------|
| HN01 | Java Service | SJS (interno) | Procesamiento local, mayor control |
| GT01 | Web Service | MTR (externo) | SOAP, dependencia externa |
| PA01 | Web Service | MTR (externo) | SOAP, dependencia externa |
| NI01 | Web Service | MTR (externo) | SOAP, sin validaciones previas |

### 2. Bitácora y Auditoría

| Región | Bitácora Request | Bitácora Response | Bitácora Error | SP Utilizado |
|--------|------------------|-------------------|----------------|--------------|
| HN01 | ✅ Sí | ✅ Sí | ✅ Sí | registraBitacoraPagosMasivos |
| GT01 | ✅ Sí | ✅ Sí | ✅ Sí | registraBitacoraPagosMasivosRG |
| PA01 | ✅ Sí | ✅ Sí | ✅ Sí | registraBitacoraPagosMasivosRG |
| NI01 | ❌ No | ❌ No | ❌ No | N/A |

### 3. Validación de Acceso

| Región | Implementado | Tipo | Criterio de Éxito |
|--------|--------------|------|-------------------|
| HN01 | ✅ Sí | Stored Procedure | ERROR_MESSAGE vacío |
| GT01 | ✅ Sí | Web Service | status = '00000' |
| PA01 | ✅ Sí | Web Service | status = '00000' |
| NI01 | ❌ No | N/A | N/A |

### 4. Transformaciones

Todas las regiones tienen transformaciones específicas para:
- Request: Mapeo OSB → Backend
- Response Body: Mapeo Backend → OSB
- Response Header: Construcción de header (excepto HN01)

### 5. Manejo de Errores

Todas las regiones:
- Usan MapeoErrores.proxy
- Código de servicio: FICBCO0231
- Capturan errorCode y errorMessage
- Retornan estructura estándar de error

---

## Recomendaciones de Unificación

### Prioridad Alta

1. **Unificar Bitácora**
   - Implementar bitácora para NI01
   - Considerar usar mismo SP para todas las regiones
   - Agregar campo region/country en SP único

2. **Estandarizar Validación de Acceso**
   - Implementar validación para NI01
   - Unificar criterios de éxito
   - Considerar servicio centralizado

3. **Arquitectura de Backend**
   - Evaluar migrar HN01 a MTR o viceversa
   - Unificar contratos de servicio
   - Estandarizar responses

### Prioridad Media

4. **Transformaciones**
   - Crear transformaciones genéricas con parámetros
   - Reducir duplicación de código XQuery
   - Centralizar lógica común

5. **Manejo de Errores**
   - Ya está unificado, mantener estándar
   - Documentar códigos de error por región

### Prioridad Baja

6. **Configuración**
   - Externalizar timeouts
   - Configurar retries
   - Agregar circuit breakers

---

## Matriz de Compatibilidad

| Funcionalidad | HN01 | GT01 | PA01 | NI01 | Notas |
|---------------|------|------|------|------|-------|
| Carga de Lotes | ✅ | ✅ | ✅ | ✅ | Todos implementados |
| Validación de Acceso | ✅ | ✅ | ✅ | ❌ | NI01 sin validación |
| Bitácora Completa | ✅ | ✅ | ✅ | ❌ | NI01 sin bitácora |
| Mapeo de Errores | ✅ | ✅ | ✅ | ✅ | Todos usan MapeoErrores |
| Validación Regional | ✅ | ✅ | ✅ | ✅ | Todos usan ValidaServicioRegional |
| Autenticación | ✅ | ✅ | ✅ | ✅ | Custom token en header |

---

## Conclusiones

1. **HN01** es la implementación más completa con validaciones y bitácora
2. **GT01 y PA01** son idénticas en estructura, solo difieren en transformaciones
3. **NI01** es la implementación más simple, sin validaciones ni bitácora
4. Existe oportunidad de unificación significativa
5. La migración debe considerar estas diferencias para no perder funcionalidad
