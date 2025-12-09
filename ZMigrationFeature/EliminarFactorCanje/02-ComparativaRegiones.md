# Comparativa entre Regiones - EliminarFactorCanje

## Tabla de Comparación General

| Aspecto | HN01 (Honduras) | GT01 (Guatemala) | PA01 (Panamá) | NI01 (Nicaragua) |
|---------|-----------------|------------------|---------------|------------------|
| **Endpoint OSB** | `Middleware/v2/ProxyServices/EliminarFactorCanjeHN` | `Middleware/v2/ProxyServices/EliminarFactorCanjeGT` | `Middleware/v2/ProxyServices/EliminarFactorCanjePA` | `Middleware/v2/ProxyServices/EliminarFactorCanjeNI` |
| **Nombre de Base de Datos** | Oracle DB (HN) | Oracle DB (GT) | Oracle DB (PA) | Oracle DB (NI) |
| **Esquema** | (default del usuario) | `PROXYABANKSGT` | `PROXYABANKSPA` | `PROXYNICARAGUA` |
| **Stored Procedure** | `PL_P_ELIMINAR_FACTOR_CANJE` | `PL_P_ELIMINAR_FACTOR_CANJE` | `PL_P_ELIMINAR_FACTOR_CANJE` | `PL_P_ELIMINAR_FACTOR_CANJE` |
| **Nombre de Conexión DB** | `ConnectionProxyAbanksHN` | `ConnectionProxyAbanksGT` | `ConnectionProxyAbanksPA` | `ConnectionProxyNI` |
| **Business Service** | `Middleware/v2/BusinessServices/ABK/eliminarFactorCanje/biz/eliminarFactorCanje_db` | `Middleware/v2/BusinessServices/ABKGT/eliminarFactorCanje/biz/eliminarFactorCanje_db` | `Middleware/v2/BusinessServices/ABKPA/eliminarFactorCanje/biz/eliminarFactorCanje_db` | `Middleware/v2/BusinessServices/PXYNIC/eliminarFactorCanje/biz/eliminarFactorCanje_db` |
| **Transformación XQuery** | `eliminarFactorCanjeHNIn.xq` | `eliminarFactorCanjeGTIn.xq` | `eliminarFactorCanjePAIn.xq` | `eliminarFactorCanjeIn.xq` |
| **Selector Type** | `SOAP body` | `SOAP body` | `SOAP action` | `SOAP action` |
| **Provider ID** | `local` | `local` | `local` | `http` |
| **URI Endpoint** | (local) | (local) | (local) | `/Middleware/v2/ProxyServices/EliminarFactorCanjeNI` |
| **Campos Diferenciadores** | Ninguno | Ninguno | Ninguno | Ninguno |
| **Errores/Excepciones** | Error handler estándar | Error handler estándar | Error handler estándar | Error handler estándar |
| **Timeouts** | No configurado | No configurado | No configurado | No configurado |
| **Retrys** | 0 reintentos | 0 reintentos | 0 reintentos | 0 reintentos |
| **Retry Interval** | 30 segundos | 30 segundos | 30 segundos | 30 segundos |
| **Dependencias Internas** | `eliminarFactorCanje_db` (ABK) | `eliminarFactorCanje_db` (ABKGT) | `eliminarFactorCanje_db` (ABKPA) | `eliminarFactorCanje_db` (PXYNIC) |
| **Tracing Enabled** | `false` | No especificado | No especificado | `false` |
| **Logging Level** | `debug` | `debug` | `debug` | `debug` |
| **Monitoring Enabled** | `false` | `false` | `false` | `false` |
| **SLA Alerting** | `enabled=true`, level=`normal` | `enabled=true`, level=`normal` | `enabled=true`, level=`normal` | `enabled=true`, level=`normal` |
| **Pipeline Alerting** | `enabled=true`, level=`normal` | `enabled=true`, level=`normal` | `enabled=true`, level=`normal` | `enabled=true`, level=`normal` |
| **Throttling** | `disabled` | `disabled` | `disabled` | `disabled` |
| **Result Caching** | `enabled=true` (not supported) | `enabled=true` (not supported) | `enabled=true` (not supported) | `enabled=true` (not supported) |

---

## Detalles por Región

### 1. Honduras (HN01)

#### 1.1. Proxy Service
- **Ruta**: `Middleware/v2/ProxyServices/EliminarFactorCanjeHN.proxy`
- **Pipeline Request**: `HN01_EliminarFactorCanje_request`
- **Pipeline Response**: `HN01_EliminarFactorCanje_response`
- **Error Handler**: `_onErrorHandler-209870744149950847-7198ec95.17cc2098005.-7451`

#### 1.2. Configuración de Binding
```xml
<ser:binding type="SOAP" isSoap12="false">
	<con:wsdl ref="Middleware/v2/Resources/EliminarFactorCanje/wsdl/eliminarFactorCanjePS"/>
	<con:port>
		<con:name>eliminarFactorCanjePSSOAP</con:name>
		<con:namespace>http://www.ficohsa.com.hn/middleware.services/eliminarFactorCanjePS/</con:namespace>
	</con:port>
	<con:selector type="SOAP body"/>
</ser:binding>
```

#### 1.3. Endpoint Configuration
- **Provider ID**: `local`
- **Inbound**: `true`
- **All Headers**: `true`

#### 1.4. Business Service
- **Ruta**: `Middleware/v2/BusinessServices/ABK/eliminarFactorCanje/biz/eliminarFactorCanje_db.biz`
- **Conexión JNDI**: `jca://eis/DB/ConnectionProxyAbanksHN`
- **Esquema**: (esquema por defecto del usuario de conexión)
- **Stored Procedure**: `PL_P_ELIMINAR_FACTOR_CANJE`
- **Adapter Type**: `DB`
- **Connection Mode**: `managed`

#### 1.5. Transformación XQuery
- **Archivo**: `Middleware/v2/Resources/EliminarFactorCanje/xq/eliminarFactorCanjeHNIn.xq`
- **Función**: `xf:eliminarFactorCanjeHNIn`
- **Parámetros de Entrada**:
	- `$eliminarFactorCanje` (element)
	- `$userName` (xs:string)
- **Mapeo**:
	- `PROMO_ID` → `PV_IDPROMOCION`
	- `upper-case($userName)` → `PV_USUARIO`

#### 1.6. Políticas OSB
- **WS-Policy**: `wsdl-policy-attachments`
- **Retry Count**: 0
- **Retry Interval**: 30 segundos
- **Retry Application Errors**: `true`
- **Load Balancing**: `round-robin`

#### 1.7. Handlers
- **Stage "FlujoEntrada"**: Invoca Business Service y captura respuesta
- **Stage "FujoSalida"**: Evalúa código de respuesta y construye header
- **Stage "ManejoError"**: Captura excepciones y construye response de error

#### 1.8. Validaciones
- Validación de `errorCode = 'SUCCESS'` para determinar éxito
- Si `errorCode != 'SUCCESS'`, se incluye `validationMessage` en el header

---

### 2. Guatemala (GT01)

#### 2.1. Proxy Service
- **Ruta**: `Middleware/v2/ProxyServices/EliminarFactorCanjeGT.proxy`
- **Pipeline Request**: `GT01_EliminarFactorCanje_request`
- **Pipeline Response**: `GT01_EliminarFactorCanje_response`
- **Error Handler**: `_onErrorHandler-222030136084947819--55d11224.16afe96a9fa.-7a70`

#### 2.2. Configuración de Binding
```xml
<ser:binding type="SOAP" isSoap12="false">
	<con:wsdl ref="Middleware/v2/Resources/EliminarFactorCanje/wsdl/eliminarFactorCanjePS"/>
	<con:port>
		<con:name>eliminarFactorCanjePSSOAP</con:name>
		<con:namespace>http://www.ficohsa.com.hn/middleware.services/eliminarFactorCanjePS/</con:namespace>
	</con:port>
	<con:selector type="SOAP body"/>
</ser:binding>
```

#### 2.3. Endpoint Configuration
- **Provider ID**: `local`
- **Inbound**: `true`
- **All Headers**: `true`

#### 2.4. Business Service
- **Ruta**: `Middleware/v2/BusinessServices/ABKGT/eliminarFactorCanje/biz/eliminarFactorCanje_db.biz`
- **Conexión JNDI**: `jca://eis/DB/ConnectionProxyAbanksGT`
- **Esquema**: `PROXYABANKSGT` (explícitamente configurado)
- **Stored Procedure**: `PL_P_ELIMINAR_FACTOR_CANJE`
- **Adapter Type**: `DB`
- **Connection Mode**: `managed`

#### 2.5. Transformación XQuery
- **Archivo**: `Middleware/v2/Resources/EliminarFactorCanje/xq/eliminarFactorCanjeGTIn.xq`
- **Función**: `xf:eliminarFactorCanjeGTIn`
- **Parámetros de Entrada**:
	- `$eliminarFactorCanje1` (element)
	- `$userName` (xs:string)
- **Mapeo**:
	- `PROMO_ID` → `PV_IDPROMOCION`
	- `upper-case($userName)` → `PV_USUARIO`

#### 2.6. Políticas OSB
- **WS-Policy**: `wsdl-policy-attachments`
- **Retry Count**: 0
- **Retry Interval**: 30 segundos
- **Retry Application Errors**: `true`
- **Load Balancing**: `round-robin`

#### 2.7. Handlers
- **Stage "FlujoEntrada"**: Invoca Business Service y captura respuesta
- **Stage "FujoSalida"**: Evalúa código de respuesta y construye header
- **Stage "ManejoError"**: Captura excepciones y construye response de error

#### 2.8. Validaciones
- Validación de `errorCode = 'SUCCESS'` para determinar éxito
- Si `errorCode != 'SUCCESS'`, se incluye `validationMessage` en el header

#### 2.9. Diferencias con HN01
- **Esquema explícito**: GT01 especifica `PROXYABANKSGT`, HN01 usa el esquema por defecto
- **Nombre de variable**: GT01 usa `$eliminarFactorCanje1`, HN01 usa `$eliminarFactorCanje`
- **Business Service path**: Diferente carpeta (ABKGT vs ABK)

---

### 3. Panamá (PA01)

#### 3.1. Proxy Service
- **Ruta**: `Middleware/v2/ProxyServices/EliminarFactorCanjePA.proxy`
- **Pipeline Request**: `PA01_EliminarFactorCanje_request`
- **Pipeline Response**: `PA01_EliminarFactorCanje_response`
- **Error Handler**: `_onErrorHandler-222030136084947819--55d11224.16afe96a9fa.-7bb0`

#### 3.2. Configuración de Binding
```xml
<ser:binding type="SOAP" isSoap12="false">
	<con:wsdl ref="Middleware/v2/Resources/EliminarFactorCanje/wsdl/eliminarFactorCanjePS"/>
	<con:port>
		<con:name>eliminarFactorCanjePSSOAP</con:name>
		<con:namespace>http://www.ficohsa.com.hn/middleware.services/eliminarFactorCanjePS/</con:namespace>
	</con:port>
	<con:selector type="SOAP action"/>
</ser:binding>
```

#### 3.3. Endpoint Configuration
- **Provider ID**: `local`
- **Inbound**: `true`
- **All Headers**: `true`

#### 3.4. Business Service
- **Ruta**: `Middleware/v2/BusinessServices/ABKPA/eliminarFactorCanje/biz/eliminarFactorCanje_db.biz`
- **Conexión JNDI**: `jca://eis/DB/ConnectionProxyAbanksPA`
- **Esquema**: `PROXYABANKSPA` (explícitamente configurado)
- **Stored Procedure**: `PL_P_ELIMINAR_FACTOR_CANJE`
- **Adapter Type**: `DB`
- **Connection Mode**: `managed`

#### 3.5. Transformación XQuery
- **Archivo**: `Middleware/v2/Resources/EliminarFactorCanje/xq/eliminarFactorCanjePAIn.xq`
- **Función**: `xf:eliminarFactorCanjePAIn`
- **Parámetros de Entrada**:
	- `$eliminarFactorCanje1` (element)
	- `$userName` (xs:string)
- **Mapeo**:
	- `PROMO_ID` → `PV_IDPROMOCION`
	- `upper-case($userName)` → `PV_USUARIO`

#### 3.6. Políticas OSB
- **WS-Policy**: `wsdl-policy-attachments`
- **Retry Count**: 0
- **Retry Interval**: 30 segundos
- **Retry Application Errors**: `true`
- **Load Balancing**: `round-robin`

#### 3.7. Handlers
- **Stage "FlujoEntrada"**: Invoca Business Service y captura respuesta
- **Stage "FlujoSalida"**: Evalúa código de respuesta y construye header
- **Stage "ManejoError"**: Captura excepciones y construye response de error

#### 3.8. Validaciones
- Validación de `errorCode = 'SUCCESS'` para determinar éxito
- Si `errorCode != 'SUCCESS'`, se incluye `validationMessage` en el header

#### 3.9. Diferencias con HN01 y GT01
- **Selector Type**: `SOAP action` en lugar de `SOAP body`
- **Esquema explícito**: `PROXYABANKSPA`
- **Nombre de variable**: Usa `$eliminarFactorCanje1` (igual que GT01)
- **Business Service path**: Carpeta ABKPA

---

### 4. Nicaragua (NI01)

#### 4.1. Proxy Service
- **Ruta**: `Middleware/v2/ProxyServices/EliminarFactorCanjeNI.proxy`
- **Pipeline Request**: `NI01_EliminarFactorCanje_request`
- **Pipeline Response**: `NI01_EliminarFactorCanje_response`
- **Error Handler**: `_onErrorHandler-209870744149950847-7198ec95.17cc2098005.-7db9`

#### 4.2. Configuración de Binding
```xml
<ser:binding type="SOAP" isSoap12="false">
	<con:wsdl ref="Middleware/v2/Resources/EliminarFactorCanje/wsdl/eliminarFactorCanjePS"/>
	<con:port>
		<con:name>eliminarFactorCanjePSSOAP</con:name>
		<con:namespace>http://www.ficohsa.com.hn/middleware.services/eliminarFactorCanjePS/</con:namespace>
	</con:port>
	<con:selector type="SOAP action"/>
</ser:binding>
```

#### 4.3. Endpoint Configuration
- **Provider ID**: `http` (diferente a otras regiones)
- **Inbound**: `true`
- **URI**: `/Middleware/v2/ProxyServices/EliminarFactorCanjeNI`
- **All Headers**: `false` (diferente a otras regiones)

#### 4.4. Business Service
- **Ruta**: `Middleware/v2/BusinessServices/PXYNIC/eliminarFactorCanje/biz/eliminarFactorCanje_db.biz`
- **Conexión JNDI**: `jca://eis/DB/ConnectionProxyNI`
- **Esquema**: `PROXYNICARAGUA` (explícitamente configurado)
- **Stored Procedure**: `PL_P_ELIMINAR_FACTOR_CANJE`
- **Adapter Type**: `DB`
- **Connection Mode**: `managed`

#### 4.5. Transformación XQuery
- **Archivo**: `Middleware/v2/Resources/EliminarFactorCanje/xq/eliminarFactorCanjeIn.xq`
- **Función**: `xf:eliminarFactorCanjeIn`
- **Parámetros de Entrada**:
	- `$eliminarFactorCanje1` (element)
	- `$userName` (xs:string)
- **Mapeo**:
	- `PROMO_ID` → `PV_IDPROMOCION`
	- `upper-case($userName)` → `PV_USUARIO`

#### 4.6. Políticas OSB
- **WS-Policy**: `wsdl-policy-attachments`
- **Retry Count**: 0
- **Retry Interval**: 30 segundos
- **Retry Application Errors**: `true`
- **Load Balancing**: `round-robin`

#### 4.7. Handlers
- **Stage "FlujoEntrada"**: Invoca Business Service y captura respuesta
- **Stage "FlujoSalida"**: Evalúa código de respuesta y construye header
- **Stage "ManejoError"**: Captura excepciones y construye response de error

#### 4.8. Validaciones
- Validación de `errorCode = 'SUCCESS'` para determinar éxito
- Si `errorCode != 'SUCCESS'`, se incluye `validationMessage` en el header

#### 4.9. Diferencias con Otras Regiones
- **Provider ID**: `http` en lugar de `local`
- **URI explícito**: `/Middleware/v2/ProxyServices/EliminarFactorCanjeNI`
- **All Headers**: `false` en lugar de `true`
- **Selector Type**: `SOAP action` (igual que PA01)
- **Esquema explícito**: `PROXYNICARAGUA`
- **Business Service path**: Carpeta PXYNIC

---

## Análisis de Diferencias Clave

### 1. Selector Type

| Región | Selector Type | Implicación |
|--------|---------------|-------------|
| HN01 | `SOAP body` | Enrutamiento basado en el contenido del body SOAP |
| GT01 | `SOAP body` | Enrutamiento basado en el contenido del body SOAP |
| PA01 | `SOAP action` | Enrutamiento basado en el header SOAPAction |
| NI01 | `SOAP action` | Enrutamiento basado en el header SOAPAction |

**Impacto**: Los clientes que invocan PA01 y NI01 deben incluir el header `SOAPAction` en sus requests, mientras que HN01 y GT01 no lo requieren.

### 2. Provider ID y Endpoint Configuration

| Región | Provider ID | URI Explícito | All Headers |
|--------|-------------|---------------|-------------|
| HN01 | `local` | No | `true` |
| GT01 | `local` | No | `true` |
| PA01 | `local` | No | `true` |
| NI01 | `http` | `/Middleware/v2/ProxyServices/EliminarFactorCanjeNI` | `false` |

**Impacto**: NI01 tiene una configuración de endpoint diferente, posiblemente para permitir invocación HTTP directa. El `all-headers=false` puede causar pérdida de headers personalizados.

### 3. Esquemas de Base de Datos

| Región | Esquema | Configuración |
|--------|---------|---------------|
| HN01 | (default) | No especificado en JCA |
| GT01 | `PROXYABANKSGT` | Especificado en JCA property `SchemaName` |
| PA01 | `PROXYABANKSPA` | Especificado en JCA property `SchemaName` |
| NI01 | `PROXYNICARAGUA` | Especificado en JCA property `SchemaName` |

**Impacto**: HN01 depende del esquema por defecto del usuario de conexión, lo que puede causar problemas si el usuario tiene acceso a múltiples esquemas.

### 4. Nombres de Variables en XQuery

| Región | Variable de Request | Consistencia |
|--------|---------------------|--------------|
| HN01 | `$eliminarFactorCanje` | Diferente |
| GT01 | `$eliminarFactorCanje1` | Estándar |
| PA01 | `$eliminarFactorCanje1` | Estándar |
| NI01 | `$eliminarFactorCanje1` | Estándar |

**Impacto**: Inconsistencia menor en nombres de variables, no afecta funcionalidad pero dificulta mantenimiento.

### 5. Carpetas de Business Services

| Región | Carpeta | Patrón |
|--------|---------|--------|
| HN01 | `ABK` | Abanks (sin sufijo regional) |
| GT01 | `ABKGT` | Abanks + sufijo regional |
| PA01 | `ABKPA` | Abanks + sufijo regional |
| NI01 | `PXYNIC` | Proxy + código regional |

**Impacto**: Inconsistencia en convención de nombres. NI01 usa un patrón diferente (`PXYNIC` en lugar de `ABKNI`).

---

## Similitudes entre Regiones

### 1. Estructura de Pipelines
Todas las regiones siguen la misma estructura:
- **Request Pipeline**: Stage "FlujoEntrada" (o "FlujoEntrada")
- **Response Pipeline**: Stage "FujoSalida" (o "FlujoSalida")
- **Error Pipeline**: Stage "ManejoError"

### 2. Lógica de Transformación
Todas las regiones aplican el mismo mapeo:
```xquery
<ns0:InputParameters>
	<ns0:PV_IDPROMOCION>{ data($eliminarFactorCanje/PROMO_ID) }</ns0:PV_IDPROMOCION>
	<ns0:PV_USUARIO>{ upper-case($userName) }</ns0:PV_USUARIO>
</ns0:InputParameters>
```

### 3. Evaluación de Respuesta
Todas las regiones usan la misma lógica:
```xquery
if ($errorCode = 'SUCCESS') then
	<successIndicator>Success</successIndicator>
else
	<successIndicator>{ $errorCode }</successIndicator>
	<messages>{ $validationMessage }</messages>
```

### 4. Stored Procedure
Todas las regiones invocan el mismo SP: `PL_P_ELIMINAR_FACTOR_CANJE`

### 5. Parámetros de Entrada y Salida
Todas las regiones usan los mismos parámetros:
- **Input**: `PV_IDPROMOCION`, `PV_USUARIO`
- **Output**: `PV_CODIGOMENSAJE`, `PV_DESCRIPCIONMENSAJE`

### 6. Configuración de Retry
Todas las regiones tienen:
- Retry Count: 0
- Retry Interval: 30 segundos
- Retry Application Errors: true

### 7. Configuración de Alerting
Todas las regiones tienen:
- SLA Alerting: enabled=true, level=normal
- Pipeline Alerting: enabled=true, level=normal

---

## Recomendaciones de Estandarización

### 1. Selector Type
**Recomendación**: Estandarizar en `SOAP body` para todas las regiones.
- **Razón**: Más flexible y no requiere configuración adicional en clientes.
- **Impacto**: Requiere modificar PA01 y NI01.

### 2. Provider ID y Endpoint Configuration
**Recomendación**: Estandarizar en `provider-id=local` y `all-headers=true`.
- **Razón**: Consistencia y mejor propagación de headers.
- **Impacto**: Requiere modificar NI01.

### 3. Esquemas de Base de Datos
**Recomendación**: Especificar explícitamente el esquema en todas las regiones.
- **Razón**: Evitar ambigüedades y problemas de permisos.
- **Impacto**: Requiere agregar `SchemaName` property en HN01.

### 4. Nombres de Variables
**Recomendación**: Estandarizar en `$eliminarFactorCanje1` para todas las regiones.
- **Razón**: Consistencia en código.
- **Impacto**: Requiere modificar HN01.

### 5. Convención de Carpetas
**Recomendación**: Estandarizar en patrón `ABK{REGION}` para todas las regiones.
- **Razón**: Consistencia en estructura de carpetas.
- **Impacto**: Requiere renombrar carpeta de NI01 de `PXYNIC` a `ABKNI`.

### 6. Timeouts
**Recomendación**: Configurar timeouts explícitos en todas las regiones.
- **Razón**: Evitar bloqueos indefinidos.
- **Impacto**: Agregar configuración de timeout en Business Services.

### 7. Monitoring
**Recomendación**: Habilitar monitoring en producción.
- **Razón**: Visibilidad de métricas de performance.
- **Impacto**: Cambiar `monitoring isEnabled="false"` a `true`.

---

## Conclusión

Las cuatro regiones implementan la misma funcionalidad con diferencias menores en configuración. Las principales diferencias son:

1. **Selector Type**: HN/GT usan `SOAP body`, PA/NI usan `SOAP action`
2. **Endpoint Configuration**: NI usa `provider-id=http` y `all-headers=false`
3. **Esquemas**: Solo HN no especifica esquema explícitamente
4. **Convención de nombres**: NI usa `PXYNIC` en lugar de `ABKNI`

Estas diferencias no afectan la funcionalidad core pero pueden causar problemas de interoperabilidad y mantenimiento. Se recomienda estandarizar las configuraciones para facilitar el soporte y la migración.
