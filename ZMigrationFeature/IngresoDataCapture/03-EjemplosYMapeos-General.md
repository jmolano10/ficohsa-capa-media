# Ejemplos de Request/Response y Mapeo de Datos - General

## Request OSB (ejemplo SOAP/XML)

### SOAP Envelope Completo
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
               xmlns:ing="http://www.ficohsa.com.hn/middleware.services/ingresoDataCaptureTypes"
               xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
    <soap:Header>
        <aut:AutenticacionRequestHeader>
            <UserName>USUARIO_BANCO</UserName>
            <Password>PASSWORD123</Password>
        </aut:AutenticacionRequestHeader>
    </soap:Header>
    <soap:Body>
        <ing:ingresoDataCapture>
            <BATCH_ID>BATCH001</BATCH_ID>
            <DEPARTMENT_CODE>001</DEPARTMENT_CODE>
            <ACCOUNT_NUMBER>1234567890</ACCOUNT_NUMBER>
            <CURRENCY>HNL</CURRENCY>
            <AMOUNT>1000.00</AMOUNT>
            <DEBIT_CREDIT>DEBIT</DEBIT_CREDIT>
            <DESCRIPTION>Transaccion de prueba para ingreso de data capture</DESCRIPTION>
            <VALUE_DATE>20241201</VALUE_DATE>
            <PROFIT_CENTER>PC001</PROFIT_CENTER>
            <PROFIT_LOSS_CATEGORY>PL001</PROFIT_LOSS_CATEGORY>
            <PRODUCT_CATEGORY>PROD001</PRODUCT_CATEGORY>
        </ing:ingresoDataCapture>
    </soap:Body>
</soap:Envelope>
```

### Request Body con Moneda Extranjera
```xml
<ing:ingresoDataCapture xmlns:ing="http://www.ficohsa.com.hn/middleware.services/ingresoDataCaptureTypes">
    <BATCH_ID>BATCH002</BATCH_ID>
    <DEPARTMENT_CODE>002</DEPARTMENT_CODE>
    <ACCOUNT_NUMBER>9876543210</ACCOUNT_NUMBER>
    <CURRENCY>USD</CURRENCY>
    <AMOUNT>500.00</AMOUNT>
    <DEBIT_CREDIT>CREDIT</DEBIT_CREDIT>
    <DESCRIPTION>Credito en dolares americanos</DESCRIPTION>
    <VALUE_DATE>20241201</VALUE_DATE>
    <PROFIT_CENTER>PC002</PROFIT_CENTER>
    <PROFIT_LOSS_CATEGORY>PL002</PROFIT_LOSS_CATEGORY>
    <PRODUCT_CATEGORY>PROD002</PRODUCT_CATEGORY>
</ing:ingresoDataCapture>
```

## Response OSB (ejemplo SOAP/XML)

### SOAP Envelope de Respuesta Exitosa
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
               xmlns:ing="http://www.ficohsa.com.hn/middleware.services/ingresoDataCaptureTypes"
               xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
    <soap:Header>
        <aut:ResponseHeader>
            <transactionId>TXN20241201001</transactionId>
            <successIndicator>Success</successIndicator>
            <messages></messages>
            <valueDate>20241201</valueDate>
        </aut:ResponseHeader>
    </soap:Header>
    <soap:Body>
        <ing:ingresoDataCaptureResponse>
            <RECORD_STATUS>LIVE</RECORD_STATUS>
        </ing:ingresoDataCaptureResponse>
    </soap:Body>
</soap:Envelope>
```

### Response de Error por Validación
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
               xmlns:ing="http://www.ficohsa.com.hn/middleware.services/ingresoDataCaptureTypes"
               xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
    <soap:Header>
        <aut:ResponseHeader>
            <successIndicator>ERROR</successIndicator>
            <messages>REQUIRED FIELDS NOT SUPPLIED</messages>
        </aut:ResponseHeader>
    </soap:Header>
    <soap:Body>
        <ing:ingresoDataCaptureResponse/>
    </soap:Body>
</soap:Envelope>
```

### Response de Error por Valor Inválido
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
               xmlns:ing="http://www.ficohsa.com.hn/middleware.services/ingresoDataCaptureTypes"
               xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
    <soap:Header>
        <aut:ResponseHeader>
            <successIndicator>ERROR</successIndicator>
            <messages>VALUE NOT ALLOWED FOR FIELD DEBIT_CREDIT. IT MUST BE "DEBIT" OR "CREDIT"</messages>
        </aut:ResponseHeader>
    </soap:Header>
    <soap:Body>
        <ing:ingresoDataCaptureResponse/>
    </soap:Body>
</soap:Envelope>
```

## Requests/Responses internos a servicios dependientes

### Request a ObtenerParametrizacion
```xml
<osb:obtenerParametrizacion xmlns:osb="http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_GET_CONFIG/">
    <osb:NOMBRE_PARAMETROS>T24T099.TXNCODEDR||T24T099.TXNCODECR</osb:NOMBRE_PARAMETROS>
</osb:obtenerParametrizacion>
```

### Response de ObtenerParametrizacion (Exitosa)
```xml
<osb:obtenerParametrizacionResponse xmlns:osb="http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_GET_CONFIG/">
    <osb:ERROR_CODE>SUCCESS</osb:ERROR_CODE>
    <osb:ERROR_MESSAGE></osb:ERROR_MESSAGE>
    <osb:CONFIGURACIONES>
        <osb:CONFIGURACIONES_ITEM>
            <osb:NAME>T24T099.TXNCODEDR</osb:NAME>
            <osb:VALUE>AC</osb:VALUE>
        </osb:CONFIGURACIONES_ITEM>
        <osb:CONFIGURACIONES_ITEM>
            <osb:NAME>T24T099.TXNCODECR</osb:NAME>
            <osb:VALUE>AC</osb:VALUE>
        </osb:CONFIGURACIONES_ITEM>
    </osb:CONFIGURACIONES>
</osb:obtenerParametrizacionResponse>
```

### Request a DataCapture T24 (Moneda Local HNL)
```xml
<ns0:IngresodeDataCapture xmlns:ns0="T24WebServicesImpl">
    <WebRequestCommon>
        <userName>T24_USER</userName>
        <password>T24_PASSWORD</password>
    </WebRequestCommon>
    <OfsFunction>
        <gtsControl></gtsControl>
        <messageId>uuid-12345-67890</messageId>
        <noOfAuth></noOfAuth>
        <replace></replace>
    </OfsFunction>
    <DATACAPTUREINPUTWSType id="001BATCH001">
        <ACCOUNTNUMBER>1234567890</ACCOUNTNUMBER>
        <SIGN>D</SIGN>
        <TRANSACTIONCODE>AC</TRANSACTIONCODE>
        <gNARRATIVE>
            <NARRATIVE>Transaccion de prueba para ingreso</NARRATIVE>
            <NARRATIVE>de data capture</NARRATIVE>
        </gNARRATIVE>
        <PLCATEGORY>PL001</PLCATEGORY>
        <ACCOUNTOFFICER>PC001</ACCOUNTOFFICER>
        <PRODUCTCATEGORY>PROD001</PRODUCTCATEGORY>
        <VALUEDATE>20241201</VALUEDATE>
        <AMOUNTLCY>1000.00</AMOUNTLCY>
    </DATACAPTUREINPUTWSType>
</ns0:IngresodeDataCapture>
```

### Request a DataCapture T24 (Moneda Extranjera USD)
```xml
<ns0:IngresodeDataCapture xmlns:ns0="T24WebServicesImpl">
    <WebRequestCommon>
        <userName>T24_USER</userName>
        <password>T24_PASSWORD</password>
    </WebRequestCommon>
    <OfsFunction>
        <gtsControl></gtsControl>
        <messageId>uuid-12345-67891</messageId>
        <noOfAuth></noOfAuth>
        <replace></replace>
    </OfsFunction>
    <DATACAPTUREINPUTWSType id="002BATCH002">
        <ACCOUNTNUMBER>9876543210</ACCOUNTNUMBER>
        <SIGN>C</SIGN>
        <TRANSACTIONCODE>AC</TRANSACTIONCODE>
        <gNARRATIVE>
            <NARRATIVE>Credito en dolares americanos</NARRATIVE>
        </gNARRATIVE>
        <PLCATEGORY>PL002</PLCATEGORY>
        <ACCOUNTOFFICER>PC002</ACCOUNTOFFICER>
        <PRODUCTCATEGORY>PROD002</PRODUCTCATEGORY>
        <VALUEDATE>20241201</VALUEDATE>
        <CURRENCY>USD</CURRENCY>
        <AMOUNTFCY>500.00</AMOUNTFCY>
    </DATACAPTUREINPUTWSType>
</ns0:IngresodeDataCapture>
```

### Response de DataCapture T24 (Exitosa)
```xml
<ns0:IngresodeDataCaptureResponse xmlns:ns0="T24WebServicesImpl">
    <Status>
        <transactionId>TXN20241201001</transactionId>
        <messageId>uuid-12345-67890</messageId>
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
            <NARRATIVE>Transaccion de prueba para ingreso</NARRATIVE>
            <NARRATIVE>de data capture</NARRATIVE>
        </gNARRATIVE>
        <PLCATEGORY>PL001</PLCATEGORY>
        <ACCOUNTOFFICER>PC001</ACCOUNTOFFICER>
        <PRODUCTCATEGORY>PROD001</PRODUCTCATEGORY>
        <VALUEDATE>20241201</VALUEDATE>
        <RECORDSTATUS>LIVE</RECORDSTATUS>
        <CURRNO>1</CURRNO>
    </DATACAPTUREType>
</ns0:IngresodeDataCaptureResponse>
```

## Cadenas de conexión detectadas y credenciales

### Business Service DataCapture
- **Endpoint**: `http://mwinterbanca:7003/svcDataCapture/services`
- **Tipo**: T24 Web Service (SOAP)
- **Operación**: `IngresodeDataCapture`
- **Método HTTP**: POST
- **Timeout**: 0 segundos (sin límite)
- **Connection Timeout**: 0 segundos (sin límite)
- **Retry Count**: 0 (sin reintentos)
- **Load Balancing**: round-robin

### Business Service ObtenerParametrizacion
- **Tipo**: Database Adapter (JCA)
- **Base de Datos**: ORA_BANK
- **Esquema**: OSB_GET_CONFIG
- **Operación**: obtenerParametrizacion
- **JCA File**: `obtenerParametrizacion_db.jca`
- **WSDL**: `obtenerParametrizacion_db.wsdl`

### Credenciales y Seguridad
- **Autenticación OSB**: Custom Token Authentication
- **LDAP Lookup**: `Middleware/Security/{USERNAME}`
- **Fallback**: Credenciales originales del header
- **T24 Authentication**: Username/Password en WebRequestCommon

## Tablas de mapeo de entrada por cada llamada a servicio dependiente

### Mapeo OSB Request → ObtenerParametrizacion Request

| Campo Origen (OSB) | Transformación/Script | Campo Destino (ObtenerParametrizacion) |
|-------------------|----------------------|---------------------------------------|
| N/A (hardcoded) | `"T24T099.TXNCODEDR||T24T099.TXNCODECR"` | `NOMBRE_PARAMETROS` |

### Mapeo OSB Request → DataCapture T24 Request

| Campo Origen (OSB) | Transformación/Script | Campo Destino (T24) |
|-------------------|----------------------|-------------------|
| `$autenticacionRequestHeader/UserName` | `getUsername()` o directo | `WebRequestCommon/userName` |
| `$autenticacionRequestHeader/Password` | `getPassword()` o directo | `WebRequestCommon/password` |
| `$uuid` | `fn-bea:uuid()` generado | `OfsFunction/messageId` |
| `$ingresoDataCapture/DEPARTMENT_CODE + BATCH_ID` | `concat()` | `DATACAPTUREINPUTWSType/@id` |
| `$ingresoDataCapture/ACCOUNT_NUMBER` | `data()` | `ACCOUNTNUMBER` |
| `$ingresoDataCapture/DEBIT_CREDIT` | `if "DEBIT" then "D" else "C"` | `SIGN` |
| `$transactionCodeDebito` (si DEBIT) | Parámetro obtenido | `TRANSACTIONCODE` |
| `$transactionCodeCredito` (si CREDIT) | Parámetro obtenido | `TRANSACTIONCODE` |
| `$ingresoDataCapture/DESCRIPTION` | `splitString(34)` | `gNARRATIVE/NARRATIVE` (múltiples) |
| `$ingresoDataCapture/PROFIT_LOSS_CATEGORY` | `data()` | `PLCATEGORY` |
| `$ingresoDataCapture/PROFIT_CENTER` | `data()` | `ACCOUNTOFFICER` |
| `$ingresoDataCapture/PRODUCT_CATEGORY` | `data()` | `PRODUCTCATEGORY` |
| `$ingresoDataCapture/VALUE_DATE` | `data()` | `VALUEDATE` |
| `$ingresoDataCapture/AMOUNT` (si HNL) | `data()` | `AMOUNTLCY` |
| `$ingresoDataCapture/CURRENCY` (si no HNL) | `data()` | `CURRENCY` |
| `$ingresoDataCapture/AMOUNT` (si no HNL) | `data()` | `AMOUNTFCY` |

## Tablas de mapeo de salida por cada respuesta de servicio dependiente

### Mapeo ObtenerParametrizacion Response → Variables OSB

| Campo Origen (ObtenerParametrizacion) | Transformación/Script | Campo Destino (OSB Variables) |
|--------------------------------------|----------------------|------------------------------|
| `$RESPONSEobtenerParametrizacion/osb:ERROR_CODE` | `fn:string()` | `$statusParametrizacion` |
| `$RESPONSEobtenerParametrizacion/osb:CONFIGURACIONES/osb:CONFIGURACIONES_ITEM[osb:NAME="T24T099.TXNCODEDR"]/osb:VALUE` | `fn:string()` | `$transactionCodeDebit` |
| `$RESPONSEobtenerParametrizacion/osb:CONFIGURACIONES/osb:CONFIGURACIONES_ITEM[osb:NAME="T24T099.TXNCODECR"]/osb:VALUE` | `fn:string()` | `$transactionCodeCredit` |
| `$RESPONSEobtenerParametrizacion/osb:ERROR_MESSAGE` | `fn:string()` | `$errorParametrizacion` |

### Mapeo DataCapture T24 Response → OSB Response Header

| Campo Origen (T24) | Transformación/Script | Campo Destino (OSB Header) |
|--------------------|----------------------|---------------------------|
| `$ingresodeDataCaptureResponse/Status/transactionId` | `data()` | `aut:ResponseHeader/transactionId` |
| `$ingresodeDataCaptureResponse/Status/successIndicator` | `data()` | `aut:ResponseHeader/successIndicator` |
| `$ingresodeDataCaptureResponse/Status/messages` | `data()` | `aut:ResponseHeader/messages` |
| `$ingresodeDataCaptureResponse/DATACAPTUREType/VALUEDATE` | `data()` | `aut:ResponseHeader/valueDate` |

### Mapeo DataCapture T24 Response → OSB Response Body

| Campo Origen (T24) | Transformación/Script | Campo Destino (OSB Body) |
|--------------------|----------------------|-------------------------|
| `$ingresodeDataCaptureResponse/DATACAPTUREType/RECORDSTATUS` | `if != "" then data() else ()` | `ing:ingresoDataCaptureResponse/RECORD_STATUS` |

## Reglas de negocio detectadas

### Reglas de Validación
1. **Validación de Campos Requeridos**:
   - **Ubicación**: `ingresoDataCaptureValidateRequired.xq` líneas 8-14
   - **Regla**: BATCH_ID, CURRENCY, AMOUNT, DESCRIPTION no pueden estar vacíos
   - **Código**: `if( fn:string($ingresoDataCapture/BATCH_ID/text()) = "" or fn:string($ingresoDataCapture/CURRENCY/text()) = "" or fn:string($ingresoDataCapture/AMOUNT/text()) = "" or fn:string($ingresoDataCapture/DESCRIPTION/text()) = "")`

2. **Validación de DEBIT_CREDIT**:
   - **Ubicación**: `ingresoDataCaptureValidateRequired.xq` línea 13
   - **Regla**: DEBIT_CREDIT debe ser "DEBIT" o "CREDIT"
   - **Código**: `not (fn:string($ingresoDataCapture/DEBIT_CREDIT/text()) = ( "DEBIT" , "CREDIT" ))`

3. **Validación en Pipeline**:
   - **Ubicación**: Pipeline response, condición línea con `not (fn:string($body/ing:ingresoDataCapture/DEBIT_CREDIT/text()) = ("DEBIT","CREDIT"))`
   - **Regla**: Validación adicional de DEBIT_CREDIT en el pipeline
   - **Mensaje**: "VALUE NOT ALLOWED FOR FIELD DEBIT_CREDIT. IT MUST BE \"DEBIT\" OR \"CREDIT\""

### Reglas de Transformación de Moneda
4. **Lógica de Moneda Local vs Extranjera**:
   - **Ubicación**: `ingresoDataCaptureIn.xq` líneas 75-82
   - **Regla**: Si moneda es HNL usar AMOUNTLCY, sino usar CURRENCY + AMOUNTFCY
   - **Código**: `if (data($ingresoDataCapture/CURRENCY) = "HNL") then (<AMOUNTLCY>{data($ingresoDataCapture/AMOUNT)}</AMOUNTLCY>) else (<CURRENCY>{data($ingresoDataCapture/CURRENCY)}</CURRENCY>, <AMOUNTFCY>{data($ingresoDataCapture/AMOUNT)}</AMOUNTFCY>)`

### Reglas de Mapeo de Transacciones
5. **Mapeo de DEBIT_CREDIT a SIGN y TRANSACTIONCODE**:
   - **Ubicación**: `ingresoDataCaptureIn.xq` líneas 58-66
   - **Regla**: DEBIT → SIGN="D" + código débito, CREDIT → SIGN="C" + código crédito
   - **Código**: `if ($debit_credit = "DEBIT") then (<SIGN>D</SIGN>, <TRANSACTIONCODE>{$transactionCodeDebito}</TRANSACTIONCODE>) else if ($debit_credit = "CREDIT") then (<SIGN>C</SIGN>, <TRANSACTIONCODE>{$transactionCodeCredito}</TRANSACTIONCODE>)`

### Reglas de Procesamiento de Texto
6. **División de Narrativa**:
   - **Ubicación**: `ingresoDataCaptureIn.xq` función `splitString` líneas 25-29
   - **Regla**: Dividir descripción en líneas de máximo 34 caracteres
   - **Código**: `if (exists($String) and string-length($String) > $length) then (substring($String,1,$length), splitString(substring($String,$length+1),$length)) else $String`

7. **Generación de ID de Transacción**:
   - **Ubicación**: `ingresoDataCaptureIn.xq` línea 56
   - **Regla**: ID = DEPARTMENT_CODE + BATCH_ID
   - **Código**: `concat($ingresoDataCapture/DEPARTMENT_CODE , $ingresoDataCapture/BATCH_ID)`

### Reglas de Seguridad y Credenciales
8. **Lookup de Credenciales LDAP**:
   - **Ubicación**: `ingresoDataCaptureIn.xq` funciones `getUsername` y `getPassword` líneas 10-23
   - **Regla**: Intentar obtener credenciales de LDAP, usar originales como fallback
   - **Código**: `fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), data($autenticacionRequestHeader/UserName))`

9. **Path de Seguridad LDAP**:
   - **Ubicación**: `ingresoDataCaptureIn.xq` líneas 11 y 18
   - **Regla**: Credenciales en `Middleware/Security/{USERNAME_UPPERCASE}`
   - **Código**: `concat("Middleware/Security/", upper-case($LDAPUsername))`

### Reglas de Manejo de Errores
10. **Manejo de Error de Parametrización**:
    - **Ubicación**: Pipeline request, condición `$statusParametrizacion = "SUCCESS"`
    - **Regla**: Solo proceder si la parametrización es exitosa
    - **Mensaje Error**: Usar `$errorParametrizacion` del response

11. **Manejo de Campos Requeridos**:
    - **Ubicación**: Pipeline response, condición `$isRequestValid = "true"`
    - **Regla**: Solo procesar si la validación es exitosa
    - **Mensaje Error**: "REQUIRED FIELDS NOT SUPPLIED"

12. **Manejo de Faults del Sistema**:
    - **Ubicación**: Pipeline de error
    - **Regla**: Capturar errorCode y reason del fault
    - **Código**: `concat(fn:string($fault/ctx:errorCode/text()), ": ", fn:string($fault/ctx:reason/text()))`