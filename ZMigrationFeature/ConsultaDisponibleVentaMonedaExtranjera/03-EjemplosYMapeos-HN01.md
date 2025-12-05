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
        <con:consultaDisponibleVentaMonedaExtranjera xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaDisponibleVentaMonedaExtranjeraTypes">
            <CURRENCY>USD</CURRENCY>
        </con:consultaDisponibleVentaMonedaExtranjera>
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
        </aut:ResponseHeader>
    </soap:Header>
    <soap:Body>
        <con:consultaDisponibleVentaMonedaExtranjeraResponse xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaDisponibleVentaMonedaExtranjeraTypes">
            <AMOUNT_AVAILABLE>2500000.00</AMOUNT_AVAILABLE>
        </con:consultaDisponibleVentaMonedaExtranjeraResponse>
    </soap:Body>
</soap:Envelope>
```

### SOAP Response con Error
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
    <soap:Header>
        <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
            <successIndicator>ERROR</successIndicator>
            <messages>Currency not found or not available for sale</messages>
        </aut:ResponseHeader>
    </soap:Header>
    <soap:Body>
        <con:consultaDisponibleVentaMonedaExtranjeraResponse xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaDisponibleVentaMonedaExtranjeraTypes"/>
    </soap:Body>
</soap:Envelope>
```

## Requests/Responses Internos a Servicios Dependientes

### Request a T24 MercadoLibre
```xml
<ns0:consultamontodisponiblevtadolar xmlns:ns0="T24WebServicesImpl">
    <WebRequestCommon>
        <userName>FICOHSA_USER</userName>
        <password>encrypted_password</password>
    </WebRequestCommon>
    <FICOESELLTABLEENTRIESFXWSType>
        <enquiryInputCollection>
            <columnName>CURRENCY</columnName>
            <criteriaValue>USD</criteriaValue>
            <operand>EQ</operand>
        </enquiryInputCollection>
    </FICOESELLTABLEENTRIESFXWSType>
</ns0:consultamontodisponiblevtadolar>
```

### Response de T24 MercadoLibre
```xml
<ns0:consultamontodisponiblevtadolarResponse xmlns:ns0="T24WebServicesImpl">
    <Status>
        <successIndicator>Success</successIndicator>
        <messages></messages>
    </Status>
    <FICOESELLTABLEENTRIESFXWSType>
        <gFICOESELLTABLEENTRIESFXWSDetailType>
            <mFICOESELLTABLEENTRIESFXWSDetailType>
                <AvailableAmt>2500000.00</AvailableAmt>
                <Currency>USD</Currency>
                <LastUpdate>2024-12-01</LastUpdate>
            </mFICOESELLTABLEENTRIESFXWSDetailType>
        </gFICOESELLTABLEENTRIESFXWSDetailType>
    </FICOESELLTABLEENTRIESFXWSType>
</ns0:consultamontodisponiblevtadolarResponse>
```

## Cadenas de Conexión y Credenciales

### Conexión T24 MercadoLibre
- **Endpoint WSDL**: `http://172.23.13.19:7003/svcMercadoLibre/services`
- **Operación**: `consultamontodisponiblevtadolar`
- **Protocolo**: SOAP/HTTP
- **Timeout**: 0 (sin límite configurado)
- **Retry**: 0 reintentos
- **Load Balancing**: Round-robin

### Credenciales LDAP
- **Path Base**: `Middleware/Security/`
- **Pattern**: `Middleware/Security/{UPPER(USERNAME)}`
- **Función Lookup**: `fn-bea:lookupBasicCredentials()`
- **Failover**: Usa credenciales del header si LDAP falla

## Tablas de Mapeo de Entrada

### Mapeo OSB Request → T24 Request

| Campo Origen (OSB) | Transformación/Script | Campo Destino (T24) |
|-------------------|----------------------|-------------------|
| `$header/aut:RequestHeader/Authentication/UserName` | `getUsername()` con LDAP lookup + failover | `WebRequestCommon/userName` |
| `$header/aut:RequestHeader/Authentication/Password` | `getPassword()` con LDAP lookup + failover | `WebRequestCommon/password` |
| `$body/con:consultaDisponibleVentaMonedaExtranjera/CURRENCY` | `data()` directo | `FICOESELLTABLEENTRIESFXWSType/enquiryInputCollection/criteriaValue` |
| Constante "CURRENCY" | Valor fijo | `FICOESELLTABLEENTRIESFXWSType/enquiryInputCollection/columnName` |
| Constante "EQ" | Valor fijo | `FICOESELLTABLEENTRIESFXWSType/enquiryInputCollection/operand` |

### Script de Transformación de Entrada
**Archivo**: `consultaMontoDisponibleVentaDolarIn.xq`
```xquery
declare function getUsername ($LDAPUsername as xs:string) as xs:string { 
    let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
    return $data/con:username/text()
};

declare function getPassword ($LDAPUsername as xs:string) as xs:string {      
    let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
    return $data/con:password/text()
};
```

## Tablas de Mapeo de Salida

### Mapeo T24 Response → OSB Response

| Campo Origen (T24) | Transformación/Script | Campo Destino (OSB) |
|-------------------|----------------------|-------------------|
| `$RSPConsultamontodisponiblevtadolar/Status/successIndicator` | Evaluación condicional | `$errorCode` variable |
| `$RSPConsultamontodisponiblevtadolar/Status/messages` | `fn:string-join(., '. ')` | `$validationMessage` variable |
| `$RSPConsultamontodisponiblevtadolar/FICOESELLTABLEENTRIESFXWSType[1]/gFICOESELLTABLEENTRIESFXWSDetailType/mFICOESELLTABLEENTRIESFXWSDetailType[1]/AvailableAmt` | `data()` + selección del primer elemento | `con:consultaDisponibleVentaMonedaExtranjeraResponse/AMOUNT_AVAILABLE` |

### Script de Transformación de Salida
**Archivo**: `consultaDisponibleVentaMonedaExtranjeraOut.xq`
```xquery
let $result :=
    for $AvailableAmt in $consultamontodisponiblevtadolarResponse/FICOESELLTABLEENTRIESFXWSType[1]/gFICOESELLTABLEENTRIESFXWSDetailType/mFICOESELLTABLEENTRIESFXWSDetailType[1]/AvailableAmt
    return
        <AMOUNT_AVAILABLE>{ data($AvailableAmt) }</AMOUNT_AVAILABLE>
return $result[1]
```

## Reglas de Negocio Detectadas

### 1. Validación de Mensaje Vacío
**Ubicación**: `ConsultaDisponibleVentaMonedaExtranjeraHN_response` pipeline
**Lógica**: 
```xquery
$validationMessage = ""
```
**Descripción**: Si no hay mensajes de error de T24, se considera exitoso

### 2. Manejo de Credenciales con Failover
**Ubicación**: `consultaMontoDisponibleVentaDolarIn.xq`
**Lógica**:
```xquery
fn-bea:fail-over(getUsername(data($requestHeader/Authentication/UserName)), 
                 data($requestHeader/Authentication/UserName))
```
**Descripción**: Intenta obtener credenciales de LDAP, si falla usa las del header

### 3. Selección del Primer Resultado
**Ubicación**: `consultaDisponibleVentaMonedaExtranjeraOut.xq`
**Lógica**:
```xquery
return $result[1]
```
**Descripción**: Si T24 retorna múltiples resultados, toma solo el primero

### 4. Construcción de Header de Respuesta
**Ubicación**: `ConsultaDisponibleVentaMonedaExtranjeraHN_response` pipeline
**Lógica**:
```xml
<aut:ResponseHeader>
    <successIndicator>{$errorCode}</successIndicator>
    <messages>{ $validationMessage }</messages>
</aut:ResponseHeader>
```
**Descripción**: Header dinámico basado en resultado de T24

### 5. Manejo de Errores en Pipeline Error
**Ubicación**: `_onErrorHandler` pipeline
**Lógica**:
```xquery
string($fault/ctx:errorCode/text())
string($fault/ctx:reason/text())
```
**Descripción**: Captura errores del contexto OSB y los mapea a response estándar

## Configuración de Políticas OSB

### Binding Configuration
- **SOAP Version**: 1.1
- **WSI Compliant**: false
- **Transport**: local (sin HTTP externo)
- **Headers**: Todos habilitados (`all-headers: true`)

### Monitoring y Alerting
- **Monitoring**: Deshabilitado
- **SLA Alerting**: Habilitado (nivel normal)
- **Pipeline Alerting**: Habilitado (nivel normal)
- **Logging**: Habilitado (nivel debug)
- **Message Tracing**: Deshabilitado

### Throttling y Performance
- **Throttling**: Deshabilitado
- **Capacity**: 0 (ilimitado)
- **Queue Length**: 0
- **Time to Live**: 0

## Dependencias y Referencias

### Archivos XQuery Referenciados
- `Middleware/v2/Resources/ConsultaDisponibleVentaMonedaExtranjera/xq/consultaMontoDisponibleVentaDolarIn`
- `Middleware/v2/Resources/ConsultaDisponibleVentaMonedaExtranjera/xq/consultaDisponibleVentaMonedaExtranjeraOut`

### Esquemas XSD Referenciados
- `Middleware/v2/Resources/ConsultaDisponibleVentaMonedaExtranjera/xsd/consultaDisponibleVentaMonedaExtranjeraTypes`
- `../../../BusinessServices/T24/MercadoLibre/xsd/XMLSchema_161558775.xsd`

### Business Services Referenciados
- `Middleware/v2/BusinessServices/T24/MercadoLibre/biz/mercadoLibre`

### Namespaces Utilizados
- `T24WebServicesImpl` - Namespace de T24
- `http://www.ficohsa.com.hn/middleware.services/consultaDisponibleVentaMonedaExtranjeraTypes` - Tipos OSB
- `http://www.ficohsa.com.hn/middleware.services/autType` - Headers de autenticación