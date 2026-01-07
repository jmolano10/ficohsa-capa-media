# Ejemplos de Request/Response y Mapeo de Datos - General

## Request OSB (ejemplo SOAP/XML)

### SOAP Envelope Completo
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
               xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autorizacionDataCaptureTypes"
               xmlns:auth="http://www.ficohsa.com.hn/middleware.services/autType">
    <soap:Header>
        <auth:AutenticacionRequestHeader>
            <UserName>USUARIO_AUTORIZADOR</UserName>
            <Password>PASSWORD123</Password>
        </auth:AutenticacionRequestHeader>
    </soap:Header>
    <soap:Body>
        <aut:autorizacionDataCapture>
            <DATA_CAPTURE_ID>001BATCH001</DATA_CAPTURE_ID>
        </aut:autorizacionDataCapture>
    </soap:Body>
</soap:Envelope>
```

### Request Body Mínimo
```xml
<aut:autorizacionDataCapture xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autorizacionDataCaptureTypes">
    <DATA_CAPTURE_ID>002BATCH002</DATA_CAPTURE_ID>
</aut:autorizacionDataCapture>
```

## Response OSB (ejemplo SOAP/XML)

### SOAP Envelope de Respuesta Exitosa
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
               xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autorizacionDataCaptureTypes"
               xmlns:auth="http://www.ficohsa.com.hn/middleware.services/autType">
    <soap:Header>
        <auth:ResponseHeader>
            <transactionId>TXN20241201001</transactionId>
            <successIndicator>Success</successIndicator>
            <messages></messages>
        </auth:ResponseHeader>
    </soap:Header>
    <soap:Body>
        <aut:autorizacionDataCaptureResponse>
            <TRANSACTION_DATE>20241201</TRANSACTION_DATE>
        </aut:autorizacionDataCaptureResponse>
    </soap:Body>
</soap:Envelope>
```

### Response de Error por Validación
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
               xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autorizacionDataCaptureTypes"
               xmlns:auth="http://www.ficohsa.com.hn/middleware.services/autType">
    <soap:Header>
        <auth:ResponseHeader>
            <successIndicator>ERROR</successIndicator>
            <messages>REQUIRED FILEDS NOT SUPPLIED</messages>
        </auth:ResponseHeader>
    </soap:Header>
    <soap:Body>
        <aut:autorizacionDataCaptureResponse/>
    </soap:Body>
</soap:Envelope>
```

### Response de Error del Sistema
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
               xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autorizacionDataCaptureTypes"
               xmlns:auth="http://www.ficohsa.com.hn/middleware.services/autType">
    <soap:Header>
        <auth:ResponseHeader>
            <successIndicator>ERROR</successIndicator>
            <messages>BEA-380002: Connection refused</messages>
        </auth:ResponseHeader>
    </soap:Header>
    <soap:Body>
        <aut:autorizacionDataCaptureResponse/>
    </soap:Body>
</soap:Envelope>
```

## Requests/Responses internos a servicios dependientes

### Request a DataCapture T24 (Autorización)
```xml
<ns0:Autorizaciondedatacapture xmlns:ns0="T24WebServicesImpl">
    <WebRequestCommon>
        <userName>T24_USER</userName>
        <password>T24_PASSWORD</password>
    </WebRequestCommon>
    <DATACAPTUREINPUTWSType>
        <transactionId>001BATCH001</transactionId>
    </DATACAPTUREINPUTWSType>
</ns0:Autorizaciondedatacapture>
```

### Response de DataCapture T24 (Exitosa)
```xml
<ns0:AutorizaciondedatacaptureResponse xmlns:ns0="T24WebServicesImpl">
    <Status>
        <transactionId>TXN20241201001</transactionId>
        <messageId>MSG20241201001</messageId>
        <successIndicator>Success</successIndicator>
        <application>DATACAPTURE</application>
        <messages></messages>
    </Status>
    <DATACAPTUREType id="001BATCH001">
        <ACCOUNTNUMBER>1234567890</ACCOUNTNUMBER>
        <SIGN>D</SIGN>
        <AMOUNTLCY>1000.00</AMOUNTLCY>
        <TRANSACTIONCODE>AC</TRANSACTIONCODE>
        <gNARRATIVE>
            <NARRATIVE>Transaccion autorizada</NARRATIVE>
        </gNARRATIVE>
        <VALUEDATE>20241201</VALUEDATE>
        <RECORDSTATUS>LIVE</RECORDSTATUS>
        <CURRNO>2</CURRNO>
        <AUTHORISER>AUTORIZADOR01</AUTHORISER>
        <AUDITDATETIME>20241201103000</AUDITDATETIME>
    </DATACAPTUREType>
</ns0:AutorizaciondedatacaptureResponse>
```

### Response de DataCapture T24 (Error)
```xml
<ns0:AutorizaciondedatacaptureResponse xmlns:ns0="T24WebServicesImpl">
    <Status>
        <transactionId>001BATCH001</transactionId>
        <messageId>MSG20241201002</messageId>
        <successIndicator>T24Error</successIndicator>
        <application>DATACAPTURE</application>
        <messages>Transaction not found or already authorized</messages>
    </Status>
    <DATACAPTUREType id="001BATCH001">
        <RECORDSTATUS>ERROR</RECORDSTATUS>
    </DATACAPTUREType>
</ns0:AutorizaciondedatacaptureResponse>
```

## Cadenas de conexión detectadas y credenciales

### Business Service DataCapture
- **Endpoint**: `http://mwinterbanca:7003/svcDataCapture/services`
- **Tipo**: T24 Web Service (SOAP)
- **Operación**: `Autorizaciondedatacapture`
- **Método HTTP**: POST
- **Timeout**: No configurado explícitamente
- **Connection Timeout**: No configurado explícitamente
- **Retry Count**: No configurado explícitamente
- **Load Balancing**: round-robin (heredado de configuración general)

### Credenciales y Seguridad
- **Autenticación OSB**: Custom Token Authentication
- **LDAP Lookup**: `Middleware/Security/{USERNAME}`
- **Fallback**: Credenciales originales del header
- **T24 Authentication**: Username/Password en WebRequestCommon

## Tablas de mapeo de entrada por cada llamada a servicio dependiente

### Mapeo OSB Request → DataCapture T24 Request

| Campo Origen (OSB) | Transformación/Script | Campo Destino (T24) |
|-------------------|----------------------|-------------------|
| `$autenticacionRequestHeader/UserName` | `getUsername()` o directo | `WebRequestCommon/userName` |
| `$autenticacionRequestHeader/Password` | `getPassword()` o directo | `WebRequestCommon/password` |
| `$autorizacionDataCapture/DATA_CAPTURE_ID` | `data()` | `DATACAPTUREINPUTWSType/transactionId` |

## Tablas de mapeo de salida por cada respuesta de servicio dependiente

### Mapeo DataCapture T24 Response → OSB Response Header

| Campo Origen (T24) | Transformación/Script | Campo Destino (OSB Header) |
|--------------------|----------------------|---------------------------|
| `$autorizaciondedatacaptureResponse/Status/transactionId` | `data()` | `auth:ResponseHeader/transactionId` |
| `$autorizaciondedatacaptureResponse/Status/successIndicator` | `data()` | `auth:ResponseHeader/successIndicator` |
| `$autorizaciondedatacaptureResponse/Status/messages` | `data()` | `auth:ResponseHeader/messages` |

### Mapeo DataCapture T24 Response → OSB Response Body

| Campo Origen (T24) | Transformación/Script | Campo Destino (OSB Body) |
|--------------------|----------------------|-------------------------|
| `$autorizaciondedatacaptureResponse/DATACAPTUREType/VALUEDATE` | `data()` | `aut:autorizacionDataCaptureResponse/TRANSACTION_DATE` |

## Reglas de negocio detectadas

### Reglas de Validación
1. **Validación de Campo Requerido**:
   - **Ubicación**: `autorizacionDataCaptureValidation.xq` líneas 8-12
   - **Regla**: DATA_CAPTURE_ID no puede estar vacío
   - **Código**: `if (fn:string($autorizacionDataCapture/DATA_CAPTURE_ID/text()) = "") then ("REQUIRED FILEDS NOT SUPPLIED") else ("")`
   - **Nota**: Existe un typo en el mensaje de error ("FILEDS" en lugar de "FIELDS")

### Reglas de Transformación
2. **Mapeo de ID de Transacción**:
   - **Ubicación**: `autorizacionDataCaptureIn.xq` línea 33
   - **Regla**: DATA_CAPTURE_ID se mapea directamente a transactionId
   - **Código**: `<transactionId>{ data($autorizacionDataCapture/DATA_CAPTURE_ID) }</transactionId>`

3. **Extracción de Fecha de Transacción**:
   - **Ubicación**: `autorizacionDataCaptureOut.xq` líneas 12-15
   - **Regla**: VALUEDATE de T24 se convierte en TRANSACTION_DATE
   - **Código**: `for $VALUEDATE in $autorizaciondedatacaptureResponse/DATACAPTUREType/VALUEDATE return <TRANSACTION_DATE>{ data($VALUEDATE) }</TRANSACTION_DATE>`

### Reglas de Seguridad y Credenciales
4. **Lookup de Credenciales LDAP**:
   - **Ubicación**: `autorizacionDataCaptureIn.xq` funciones `getUsername` y `getPassword` líneas 11-20
   - **Regla**: Intentar obtener credenciales de LDAP, usar originales como fallback
   - **Código**: `fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), data($autenticacionRequestHeader/UserName))`

5. **Path de Seguridad LDAP**:
   - **Ubicación**: `autorizacionDataCaptureIn.xq` líneas 12 y 17
   - **Regla**: Credenciales en `Middleware/Security/{USERNAME_UPPERCASE}`
   - **Código**: `concat("Middleware/Security/", upper-case($LDAPUsername))`

### Reglas de Manejo de Errores
6. **Manejo de Error de Validación**:
   - **Ubicación**: Pipeline response, condición `$validationMessage = ""`
   - **Regla**: Solo proceder si la validación es exitosa
   - **Mensaje Error**: Usar `$validationMessage` del validador

7. **Manejo de Faults del Sistema**:
   - **Ubicación**: Pipeline de error
   - **Regla**: Capturar errorCode y reason del fault
   - **Código**: `concat(fn:string($fault/ctx:errorCode/text()), ": ", fn:string($fault/ctx:reason/text()))`

### Reglas de Procesamiento de Respuesta
8. **Mapeo de Headers de Respuesta**:
   - **Ubicación**: `autorizacionDataCaptureHeaderOut.xq` líneas 11-25
   - **Regla**: Mapear todos los campos de Status a ResponseHeader
   - **Código**: `for $transactionId in $autorizaciondedatacaptureResponse/Status/transactionId return <transactionId>{ data($transactionId) }</transactionId>`

9. **Condicional de Procesamiento**:
   - **Ubicación**: Pipeline request y response
   - **Regla**: Solo invocar T24 si la validación es exitosa
   - **Condición**: `$validationMessage = ""`

### Reglas de Estructura de Datos
10. **Estructura Mínima de Request T24**:
    - **Ubicación**: `autorizacionDataCaptureIn.xq` líneas 23-34
    - **Regla**: Request T24 requiere WebRequestCommon y DATACAPTUREINPUTWSType
    - **Estructura**: WebRequestCommon (userName, password) + DATACAPTUREINPUTWSType (transactionId)

11. **Extracción Condicional de Fecha**:
    - **Ubicación**: `autorizacionDataCaptureOut.xq` líneas 12-15
    - **Regla**: Solo incluir TRANSACTION_DATE si VALUEDATE existe en la respuesta
    - **Código**: `for $VALUEDATE in $autorizaciondedatacaptureResponse/DATACAPTUREType/VALUEDATE return`

### Reglas de Flujo de Control
12. **Validación Previa a Procesamiento**:
    - **Ubicación**: Pipeline request, stage1
    - **Regla**: Validar antes de invocar el servicio T24
    - **Flujo**: Validación → (Si exitosa) Invocación T24 → (Si falla) Skip

13. **Respuesta Condicional**:
    - **Ubicación**: Pipeline response, stage1
    - **Regla**: Respuesta diferente según resultado de validación
    - **Flujo**: (Si validación exitosa) Transformar respuesta T24 → (Si falla) Respuesta de error

14. **Manejo de Errores de Sistema**:
    - **Ubicación**: Pipeline de error
    - **Regla**: Capturar cualquier fault del sistema y convertir a respuesta de error
    - **Acción**: Concatenar código y razón del error + reply inmediato