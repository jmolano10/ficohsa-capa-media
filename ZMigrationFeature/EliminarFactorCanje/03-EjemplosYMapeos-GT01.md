# Ejemplos y Mapeos - Guatemala (GT01)

## Request OSB (Ejemplo SOAP/XML)

### SOAP Envelope Completo
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:ges="http://www.ficohsa.com.hn/middleware.services/gestionPuntosTarjetasTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>ADMIN_GT</UserName>
         </Authentication>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <ges:eliminarFactorCanje>
         <PROMO_ID>PROMO_GT_2024_001</PROMO_ID>
      </ges:eliminarFactorCanje>
   </soapenv:Body>
</soapenv:Envelope>
```

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

### Response con Error
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:ges="http://www.ficohsa.com.hn/middleware.services/gestionPuntosTarjetasTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>ERROR</successIndicator>
         <messages>Promoción no encontrada en Guatemala</messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <ges:eliminarFactorCanjeResponse/>
   </soapenv:Body>
</soapenv:Envelope>
```

---

## Requests/Responses Internos a Servicios Dependientes

### 1. Invocación a Business Service (DB Adapter)

#### Request al Stored Procedure
```xml
<ns0:InputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/eliminarFactorCanje">
   <ns0:PV_IDPROMOCION>PROMO_GT_2024_001</ns0:PV_IDPROMOCION>
   <ns0:PV_USUARIO>ADMIN_GT</ns0:PV_USUARIO>
</ns0:InputParameters>
```

#### Response del Stored Procedure (Éxito)
```xml
<ns0:OutputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/eliminarFactorCanje">
   <ns0:PV_CODIGOMENSAJE>SUCCESS</ns0:PV_CODIGOMENSAJE>
   <ns0:PV_DESCRIPCIONMENSAJE>Factor de canje eliminado correctamente</ns0:PV_DESCRIPCIONMENSAJE>
</ns0:OutputParameters>
```

---

## Cadenas de Conexión y Credenciales

### Conexión a Base de Datos

| Propiedad | Valor |
|-----------|-------|
| **Tipo de Conexión** | JCA (Java Connector Architecture) |
| **JNDI Name** | `jca://eis/DB/ConnectionProxyAbanksGT` |
| **Adapter Type** | `DB` (Database Adapter) |
| **Connection Mode** | `managed` |
| **Esquema** | `PROXYABANKSGT` |
| **Stored Procedure** | `PL_P_ELIMINAR_FACTOR_CANJE` |
| **Operación** | `eliminarFactorCanje` |

### Configuración del Business Service

| Propiedad | Valor |
|-----------|-------|
| **Business Service Path** | `Middleware/v2/BusinessServices/ABKGT/eliminarFactorCanje/biz/eliminarFactorCanje_db` |
| **WSDL** | `Middleware/v2/BusinessServices/ABKGT/eliminarFactorCanje/wsdl/eliminarFactorCanje_db.wsdl` |
| **JCA File** | `Middleware/v2/BusinessServices/ABKGT/eliminarFactorCanje/jca/eliminarFactorCanje_db.jca` |
| **XSD** | `Middleware/v2/BusinessServices/ABKGT/eliminarFactorCanje/xsd/eliminarFactorCanje_sp.xsd` |
| **Binding Namespace** | `http://xmlns.oracle.com/pcbpel/adapter/db/GestionPuntosTargetaGT/eliminarFactorCanje/eliminarFactorCanje` |
| **Binding Name** | `eliminarFactorCanje_ptt-binding` |

---

## Tablas de Mapeo de Entrada

### Mapeo: Request OSB → Stored Procedure

| Campo Origen (OSB) | Transformación/Script | Campo Destino (SP) | Ubicación Transformación |
|--------------------|----------------------|-------------------|-------------------------|
| `$body/ges:eliminarFactorCanje/PROMO_ID` | `data($eliminarFactorCanje1/PROMO_ID)` | `PV_IDPROMOCION` | `eliminarFactorCanjeGTIn.xq` línea 11 |
| `$header/aut:RequestHeader/Authentication/UserName` | `upper-case($userName)` | `PV_USUARIO` | `eliminarFactorCanjeGTIn.xq` línea 12 |

### Detalle de Transformación XQuery

**Archivo**: `Middleware/v2/Resources/EliminarFactorCanje/xq/eliminarFactorCanjeGTIn.xq`

**Función**: `xf:eliminarFactorCanjeGTIn`

**Código Relevante**:
```xquery
declare function xf:eliminarFactorCanjeGTIn($eliminarFactorCanje1 as element(ns1:eliminarFactorCanje),
    $userName as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_IDPROMOCION>{ data($eliminarFactorCanje1/PROMO_ID) }</ns0:PV_IDPROMOCION>
            <ns0:PV_USUARIO>{ upper-case($userName) }</ns0:PV_USUARIO>
        </ns0:InputParameters>
};
```

**Nota**: La única diferencia con HN01 es el nombre del parámetro (`$eliminarFactorCanje1` en lugar de `$eliminarFactorCanje`).

---

## Tablas de Mapeo de Salida

### Mapeo: Response Stored Procedure → Response OSB

| Campo Origen (SP) | Transformación/Script | Campo Destino (OSB) | Ubicación Transformación |
|-------------------|----------------------|---------------------|-------------------------|
| `$RSPeliminarFactorCanje/elim:PV_CODIGOMENSAJE` | `string($RSPeliminarFactorCanje/elim:PV_CODIGOMENSAJE/text())` | `$errorCode` (variable) | `EliminarFactorCanjeGT.proxy` Stage "FlujoEntrada" |
| `$RSPeliminarFactorCanje/elim:PV_DESCRIPCIONMENSAJE` | `string($RSPeliminarFactorCanje/elim:PV_DESCRIPCIONMENSAJE/text())` | `$validationMessage` (variable) | `EliminarFactorCanjeGT.proxy` Stage "FlujoEntrada" |
| `$errorCode` | `if ($errorCode = 'SUCCESS')` | `successIndicator` = `"Success"` | `EliminarFactorCanjeGT.proxy` Stage "FujoSalida" |
| `$errorCode` (si != SUCCESS) | (sin transformación) | `successIndicator` = `$errorCode` | `EliminarFactorCanjeGT.proxy` Stage "FujoSalida" |
| `$validationMessage` (si error) | (sin transformación) | `messages` = `$validationMessage` | `EliminarFactorCanjeGT.proxy` Stage "FujoSalida" |

---

## Reglas de Negocio

### Regla 1: Conversión de Usuario a Mayúsculas
**Ubicación**: `eliminarFactorCanjeGTIn.xq` línea 12
```xquery
<ns0:PV_USUARIO>{ upper-case($userName) }</ns0:PV_USUARIO>
```

### Regla 2: Evaluación de Código de Respuesta
**Ubicación**: `EliminarFactorCanjeGT.proxy` → Stage "FujoSalida"
```xquery
$errorCode = 'SUCCESS'
```

### Regla 3: Esquema Explícito para Guatemala
**Ubicación**: `eliminarFactorCanje_db.biz` (ABKGT)
```xml
<jca:property>
	<jca:name>SchemaName</jca:name>
	<jca:value>PROXYABANKSGT</jca:value>
</jca:property>
```
**Razón**: Guatemala requiere especificar explícitamente el esquema `PROXYABANKSGT`.

---

## Diferencias con Honduras (HN01)

| Aspecto | HN01 | GT01 |
|---------|------|------|
| **Esquema DB** | (default) | `PROXYABANKSGT` (explícito) |
| **Conexión JNDI** | `ConnectionProxyAbanksHN` | `ConnectionProxyAbanksGT` |
| **Business Service Path** | `ABK/eliminarFactorCanje` | `ABKGT/eliminarFactorCanje` |
| **Variable XQuery** | `$eliminarFactorCanje` | `$eliminarFactorCanje1` |
| **Binding Namespace** | `...ALERTAS/Middleware/...` | `...GestionPuntosTargetaGT/...` |

---

## Fragmentos de Código Relevantes

### Invocación al Business Service

**Ubicación**: `EliminarFactorCanjeGT.proxy` → Request Pipeline → Stage "FlujoEntrada"

```xml
<con1:wsCallout>
	<con1:service xsi:type="ref:BusinessServiceRef" 
	              ref="Middleware/v2/BusinessServices/ABKGT/eliminarFactorCanje/biz/eliminarFactorCanje_db"/>
	<con1:operation>eliminarFactorCanje</con1:operation>
	<con1:requestTransform>
		<con1:assign varName="REQeliminarFactorCanje">
			<con1:expr>
				<con2:xqueryTransform>
					<con2:resource ref="Middleware/v2/Resources/EliminarFactorCanje/xq/eliminarFactorCanjeGTIn"/>
					<con2:param name="eliminarFactorCanje1">
						<con2:path>$body/ges:eliminarFactorCanje</con2:path>
					</con2:param>
					<con2:param name="userName">
						<con2:path>string($header/aut:RequestHeader/Authentication/UserName/text())</con2:path>
					</con2:param>
				</con2:xqueryTransform>
			</con1:expr>
		</con1:assign>
	</con1:requestTransform>
</con1:wsCallout>
```

---

## Resumen de Flujo de Datos

### Flujo Completo
```
Cliente SOAP Request (GT)
	↓
UserName = "ADMIN_GT"
PROMO_ID = "PROMO_GT_2024_001"
	↓
XQuery Transform (eliminarFactorCanjeGTIn.xq)
	↓
PV_IDPROMOCION = "PROMO_GT_2024_001"
PV_USUARIO = "ADMIN_GT"
	↓
DB Connection: ConnectionProxyAbanksGT
Schema: PROXYABANKSGT
	↓
Stored Procedure: PL_P_ELIMINAR_FACTOR_CANJE
	↓
PV_CODIGOMENSAJE = "SUCCESS"
PV_DESCRIPCIONMENSAJE = "Factor de canje eliminado correctamente"
	↓
successIndicator = "Success"
	↓
Cliente SOAP Response
```
