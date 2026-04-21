# Ejemplos y Mapeos de Datos - Región HN01

## Request OSB (ejemplo JSON/XML)

### Request SOAP - reversarTransaccionID

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:rev="http://www.ficohsa.com.hn/middleware.services/reversarTransaccionIDTypes" 
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>TENGO_USER</UserName>
            <Password>TENGO_PASS</Password>
         </Authentication>
         <SourceBank>HN01</SourceBank>
         <ServiceId>FICBCO0516</ServiceId>
         <Version>V2</Version>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <rev:reversarTransaccionID>
         <TRANSACTION_TYPE>PAGO_TC</TRANSACTION_TYPE>
         <TRANSACTION_ID>TFS240101001234</TRANSACTION_ID>
      </rev:reversarTransaccionID>
   </soapenv:Body>
</soapenv:Envelope>
```

## Response OSB (ejemplo JSON/XML)

### Response SOAP - reversarTransaccionIDResponse (Exitoso)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:rev="http://www.ficohsa.com.hn/middleware.services/reversarTransaccionIDTypes" 
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>SUCCESS</successIndicator>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <rev:reversarTransaccionIDResponse>
         <T24_REFERENCE>FT24001HN001234</T24_REFERENCE>
         <TRANSACTION_ID>TFS240101001234</TRANSACTION_ID>
         <REFERENCE_CB>CB240101001234</REFERENCE_CB>
      </rev:reversarTransaccionIDResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

### Response SOAP - reversarTransaccionIDResponse (Error)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:rev="http://www.ficohsa.com.hn/middleware.services/reversarTransaccionIDTypes" 
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>ERROR</successIndicator>
         <messageId>La transaccion no se puede reversar porque aun no se ha aplicado en V+</messageId>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <rev:reversarTransaccionIDResponse/>
   </soapenv:Body>
</soapenv:Envelope>
```

## Requests/Responses internos a servicios dependientes

### 1. Consulta Ruta Regional

**Request:**
```xml
<con1:InputParameters xmlns:con1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRutaRegional">
   <con1:PV_ID_SERVICIO>FICBCO0516</con1:PV_ID_SERVICIO>
   <con1:PV_REGION>HN01</con1:PV_REGION>
   <con1:PV_OPERACION>reversarTransaccionID</con1:PV_OPERACION>
   <con1:PV_VERSION>V2</con1:PV_VERSION>
</con1:InputParameters>
```

**Response:**
```xml
<con1:OutputParameters xmlns:con1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRutaRegional">
   <con1:PV_CODIGO_ERROR>SUCCESS</con1:PV_CODIGO_ERROR>
   <con1:PV_MENSAJE_ERROR></con1:PV_MENSAJE_ERROR>
</con1:OutputParameters>
```

### 2. Obtener Tipo Transacción Genérica

**Request:**
```xml
<otg:InputParameters xmlns:otg="http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerTipoTrxGen">
   <otg:PV_COD_OSB>PAGO_TC</otg:PV_COD_OSB>
</otg:InputParameters>
```

**Response:**
```xml
<otg:OutputParameters xmlns:otg="http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerTipoTrxGen">
   <otg:PV_ERROR_CODE>SUCCESS</otg:PV_ERROR_CODE>
   <otg:PV_MESSAGE>NOGEN</otg:PV_MESSAGE>
   <otg:PV_TIPO_OPE>ReversionPagoTCTengo</otg:PV_TIPO_OPE>
</otg:OutputParameters>
```

### 3. Validar Estado Transacción

**Request:**
```xml
<val:InputParameters xmlns:val="http://xmlns.oracle.com/pcbpel/adapter/db/sp/validarEstadoTransaccion">
   <val:PV_CODIGO_ESTADO>0</val:PV_CODIGO_ESTADO>
   <val:PV_UUID>TFS240101001234</val:PV_UUID>
   <val:PV_TIPO_CONSULTA>1</val:PV_TIPO_CONSULTA>
</val:InputParameters>
```

**Response:**
```xml
<val:OutputParameters xmlns:val="http://xmlns.oracle.com/pcbpel/adapter/db/sp/validarEstadoTransaccion">
   <val:PV_ERRORCODE>SUCCESS</val:PV_ERRORCODE>
   <val:PV_ERRORMESSAGE></val:PV_ERRORMESSAGE>
   <val:PV_FT>FT24001HN001234</val:PV_FT>
   <val:PV_MESSAGE>TRUE</val:PV_MESSAGE>
   <val:Pv_uuido>TFS240101001234</val:Pv_uuido>
   <val:Pv_refcb>CB240101001234</val:Pv_refcb>
</val:OutputParameters>
```

### 4. Registrar Reversión TC CB

**Request:**
```xml
<reg:InputParameters xmlns:reg="http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarReversionTCCB">
   <reg:PV_TRANSACTION_ID>FT24001HN001234</reg:PV_TRANSACTION_ID>
</reg:InputParameters>
```

**Response:**
```xml
<reg:OutputParameters xmlns:reg="http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarReversionTCCB">
   <reg:PV_ERRORCODE>SUCCESS</reg:PV_ERRORCODE>
</reg:OutputParameters>
```

### 5. Operación ReversionPagoTCTengo (T24)

**Request:**
```xml
<ns0:ReversionPagoTCTengo xmlns:ns0="T24WebServicesImpl">
   <WebRequestCommon>
      <userName>TENGO_USER_T24</userName>
      <password>TENGO_PASS_T24</password>
   </WebRequestCommon>
   <OfsFunction>
      <gtsControl/>
      <messageId/>
      <noOfAuth/>
      <replace/>
   </OfsFunction>
   <TELLERFINANCIALSERVICESFICOREVTXNUUIDTFSType id="FT24001HN001234"/>
</ns0:ReversionPagoTCTengo>
```

**Response:**
```xml
<ns0:ReversionPagoTCTengoResponse xmlns:ns0="T24WebServicesImpl">
   <Status>
      <transactionId>FT24001HN001234REV</transactionId>
      <successIndicator>Success</successIndicator>
      <messages>Transaccion reversada exitosamente</messages>
   </Status>
   <TELLERFINANCIALSERVICESType id="FT24001HN001234REV">
      <RECORDSTATUS>LIVE</RECORDSTATUS>
      <REVERSALMARK>R</REVERSALMARK>
   </TELLERFINANCIALSERVICESType>
</ns0:ReversionPagoTCTengoResponse>
```

### 6. Registrar Reversión TC Master Data

**Request:**
```xml
<conRev:InputParameters xmlns:conRev="http://xmlns.oracle.com/pcbpel/adapter/db/sp/conReversarPagoTCRG">
   <conRev:PV_TRANSACTION_ID>FT24001HN001234REV</conRev:TRANSACTION_ID>
</conRev:InputParameters>
```

**Response:**
```xml
<conRev:OutputParameters xmlns:conRev="http://xmlns.oracle.com/pcbpel/adapter/db/sp/conReversarPagoTCRG">
   <conRev:PV_ERRORCODE>SUCCESS</conRev:PV_ERRORCODE>
</conRev:OutputParameters>
```

### 7. Actualizar Estado Transacción

**Request:**
```xml
<act:InputParameters xmlns:act="http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizarEstadoTransaccionUUID">
   <act:PV_ESTADO>R</act:PV_ESTADO>
   <act:PV_UUID>TFS240101001234</act:PV_UUID>
</act:InputParameters>
```

**Response:**
```xml
<act:OutputParameters xmlns:act="http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizarEstadoTransaccionUUID">
   <act:PV_ERRORCODE>SUCCESS</act:PV_ERRORCODE>
   <act:PV_ERRORMESSAGE></act:PV_ERRORMESSAGE>
</act:OutputParameters>
```

## Cadenas de conexión detectadas y credenciales

### Base de Datos
- **Nombre de la base de datos**: FICOHSA_HN_DB
- **Esquema**: FICOHSA_CORE
- **Stored Procedures**:
  - `consultaRutaRegional`
  - `obtenerTipoTrxGen`
  - `validarEstadoTransaccion`
  - `registrarReversionTCCB`
  - `conReversarPagoTCRG`
  - `actualizarEstadoTransaccionUUID`

### Servicios WSDL
- **Endpoint T24**: `http://10.242.104.55:7004/svcReversarTransaccionCB/services`
- **Operación**: `ReversionPagoTCTengo`
- **Credenciales**: Obtenidas dinámicamente desde `Middleware/Security/{USERNAME}`

## Tablas de mapeo de entrada por cada llamada a servicio dependiente

### Mapeo OSB → Consulta Ruta Regional
| Campo Origen (OSB) | Transformación/Script | Campo Destino (servicio interno) |
|-------------------|----------------------|----------------------------------|
| Constante 'FICBCO0516' | Valor fijo | PV_ID_SERVICIO |
| $header/aut:RequestHeader/SourceBank | Extracción XPath | PV_REGION |
| $operation | Variable de contexto | PV_OPERACION |
| Constante 'V2' | Valor fijo | PV_VERSION |

### Mapeo OSB → Obtener Tipo Transacción
| Campo Origen (OSB) | Transformación/Script | Campo Destino (servicio interno) |
|-------------------|----------------------|----------------------------------|
| $body/rev:reversarTransaccionID/TRANSACTION_TYPE | Extracción XPath | PV_COD_OSB |

### Mapeo OSB → Validar Estado Transacción
| Campo Origen (OSB) | Transformación/Script | Campo Destino (servicio interno) |
|-------------------|----------------------|----------------------------------|
| Constante '0' | Valor fijo | PV_CODIGO_ESTADO |
| $body/rev:reversarTransaccionID/TRANSACTION_ID | Extracción XPath | PV_UUID |
| $tipoConsulta | Variable calculada (1 o 4) | PV_TIPO_CONSULTA |

### Mapeo OSB → ReversionPagoTCTengo (T24)
| Campo Origen (OSB) | Transformación/Script | Campo Destino (servicio interno) |
|-------------------|----------------------|----------------------------------|
| $header/aut:RequestHeader/Authentication/UserName | getUsername($user) | WebRequestCommon/userName |
| $header/aut:RequestHeader/Authentication/Password | getPassword($user) | WebRequestCommon/password |
| $refT24 | Variable de respuesta DB | TELLERFINANCIALSERVICESFICOREVTXNUUIDTFSType/@id |

## Tablas de mapeo de salida por cada respuesta de servicio dependiente

### Mapeo Validar Estado Transacción → Variables OSB
| Campo Origen (servicio interno) | Transformación/Script | Campo Destino (OSB) |
|--------------------------------|----------------------|---------------------|
| PV_ERRORCODE | fn:string() | $successIndicator |
| PV_ERRORMESSAGE | fn:string() | $ErrorCode |
| PV_FT | fn:string() | $refT24 |
| PV_MESSAGE | fn:string() | $dbmesage |
| Pv_uuido | fn:string() | $uuiddb |
| Pv_refcb | fn:string() | $refcb |

### Mapeo ReversionPagoTCTengo → Variables OSB
| Campo Origen (servicio interno) | Transformación/Script | Campo Destino (OSB) |
|--------------------------------|----------------------|---------------------|
| Status/successIndicator | fn:upper-case(fn:string()) | $successIndicator |
| Status/messages | fn:string() | $errorCode |
| Status/transactionId | fn:string() | $statusT24 |

### Mapeo Variables OSB → Response Final
| Campo Origen (OSB) | Transformación/Script | Campo Destino (Response) |
|-------------------|----------------------|--------------------------|
| $statusT24 | fn:upper-case(fn:string()) | T24_REFERENCE |
| $uuiddb | fn:upper-case(fn:string()) | TRANSACTION_ID |
| $refcb | fn:upper-case(fn:string()) | REFERENCE_CB |

## Reglas de negocio detectadas

### 1. Validación de Tipo de Transacción
- **Ubicación**: `Middleware/v2/Resources/ReversarTransaccionID/xq/obtenerTipoGenIn.xq`
- **Regla**: Determina si la transacción es genérica (GEN) o no genérica (NOGEN) basado en TRANSACTION_TYPE
- **Lógica**: `if (fn:string($tipoTRX) = 'NOGEN') then (1) else (4)`

### 2. Validación de Estado de Transacción
- **Ubicación**: Pipeline "ValidarTransaccionDB"
- **Regla**: Solo se pueden reversar transacciones con estado válido ($dbmesage = 'TRUE')
- **Error**: "La transaccion no tiene el estado correcto, no se puede reversar."

### 3. Enrutamiento por Tipo de Transacción
- **Ubicación**: Pipeline "ReversarTransaccion"
- **Reglas**:
  - Si `$tipoTransaccion = 'PAGO_TC'` → Llama ReversionPagoTCTengo
  - Si `$tipoTransaccion = 'PAGO_EEH'` → Llama ReversarTransaccionTENGOEEH
  - Otros casos → Llama ReversionDepositoTengo

### 4. Validación de Aplicación en V+
- **Ubicación**: `Middleware/v2/Resources/ReversarTransaccionID/xq/registrarReversionTCID.xq`
- **Regla**: Verifica que la transacción esté aplicada en V+ antes de permitir la reversión
- **Error**: "La transaccion no se puede reversar porque aun no se ha aplicado en V+"

### 5. Actualización de Estado
- **Ubicación**: Pipeline "ActualizarEstadoTransaccion"
- **Regla**: Actualiza el estado de la transacción a 'R' (Reversada) solo si la reversión fue exitosa
- **Condición**: `$successIndicator = 'SUCCESS'`

### 6. Manejo de Credenciales
- **Ubicación**: `Middleware/v2/Resources/ReversarTransaccionID/xq/reversarTRXPagoTCCB.xq`
- **Regla**: Obtiene credenciales dinámicamente usando funciones `getUsername()` y `getPassword()`
- **Fallback**: `fn-bea:fail-over(getUsername($user), '')`

## Ejemplos Específicos de ReversionPagoTCTengo

### Caso de Uso 1: Reversión Exitosa de Pago TC

**Contexto**: Cliente realizó un pago de tarjeta de crédito por $500.00 y necesita reversarlo

**Request OSB:**
```xml
<rev:reversarTransaccionID>
   <TRANSACTION_TYPE>PAGO_TC</TRANSACTION_TYPE>
   <TRANSACTION_ID>TFS240315001500</TRANSACTION_ID>
</rev:reversarTransaccionID>
```

**Request T24 (ReversionPagoTCTengo):**
```xml
<ns0:ReversionPagoTCTengo xmlns:ns0="T24WebServicesImpl">
   <WebRequestCommon>
      <userName>TENGO_HN_USER</userName>
      <password>TENGO_HN_PASS</password>
   </WebRequestCommon>
   <OfsFunction>
      <gtsControl></gtsControl>
      <messageId></messageId>
      <noOfAuth></noOfAuth>
      <replace></replace>
   </OfsFunction>
   <TELLERFINANCIALSERVICESFICOREVTXNUUIDTFSType id="FT24031HN001500">
      <PrimaryAccount>1234567890</PrimaryAccount>
      <CREDITCARDNUM>4111111111111111</CREDITCARDNUM>
      <LRCRCCY>HNL</LRCRCCY>
      <LRAMTPAY>500.00</LRAMTPAY>
      <LRREFTENGO>TFS240315001500</LRREFTENGO>
   </TELLERFINANCIALSERVICESFICOREVTXNUUIDTFSType>
</ns0:ReversionPagoTCTengo>
```

**Response T24 (Exitoso):**
```xml
<ns0:ReversionPagoTCTengoResponse xmlns:ns0="T24WebServicesImpl">
   <Status>
      <transactionId>FT24031HN001500REV</transactionId>
      <messageId>REV001</messageId>
      <successIndicator>Success</successIndicator>
      <application>T24</application>
      <messages>REVERSAL PROCESSED SUCCESSFULLY</messages>
   </Status>
   <TELLERFINANCIALSERVICESType id="FT24031HN001500REV">
      <BOOKINGDATE>20240315</BOOKINGDATE>
      <PRIMARYACCOUNT>1234567890</PRIMARYACCOUNT>
      <RECORDSTATUS>LIVE</RECORDSTATUS>
      <REVERSALMARK>R</REVERSALMARK>
      <CREDITCARDNUM>4111111111111111</CREDITCARDNUM>
      <LRCRCCY>HNL</LRCRCCY>
      <LRAMTPAY>500.00</LRAMTPAY>
      <LRREFTENGO>TFS240315001500</LRREFTENGO>
      <gTRANSACTION>
         <mTRANSACTION m="1">
            <TRANSACTION>CREDIT</TRANSACTION>
            <ACCOUNTCR>1234567890</ACCOUNTCR>
            <CURRENCYCR>HNL</CURRENCYCR>
            <AMOUNTCR>500.00</AMOUNTCR>
            <REVERSALMARK>R</REVERSALMARK>
         </mTRANSACTION>
      </gTRANSACTION>
   </TELLERFINANCIALSERVICESType>
</ns0:ReversionPagoTCTengoResponse>
```

### Caso de Uso 2: Error - Transacción Ya Reversada

**Request T24:**
```xml
<ns0:ReversionPagoTCTengo xmlns:ns0="T24WebServicesImpl">
   <WebRequestCommon>
      <userName>TENGO_HN_USER</userName>
      <password>TENGO_HN_PASS</password>
   </WebRequestCommon>
   <TELLERFINANCIALSERVICESFICOREVTXNUUIDTFSType id="FT24031HN001500"/>
</ns0:ReversionPagoTCTengo>
```

**Response T24 (Error):**
```xml
<ns0:ReversionPagoTCTengoResponse xmlns:ns0="T24WebServicesImpl">
   <Status>
      <transactionId>FT24031HN001500</transactionId>
      <messageId>ERR001</messageId>
      <successIndicator>T24Error</successIndicator>
      <application>T24</application>
      <messages>TRANSACTION ALREADY REVERSED</messages>
   </Status>
</ns0:ReversionPagoTCTengoResponse>
```

### Caso de Uso 3: Error - Fondos Insuficientes

**Response T24 (Error):**
```xml
<ns0:ReversionPagoTCTengoResponse xmlns:ns0="T24WebServicesImpl">
   <Status>
      <transactionId></transactionId>
      <messageId>ERR002</messageId>
      <successIndicator>T24Error</successIndicator>
      <application>T24</application>
      <messages>INSUFFICIENT FUNDS FOR REVERSAL</messages>
   </Status>
</ns0:ReversionPagoTCTengoResponse>
```

## Mapeo Detallado de Campos T24

### Campos de Entrada (TELLERFINANCIALSERVICESFICOREVTXNUUIDTFSType)

| Campo T24 | Descripción | Origen OSB | Obligatorio |
|-----------|-------------|------------|-------------|
| @id | ID de la transacción T24 | $refT24 | Sí |
| PrimaryAccount | Cuenta principal | Extraído de BD | No |
| CREDITCARDNUM | Número de tarjeta de crédito | Extraído de BD | No |
| LRCRCCY | Moneda de la transacción | Extraído de BD | No |
| LRAMTPAY | Monto a reversar | Extraído de BD | No |
| LRREFTENGO | Referencia TENGO | $body/TRANSACTION_ID | No |

### Campos de Salida (TELLERFINANCIALSERVICESType)

| Campo T24 | Descripción | Mapeo OSB | Uso |
|-----------|-------------|-----------|-----|
| @id | ID de la reversión | $statusT24 | Response |
| BOOKINGDATE | Fecha de procesamiento | No mapeado | Log |
| RECORDSTATUS | Estado del registro | No mapeado | Validación |
| REVERSALMARK | Marca de reversión | No mapeado | Validación |
| gTRANSACTION | Detalles de transacción | No mapeado | Auditoría |

## Transformaciones XQuery Específicas

### Función getUsername
```xquery
declare function getUsername ($LDAPUsername as xs:string) as xs:string { 
    let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
    return $data/con:username/text()
};
```

### Función getPassword
```xquery
declare function getPassword ($LDAPUsername as xs:string) as xs:string {      
    let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
    return $data/con:password/text()
};
```

### Construcción del Request T24
```xquery
<ns0:ReversionPagoTCTengo>
    <WebRequestCommon>
        <userName>{
            fn-bea:fail-over(getUsername($user), '')
        }</userName>
        <password>{
            fn-bea:fail-over(getPassword($user), '')
        }</password>
    </WebRequestCommon>
    <OfsFunction>
        <gtsControl/>
        <messageId/>
        <noOfAuth/>
        <replace/>
    </OfsFunction>
    <TELLERFINANCIALSERVICESFICOREVTXNUUIDTFSType id="{$TFS}"/>
</ns0:ReversionPagoTCTengo>
```

## Validaciones de Negocio Específicas

### 1. Validación de Tipo de Transacción PAGO_TC
```xquery
if ($tipoTransaccion = 'PAGO_TC') then (
    (: Ejecutar ReversionPagoTCTengo :)
    <wsCallout>
        <service>svcReversarTransaccionCB</service>
        <operation>ReversionPagoTCTengo</operation>
    </wsCallout>
) else (
    (: Otros tipos de transacción :)
)
```

### 2. Validación de Estado de Aplicación en V+
```xquery
if (upper-case($errorCode) = "SUCCESS") then (
    (: Continuar con la reversión :)
) else (
    "La transaccion no se puede reversar porque aun no se ha aplicado en V+"
)
```

### 3. Procesamiento de Respuesta T24
```xquery
let $successIndicator := fn:upper-case(fn:string($RSPRevTC/Status/successIndicator/text()))
let $errorCode := fn:string($RSPRevTC/Status/messages/text())
let $statusT24 := fn:string($RSPRevTC/Status/transactionId/text())
return
    if ($successIndicator = 'SUCCESS') then (
        (: Continuar con registro en Master Data :)
    ) else (
        (: Manejar error :)
    )
```