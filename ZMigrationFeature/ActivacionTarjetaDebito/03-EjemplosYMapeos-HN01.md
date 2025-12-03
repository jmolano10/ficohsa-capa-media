# Ejemplos de Request/Response y Mapeo de Datos - HN01 (Honduras)

## Request OSB (Ejemplo JSON/XML)

### SOAP Request Completo
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
    <soap:Header>
        <aut:RequestHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
            <Authentication>
                <UserName>USRHONDURAS01</UserName>
                <Password>password123</Password>
            </Authentication>
            <Region>
                <SourceBank>HN01</SourceBank>
                <DestinationBank>HN01</DestinationBank>
            </Region>
            <TransactionId>TXN-20241201-001</TransactionId>
            <Timestamp>2024-12-01T10:30:00</Timestamp>
        </aut:RequestHeader>
    </soap:Header>
    <soap:Body>
        <act:activacionTarjetaDebito xmlns:act="http://www.ficohsa.com.hn/middleware.services/activacionTarjetaDebitoTypes">
            <DEBIT_CARD_NUMBER>1234567890123456</DEBIT_CARD_NUMBER>
        </act:activacionTarjetaDebito>
    </soap:Body>
</soap:Envelope>
```

## Response OSB (Ejemplo JSON/XML)

### SOAP Response Exitoso
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
    <soap:Header>
        <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
            <successIndicator>Success</successIndicator>
            <transactionId>TXN-ACT-20241201-001</transactionId>
        </aut:ResponseHeader>
    </soap:Header>
    <soap:Body>
        <act:activacionTarjetaDebitoResponse xmlns:act="http://www.ficohsa.com.hn/middleware.services/activacionTarjetaDebitoTypes"/>
    </soap:Body>
</soap:Envelope>
```

### SOAP Response con Error - Campo Vacío
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
    <soap:Header>
        <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
            <successIndicator>ERROR</successIndicator>
            <messages>REQUIRED FIELDS NOT SUPPLIED</messages>
        </aut:ResponseHeader>
    </soap:Header>
    <soap:Body>
        <act:activacionTarjetaDebitoResponse xmlns:act="http://www.ficohsa.com.hn/middleware.services/activacionTarjetaDebitoTypes"/>
    </soap:Body>
</soap:Envelope>
```

### SOAP Response con Error - Tarjeta No Encontrada
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
    <soap:Header>
        <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
            <successIndicator>ERROR</successIndicator>
            <messages>NO RECORDS FOUND FOR THE SPECIFIED CARD NUMBER</messages>
        </aut:ResponseHeader>
    </soap:Header>
    <soap:Body>
        <act:activacionTarjetaDebitoResponse xmlns:act="http://www.ficohsa.com.hn/middleware.services/activacionTarjetaDebitoTypes"/>
    </soap:Body>
</soap:Envelope>
```

## Requests/Responses Internos a Servicios Dependientes

### 1. Request a ConsultaMaestraTarjetaDebito (T24)
```xml
<ns2:ConsultaMaestraTarjetaDebito xmlns:ns2="T24WebServicesImpl">
    <WebRequestCommon>
        <userName>FICOHSA_USER</userName>
        <password>encrypted_password</password>
    </WebRequestCommon>
    <WSFICODEBITCARDCUSTOMERType>
        <enquiryInputCollection>
            <columnName>@ID</columnName>
            <criteriaValue>...1234567890123456</criteriaValue>
            <operand>LK</operand>
        </enquiryInputCollection>
    </WSFICODEBITCARDCUSTOMERType>
</ns2:ConsultaMaestraTarjetaDebito>
```

### Response de ConsultaMaestraTarjetaDebito
```xml
<ns2:ConsultaMaestraTarjetaDebitoResponse xmlns:ns2="T24WebServicesImpl">
    <Status>
        <successIndicator>Success</successIndicator>
        <messages></messages>
    </Status>
    <WSFICODEBITCARDCUSTOMERType>
        <gWSFICODEBITCARDCUSTOMERDetailType>
            <mWSFICODEBITCARDCUSTOMERDetailType>
                <PRODUCTTYPE>DEBITO.CLASICA</PRODUCTTYPE>
                <CUSTOMERNUMBER>12345678</CUSTOMERNUMBER>
                <CARDSTATUS>ISSUED</CARDSTATUS>
                <EXPIRYDATE>202512</EXPIRYDATE>
            </mWSFICODEBITCARDCUSTOMERDetailType>
        </gWSFICODEBITCARDCUSTOMERDetailType>
    </WSFICODEBITCARDCUSTOMERType>
</ns2:ConsultaMaestraTarjetaDebitoResponse>
```

### 2. Request a Activaciondetarjetadedebito (T24)
```xml
<ns2:ActivaciondeTarjetadeDebito xmlns:ns2="T24WebServicesImpl">
    <WebRequestCommon>
        <userName>FICOHSA_USER</userName>
        <password>encrypted_password</password>
    </WebRequestCommon>
    <OfsFunction>
        <gtsControl></gtsControl>
        <messageId></messageId>
        <noOfAuth></noOfAuth>
        <replace></replace>
    </OfsFunction>
    <LATAMCARDORDERACTIVETDWSType id="DEBITO.CLASICA.1234567890123456"/>
</ns2:ActivaciondeTarjetadeDebito>
```

### Response de Activaciondetarjetadedebito
```xml
<ns2:ActivaciondeTarjetadeDebitoResponse xmlns:ns2="T24WebServicesImpl">
    <Status>
        <successIndicator>Success</successIndicator>
        <messages></messages>
    </Status>
    <LATAMCARDORDERACTIVETDOUTPUTType>
        <TransactionId>ACT20241201001</TransactionId>
        <CardNumber>1234567890123456</CardNumber>
        <ActivationDate>20241201</ActivationDate>
        <Status>ACTIVE</Status>
    </LATAMCARDORDERACTIVETDOUTPUTType>
</ns2:ActivaciondeTarjetadeDebitoResponse>
```

### 3. Request a RegistrarBitacoraOSB (Request)
```xml
<registrarBitacoraOSB>
    <UuidReq></UuidReq>
    <IdOsb>mwomnicanal:8004</IdOsb>
    <Uuid>uuid-req-20241201-001</Uuid>
    <BancoDestino>HN01</BancoDestino>
    <Contenido>
        <act:activacionTarjetaDebito>
            <DEBIT_CARD_NUMBER>1234567890123456</DEBIT_CARD_NUMBER>
        </act:activacionTarjetaDebito>
    </Contenido>
    <BancoOrigen>HN01</BancoOrigen>
    <Usuario>USRHONDURAS01</Usuario>
    <IdServicio>FICBCO0324</IdServicio>
    <IdOperacion>activacionTarjetaDebito</IdOperacion>
    <Resultado></Resultado>
    <IdTxn></IdTxn>
    <TipoMensaje>REQ</TipoMensaje>
    <FechaTxn>2024-12-01</FechaTxn>
    <MensajeError></MensajeError>
</registrarBitacoraOSB>
```

### 4. Request a RegistrarBitacoraOSB (Response)
```xml
<registrarBitacoraOSB>
    <UuidReq>uuid-req-20241201-001</UuidReq>
    <IdOsb>mwomnicanal:8004</IdOsb>
    <Uuid>uuid-rsp-20241201-001</Uuid>
    <Contenido>
        <act:activacionTarjetaDebitoResponse/>
    </Contenido>
    <Usuario>USRHONDURAS01</Usuario>
    <FechaTxn>2024-12-01</FechaTxn>
    <MensajeError></MensajeError>
    <BancoDestino>HN01</BancoDestino>
    <BancoOrigen>HN01</BancoOrigen>
    <IdOperacion>activacionTarjetaDebito</IdOperacion>
    <Resultado>Success</Resultado>
    <IdServicio>FICBCO0324</IdServicio>
    <IdTxn>TXN-ACT-20241201-001</IdTxn>
    <TipoMensaje>RSP</TipoMensaje>
</registrarBitacoraOSB>
```

## Cadenas de Conexión y Credenciales

### Conexión T24 TarjetasDebito
- **Business Service**: `Middleware/Business_Resources/tarjetasDebito/Resources/tarjetasDebitoBS`
- **Operaciones**: `ConsultaMaestraTarjetaDebito`, `Activaciondetarjetadedebito`
- **Protocolo**: SOAP/HTTP
- **Timeout**: No configurado específicamente
- **Retry**: No configurado

### Conexión Bitácora OSB
- **Business Service**: `Middleware/v2/BusinessServices/OSB/RegistrarBitacoraOSB_v2/biz/RegistrarBitacoraOSB_v2`
- **Operación**: `registrarBitacoraOSB`
- **Protocolo**: Interno OSB
- **Modo**: Route (fire-and-forget)

### Credenciales LDAP
- **Path Base**: `Middleware/Security/`
- **Pattern**: `Middleware/Security/{UPPER(USERNAME)}`
- **Función Lookup**: `fn-bea:lookupBasicCredentials()`
- **Failover**: Usa credenciales del header si LDAP falla

## Tablas de Mapeo de Entrada

### Mapeo OSB Request → ConsultaMaestraTarjetaDebito

| Campo Origen (OSB) | Transformación/Script | Campo Destino (T24) |
|-------------------|----------------------|-------------------|
| `$header/aut:RequestHeader/Authentication/UserName` | `getUsername()` con LDAP lookup + failover | `WebRequestCommon/userName` |
| `$header/aut:RequestHeader/Authentication/Password` | `getPassword()` con LDAP lookup + failover | `WebRequestCommon/password` |
| `$body/act:activacionTarjetaDebito/DEBIT_CARD_NUMBER` | `concat("...", data())` | `WSFICODEBITCARDCUSTOMERType/enquiryInputCollection/criteriaValue` |
| Constante "@ID" | Valor fijo | `WSFICODEBITCARDCUSTOMERType/enquiryInputCollection/columnName` |
| Constante "LK" | Valor fijo | `WSFICODEBITCARDCUSTOMERType/enquiryInputCollection/operand` |

### Mapeo ConsultaMaestraTarjetaDebito Response → ActivaciondeTarjetadeDebito

| Campo Origen (T24 Consulta) | Transformación/Script | Campo Destino (T24 Activación) |
|----------------------------|----------------------|-------------------------------|
| `$header/aut:RequestHeader/Authentication/UserName` | `getUsername()` con LDAP lookup + failover | `WebRequestCommon/userName` |
| `$header/aut:RequestHeader/Authentication/Password` | `getPassword()` con LDAP lookup + failover | `WebRequestCommon/password` |
| `$consultaMaestraTarjetaDebitoResponse/.../PRODUCTTYPE` + `$activacionTarjetaDebito/DEBIT_CARD_NUMBER` | `concat(PRODUCTTYPE, ".", DEBIT_CARD_NUMBER)` | `LATAMCARDORDERACTIVETDWSType/@id` |

### Script de Transformación consultaMaestraTDIn.xq
```xquery
declare function getUsername ($LDAPUsername as xs:string) as xs:string { 
    let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
    return $data/con:username/text()
};

declare function getPassword ($LDAPUsername as xs:string) as xs:string {      
    let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
    return $data/con:password/text()
};

<WSFICODEBITCARDCUSTOMERType>
    <enquiryInputCollection>
        <columnName>@ID</columnName>
        <criteriaValue>{concat("...", data($activacionTarjetaDebito/DEBIT_CARD_NUMBER))}</criteriaValue>
        <operand>LK</operand>
    </enquiryInputCollection>
</WSFICODEBITCARDCUSTOMERType>
```

### Script de Transformación activacionTarjetaDebitoIn.xq
```xquery
<LATAMCARDORDERACTIVETDWSType id="{concat($consultaMaestraTarjetaDebitoResponse/WSFICODEBITCARDCUSTOMERType[1]/gWSFICODEBITCARDCUSTOMERDetailType/mWSFICODEBITCARDCUSTOMERDetailType[1]/PRODUCTTYPE, ".", $activacionTarjetaDebito/DEBIT_CARD_NUMBER)}"/>
```

## Tablas de Mapeo de Salida

### Mapeo T24 Response → OSB Response Header

| Campo Origen (T24) | Transformación/Script | Campo Destino (OSB) |
|-------------------|----------------------|-------------------|
| `$RESPONSEActivaciondetarjetadedebito/Status/successIndicator` | Evaluación condicional | Header successIndicator |
| `$RESPONSEActivaciondetarjetadedebito/Status/messages` | `data()` directo | Header messages |
| `$RESPONSEActivaciondetarjetadedebito/.../TransactionId` | `data()` directo | Header transactionId |

### Script de Transformación activacionTarjetaDebitoHeaderOut.xq
```xquery
<aut:ResponseHeader>
    <successIndicator>{data($activaciondeTarjetadeDebitoResponse/Status/successIndicator)}</successIndicator>
    {
        if ($activaciondeTarjetadeDebitoResponse/Status/messages/text()) then
            <messages>{data($activaciondeTarjetadeDebitoResponse/Status/messages)}</messages>
        else ()
    }
    {
        if ($activaciondeTarjetadeDebitoResponse/LATAMCARDORDERACTIVETDOUTPUTType/TransactionId/text()) then
            <transactionId>{data($activaciondeTarjetadeDebitoResponse/LATAMCARDORDERACTIVETDOUTPUTType/TransactionId)}</transactionId>
        else ()
    }
</aut:ResponseHeader>
```

## Reglas de Negocio Detectadas

### 1. Validación de Campo Obligatorio
**Ubicación**: `HN01_ActivacionTarjetasDebito_request` pipeline
**Lógica**: 
```xquery
$cardNumber != ""
```
**Descripción**: El número de tarjeta no puede estar vacío

### 2. Patrón de Búsqueda de Tarjeta
**Ubicación**: `consultaMaestraTDIn.xq`
**Lógica**:
```xquery
concat("...", data($activacionTarjetaDebito/DEBIT_CARD_NUMBER))
```
**Descripción**: Busca tarjetas que terminen con el número proporcionado

### 3. Validación de Tipo de Producto
**Ubicación**: `HN01_ActivacionTarjetasDebito_request` pipeline
**Lógica**:
```xquery
$productType != ""
```
**Descripción**: Debe existir un tipo de producto válido para la tarjeta

### 4. Construcción de ID Compuesto
**Ubicación**: `activacionTarjetaDebitoIn.xq`
**Lógica**:
```xquery
concat($consultaMaestraTarjetaDebitoResponse/.../PRODUCTTYPE, ".", $activacionTarjetaDebito/DEBIT_CARD_NUMBER)
```
**Descripción**: El ID de activación combina tipo de producto y número de tarjeta

### 5. Manejo de Mensajes de Error Condicional
**Ubicación**: `HN01_ActivacionTarjetasDebito_request` pipeline
**Lógica**:
```xquery
if (empty($RESPONSEConsultaMaestraTarjetaDebito/WSFICODEBITCARDCUSTOMERType/ZERORECORDS/text())) then (
    fn:string($RESPONSEConsultaMaestraTarjetaDebito/Status/messages/text())
) else (
    fn:string($RESPONSEConsultaMaestraTarjetaDebito/WSFICODEBITCARDCUSTOMERType/ZERORECORDS/text())
)
```
**Descripción**: Prioriza mensaje ZERORECORDS sobre mensajes de Status

### 6. Generación de UUID para Bitácora
**Ubicación**: Stages de bitácora
**Lógica**:
```xquery
<con2:resource ref="Middleware/Business_Resources/general/UUID/obtenerUUID"/>
```
**Descripción**: Genera UUIDs únicos para vincular request y response en bitácora

## Configuración de Políticas OSB

### Binding Configuration
- **SOAP Version**: 1.1
- **WSI Compliant**: No especificado
- **Transport**: HTTPS
- **Port**: activacionTarjetaDebitoPSSOAP

### Monitoring y Alerting
- **Monitoring**: Deshabilitado
- **SLA Alerting**: Habilitado (nivel normal)
- **Pipeline Alerting**: Habilitado (nivel normal)
- **Logging**: Habilitado (nivel debug)
- **Reporting**: Habilitado

### Branch Configuration
- **Tipo**: Condition branch
- **Variable**: header
- **XPath**: `./aut:RequestHeader/Region/SourceBank`
- **Condición HN01**: `equals 'HN01'`
- **Default**: Error "SERVICE NOT IMPLEMENTED YET"

## Ejemplos de Casos de Uso

### Caso 1: Activación Exitosa
```xml
<!-- Request -->
<DEBIT_CARD_NUMBER>4567890123456789</DEBIT_CARD_NUMBER>

<!-- Consulta Maestra Response -->
<PRODUCTTYPE>DEBITO.GOLD</PRODUCTTYPE>

<!-- ID Generado para Activación -->
<LATAMCARDORDERACTIVETDWSType id="DEBITO.GOLD.4567890123456789"/>

<!-- Response Final -->
<successIndicator>Success</successIndicator>
<transactionId>ACT20241201002</transactionId>
```

### Caso 2: Tarjeta No Encontrada
```xml
<!-- Request -->
<DEBIT_CARD_NUMBER>9999999999999999</DEBIT_CARD_NUMBER>

<!-- Consulta Maestra Response -->
<ZERORECORDS>NO RECORDS FOUND</ZERORECORDS>

<!-- Response Final -->
<successIndicator>ERROR</successIndicator>
<messages>NO RECORDS FOUND</messages>
```

### Caso 3: Campo Vacío
```xml
<!-- Request -->
<DEBIT_CARD_NUMBER></DEBIT_CARD_NUMBER>

<!-- Response Final -->
<successIndicator>ERROR</successIndicator>
<messages>REQUIRED FIELDS NOT SUPPLIED</messages>
```

## Dependencias y Referencias

### Archivos XQuery Referenciados
- `Middleware/v2/Resources/ActivacionTarjetaDebito/xq/consultaMaestraTDIn`
- `Middleware/v2/Resources/ActivacionTarjetaDebito/xq/activacionTarjetaDebitoIn`
- `Middleware/v2/Resources/ActivacionTarjetaDebito/xq/activacionTarjetaDebitoHeaderOut`
- `Middleware/v2/Resources/Generales/xq/registrarBitacoraOSBIn`
- `Middleware/Business_Resources/general/UUID/obtenerUUID`

### Esquemas XSD Referenciados
- `Middleware/v2/Resources/ActivacionTarjetaDebito/xsd/activacionTarjetaDebitoTypes`
- `../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd`

### Business Services Referenciados
- `Middleware/Business_Resources/tarjetasDebito/Resources/tarjetasDebitoBS`
- `Middleware/v2/BusinessServices/OSB/RegistrarBitacoraOSB_v2/biz/RegistrarBitacoraOSB_v2`

### Namespaces Utilizados
- `T24WebServicesImpl` - Namespace de T24
- `http://www.ficohsa.com.hn/middleware.services/activacionTarjetaDebitoTypes` - Tipos OSB
- `http://www.ficohsa.com.hn/middleware.services/autType` - Headers de autenticación

### Funciones Personalizadas
- `getUsername()` - Lookup de usuario en LDAP
- `getPassword()` - Lookup de password en LDAP
- `obtenerUUID()` - Generación de UUIDs únicos