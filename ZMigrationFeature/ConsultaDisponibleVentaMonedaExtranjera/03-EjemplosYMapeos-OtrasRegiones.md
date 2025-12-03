# Ejemplos de Request/Response y Mapeo de Datos - Otras Regiones (GT01/PA01/NI01)

## Request OSB (Ejemplo JSON/XML)

### SOAP Request Completo
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
    <soap:Header>
        <aut:RequestHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
            <Authentication>
                <UserName>USRGUATEMALA01</UserName>
                <Password>password123</Password>
            </Authentication>
            <Region>
                <SourceBank>GT01</SourceBank>
                <DestinationBank>GT01</DestinationBank>
            </Region>
            <TransactionId>TXN-20241201-002</TransactionId>
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
            <successIndicator>SUCCESS</successIndicator>
        </aut:ResponseHeader>
    </soap:Header>
    <soap:Body>
        <con:consultaDisponibleVentaMonedaExtranjeraResponse xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaDisponibleVentaMonedaExtranjeraTypes">
            <AMOUNT_AVAILABLE>1750000.00</AMOUNT_AVAILABLE>
        </con:consultaDisponibleVentaMonedaExtranjeraResponse>
    </soap:Body>
</soap:Envelope>
```

### SOAP Response con Error de Enrutamiento
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
    <soap:Header>
        <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
            <successIndicator>ERROR</successIndicator>
            <messages>FICBCO0434: Región no configurada para el servicio</messages>
        </aut:ResponseHeader>
    </soap:Header>
    <soap:Body>
        <con:consultaDisponibleVentaMonedaExtranjeraResponse xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaDisponibleVentaMonedaExtranjeraTypes"/>
    </soap:Body>
</soap:Envelope>
```

## Requests/Responses Internos a Servicios Dependientes

### 1. Request a consultaRutaRegional_db

```xml
<ns0:InputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRutaRegional">
    <ns0:PV_SERVICIO>FICBCO0434</ns0:PV_SERVICIO>
    <ns0:PV_ORIGEN>GT01</ns0:PV_ORIGEN>
    <ns0:PV_DESTINO>GT01</ns0:PV_DESTINO>
    <ns0:PV_OPERACION>consultaDisponibleVentaMonedaExtranjera</ns0:PV_OPERACION>
    <ns0:PV_VERSION>V2</ns0:PV_VERSION>
    <ns0:PV_USUARIO>USRGUATEMALA01</ns0:PV_USUARIO>
</ns0:InputParameters>
```

### Response de consultaRutaRegional_db

#### Response Exitoso
```xml
<ns0:OutputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRutaRegional">
    <ns0:PV_CODIGO_ERROR>SUCCESS</ns0:PV_CODIGO_ERROR>
    <ns0:PV_MENSAJE_ERROR></ns0:PV_MENSAJE_ERROR>
    <ns0:PV_UBICACION>Middleware/v2/ProxyServices/ConsultaDisponibleVentaMonedaExtranjeraGT</ns0:PV_UBICACION>
</ns0:OutputParameters>
```

#### Response con Error
```xml
<ns0:OutputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRutaRegional">
    <ns0:PV_CODIGO_ERROR>ERROR</ns0:PV_CODIGO_ERROR>
    <ns0:PV_MENSAJE_ERROR>Servicio no configurado para la región GT01</ns0:PV_MENSAJE_ERROR>
    <ns0:PV_UBICACION></ns0:PV_UBICACION>
</ns0:OutputParameters>
```

### 2. Request a MapeoErrores (en caso de error)

```xml
<mapeoErrores>
    <CODIGO_ERROR>ERROR</CODIGO_ERROR>
    <MENSAJE_ERROR>FICBCO0434$#$Servicio no configurado para la región GT01</MENSAJE_ERROR>
</mapeoErrores>
```

### Response de MapeoErrores

```xml
<mapeoErroresResponse>
    <CODIGO_ERROR_MAPEADO>SERV_NOT_CONFIGURED</CODIGO_ERROR_MAPEADO>
    <MENSAJE_ERROR_MAPEADO>El servicio no está configurado para la región solicitada</MENSAJE_ERROR_MAPEADO>
    <CODIGO_APLICACION>FICBCO0434</CODIGO_APLICACION>
</mapeoErroresResponse>
```

## Cadenas de Conexión y Credenciales

### Conexión Base de Datos Middleware
- **JCA Connection**: `jca://eis/DB/ConnectionMiddleware`
- **Stored Procedure**: `MW_P_CONSULTA_RUTA_REGIONAL`
- **Esquema**: `consultaRutaRegional_sp`
- **Adapter**: DB Adapter
- **Connection Mode**: Managed
- **Retry Count**: 0
- **Retry Interval**: 30 segundos

### Endpoint Principal
- **URL**: `https://mwomnicanal:8004/Middleware/OperationsAndExecution/ConsumerService/ConsultaDisponibleVentaMonedaExtranjera`
- **Protocolo**: HTTPS
- **Autenticación**: Custom token authentication
- **Transport**: HTTP con SSL habilitado

## Tablas de Mapeo de Entrada

### Mapeo OSB Request → consultaRutaRegional Request

| Campo Origen (OSB) | Transformación/Script | Campo Destino (DB) |
|-------------------|----------------------|-------------------|
| Constante "FICBCO0434" | Valor fijo del servicio | `PV_SERVICIO` |
| `$header/aut:RequestHeader/Region/SourceBank` | `data()` directo | `PV_ORIGEN` |
| `$header/aut:RequestHeader/Region/DestinationBank` | `data()` con iteración | `PV_DESTINO` |
| `$operation` | Variable del contexto OSB | `PV_OPERACION` |
| Constante "V2" | Versión fija | `PV_VERSION` |
| `$header/aut:RequestHeader/Authentication/UserName` | `upper-case()` | `PV_USUARIO` |

### Script de Transformación consultaRutaRegional
**Archivo**: `consultaRutaRegionalIn.xq`
```xquery
<ns0:InputParameters>
    <ns0:PV_SERVICIO>{ $idServicio }</ns0:PV_SERVICIO>
    <ns0:PV_ORIGEN>{ data($requestHeader/Region/SourceBank) }</ns0:PV_ORIGEN>
    {
        for $destinationBank in $requestHeader/Region/DestinationBank
        return
            <ns0:PV_DESTINO>{ data($destinationBank) }</ns0:PV_DESTINO>
    }
    <ns0:PV_OPERACION>{ $operacion }</ns0:PV_OPERACION>
    <ns0:PV_VERSION>{ $version }</ns0:PV_VERSION>
    <ns0:PV_USUARIO>{ upper-case($requestHeader/Authentication/UserName/text()) }</ns0:PV_USUARIO>
</ns0:InputParameters>
```

## Tablas de Mapeo de Salida

### Mapeo consultaRutaRegional Response → Enrutamiento Dinámico

| Campo Origen (DB) | Transformación/Script | Campo Destino (Routing) |
|-------------------|----------------------|------------------------|
| `$RSPConsultaRutaRegional/con:PV_CODIGO_ERROR` | Evaluación `!= 'SUCCESS'` | Condición de error |
| `$RSPConsultaRutaRegional/con:PV_MENSAJE_ERROR` | `string()` | Mensaje de error |
| `$RSPConsultaRutaRegional/con:PV_UBICACION` | `string()` | Proxy destino para enrutamiento |

### Script de Enrutamiento Dinámico
```xml
<ctx:route>
    <ctx:service isProxy='true'>{string($RSPConsultaRutaRegional/con:PV_UBICACION/text())}</ctx:service>
</ctx:route>
```

### Mapeo MapeoErrores Request

| Campo Origen | Transformación/Script | Campo Destino |
|-------------|----------------------|---------------|
| `$errorCode` o `$RSPConsultaRutaRegional/con:PV_CODIGO_ERROR` | Directo | `CODIGO_ERROR` |
| Concatenación con servicio ID | `fn:concat("FICBCO0434", "$#$", $errorMessage)` | `MENSAJE_ERROR` |

## Reglas de Negocio Detectadas

### 1. Validación XSD Obligatoria
**Ubicación**: `ValidacionXSD` stage
**Lógica**:
```xml
<con1:validate>
    <con1:schema ref="Middleware/v2/Resources/ConsultaDisponibleVentaMonedaExtranjera/xsd/consultaDisponibleVentaMonedaExtranjeraTypes"/>
    <con1:schemaElement>con:consultaDisponibleVentaMonedaExtranjera</con1:schemaElement>
</con1:validate>
```
**Descripción**: Validación obligatoria del esquema antes del procesamiento

### 2. Evaluación de Código de Error Regional
**Ubicación**: `ConsultaRutaRegional` stage
**Lógica**:
```xquery
string($RSPConsultaRutaRegional/con1:PV_CODIGO_ERROR/text()) != 'SUCCESS'
```
**Descripción**: Si la consulta regional falla, termina el procesamiento con error

### 3. Aplicación de Valores por Defecto Regional
**Ubicación**: `ConsultaRutaRegional` stage (caso exitoso)
**Script**: `aplicarValoresPorDefectoRegion.xq`
**Descripción**: Aplica configuración regional por defecto al header

### 4. Construcción de Mensaje de Error con Servicio ID
**Ubicación**: Pipeline de error y respuesta con error
**Lógica**:
```xquery
fn:concat("FICBCO0434", "$#$", $errorMessage)
```
**Descripción**: Prefija mensajes de error con el ID del servicio

### 5. Enrutamiento Dinámico Basado en PV_UBICACION
**Ubicación**: `RouterDinamico` route node
**Lógica**:
```xml
<ctx:service isProxy='true'>{string($RSPConsultaRutaRegional/con:PV_UBICACION/text())}</ctx:service>
```
**Descripción**: Enruta dinámicamente al proxy especificado en la respuesta de BD

### 6. Manejo de Errores con MapeoErrores
**Ubicación**: `MapeoError` stage en response pipeline
**Condición**:
```xquery
fn:upper-case(fn:string($header/aut:ResponseHeader/successIndicator/text())) != "SUCCESS"
```
**Descripción**: Si el indicador no es SUCCESS, invoca servicio de mapeo de errores

## Configuración de Políticas OSB

### Security Configuration
- **Authentication Type**: Custom token authentication
- **Username Selector**: XPath en header
- **Password Selector**: XPath en header
- **Variable**: header

### Binding Configuration
- **SOAP Version**: 1.1
- **WSI Compliant**: false
- **Transport**: HTTPS
- **Port**: consultaDisponibleVentaMonedaExtranjeraPSSOAP

### Monitoring y Alerting
- **Monitoring**: Deshabilitado
- **SLA Alerting**: Habilitado (nivel normal)
- **Pipeline Alerting**: Habilitado (nivel normal)
- **Logging**: Habilitado (nivel debug)
- **Reporting**: Habilitado

### Throttling y Performance
- **Throttling**: Deshabilitado
- **Message Tracing**: Deshabilitado
- **Aggregation Interval**: 10 segundos

## Stored Procedure de Base de Datos

### MW_P_CONSULTA_RUTA_REGIONAL
**Parámetros de Entrada**:
- `PV_SERVICIO` (VARCHAR2): ID del servicio (FICBCO0434)
- `PV_ORIGEN` (VARCHAR2): Banco origen (GT01, PA01, NI01)
- `PV_DESTINO` (VARCHAR2): Banco destino
- `PV_OPERACION` (VARCHAR2): Nombre de la operación
- `PV_VERSION` (VARCHAR2): Versión del servicio (V2)
- `PV_USUARIO` (VARCHAR2): Usuario que ejecuta

**Parámetros de Salida**:
- `PV_CODIGO_ERROR` (VARCHAR2): Código de resultado (SUCCESS/ERROR)
- `PV_MENSAJE_ERROR` (VARCHAR2): Mensaje de error si aplica
- `PV_UBICACION` (VARCHAR2): Ruta del proxy destino

**Lógica Esperada**:
```sql
-- Pseudocódigo del SP
BEGIN
    SELECT proxy_path 
    INTO PV_UBICACION
    FROM MW_ROUTING_CONFIG 
    WHERE service_id = PV_SERVICIO 
      AND source_region = PV_ORIGEN
      AND destination_region = PV_DESTINO
      AND operation_name = PV_OPERACION
      AND version = PV_VERSION
      AND status = 'ACTIVE';
      
    PV_CODIGO_ERROR := 'SUCCESS';
    PV_MENSAJE_ERROR := '';
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        PV_CODIGO_ERROR := 'ERROR';
        PV_MENSAJE_ERROR := 'Configuración no encontrada para la región';
        PV_UBICACION := '';
END;
```

## Dependencias y Referencias

### Archivos XQuery Referenciados
- `Middleware/v2/Resources/Generales/xq/consultaRutaRegionalIn`
- `Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegion`
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn`
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut`

### Esquemas XSD Referenciados
- `Middleware/v2/Resources/ConsultaDisponibleVentaMonedaExtranjera/xsd/consultaDisponibleVentaMonedaExtranjeraTypes`
- `Middleware/v2/BusinessServices/MDW/consultaRutaRegional/xsd/consultaRutaRegional_sp`

### Business Services Referenciados
- `Middleware/v2/BusinessServices/MDW/consultaRutaRegional/biz/consultaRutaRegional_db`

### Proxy Services Referenciados
- `Middleware/v2/ProxyServices/MapeoErrores`
- Proxies regionales dinámicos (determinados por BD)

### Namespaces Utilizados
- `http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRutaRegional` - SP de enrutamiento
- `http://www.ficohsa.com.hn/middleware.services/consultaDisponibleVentaMonedaExtranjeraTypes` - Tipos OSB
- `http://www.ficohsa.com.hn/middleware.services/autType` - Headers de autenticación