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
        <act:actualizaDisponibleVentaMonedaExtranjera xmlns:act="http://www.ficohsa.com.hn/middleware.services/actualizaDisponibleVentaMonedaExtranjeraTypes">
            <PROFILE>CLIENTE001</PROFILE>
            <CURRENCY>USD</CURRENCY>
            <AMOUNT>50000.00</AMOUNT>
            <DEAL>DEAL20241201001</DEAL>
            <STATUS>ACTIVE</STATUS>
            <OPERATION_TYPE>SELL</OPERATION_TYPE>
            <END_DATE>20241231</END_DATE>
            <ACTION_TYPE>UPDATE</ACTION_TYPE>
        </act:actualizaDisponibleVentaMonedaExtranjera>
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
        <act:actualizaDisponibleVentaMonedaExtranjeraResponse xmlns:act="http://www.ficohsa.com.hn/middleware.services/actualizaDisponibleVentaMonedaExtranjeraTypes">
            <SUCCESS_FLAG>Success</SUCCESS_FLAG>
        </act:actualizaDisponibleVentaMonedaExtranjeraResponse>
    </soap:Body>
</soap:Envelope>
```

### SOAP Response con Error
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
    <soap:Header>
        <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
            <successIndicator>ERROR</successIndicator>
            <messages>Deal not found or invalid status</messages>
        </aut:ResponseHeader>
    </soap:Header>
    <soap:Body>
        <act:actualizaDisponibleVentaMonedaExtranjeraResponse xmlns:act="http://www.ficohsa.com.hn/middleware.services/actualizaDisponibleVentaMonedaExtranjeraTypes"/>
    </soap:Body>
</soap:Envelope>
```

## Requests/Responses Internos a Servicios Dependientes

### Request a T24 MercadoLibre
```xml
<ns0:ActualizaDisponibleMonedaFCY xmlns:ns0="T24WebServicesImpl">
    <WebRequestCommon>
        <userName>FICOHSA_USER</userName>
        <password>encrypted_password</password>
    </WebRequestCommon>
    <OfsFunction>
        <gtsControl/>
        <messageId/>
        <noOfAuth/>
        <replace/>
    </OfsFunction>
    <FICOFXDEALSTXNINPUTType id="DEAL20241201001">
        <Estado>ACTIVE</Estado>
        <Cliente>CLIENTE001</Cliente>
        <Moneda>USD</Moneda>
        <Monto>50000.00</Monto>
        <Fecha>20241201</Fecha>
        <FechaVencimiento>20241231</FechaVencimiento>
        <TipodeOperacion>SELL</TipodeOperacion>
        <TipodeAccion>UPDATE</TipodeAccion>
    </FICOFXDEALSTXNINPUTType>
</ns0:ActualizaDisponibleMonedaFCY>
```

### Response de T24 MercadoLibre
```xml
<ns0:ActualizaDisponibleMonedaFCYResponse xmlns:ns0="T24WebServicesImpl">
    <Status>
        <successIndicator>Success</successIndicator>
        <messages></messages>
    </Status>
    <FICOFXDEALSTXNOUTPUTType>
        <DealId>DEAL20241201001</DealId>
        <ProcessedAmount>50000.00</ProcessedAmount>
        <UpdatedDate>20241201</UpdatedDate>
        <NewStatus>ACTIVE</NewStatus>
    </FICOFXDEALSTXNOUTPUTType>
</ns0:ActualizaDisponibleMonedaFCYResponse>
```

## Cadenas de Conexión y Credenciales

### Conexión T24 MercadoLibre
- **Endpoint WSDL**: `http://172.23.13.19:7003/svcMercadoLibre/services`
- **Operación**: `ActualizaDisponibleMonedaFCY`
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
| `$body/act:actualizaDisponibleVentaMonedaExtranjera/DEAL` | `data()` directo | `FICOFXDEALSTXNINPUTType/@id` |
| `$body/act:actualizaDisponibleVentaMonedaExtranjera/STATUS` | `data()` directo | `FICOFXDEALSTXNINPUTType/Estado` |
| `$body/act:actualizaDisponibleVentaMonedaExtranjera/PROFILE` | `data()` directo | `FICOFXDEALSTXNINPUTType/Cliente` |
| `$body/act:actualizaDisponibleVentaMonedaExtranjera/CURRENCY` | `data()` directo | `FICOFXDEALSTXNINPUTType/Moneda` |
| `$body/act:actualizaDisponibleVentaMonedaExtranjera/AMOUNT` | `data()` directo | `FICOFXDEALSTXNINPUTType/Monto` |
| `current-date()` | `date-to-string()` función personalizada | `FICOFXDEALSTXNINPUTType/Fecha` |
| `$body/act:actualizaDisponibleVentaMonedaExtranjera/END_DATE` | `data()` directo | `FICOFXDEALSTXNINPUTType/FechaVencimiento` |
| `$body/act:actualizaDisponibleVentaMonedaExtranjera/OPERATION_TYPE` | `data()` directo | `FICOFXDEALSTXNINPUTType/TipodeOperacion` |
| `$body/act:actualizaDisponibleVentaMonedaExtranjera/ACTION_TYPE` | `data()` directo | `FICOFXDEALSTXNINPUTType/TipodeAccion` |

### Script de Transformación de Entrada
**Archivo**: `actualizaDisponibleMonedaFCYIn.xq`

#### Funciones de Credenciales
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

#### Función de Conversión de Fechas
```xquery
declare function date-to-string($fecha as xs:date) as xs:string {
    concat(substring(xs:string($fecha), 1, 4), 
           substring(xs:string($fecha), 6, 2), 
           substring(xs:string($fecha), 9, 2))
};
```

#### Transformación Principal
```xquery
<FICOFXDEALSTXNINPUTType id="{data($actualizaDisponibleVentaMonedaExtranjera/DEAL)}">
    <Estado>{data($actualizaDisponibleVentaMonedaExtranjera/STATUS)}</Estado>
    <Cliente>{data($actualizaDisponibleVentaMonedaExtranjera/PROFILE)}</Cliente>
    <Moneda>{data($actualizaDisponibleVentaMonedaExtranjera/CURRENCY)}</Moneda>
    <Monto>{data($actualizaDisponibleVentaMonedaExtranjera/AMOUNT)}</Monto>
    <Fecha>{date-to-string(current-date())}</Fecha>
    <FechaVencimiento>{data($actualizaDisponibleVentaMonedaExtranjera/END_DATE)}</FechaVencimiento>
    <TipodeOperacion>{data($actualizaDisponibleVentaMonedaExtranjera/OPERATION_TYPE)}</TipodeOperacion>
    <TipodeAccion>{data($actualizaDisponibleVentaMonedaExtranjera/ACTION_TYPE)}</TipodeAccion>
</FICOFXDEALSTXNINPUTType>
```

## Tablas de Mapeo de Salida

### Mapeo T24 Response → OSB Response

| Campo Origen (T24) | Transformación/Script | Campo Destino (OSB) |
|-------------------|----------------------|-------------------|
| `$RSPActualizaDisponibleMonedaFCY/Status/successIndicator` | Evaluación condicional | `$errorCode` variable |
| `$RSPActualizaDisponibleMonedaFCY/Status/messages` | `string-join(., '. ')` | `$validationMessage` variable |
| `$actualizaDisponibleMonedaFCYResponse/Status/successIndicator` | `data()` directo | `act:actualizaDisponibleVentaMonedaExtranjeraResponse/SUCCESS_FLAG` |

### Script de Transformación de Salida
**Archivo**: `actualizaDisponibleVentaMonedaExtranjeraOut.xq`
```xquery
<ns1:actualizaDisponibleVentaMonedaExtranjeraResponse>
    {
        for $successIndicator in $actualizaDisponibleMonedaFCYResponse/Status/successIndicator
        return
            <SUCCESS_FLAG>{data($successIndicator)}</SUCCESS_FLAG>
    }
</ns1:actualizaDisponibleVentaMonedaExtranjeraResponse>
```

## Reglas de Negocio Detectadas

### 1. Validación de Mensaje Vacío
**Ubicación**: `ActualizaDisponibleVentaMonedaExtranjeraHN_response` pipeline
**Lógica**: 
```xquery
$validationMessage = ""
```
**Descripción**: Si no hay mensajes de error de T24, se considera exitoso

### 2. Manejo de Credenciales con Failover
**Ubicación**: `actualizaDisponibleMonedaFCYIn.xq`
**Lógica**:
```xquery
fn-bea:fail-over(getUsername(data($requestHeader/Authentication/UserName)), 
                 data($requestHeader/Authentication/UserName))
```
**Descripción**: Intenta obtener credenciales de LDAP, si falla usa las del header

### 3. Generación Automática de Fecha
**Ubicación**: `actualizaDisponibleMonedaFCYIn.xq`
**Lógica**:
```xquery
<Fecha>{date-to-string(current-date())}</Fecha>
```
**Descripción**: Genera automáticamente la fecha actual en formato YYYYMMDD

### 4. Uso de Deal ID como Identificador
**Ubicación**: `actualizaDisponibleMonedaFCYIn.xq`
**Lógica**:
```xml
<FICOFXDEALSTXNINPUTType id="{data($actualizaDisponibleVentaMonedaExtranjera/DEAL)}">
```
**Descripción**: El campo DEAL se usa como identificador único del elemento T24

### 5. Construcción de Header de Respuesta Dinámico
**Ubicación**: `ActualizaDisponibleVentaMonedaExtranjeraHN_response` pipeline
**Lógica**:
```xml
<aut:ResponseHeader>
    <successIndicator>Success</successIndicator>
</aut:ResponseHeader>
```
**Descripción**: Header fijo para casos exitosos, dinámico para errores

### 6. Manejo de Errores en Pipeline Error
**Ubicación**: `_onErrorHandler` pipeline
**Lógica**:
```xquery
string($fault/ctx:errorCode/text())
string($fault/ctx:reason/text())
```
**Descripción**: Captura errores del contexto OSB y los mapea a response estándar

### 7. Configuración OFS Function
**Ubicación**: `actualizaDisponibleMonedaFCYIn.xq`
**Lógica**:
```xml
<OfsFunction>
    <gtsControl/>
    <messageId/>
    <noOfAuth/>
    <replace/>
</OfsFunction>
```
**Descripción**: Configuración estándar para operaciones T24 OFS

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

## Ejemplos de Casos de Uso

### Caso 1: Actualización de Deal Activo
```xml
<!-- Request -->
<PROFILE>CORP001</PROFILE>
<CURRENCY>USD</CURRENCY>
<AMOUNT>100000.00</AMOUNT>
<DEAL>DEAL20241201002</DEAL>
<STATUS>ACTIVE</STATUS>
<OPERATION_TYPE>SELL</OPERATION_TYPE>
<END_DATE>20250131</END_DATE>
<ACTION_TYPE>UPDATE</ACTION_TYPE>

<!-- T24 Mapping -->
<FICOFXDEALSTXNINPUTType id="DEAL20241201002">
    <Estado>ACTIVE</Estado>
    <Cliente>CORP001</Cliente>
    <Moneda>USD</Moneda>
    <Monto>100000.00</Monto>
    <Fecha>20241201</Fecha>
    <FechaVencimiento>20250131</FechaVencimiento>
    <TipodeOperacion>SELL</TipodeOperacion>
    <TipodeAccion>UPDATE</TipodeAccion>
</FICOFXDEALSTXNINPUTType>
```

### Caso 2: Creación de Nuevo Deal
```xml
<!-- Request -->
<PROFILE>RETAIL001</PROFILE>
<CURRENCY>EUR</CURRENCY>
<AMOUNT>25000.00</AMOUNT>
<DEAL>DEAL20241201003</DEAL>
<STATUS>PENDING</STATUS>
<OPERATION_TYPE>BUY</OPERATION_TYPE>
<END_DATE>20241215</END_DATE>
<ACTION_TYPE>CREATE</ACTION_TYPE>

<!-- T24 Mapping -->
<FICOFXDEALSTXNINPUTType id="DEAL20241201003">
    <Estado>PENDING</Estado>
    <Cliente>RETAIL001</Cliente>
    <Moneda>EUR</Moneda>
    <Monto>25000.00</Monto>
    <Fecha>20241201</Fecha>
    <FechaVencimiento>20241215</FechaVencimiento>
    <TipodeOperacion>BUY</TipodeOperacion>
    <TipodeAccion>CREATE</TipodeAccion>
</FICOFXDEALSTXNINPUTType>
```

## Dependencias y Referencias

### Archivos XQuery Referenciados
- `Middleware/v2/Resources/ActualizaDisponibleVentaMonedaExtranjera/xq/actualizaDisponibleMonedaFCYIn`
- `Middleware/v2/Resources/ActualizaDisponibleVentaMonedaExtranjera/xq/actualizaDisponibleVentaMonedaExtranjeraOut`

### Esquemas XSD Referenciados
- `Middleware/v2/Resources/ActualizaDisponibleVentaMonedaExtranjera/xsd/actualizaDisponibleVentaMonedaExtranjeraTypes`
- `../../../BusinessServices/T24/MercadoLibre/xsd/XMLSchema_161558775.xsd`

### Business Services Referenciados
- `Middleware/v2/BusinessServices/T24/MercadoLibre/biz/mercadoLibre`

### Namespaces Utilizados
- `T24WebServicesImpl` - Namespace de T24
- `http://www.ficohsa.com.hn/middleware.services/actualizaDisponibleVentaMonedaExtranjeraTypes` - Tipos OSB
- `http://www.ficohsa.com.hn/middleware.services/autType` - Headers de autenticación

### Funciones Personalizadas
- `getUsername()` - Lookup de usuario en LDAP
- `getPassword()` - Lookup de password en LDAP  
- `date-to-string()` - Conversión de fecha a formato YYYYMMDD