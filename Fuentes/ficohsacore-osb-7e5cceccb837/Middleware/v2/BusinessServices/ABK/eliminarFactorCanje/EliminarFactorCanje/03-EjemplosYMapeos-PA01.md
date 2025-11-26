# Ejemplos y Mapeos - Panamá (PA01)

## Request OSB (Ejemplo SOAP/XML)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:ges="http://www.ficohsa.com.hn/middleware.services/gestionPuntosTarjetasTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>ADMIN_PA</UserName>
         </Authentication>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <ges:eliminarFactorCanje>
         <PROMO_ID>PROMO_PA_2024_001</PROMO_ID>
      </ges:eliminarFactorCanje>
   </soapenv:Body>
</soapenv:Envelope>
```

**Nota Importante**: PA01 usa `selector type="SOAP action"`, por lo que el cliente debe incluir el header SOAPAction en el HTTP request.

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
| **JNDI Name** | `jca://eis/DB/ConnectionProxyAbanksPA` |
| **Esquema** | `PROXYABANKSPA` |
| **Stored Procedure** | `PL_P_ELIMINAR_FACTOR_CANJE` |
| **Business Service Path** | `Middleware/v2/BusinessServices/ABKPA/eliminarFactorCanje/biz/eliminarFactorCanje_db` |
| **Binding Namespace** | `http://xmlns.oracle.com/pcbpel/adapter/db/GestionPuntosTargetaPA/eliminarFactorCanje/eliminarFactorCanje` |

---

## Tablas de Mapeo

### Mapeo de Entrada: Request OSB → Stored Procedure

| Campo Origen (OSB) | Transformación | Campo Destino (SP) | Archivo XQuery |
|--------------------|----------------|-------------------|----------------|
| `PROMO_ID` | `data($eliminarFactorCanje1/PROMO_ID)` | `PV_IDPROMOCION` | `eliminarFactorCanjePAIn.xq` |
| `UserName` | `upper-case($userName)` | `PV_USUARIO` | `eliminarFactorCanjePAIn.xq` |

### Mapeo de Salida: Response SP → Response OSB

| Campo Origen (SP) | Transformación | Campo Destino (OSB) |
|-------------------|----------------|---------------------|
| `PV_CODIGOMENSAJE` | `string(...)` | `$errorCode` |
| `PV_DESCRIPCIONMENSAJE` | `string(...)` | `$validationMessage` |
| `$errorCode = 'SUCCESS'` | Evaluación condicional | `successIndicator` = "Success" |

---

## Reglas de Negocio

### Regla 1: Selector Type SOAP Action
**Ubicación**: `EliminarFactorCanjePA.proxy`
```xml
<con:selector type="SOAP action"/>
```
**Implicación**: Los clientes deben incluir el header HTTP `SOAPAction` con el valor especificado en el WSDL.

### Regla 2: Esquema Explícito PROXYABANKSPA
**Ubicación**: `eliminarFactorCanje_db.biz` (ABKPA)
```xml
<jca:property>
	<jca:name>SchemaName</jca:name>
	<jca:value>PROXYABANKSPA</jca:value>
</jca:property>
```

### Regla 3: Transformación XQuery
**Archivo**: `eliminarFactorCanjePAIn.xq`
```xquery
declare function xf:eliminarFactorCanjePAIn($eliminarFactorCanje1 as element(ns1:eliminarFactorCanje),
    $userName as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_IDPROMOCION>{ data($eliminarFactorCanje1/PROMO_ID) }</ns0:PV_IDPROMOCION>
            <ns0:PV_USUARIO>{ upper-case($userName) }</ns0:PV_USUARIO>
        </ns0:InputParameters>
};
```

---

## Diferencias con Otras Regiones

| Aspecto | HN01/GT01 | PA01 |
|---------|-----------|------|
| **Selector Type** | `SOAP body` | `SOAP action` |
| **Esquema DB** | HN: default, GT: PROXYABANKSGT | `PROXYABANKSPA` |
| **Conexión JNDI** | ConnectionProxyAbanksHN/GT | `ConnectionProxyAbanksPA` |
| **Business Service** | ABK/ABKGT | `ABKPA` |

---

## Fragmentos de Código Relevantes

### Configuración de Binding (SOAP Action)

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

### Invocación al Business Service

```xml
<con1:wsCallout>
	<con1:service xsi:type="ref:BusinessServiceRef" 
	              ref="Middleware/v2/BusinessServices/ABKPA/eliminarFactorCanje/biz/eliminarFactorCanje_db"/>
	<con1:operation>eliminarFactorCanje</con1:operation>
	<con1:requestTransform>
		<con1:assign varName="REQeliminarFactorCanje">
			<con1:expr>
				<con2:xqueryTransform>
					<con2:resource ref="Middleware/v2/Resources/EliminarFactorCanje/xq/eliminarFactorCanjePAIn"/>
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

## Resumen de Flujo

```
Cliente SOAP Request (PA)
	↓
[HTTP Header: SOAPAction requerido]
UserName = "ADMIN_PA"
PROMO_ID = "PROMO_PA_2024_001"
	↓
Selector: SOAP action
	↓
XQuery Transform (eliminarFactorCanjePAIn.xq)
	↓
DB Connection: ConnectionProxyAbanksPA
Schema: PROXYABANKSPA
	↓
SP: PL_P_ELIMINAR_FACTOR_CANJE
	↓
Response: successIndicator = "Success"
	↓
Cliente SOAP Response
```
