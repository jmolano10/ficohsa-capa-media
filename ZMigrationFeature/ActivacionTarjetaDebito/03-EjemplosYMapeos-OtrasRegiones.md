# Ejemplos de Request/Response y Mapeo de Datos - Otras Regiones

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

### SOAP Response Error Estándar
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
    <soap:Header>
        <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
            <successIndicator>ERROR</successIndicator>
            <messages>SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY</messages>
        </aut:ResponseHeader>
    </soap:Header>
    <soap:Body>
        <act:activacionTarjetaDebitoResponse xmlns:act="http://www.ficohsa.com.hn/middleware.services/activacionTarjetaDebitoTypes"/>
    </soap:Body>
</soap:Envelope>
```

## Requests/Responses Internos a Servicios Dependientes

### Request a ValidaServicioRegional_db
```xml
<ns0:InputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidaServicioRegional">
    <ns0:PV_SERVICIO>FICBCO0324</ns0:PV_SERVICIO>
    <ns0:PV_ORIGEN>GT01</ns0:PV_ORIGEN>
    <ns0:PV_DESTINO>GT01</ns0:PV_DESTINO>
    <ns0:PV_USUARIO>USRGUATEMALA01</ns0:PV_USUARIO>
</ns0:InputParameters>
```

### Response de ValidaServicioRegional_db
```xml
<ns0:OutputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidaServicioRegional">
    <ns0:PV_CODIGO_ERROR>ERROR</ns0:PV_CODIGO_ERROR>
    <ns0:PV_MENSAJE_ERROR>Servicio no disponible para la región GT01</ns0:PV_MENSAJE_ERROR>
</ns0:OutputParameters>
```

## Reglas de Negocio Detectadas

### 1. Validación Regional Obligatoria
**Ubicación**: `ValidacionServicioRegional` stage
**Lógica**:
```xquery
upper-case(fn:string($respValidaServicioRegional/val:PV_CODIGO_ERROR/text())) != 'SUCCESS'
```
**Descripción**: Si la validación regional falla, termina con error

### 2. Error por Defecto
**Ubicación**: `Default_ActivacionTarjetasDebito_response` pipeline
**Lógica**:
```xml
<con1:Error>
    <con1:errCode>MW-0008</con1:errCode>
    <con1:message>SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY</con1:message>
</con1:Error>
```
**Descripción**: Todas las regiones no-HN01 reciben este error estándar

## Stored Procedure de Base de Datos

### ValidaServicioRegional
**Parámetros**:
- `PV_SERVICIO`: FICBCO0324
- `PV_ORIGEN`: Región origen
- `PV_DESTINO`: Región destino  
- `PV_USUARIO`: Usuario

**Lógica Esperada**:
```sql
BEGIN
    SELECT 'SUCCESS' INTO PV_CODIGO_ERROR
    FROM MW_SERVICIOS_REGIONALES 
    WHERE service_id = PV_SERVICIO 
      AND region = PV_ORIGEN
      AND status = 'ACTIVE';
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        PV_CODIGO_ERROR := 'ERROR';
        PV_MENSAJE_ERROR := 'Servicio no disponible para la región';
END;
```