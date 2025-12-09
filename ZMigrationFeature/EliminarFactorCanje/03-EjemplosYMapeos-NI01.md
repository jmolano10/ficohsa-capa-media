# Ejemplos y Mapeos - Nicaragua (NI01)

## Request OSB (Ejemplo SOAP/XML)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:ges="http://www.ficohsa.com.hn/middleware.services/gestionPuntosTarjetasTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>ADMIN_NI</UserName>
         </Authentication>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <ges:eliminarFactorCanje>
         <PROMO_ID>PROMO_NI_2024_001</PROMO_ID>
      </ges:eliminarFactorCanje>
   </soapenv:Body>
</soapenv:Envelope>
```

**Notas Importantes para NI01**:
- Usa `selector type="SOAP action"` (requiere header SOAPAction)
- Usa `provider-id="http"` (diferente a otras regiones)
- Tiene URI explícito: `/Middleware/v2/ProxyServices/EliminarFactorCanjeNI`
- `all-headers="false"` (puede perder headers personalizados)

---

## Response OSB (Ejemplo SOAP/XML)

### Response Exitoso
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:ges="http://www.ficohsa.com.hn/middleware.services/gestionPuntosTarjetasTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>Success</successIndicator>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <ges:eliminarFactorCanjeResponse/>
   </soapenv:Body>
</soapenv:Envelope>
```

---

## Cadenas de Conexión y Credenciales

### Conexión a Base de Datos

| Propiedad | Valor |
|-----------|-------|
| **JNDI Name** | `jca://eis/DB/ConnectionProxyNI` |
| **Esquema** | `PROXYNICARAGUA` |
| **Stored Procedure** | `PL_P_ELIMINAR_FACTOR_CANJE` |
| **Business Service Path** | `Middleware/v2/BusinessServices/PXYNIC/eliminarFactorCanje/biz/eliminarFactorCanje_db` |
| **Binding Namespace** | `http://xmlns.oracle.com/pcbpel/adapter/db/Application/eliminarFactorCanje/eliminarFactorCanje` |

### Configuración de Endpoint (Diferente a Otras Regiones)

| Propiedad | Valor |
|-----------|-------|
| **Provider ID** | `http` (en lugar de `local`) |
| **URI** | `/Middleware/v2/ProxyServices/EliminarFactorCanjeNI` |
| **All Headers** | `false` (en lugar de `true`) |

---

## Tablas de Mapeo

### Mapeo de Entrada: Request OSB → Stored Procedure

| Campo Origen (OSB) | Transformación | Campo Destino (SP) | Archivo XQuery |
|--------------------|----------------|-------------------|----------------|
| `PROMO_ID` | `data($eliminarFactorCanje1/PROMO_ID)` | `PV_IDPROMOCION` | `eliminarFactorCanjeIn.xq` |
| `UserName` | `upper-case($userName)` | `PV_USUARIO` | `eliminarFactorCanjeIn.xq` |

**Nota**: NI01 usa el archivo `eliminarFactorCanjeIn.xq` (sin sufijo regional).

### Mapeo de Salida: Response SP → Response OSB

| Campo Origen (SP) | Transformación | Campo Destino (OSB) |
|-------------------|----------------|---------------------|
| `PV_CODIGOMENSAJE` | `fn:string(...)` | `$errorCode` |
| `PV_DESCRIPCIONMENSAJE` | `fn:string(...)` | `$validationMessage` |
| `$errorCode = 'SUCCESS'` | Evaluación condicional | `successIndicator` = "Success" |

---

## Reglas de Negocio

### Regla 1: Selector Type SOAP Action
**Ubicación**: `EliminarFactorCanjeNI.proxy`
```xml
<con:selector type="SOAP action"/>
```

### Regla 2: Provider HTTP con URI Explícito
**Ubicación**: `EliminarFactorCanjeNI.proxy`
```xml
<tran:provider-id>http</tran:provider-id>
<tran:URI>
	<env:value>/Middleware/v2/ProxyServices/EliminarFactorCanjeNI</env:value>
</tran:URI>
<tran:all-headers>false</tran:all-headers>
```
**Implicación**: 
- Permite invocación HTTP directa
- `all-headers=false` puede causar pérdida de headers personalizados

### Regla 3: Esquema PROXYNICARAGUA
**Ubicación**: `eliminarFactorCanje_db.biz` (PXYNIC)
```xml
<jca:property>
	<jca:name>SchemaName</jca:name>
	<jca:value>PROXYNICARAGUA</jca:value>
</jca:property>
```

### Regla 4: Transformación XQuery
**Archivo**: `eliminarFactorCanjeIn.xq`
```xquery
declare function xf:eliminarFactorCanjeIn($eliminarFactorCanje1 as element(ns1:eliminarFactorCanje),
    $userName as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_IDPROMOCION>{ data($eliminarFactorCanje1/PROMO_ID) }</ns0:PV_IDPROMOCION>
            <ns0:PV_USUARIO>{ upper-case($userName) }</ns0:PV_USUARIO>
        </ns0:InputParameters>
};
```

### Regla 5: Uso de fn:string en lugar de string
**Ubicación**: `EliminarFactorCanjeNI.proxy` → Stage "FlujoEntrada"
```xquery
fn:string($RSPeliminarFactorCanje/elim:PV_CODIGOMENSAJE/text())
fn:string($RSPeliminarFactorCanje/elim:PV_DESCRIPCIONMENSAJE/text())
```
**Nota**: Usa el prefijo `fn:` explícitamente (buena práctica).

---

## Diferencias con Otras Regiones

| Aspecto | HN01/GT01 | PA01 | NI01 |
|---------|-----------|------|------|
| **Selector Type** | `SOAP body` | `SOAP action` | `SOAP action` |
| **Provider ID** | `local` | `local` | `http` |
| **URI Explícito** | No | No | Sí: `/Middleware/v2/ProxyServices/EliminarFactorCanjeNI` |
| **All Headers** | `true` | `true` | `false` |
| **Esquema DB** | HN: default, GT: PROXYABANKSGT | `PROXYABANKSPA` | `PROXYNICARAGUA` |
| **Business Service Folder** | ABK/ABKGT | ABKPA | `PXYNIC` |
| **XQuery File** | HN: ...HNIn.xq, GT: ...GTIn.xq | ...PAIn.xq | `...In.xq` (sin sufijo) |

---

## Fragmentos de Código Relevantes

### Configuración de Endpoint (HTTP Provider)

```xml
<ser:endpointConfig>
	<tran:provider-id>http</tran:provider-id>
	<tran:inbound>true</tran:inbound>
	<tran:URI>
		<env:value>/Middleware/v2/ProxyServices/EliminarFactorCanjeNI</env:value>
	</tran:URI>
	<tran:inbound-properties/>
	<tran:all-headers>false</tran:all-headers>
	<tran:provider-specific>
		<http:inbound-properties/>
	</tran:provider-specific>
</ser:endpointConfig>
```

### Configuración de Binding (SOAP Action)

```xml
<ser:binding type="SOAP" isSoap12="false">
	<con1:wsdl ref="Middleware/v2/Resources/EliminarFactorCanje/wsdl/eliminarFactorCanjePS"/>
	<con1:port>
		<con1:name>eliminarFactorCanjePSSOAP</con1:name>
		<con1:namespace>http://www.ficohsa.com.hn/middleware.services/eliminarFactorCanjePS/</con1:namespace>
	</con1:port>
	<con1:selector type="SOAP action"/>
</ser:binding>
```

### Invocación al Business Service

```xml
<con1:wsCallout>
	<con1:service xsi:type="ref:BusinessServiceRef" 
	              ref="Middleware/v2/BusinessServices/PXYNIC/eliminarFactorCanje/biz/eliminarFactorCanje_db"/>
	<con1:operation>eliminarFactorCanje</con1:operation>
	<con1:requestTransform>
		<con1:assign varName="REQeliminarFactorCanje">
			<con1:expr>
				<con2:xqueryTransform>
					<con2:resource ref="Middleware/v2/Resources/EliminarFactorCanje/xq/eliminarFactorCanjeIn"/>
					<con2:param name="userName">
						<con2:path>fn:string($header/aut:RequestHeader/Authentication/UserName/text())</con2:path>
					</con2:param>
					<con2:param name="eliminarFactorCanje1">
						<con2:path>$body/ges:eliminarFactorCanje</con2:path>
					</con2:param>
				</con2:xqueryTransform>
			</con1:expr>
		</con1:assign>
	</con1:requestTransform>
</con1:wsCallout>
```

---

## Consideraciones Especiales para NI01

### 1. Provider HTTP
**Implicación**: El proxy puede ser invocado directamente vía HTTP sin pasar por el enrutamiento local del OSB.

**URL de Invocación Probable**:
```
http://<host>:<port>/Middleware/v2/ProxyServices/EliminarFactorCanjeNI
```

### 2. All Headers = False
**Implicación**: Los headers HTTP personalizados no se propagan automáticamente. Solo los headers SOAP estándar se procesan.

**Riesgo**: Si hay headers personalizados de seguridad, auditoría o correlación, pueden perderse.

### 3. Convención de Nombres Diferente
**Business Service Folder**: `PXYNIC` en lugar de `ABKNI`

**Razón Probable**: Convención histórica o diferente equipo de desarrollo.

### 4. XQuery Sin Sufijo Regional
**Archivo**: `eliminarFactorCanjeIn.xq` (sin "NI")

**Implicación**: Menos explícito que otras regiones, puede causar confusión en mantenimiento.

---

## Resumen de Flujo

```
Cliente HTTP/SOAP Request (NI)
	↓
[HTTP Header: SOAPAction requerido]
[Provider: http, URI: /Middleware/v2/ProxyServices/EliminarFactorCanjeNI]
[all-headers: false - headers personalizados se pierden]
	↓
UserName = "ADMIN_NI"
PROMO_ID = "PROMO_NI_2024_001"
	↓
Selector: SOAP action
	↓
XQuery Transform (eliminarFactorCanjeIn.xq)
	↓
DB Connection: ConnectionProxyNI
Schema: PROXYNICARAGUA
	↓
SP: PL_P_ELIMINAR_FACTOR_CANJE
	↓
Response: successIndicator = "Success"
	↓
Cliente SOAP Response
```

---

## Recomendaciones Específicas para NI01

1. **Estandarizar Provider ID**: Cambiar de `http` a `local` para consistencia con otras regiones.

2. **Habilitar All Headers**: Cambiar `all-headers="false"` a `true` para evitar pérdida de headers.

3. **Renombrar Business Service Folder**: De `PXYNIC` a `ABKNI` para seguir convención estándar.

4. **Renombrar XQuery**: De `eliminarFactorCanjeIn.xq` a `eliminarFactorCanjeNIIn.xq` para claridad.

5. **Validar Impacto de Provider HTTP**: Si hay clientes que invocan directamente vía HTTP, coordinar cambios.
