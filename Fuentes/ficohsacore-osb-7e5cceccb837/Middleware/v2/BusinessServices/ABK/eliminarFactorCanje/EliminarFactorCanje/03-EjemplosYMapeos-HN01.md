# Ejemplos y Mapeos - Honduras (HN01)

## Request OSB (Ejemplo SOAP/XML)

### SOAP Envelope Completo
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:ges="http://www.ficohsa.com.hn/middleware.services/gestionPuntosTarjetasTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>ADMIN_USER</UserName>
         </Authentication>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <ges:eliminarFactorCanje>
         <PROMO_ID>PROMO2024001</PROMO_ID>
      </ges:eliminarFactorCanje>
   </soapenv:Body>
</soapenv:Envelope>
```

### Campos del Request
| Campo | Tipo | Obligatorio | Descripción | Ejemplo |
|-------|------|-------------|-------------|---------|
| `UserName` | string | Sí | Usuario que ejecuta la eliminación | `ADMIN_USER` |
| `PROMO_ID` | string | Sí | ID de la promoción a eliminar (minLength=1) | `PROMO2024001` |

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
         <messages>La promoción no existe en el sistema</messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <ges:eliminarFactorCanjeResponse/>
   </soapenv:Body>
</soapenv:Envelope>
```

### Response con Excepción Técnica
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:ges="http://www.ficohsa.com.hn/middleware.services/gestionPuntosTarjetasTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:ResponseHeader>
         <messageId>-1</messageId>
         <successIndicator>ERROR</successIndicator>
         <messages>ORA-12154: TNS:could not resolve the connect identifier specified</messages>
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
   <ns0:PV_IDPROMOCION>PROMO2024001</ns0:PV_IDPROMOCION>
   <ns0:PV_USUARIO>ADMIN_USER</ns0:PV_USUARIO>
</ns0:InputParameters>
```

#### Response del Stored Procedure (Éxito)
```xml
<ns0:OutputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/eliminarFactorCanje">
   <ns0:PV_CODIGOMENSAJE>SUCCESS</ns0:PV_CODIGOMENSAJE>
   <ns0:PV_DESCRIPCIONMENSAJE>Promoción eliminada exitosamente</ns0:PV_DESCRIPCIONMENSAJE>
</ns0:OutputParameters>
```

#### Response del Stored Procedure (Error)
```xml
<ns0:OutputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/eliminarFactorCanje">
   <ns0:PV_CODIGOMENSAJE>ERROR</ns0:PV_CODIGOMENSAJE>
   <ns0:PV_DESCRIPCIONMENSAJE>La promoción no existe en el sistema</ns0:PV_DESCRIPCIONMENSAJE>
</ns0:OutputParameters>
```

---

## Cadenas de Conexión y Credenciales

### Conexión a Base de Datos

| Propiedad | Valor |
|-----------|-------|
| **Tipo de Conexión** | JCA (Java Connector Architecture) |
| **JNDI Name** | `jca://eis/DB/ConnectionProxyAbanksHN` |
| **Adapter Type** | `DB` (Database Adapter) |
| **Connection Mode** | `managed` |
| **Esquema** | (esquema por defecto del usuario de conexión) |
| **Stored Procedure** | `PL_P_ELIMINAR_FACTOR_CANJE` |
| **Package** | (no especificado, probablemente en esquema por defecto) |
| **Operación** | `eliminarFactorCanje` |

### Configuración del Business Service

| Propiedad | Valor |
|-----------|-------|
| **Business Service Path** | `Middleware/v2/BusinessServices/ABK/eliminarFactorCanje/biz/eliminarFactorCanje_db` |
| **WSDL** | `Middleware/v2/BusinessServices/ABK/eliminarFactorCanje/wsdl/eliminarFactorCanje_db.wsdl` |
| **JCA File** | `Middleware/v2/BusinessServices/ABK/eliminarFactorCanje/jca/eliminarFactorCanje_db.jca` |
| **XSD** | `Middleware/v2/BusinessServices/ABK/eliminarFactorCanje/xsd/eliminarFactorCanje_sp.xsd` |
| **Binding Namespace** | `http://xmlns.oracle.com/pcbpel/adapter/db/ALERTAS/Middleware/eliminarFactorCanje` |
| **Binding Name** | `eliminarFactorCanje_ptt-binding` |

### Configuración de Retry

| Propiedad | Valor |
|-----------|-------|
| **Retry Count** | `0` (sin reintentos automáticos) |
| **Retry Interval** | `30` segundos |
| **Retry Application Errors** | `true` |
| **Load Balancing Algorithm** | `round-robin` |

---

## Tablas de Mapeo de Entrada

### Mapeo: Request OSB → Stored Procedure

| Campo Origen (OSB) | Transformación/Script | Campo Destino (SP) | Ubicación Transformación |
|--------------------|----------------------|-------------------|-------------------------|
| `$body/ges:eliminarFactorCanje/PROMO_ID` | `data($eliminarFactorCanje/PROMO_ID)` | `PV_IDPROMOCION` | `eliminarFactorCanjeHNIn.xq` línea 11 |
| `$header/aut:RequestHeader/Authentication/UserName` | `upper-case($userName)` | `PV_USUARIO` | `eliminarFactorCanjeHNIn.xq` línea 12 |

### Detalle de Transformación XQuery

**Archivo**: `Middleware/v2/Resources/EliminarFactorCanje/xq/eliminarFactorCanjeHNIn.xq`

**Función**: `xf:eliminarFactorCanjeHNIn`

**Código Relevante**:
```xquery
declare function xf:eliminarFactorCanjeHNIn($eliminarFactorCanje as element(ns1:eliminarFactorCanje),
    $userName as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_IDPROMOCION>{ data($eliminarFactorCanje/PROMO_ID) }</ns0:PV_IDPROMOCION>
            <ns0:PV_USUARIO>{ upper-case($userName) }</ns0:PV_USUARIO>
        </ns0:InputParameters>
};
```

**Parámetros de Entrada**:
- `$eliminarFactorCanje`: Elemento XML del body del request OSB
- `$userName`: String extraído del header de autenticación

**Transformaciones Aplicadas**:
1. **PROMO_ID**: Se extrae el valor usando `data()` para obtener el contenido textual
2. **UserName**: Se convierte a mayúsculas usando `upper-case()`

---

## Tablas de Mapeo de Salida

### Mapeo: Response Stored Procedure → Response OSB (Éxito)

| Campo Origen (SP) | Transformación/Script | Campo Destino (OSB) | Ubicación Transformación |
|-------------------|----------------------|---------------------|-------------------------|
| `$RSPeliminarFactorCanje/elim:PV_CODIGOMENSAJE` | `string($RSPeliminarFactorCanje/elim:PV_CODIGOMENSAJE/text())` | `$errorCode` (variable) | `EliminarFactorCanjeHN.proxy` Stage "FlujoEntrada" |
| `$RSPeliminarFactorCanje/elim:PV_DESCRIPCIONMENSAJE` | `string($RSPeliminarFactorCanje/elim:PV_DESCRIPCIONMENSAJE/text())` | `$validationMessage` (variable) | `EliminarFactorCanjeHN.proxy` Stage "FlujoEntrada" |
| `$errorCode` | `if ($errorCode = 'SUCCESS')` | `successIndicator` = `"Success"` | `EliminarFactorCanjeHN.proxy` Stage "FujoSalida" |
| (vacío) | (vacío) | `<ges:eliminarFactorCanjeResponse/>` | `EliminarFactorCanjeHN.proxy` Stage "FujoSalida" |

### Mapeo: Response Stored Procedure → Response OSB (Error)

| Campo Origen (SP) | Transformación/Script | Campo Destino (OSB) | Ubicación Transformación |
|-------------------|----------------------|---------------------|-------------------------|
| `$errorCode` | `if ($errorCode != 'SUCCESS')` | `successIndicator` = `$errorCode` | `EliminarFactorCanjeHN.proxy` Stage "FujoSalida" |
| `$validationMessage` | (sin transformación) | `messages` = `$validationMessage` | `EliminarFactorCanjeHN.proxy` Stage "FujoSalida" |
| (vacío) | (vacío) | `<ges:eliminarFactorCanjeResponse/>` | `EliminarFactorCanjeHN.proxy` Stage "FujoSalida" |

### Detalle de Construcción de Response Header (Éxito)

**Ubicación**: `EliminarFactorCanjeHN.proxy` → Pipeline Response → Stage "FujoSalida"

**Código XQuery**:
```xquery
<aut:ResponseHeader>
	<successIndicator>Success</successIndicator>
</aut:ResponseHeader>
```

**Condición**: `$errorCode = 'SUCCESS'`

### Detalle de Construcción de Response Header (Error)

**Ubicación**: `EliminarFactorCanjeHN.proxy` → Pipeline Response → Stage "FujoSalida"

**Código XQuery**:
```xquery
<aut:ResponseHeader>
	<successIndicator>{ $errorCode }</successIndicator>
	<messages>{ $validationMessage }</messages>
</aut:ResponseHeader>
```

**Condición**: `$errorCode != 'SUCCESS'`

---

## Reglas de Negocio

### Regla 1: Conversión de Usuario a Mayúsculas

**Descripción**: El nombre de usuario siempre se convierte a mayúsculas antes de enviarlo al stored procedure.

**Ubicación**: `Middleware/v2/Resources/EliminarFactorCanje/xq/eliminarFactorCanjeHNIn.xq` línea 12

**Código**:
```xquery
<ns0:PV_USUARIO>{ upper-case($userName) }</ns0:PV_USUARIO>
```

**Razón de Negocio**: Estandarización de usuarios en la base de datos para auditoría y búsquedas case-insensitive.

---

### Regla 2: Evaluación de Código de Respuesta

**Descripción**: El código de respuesta del stored procedure determina si la operación fue exitosa.

**Ubicación**: `Middleware/v2/ProxyServices/EliminarFactorCanjeHN.proxy` → Pipeline Response → Stage "FujoSalida"

**Código**:
```xquery
if ($errorCode = 'SUCCESS') then
	<successIndicator>Success</successIndicator>
else
	<successIndicator>{ $errorCode }</successIndicator>
	<messages>{ $validationMessage }</messages>
```

**Valores Esperados**:
- `SUCCESS`: Operación exitosa
- Cualquier otro valor: Error (se propaga el código y mensaje)

**Razón de Negocio**: Estandarización de respuestas entre diferentes stored procedures y regiones.

---

### Regla 3: Response Body Vacío

**Descripción**: El body de la respuesta siempre está vacío, independientemente del resultado.

**Ubicación**: `Middleware/v2/ProxyServices/EliminarFactorCanjeHN.proxy` → Pipeline Response → Stage "FujoSalida"

**Código**:
```xquery
<ges:eliminarFactorCanjeResponse/>
```

**Razón de Negocio**: La eliminación es una operación que no retorna datos, solo confirmación de éxito/error en el header.

---

### Regla 4: Manejo de Excepciones Técnicas

**Descripción**: Las excepciones técnicas (errores de conexión, timeouts, etc.) se capturan y se retornan con `messageId=-1` y `successIndicator=ERROR`.

**Ubicación**: `Middleware/v2/ProxyServices/EliminarFactorCanjeHN.proxy` → Error Pipeline → Stage "ManejoError"

**Código**:
```xquery
<aut:ResponseHeader>
	<messageId>-1</messageId>
	<successIndicator>ERROR</successIndicator>
	<messages>{ string($fault/ctx:reason/text()) }</messages>
</aut:ResponseHeader>
```

**Razón de Negocio**: Diferenciar errores técnicos (messageId=-1) de errores de negocio (messageId no presente o diferente).

---

### Regla 5: Validación de PROMO_ID No Vacío

**Descripción**: El campo `PROMO_ID` debe tener al menos 1 carácter (minLength=1).

**Ubicación**: `Middleware/v2/Resources/GestionPuntosTarjetas/xsd/gestionPuntosTarjetasTypes.xsd`

**Definición XSD**:
```xml
<xs:simpleType name="stringMinLength1">
	<xs:restriction base="xs:string">
		<xs:minLength value="1"/>
	</xs:restriction>
</xs:simpleType>

<xs:element name="eliminarFactorCanje">
	<xs:complexType>
		<xs:sequence>
			<xs:element name="PROMO_ID" type="tns:stringMinLength1"/>
		</xs:sequence>
	</xs:complexType>
</xs:element>
```

**Validación**: Se realiza automáticamente por el OSB al validar contra el XSD.

**Razón de Negocio**: Evitar eliminaciones accidentales sin especificar una promoción.

---

## Fragmentos de Código Relevantes

### 1. Invocación al Business Service

**Ubicación**: `EliminarFactorCanjeHN.proxy` → Request Pipeline → Stage "FlujoEntrada"

```xml
<con1:wsCallout>
	<con1:service xsi:type="ref:BusinessServiceRef" 
	              ref="Middleware/v2/BusinessServices/ABK/eliminarFactorCanje/biz/eliminarFactorCanje_db"/>
	<con1:operation>eliminarFactorCanje</con1:operation>
	<con1:request>
		<con1:body>$REQeliminarFactorCanje</con1:body>
	</con1:request>
	<con1:response>
		<con1:body>RSPeliminarFactorCanje</con1:body>
	</con1:response>
	<con1:requestTransform>
		<con1:assign varName="REQeliminarFactorCanje">
			<con1:expr>
				<con2:xqueryTransform>
					<con2:resource ref="Middleware/v2/Resources/EliminarFactorCanje/xq/eliminarFactorCanjeHNIn"/>
					<con2:param name="eliminarFactorCanje">
						<con2:path>$body/ges:eliminarFactorCanje</con2:path>
					</con2:param>
					<con2:param name="userName">
						<con2:path>string($header/aut:RequestHeader/Authentication/UserName/text())</con2:path>
					</con2:param>
				</con2:xqueryTransform>
			</con1:expr>
		</con1:assign>
	</con1:requestTransform>
	<con1:responseTransform>
		<con1:assign varName="errorCode">
			<con1:expr>
				<con3:xqueryText>string($RSPeliminarFactorCanje/elim:PV_CODIGOMENSAJE/text())</con3:xqueryText>
			</con1:expr>
		</con1:assign>
		<con1:assign varName="validationMessage">
			<con1:expr>
				<con3:xqueryText>string($RSPeliminarFactorCanje/elim:PV_DESCRIPCIONMENSAJE/text())</con3:xqueryText>
			</con1:expr>
		</con1:assign>
	</con1:responseTransform>
</con1:wsCallout>
```

---

### 2. Construcción de Response

**Ubicación**: `EliminarFactorCanjeHN.proxy` → Response Pipeline → Stage "FujoSalida"

```xml
<con1:ifThenElse>
	<con1:case>
		<con1:condition>
			<con2:xqueryText>$errorCode = 'SUCCESS'</con2:xqueryText>
		</con1:condition>
		<con1:actions>
			<con1:replace varName="header" contents-only="true">
				<con1:expr>
					<con3:xqueryText><![CDATA[
<aut:ResponseHeader>
	<successIndicator>Success</successIndicator>
</aut:ResponseHeader>
					]]></con3:xqueryText>
				</con1:expr>
			</con1:replace>
		</con1:actions>
	</con1:case>
	<con1:default>
		<con1:replace varName="header" contents-only="true">
			<con1:expr>
				<con3:xqueryText><![CDATA[
<aut:ResponseHeader>
	<successIndicator>{ $errorCode }</successIndicator>
	<messages>{ $validationMessage }</messages>
</aut:ResponseHeader>
				]]></con3:xqueryText>
			</con1:expr>
		</con1:replace>
	</con1:default>
</con1:ifThenElse>

<con1:replace varName="body" contents-only="true">
	<con1:expr>
		<con3:xqueryText>&lt;ges:eliminarFactorCanjeResponse/></con3:xqueryText>
	</con1:expr>
</con1:replace>
```

---

### 3. Manejo de Errores

**Ubicación**: `EliminarFactorCanjeHN.proxy` → Error Pipeline → Stage "ManejoError"

```xml
<con2:replace varName="header" contents-only="true">
	<con1:expr>
		<con1:xqueryText><![CDATA[
<aut:ResponseHeader>
	<messageId>-1</messageId>
	<successIndicator>ERROR</successIndicator>
	<messages>{ string($fault/ctx:reason/text()) }</messages>
</aut:ResponseHeader>
		]]></con1:xqueryText>
	</con1:expr>
</con2:replace>

<con2:replace contents-only="true" varName="body">
	<con1:expr>
		<con1:xqueryText>&lt;ges:eliminarFactorCanjeResponse/></con1:xqueryText>
	</con1:expr>
</con2:replace>

<con1:reply/>
```

---

## Resumen de Flujo de Datos

### Flujo de Entrada
```
Cliente SOAP Request
	↓
Header: UserName = "ADMIN_USER"
Body: PROMO_ID = "PROMO2024001"
	↓
XQuery Transform (eliminarFactorCanjeHNIn.xq)
	↓
PV_IDPROMOCION = "PROMO2024001"
PV_USUARIO = "ADMIN_USER" (uppercase)
	↓
Stored Procedure: PL_P_ELIMINAR_FACTOR_CANJE
```

### Flujo de Salida (Éxito)
```
Stored Procedure Response
	↓
PV_CODIGOMENSAJE = "SUCCESS"
PV_DESCRIPCIONMENSAJE = "Promoción eliminada exitosamente"
	↓
Evaluación: $errorCode = 'SUCCESS'
	↓
Response Header: successIndicator = "Success"
Response Body: <eliminarFactorCanjeResponse/>
	↓
Cliente SOAP Response
```

### Flujo de Salida (Error)
```
Stored Procedure Response
	↓
PV_CODIGOMENSAJE = "ERROR"
PV_DESCRIPCIONMENSAJE = "La promoción no existe"
	↓
Evaluación: $errorCode != 'SUCCESS'
	↓
Response Header: 
	successIndicator = "ERROR"
	messages = "La promoción no existe"
Response Body: <eliminarFactorCanjeResponse/>
	↓
Cliente SOAP Response
```

### Flujo de Excepción
```
Excepción Técnica (DB Connection Error, Timeout, etc.)
	↓
Error Handler Captura $fault
	↓
Response Header:
	messageId = "-1"
	successIndicator = "ERROR"
	messages = "ORA-12154: TNS:could not resolve..."
Response Body: <eliminarFactorCanjeResponse/>
	↓
Cliente SOAP Response
```
