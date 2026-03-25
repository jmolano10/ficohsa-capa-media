# Ejemplos de Request/Response y Mapeo de Datos - NI01 (Nicaragua)

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
            <SourceBank>NI01</SourceBank>
        </Region>
    </aut:RequestHeader>
</soapenv:Header>
```

### SOAP Request Body
```xml
<soapenv:Body>
    <tns:consultaCargosRecurrentesDiarios xmlns:tns="http://www.ficohsa.com.hn/middleware.services/consultaCargosRecurrentesDiariosTypes">
        <CARD_NUMBER>5555555555554444</CARD_NUMBER>
    </tns:consultaCargosRecurrentesDiarios>
</soapenv:Body>
```

## Response OSB (Ejemplo JSON/XML)

### SOAP Response Header
```xml
<soapenv:Header>
    <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
        <successIndicator>Success</successIndicator>
        <messages>Transacciones consultadas exitosamente</messages>
    </aut:ResponseHeader>
</soapenv:Header>
```

### SOAP Response Body
```xml
<soapenv:Body>
    <tns:consultaCargosRecurrentesDiariosResponse xmlns:tns="http://www.ficohsa.com.hn/middleware.services/consultaCargosRecurrentesDiariosTypes">
        <MOVEMENT_INFORMATION>
            <COMMERCE_NAME>FARMACIA CENTRAL NI</COMMERCE_NAME>
            <MOVEMENT_STATUS>Aplicado</MOVEMENT_STATUS>
            <TRANSACTION_DATE>2024-01-15T09:15:00</TRANSACTION_DATE>
            <TRANSACTION_AMOUNT>85.00</TRANSACTION_AMOUNT>
            <TRANSACTION_CURRENCY>NIO</TRANSACTION_CURRENCY>
        </MOVEMENT_INFORMATION>
        <MOVEMENT_INFORMATION>
            <COMMERCE_NAME>GASOLINERA SHELL</COMMERCE_NAME>
            <MOVEMENT_STATUS>Rechazado</MOVEMENT_STATUS>
            <TRANSACTION_DATE>2024-01-15T16:20:00</TRANSACTION_DATE>
            <TRANSACTION_AMOUNT>120.75</TRANSACTION_AMOUNT>
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
    <con1:PV_REGION>NI01</con1:PV_REGION>
    <con1:PV_OPERACION>consultaCargosRecurrentesDiarios</con1:PV_OPERACION>
    <con1:PV_VERSION>V2</con1:PV_VERSION>
</con1:consultaRutaRegional>
```

#### Response de consultaRutaRegional_db
```xml
<con1:consultaRutaRegionalResponse xmlns:con1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRutaRegional">
    <con1:PV_CODIGO_ERROR>SUCCESS</con1:PV_CODIGO_ERROR>
    <con1:PV_MENSAJE_ERROR></con1:PV_MENSAJE_ERROR>
    <con1:PV_UBICACION>Middleware/v2/ProxyServices/ConsultaCargosRecurrentesDiariosNI</con1:PV_UBICACION>
</con1:consultaRutaRegionalResponse>
```

### 2. Obtención de Parámetros

#### Request a ObtenerParametrizacion
```xml
<osb:obtenerParametrizacion xmlns:osb="http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_GET_CONFIG/">
    <osb:NOMBRES_PARAMETROS>VISANET.STRUSER.NI01||VISANET.STRPASSWORD.NI01||VISANET.STRCARDACQMATRIZID.NI01||VISANET.STRTERMINALMATRIZID.NI01</osb:NOMBRES_PARAMETROS>
</osb:obtenerParametrizacion>
```

#### Response de ObtenerParametrizacion
```xml
<osb:obtenerParametrizacionResponse xmlns:osb="http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_GET_CONFIG/">
    <osb:ERROR_CODE></osb:ERROR_CODE>
    <osb:ERROR_MESSAGE></osb:ERROR_MESSAGE>
    <osb:CONFIGURACIONES>
        <osb:CONFIGURACIONES_ITEM>
            <osb:NAME>VISANET.STRUSER.NI01</osb:NAME>
            <osb:VALUE>usuario_visanet_ni</osb:VALUE>
        </osb:CONFIGURACIONES_ITEM>
        <osb:CONFIGURACIONES_ITEM>
            <osb:NAME>VISANET.STRPASSWORD.NI01</osb:NAME>
            <osb:VALUE>password_visanet_ni</osb:VALUE>
        </osb:CONFIGURACIONES_ITEM>
        <osb:CONFIGURACIONES_ITEM>
            <osb:NAME>VISANET.STRCARDACQMATRIZID.NI01</osb:NAME>
            <osb:VALUE>CARDACQ_NI_001</osb:VALUE>
        </osb:CONFIGURACIONES_ITEM>
        <osb:CONFIGURACIONES_ITEM>
            <osb:NAME>VISANET.STRTERMINALMATRIZID.NI01</osb:NAME>
            <osb:VALUE>TERM_NI_001</osb:VALUE>
        </osb:CONFIGURACIONES_ITEM>
    </osb:CONFIGURACIONES>
</osb:obtenerParametrizacionResponse>
```

### 3. Consulta a VisaNet

#### Request a WSVisaTransaction (VisaNet)
```xml
<tem:QueryCardTransaction xmlns:tem="http://tempuri.org/">
    <tem:input>
        <tem:strUser>usuario_visanet_ni</tem:strUser>
        <tem:strPassword>password_visanet_ni</tem:strPassword>
        <tem:strCardacqMatrizId>CARDACQ_NI_001</tem:strCardacqMatrizId>
        <tem:strTerminalMatrizId>TERM_NI_001</tem:strTerminalMatrizId>
        <tem:strCardNumber>5555555555554444</tem:strCardNumber>
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
        <tem:strQueryMessage>Transacciones consultadas exitosamente</tem:strQueryMessage>
        <tem:strResponseDetail>
            <tem:ResponseDetail>
                <tem:strTransactionResponseCode>00</tem:strTransactionResponseCode>
                <tem:strTransactionDate>1/15/2024 9:15:00 AM</tem:strTransactionDate>
                <tem:strTransactionAmount>85.00</tem:strTransactionAmount>
                <tem:strCurrencyCode>NIO</tem:strCurrencyCode>
                <tem:strCommerceName>FARMACIA CENTRAL NI</tem:strCommerceName>
            </tem:ResponseDetail>
            <tem:ResponseDetail>
                <tem:strTransactionResponseCode>51</tem:strTransactionResponseCode>
                <tem:strTransactionDate>1/15/2024 4:20:00 PM</tem:strTransactionDate>
                <tem:strTransactionAmount>120.75</tem:strTransactionAmount>
                <tem:strCurrencyCode>USD</tem:strCurrencyCode>
                <tem:strCommerceName>GASOLINERA SHELL</tem:strCommerceName>
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

### Servicio VisaNet Nicaragua
- **Endpoint WSDL**: `https://192.168.125.16:9443/WSVisaTransaction.asmx`
- **Operación**: `QueryCardTransaction`
- **Protocolo**: SOAP 1.2
- **Puerto**: 9443 (HTTPS)
- **Autenticación**: Usuario y contraseña en el request
- **Parámetros de Conexión**:
  - `strUser`: Usuario de VisaNet para Nicaragua
  - `strPassword`: Contraseña de VisaNet para Nicaragua
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
**Ubicación**: `ConsultaCargosRecurrentesDiariosNI.proxy` - Stage `ObtenerParametrizacion`
```xml
<con4:condition>
    <con:xqueryText>$validationMessage = ""</con:xqueryText>
</con4:condition>
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

### 6. Configuraciones Específicas de Nicaragua
**Ubicación**: `ConsultaCargosRecurrentesDiariosNI.proxy` - Configuraciones del Business Service
- **Throttling**: Configurado pero deshabilitado (capacity: 0, maxQueueLength: 0, timeToLive: 0)
- **Result Caching**: Soportado pero habilitado (isSupported: false, isEnabled: true)
- **Delay Interval**: Deshabilitado (isEnabled: false, delay-interval: 0)

### 7. Protocolo SOAP Específico
**Ubicación**: `wsVisaTransaction.biz` - Configuración del binding
```xml
<ser:binding type="SOAP" isSoap12="true">
```
**Regla**: Nicaragua utiliza SOAP 1.2 en lugar de SOAP 1.1 como Honduras.

### 8. Validación XSD Específica
**Ubicación**: `ConsultaCargosRecurrentesDiariosNI.proxy` - Stage `consultaCargosRecurrentesDiarios`
```xml
<con4:validate>
    <con4:wsdl ref="Middleware/v2/BusinessServices/VisaNet/wsdl/WSVisaTransaction"/>
    <con4:schemaElement xmlns:tem="http://tempuri.org/">tem:QueryCardTransaction</con4:schemaElement>
    <con4:varName>REQQueryCardTransaction</con4:varName>
    <con4:location>
        <con:xpathText>.</con:xpathText>
    </con4:location>
</con4:validate>
```
**Regla**: Valida el request contra el WSDL de VisaNet antes de enviarlo, con ubicación específica en el elemento raíz.

## Diferencias Específicas de NI01

### 1. Configuraciones de Red
- **Puerto HTTPS**: 9443 (en lugar de puerto estándar)
- **URL**: `https://192.168.125.16:9443/WSVisaTransaction.asmx`

### 2. Configuraciones de Performance
- **Throttling**: Explícitamente configurado (aunque deshabilitado)
- **Result Caching**: Configurado con parámetros específicos
- **Delay Interval**: Configuración de intervalo de retraso

### 3. Parámetros de Configuración Específicos
- Prefijo `NI01` en todos los parámetros de VisaNet
- Valores específicos para matriz de adquirente y terminal de Nicaragua

### 4. Error Handler Específico
- ID único: `_onErrorHandler-5076734320840762327-488177e2.17e276fd582.-7b56`
- Lógica idéntica a Honduras pero con identificadores únicos