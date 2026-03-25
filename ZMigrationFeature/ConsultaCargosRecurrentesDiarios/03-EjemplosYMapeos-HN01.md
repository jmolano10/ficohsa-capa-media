# Ejemplos de Request/Response y Mapeo de Datos - HN01 (Honduras)

## Request OSB (Ejemplo JSON/XML)

### SOAP Request Header
```xml
<soapenv:Header>
    <aut:RequestHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
        <Authentication>
            <UserName>usuario_osb</UserName>
            <Password>password_osb</Password>
        </Authentication>
        <Region>
            <SourceBank>HN01</SourceBank>
        </Region>
    </aut:RequestHeader>
</soapenv:Header>
```

### SOAP Request Body
```xml
<soapenv:Body>
    <tns:consultaCargosRecurrentesDiarios xmlns:tns="http://www.ficohsa.com.hn/middleware.services/consultaCargosRecurrentesDiariosTypes">
        <CARD_NUMBER>4111111111111111</CARD_NUMBER>
    </tns:consultaCargosRecurrentesDiarios>
</soapenv:Body>
```

## Response OSB (Ejemplo JSON/XML)

### SOAP Response Header
```xml
<soapenv:Header>
    <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
        <successIndicator>Success</successIndicator>
        <messages>Consulta exitosa</messages>
    </aut:ResponseHeader>
</soapenv:Header>
```

### SOAP Response Body
```xml
<soapenv:Body>
    <tns:consultaCargosRecurrentesDiariosResponse xmlns:tns="http://www.ficohsa.com.hn/middleware.services/consultaCargosRecurrentesDiariosTypes">
        <MOVEMENT_INFORMATION>
            <COMMERCE_NAME>COMERCIO EJEMPLO SA</COMMERCE_NAME>
            <MOVEMENT_STATUS>Aplicado</MOVEMENT_STATUS>
            <TRANSACTION_DATE>2024-01-15T10:30:00</TRANSACTION_DATE>
            <TRANSACTION_AMOUNT>150.00</TRANSACTION_AMOUNT>
            <TRANSACTION_CURRENCY>HNL</TRANSACTION_CURRENCY>
        </MOVEMENT_INFORMATION>
        <MOVEMENT_INFORMATION>
            <COMMERCE_NAME>SUPERMERCADO XYZ</COMMERCE_NAME>
            <MOVEMENT_STATUS>Rechazado</MOVEMENT_STATUS>
            <TRANSACTION_DATE>2024-01-15T14:45:00</TRANSACTION_DATE>
            <TRANSACTION_AMOUNT>75.50</TRANSACTION_AMOUNT>
            <TRANSACTION_CURRENCY>USD</TRANSACTION_CURRENCY>
        </MOVEMENT_INFORMATION>
    </tns:consultaCargosRecurrentesDiariosResponse>
</soapenv:Body>
```

## Requests/Responses Internos a Servicios Dependientes

### 1. Consulta de Ruta Regional

#### Request a consultaRutaRegional_db
```xml
<con1:consultaRutaRegional xmlns:con1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRutaRegional">
    <con1:PV_ID_SERVICIO>FICBCO0276</con1:PV_ID_SERVICIO>
    <con1:PV_REGION>HN01</con1:PV_REGION>
    <con1:PV_OPERACION>consultaCargosRecurrentesDiarios</con1:PV_OPERACION>
    <con1:PV_VERSION>V2</con1:PV_VERSION>
</con1:consultaRutaRegional>
```

#### Response de consultaRutaRegional_db
```xml
<con1:consultaRutaRegionalResponse xmlns:con1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRutaRegional">
    <con1:PV_CODIGO_ERROR>SUCCESS</con1:PV_CODIGO_ERROR>
    <con1:PV_MENSAJE_ERROR></con1:PV_MENSAJE_ERROR>
    <con1:PV_UBICACION>Middleware/v2/ProxyServices/ConsultaCargosRecurrentesDiariosHN</con1:PV_UBICACION>
</con1:consultaRutaRegionalResponse>
```

### 2. Obtención de Parámetros

#### Request a ObtenerParametrizacion
```xml
<osb:obtenerParametrizacion xmlns:osb="http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_GET_CONFIG/">
    <osb:NOMBRES_PARAMETROS>VISANET.STRUSER.HN01||VISANET.STRPASSWORD.HN01||VISANET.STRCARDACQMATRIZID.HN01||VISANET.STRTERMINALMATRIZID.HN01</osb:NOMBRES_PARAMETROS>
</osb:obtenerParametrizacion>
```

#### Response de ObtenerParametrizacion
```xml
<osb:obtenerParametrizacionResponse xmlns:osb="http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_GET_CONFIG/">
    <osb:ERROR_CODE></osb:ERROR_CODE>
    <osb:ERROR_MESSAGE></osb:ERROR_MESSAGE>
    <osb:CONFIGURACIONES>
        <osb:CONFIGURACIONES_ITEM>
            <osb:NAME>VISANET.STRUSER.HN01</osb:NAME>
            <osb:VALUE>usuario_visanet_hn</osb:VALUE>
        </osb:CONFIGURACIONES_ITEM>
        <osb:CONFIGURACIONES_ITEM>
            <osb:NAME>VISANET.STRPASSWORD.HN01</osb:NAME>
            <osb:VALUE>password_visanet_hn</osb:VALUE>
        </osb:CONFIGURACIONES_ITEM>
        <osb:CONFIGURACIONES_ITEM>
            <osb:NAME>VISANET.STRCARDACQMATRIZID.HN01</osb:NAME>
            <osb:VALUE>CARDACQ_HN_001</osb:VALUE>
        </osb:CONFIGURACIONES_ITEM>
        <osb:CONFIGURACIONES_ITEM>
            <osb:NAME>VISANET.STRTERMINALMATRIZID.HN01</osb:NAME>
            <osb:VALUE>TERM_HN_001</osb:VALUE>
        </osb:CONFIGURACIONES_ITEM>
    </osb:CONFIGURACIONES>
</osb:obtenerParametrizacionResponse>
```

### 3. Consulta a VisaNet

#### Request a WSVisaTransaction (VisaNet)
```xml
<tem:QueryCardTransaction xmlns:tem="http://tempuri.org/">
    <tem:input>
        <tem:strUser>usuario_visanet_hn</tem:strUser>
        <tem:strPassword>password_visanet_hn</tem:strPassword>
        <tem:strCardacqMatrizId>CARDACQ_HN_001</tem:strCardacqMatrizId>
        <tem:strTerminalMatrizId>TERM_HN_001</tem:strTerminalMatrizId>
        <tem:strCardNumber>4111111111111111</tem:strCardNumber>
        <tem:strDateIn>2024-01-15</tem:strDateIn>
        <tem:strDateOut>2024-01-15</tem:strDateOut>
    </tem:input>
</tem:QueryCardTransaction>
```

#### Response de WSVisaTransaction (VisaNet)
```xml
<tem:QueryCardTransactionResponse xmlns:tem="http://tempuri.org/">
    <tem:QueryCardTransactionResult>
        <tem:strQueryCode>000</tem:strQueryCode>
        <tem:strQueryMessage>Consulta exitosa</tem:strQueryMessage>
        <tem:strResponseDetail>
            <tem:ResponseDetail>
                <tem:strTransactionResponseCode>00</tem:strTransactionResponseCode>
                <tem:strTransactionDate>1/15/2024 10:30:00 AM</tem:strTransactionDate>
                <tem:strTransactionAmount>150.00</tem:strTransactionAmount>
                <tem:strCurrencyCode>HNL</tem:strCurrencyCode>
                <tem:strCommerceName>COMERCIO EJEMPLO SA</tem:strCommerceName>
            </tem:ResponseDetail>
            <tem:ResponseDetail>
                <tem:strTransactionResponseCode>05</tem:strTransactionResponseCode>
                <tem:strTransactionDate>1/15/2024 2:45:00 PM</tem:strTransactionDate>
                <tem:strTransactionAmount>75.50</tem:strTransactionAmount>
                <tem:strCurrencyCode>USD</tem:strCurrencyCode>
                <tem:strCommerceName>SUPERMERCADO XYZ</tem:strCommerceName>
            </tem:ResponseDetail>
        </tem:strResponseDetail>
    </tem:QueryCardTransactionResult>
</tem:QueryCardTransactionResponse>
```

## Cadenas de Conexión y Credenciales

### Base de Datos de Configuración OSB
- **Servicio**: `ObtenerParametrizacion`
- **Esquema**: `ORA_BANK`
- **Stored Procedure**: `OSB_GET_CONFIG`
- **Parámetros**: Lista de nombres de parámetros separados por `||`

### Servicio VisaNet Honduras
- **Endpoint WSDL**: `https://192.168.125.188/WSVisaTransaction.asmx`
- **Operación**: `QueryCardTransaction`
- **Protocolo**: SOAP 1.1
- **Autenticación**: Usuario y contraseña en el request
- **Parámetros de Conexión**:
  - `strUser`: Usuario de VisaNet para Honduras
  - `strPassword`: Contraseña de VisaNet para Honduras
  - `strCardacqMatrizId`: ID de matriz de adquirente
  - `strTerminalMatrizId`: ID de matriz de terminal

## Tablas de Mapeo de Entrada

### Mapeo OSB → VisaNet (queryCardTransactionIn.xq)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (VisaNet) |
|-------------------|----------------------|------------------------|
| `$header/aut:RequestHeader/Region/SourceBank` | Concatenación con prefijo | Parámetros de configuración |
| `$consultaCargosRecurrentesDiarios/CARD_NUMBER` | `xs:long(data())` | `tem:strCardNumber` |
| `$idStrUser` | Directo desde configuración | `tem:strUser` |
| `$idStrPassword` | Directo desde configuración | `tem:strPassword` |
| `$idStrCardacqMatrizId` | Directo desde configuración | `tem:strCardacqMatrizId` |
| `$idStrTerminalMatrizId` | Directo desde configuración | `tem:strTerminalMatrizId` |
| `current-date()` | `fn-bea:date-to-string-with-format("yyyy-MM-dd")` | `tem:strDateIn` |
| `current-date()` | `fn-bea:date-to-string-with-format("yyyy-MM-dd")` | `tem:strDateOut` |

## Tablas de Mapeo de Salida

### Mapeo VisaNet → OSB (consultaCargosRecurrentesDiariosOut.xq)

| Campo Origen (VisaNet) | Transformación/Script | Campo Destino (OSB) |
|-----------------------|----------------------|-------------------|
| `tem:strCommerceName` | `data()` | `COMMERCE_NAME` |
| `tem:strTransactionResponseCode` | `getStatusDescripcion()` | `MOVEMENT_STATUS` |
| `tem:strTransactionDate` | `fn-bea:dateTime-from-string-with-format("M/dd/yyyy hh:mm:ss a")` | `TRANSACTION_DATE` |
| `tem:strTransactionAmount` | `data()` | `TRANSACTION_AMOUNT` |
| `tem:strCurrencyCode` | `data()` | `TRANSACTION_CURRENCY` |

### Mapeo de Header VisaNet → OSB (consultaCargosRecurrentesDiariosHeaderOut.xq)

| Campo Origen (VisaNet) | Transformación/Script | Campo Destino (OSB) |
|-----------------------|----------------------|-------------------|
| `tem:strQueryCode` | `if($strQueryCode = '000') then 'Success' else fn:concat("VisaNet-", $strQueryCode)` | `successIndicator` |
| `tem:strQueryMessage` | `data()` | `messages` |

## Reglas de Negocio Detectadas

### 1. Mapeo de Estados de Transacción
**Ubicación**: `consultaCargosRecurrentesDiariosOut.xq` - función `getStatusDescripcion()`
```xquery
declare function getStatusDescripcion($valor as xs:string) as xs:string {
    if($valor = "00") then "Aplicado"
    else if ( $valor != "00" ) then "Rechazado"
    else("")
};
```
**Regla**: Solo el código "00" se considera como transacción aplicada, cualquier otro código se marca como rechazada.

### 2. Consulta de Fecha Actual
**Ubicación**: `queryCardTransactionIn.xq`
```xquery
<ns0:strDateIn>{fn-bea:date-to-string-with-format("yyyy-MM-dd", current-date()) }</ns0:strDateIn>
<ns0:strDateOut>{fn-bea:date-to-string-with-format("yyyy-MM-dd",current-date()) }</ns0:strDateOut>
```
**Regla**: Siempre consulta transacciones del día actual (strDateIn = strDateOut = fecha actual).

### 3. Validación de Parámetros
**Ubicación**: `ConsultaCargosRecurrentesDiariosHN.proxy` - Stage `ObtenerParametrizacion`
```xml
<con1:condition>
    <con2:xqueryText>$validationMessage = ""</con2:xqueryText>
</con1:condition>
```
**Regla**: Solo procede con la consulta a VisaNet si no hay mensajes de error en la obtención de parámetros.

### 4. Mapeo de Códigos de Respuesta
**Ubicación**: `consultaCargosRecurrentesDiariosHeaderOut.xq`
```xquery
if($strQueryCode = '000') then (
    <successIndicator>{'Success'}</successIndicator>
)
else (
    <successIndicator>{fn:concat("VisaNet-", $strQueryCode)}</successIndicator>
)
```
**Regla**: El código "000" de VisaNet se mapea a "Success", otros códigos se prefijan con "VisaNet-".

### 5. Conversión de Fechas
**Ubicación**: `consultaCargosRecurrentesDiariosOut.xq`
```xquery
if ($strTransactionDate != '') then (
    <TRANSACTION_DATE>{ fn-bea:dateTime-from-string-with-format("M/dd/yyyy hh:mm:ss a", data($strTransactionDate)) }</TRANSACTION_DATE>
)  else (
    <TRANSACTION_DATE/>
)
```
**Regla**: Las fechas de VisaNet en formato "M/dd/yyyy hh:mm:ss a" se convierten a dateTime XML, campos vacíos generan elementos vacíos.

### 6. Enrutamiento Regional
**Ubicación**: `ConsultaCargosRecurrentesDiarios.proxy` - Service ID
```xml
<con1:assign varName="serviceId">
    <con1:expr>
        <con5:xqueryText>'FICBCO0276'</con5:xqueryText>
    </con1:expr>
</con1:assign>
```
**Regla**: Utiliza el ID de servicio "FICBCO0276" para determinar la ruta regional específica.