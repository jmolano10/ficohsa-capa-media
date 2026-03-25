# Ejemplos de Request/Response y Mapeo de Datos - HN01 (Honduras)

## Request OSB (Ejemplo SOAP/XML)

### SOAP Envelope Completo
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:RequestHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <Authentication>
        <UserName>userHN01</UserName>
        <Password>passwordHN01</Password>
      </Authentication>
      <Region>
        <SourceBank>HN01</SourceBank>
        <DestinationBank>HN01</DestinationBank>
      </Region>
      <TransactionId>TXN-HN-20241201-001</TransactionId>
      <Timestamp>2024-12-01T10:30:00</Timestamp>
    </aut:RequestHeader>
  </soap:Header>
  <soap:Body>
    <con:consultaPlanesCredito xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaPlanesCreditoTypes">
      <ACCOUNT_NUMBER>5412345678901234</ACCOUNT_NUMBER>
      <ORG>HN01</ORG>
    </con:consultaPlanesCredito>
  </soap:Body>
</soap:Envelope>
```

### Body Request
```xml
<con:consultaPlanesCredito xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaPlanesCreditoTypes">
  <ACCOUNT_NUMBER>5412345678901234</ACCOUNT_NUMBER>
  <ORG>HN01</ORG>
</con:consultaPlanesCredito>
```

## Response OSB (Ejemplo SOAP/XML)

### SOAP Envelope Completo
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <successIndicator>Success</successIndicator>
      <messages></messages>
      <TransactionId>TXN-HN-20241201-001</TransactionId>
      <Timestamp>2024-12-01T10:30:05</Timestamp>
    </aut:ResponseHeader>
  </soap:Header>
  <soap:Body>
    <con:consultaPlanesCreditoResponse xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaPlanesCreditoTypes">
      <CREDIT_PLANS>
        <CREDIT_PLAN>
          <ORG>HN01</ORG>
          <ACCOUNT>5412345678901234</ACCOUNT>
          <SEQ_NUMBER>001</SEQ_NUMBER>
          <LOGO>VISA</LOGO>
          <PLAN_NUMBER>HN001</PLAN_NUMBER>
          <PAY_MINIMUM>200.00</PAY_MINIMUM>
          <TYPE_PLAN>REVOLVING</TYPE_PLAN>
          <INT_RATE>28.50</INT_RATE>
          <INT_RATE_BASE>22.00</INT_RATE_BASE>
          <CURRENT_BALANCE>3500.25</CURRENT_BALANCE>
          <DATE_PLAN>20241201</DATE_PLAN>
          <ACRD_INT>65.75</ACRD_INT>
          <DELAYS_ACRD_INT>15.50</DELAYS_ACRD_INT>
          <ACCUMULATED_DELAYS_INT>2.25</ACCUMULATED_DELAYS_INT>
        </CREDIT_PLAN>
        <CREDIT_PLAN>
          <ORG>HN01</ORG>
          <ACCOUNT>5412345678901234</ACCOUNT>
          <SEQ_NUMBER>002</SEQ_NUMBER>
          <LOGO>MASTERCARD</LOGO>
          <PLAN_NUMBER>HN002</PLAN_NUMBER>
          <PAY_MINIMUM>125.00</PAY_MINIMUM>
          <TYPE_PLAN>INSTALLMENT</TYPE_PLAN>
          <INT_RATE>22.75</INT_RATE>
          <INT_RATE_BASE>18.50</INT_RATE_BASE>
          <CURRENT_BALANCE>1850.00</CURRENT_BALANCE>
          <DATE_PLAN>20241120</DATE_PLAN>
          <ACRD_INT>35.25</ACRD_INT>
          <DELAYS_ACRD_INT>0.00</DELAYS_ACRD_INT>
          <ACCUMULATED_DELAYS_INT>0.00</ACCUMULATED_DELAYS_INT>
        </CREDIT_PLAN>
      </CREDIT_PLANS>
    </con:consultaPlanesCreditoResponse>
  </soap:Body>
</soap:Envelope>
```

## Requests/Responses Internos a Servicios Dependientes

### 1. Consulta Ruta Regional

#### Request a consultaRutaRegional
```xml
<con1:InputParameters xmlns:con1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRutaRegional">
  <con1:PV_VERSION>V2</con1:PV_VERSION>
  <con1:PV_ID_SERVICIO>FICBCO0321</con1:PV_ID_SERVICIO>
  <con1:PV_OPERACION>consultaPlanesCredito</con1:PV_OPERACION>
  <con1:PV_REGION>HN01</con1:PV_REGION>
  <con1:PV_USUARIO>userHN01</con1:PV_USUARIO>
</con1:InputParameters>
```

#### Response de consultaRutaRegional
```xml
<con1:OutputParameters xmlns:con1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRutaRegional">
  <con1:PV_CODIGO_ERROR>SUCCESS</con1:PV_CODIGO_ERROR>
  <con1:PV_MENSAJE_ERROR></con1:PV_MENSAJE_ERROR>
  <con1:PV_UBICACION>Middleware/v2/ProxyServices/ConsultaPlanesCreditoHN</con1:PV_UBICACION>
</con1:OutputParameters>
```

### 2. Consulta Base de Datos (MasterDataHN)

#### Request a conDatosPlanes_db
```xml
<con1:InputParameters xmlns:con1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatosPlanes">
  <con1:PV_CUENTA>5412345678901234</con1:PV_CUENTA>
  <con1:PV_ORG>HN01</con1:PV_ORG>
  <con1:PV_CODIGO_PAIS>HND</con1:PV_CODIGO_PAIS>
</con1:InputParameters>
```

#### Response de conDatosPlanes_db
```xml
<con1:OutputParameters xmlns:con1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatosPlanes">
  <con1:CodigoError>-1</con1:CodigoError>
  <con1:MensajeError></con1:MensajeError>
  <con1:RowSet>
    <con1:Row>
      <con1:Column name="org">HN01</con1:Column>
      <con1:Column name="cuenta">5412345678901234</con1:Column>
      <con1:Column name="numseq">001</con1:Column>
      <con1:Column name="logo">VISA</con1:Column>
      <con1:Column name="numplan">HN001</con1:Column>
      <con1:Column name="total_due">200.00</con1:Column>
      <con1:Column name="tipo_plan">REVOLVING</con1:Column>
      <con1:Column name="int_rate">28.50</con1:Column>
      <con1:Column name="int_rat1_base">22.00</con1:Column>
      <con1:Column name="balanceactual">3500.25</con1:Column>
      <con1:Column name="fecplan">2024-12-01T00:00:00</con1:Column>
      <con1:Column name="acrd_int">65.75</con1:Column>
      <con1:Column name="mora_acrd_int">15.50</con1:Column>
      <con1:Column name="d2ps_mora_int_per_diem">2.25</con1:Column>
    </con1:Row>
    <con1:Row>
      <con1:Column name="org">HN01</con1:Column>
      <con1:Column name="cuenta">5412345678901234</con1:Column>
      <con1:Column name="numseq">002</con1:Column>
      <con1:Column name="logo">MASTERCARD</con1:Column>
      <con1:Column name="numplan">HN002</con1:Column>
      <con1:Column name="total_due">125.00</con1:Column>
      <con1:Column name="tipo_plan">INSTALLMENT</con1:Column>
      <con1:Column name="int_rate">22.75</con1:Column>
      <con1:Column name="int_rat1_base">18.50</con1:Column>
      <con1:Column name="balanceactual">1850.00</con1:Column>
      <con1:Column name="fecplan">2024-11-20T00:00:00</con1:Column>
      <con1:Column name="acrd_int">35.25</con1:Column>
      <con1:Column name="mora_acrd_int">0.00</con1:Column>
      <con1:Column name="d2ps_mora_int_per_diem">0.00</con1:Column>
    </con1:Row>
  </con1:RowSet>
</con1:OutputParameters>
```

## Cadenas de Conexión y Credenciales

### Base de Datos
- **Nombre de Conexión**: eis/DB/ConnectionTarjetas
- **Nombre de Base de Datos**: ConnectionTarjetas (configurado en WebLogic)
- **Stored Procedure**: dbo.OSBConDatoPlanes
- **Esquema**: dbo
- **Package**: dbo

### Endpoint WSDL
- **Endpoint**: /Middleware/v2/ProxyServices/ConsultaPlanesCreditoHN (HTTP transport)
- **Operación**: consultaPlanesCredito
- **Namespace**: http://www.ficohsa.com.hn/middleware.services/consultaPlanesCreditoPS/

## Tablas de Mapeo de Entrada

### Mapeo OSB Request → consultaRutaRegional
| Campo Origen (OSB) | Transformación/Script | Campo Destino (consultaRutaRegional) |
|-------------------|----------------------|-------------------------------------|
| Header/Region/SourceBank | Directo | PV_REGION |
| Constante "V2" | Literal | PV_VERSION |
| Constante "FICBCO0321" | Literal | PV_ID_SERVICIO |
| $operation | Variable OSB | PV_OPERACION |
| Header/Authentication/UserName | Directo | PV_USUARIO |

### Mapeo OSB Request → conDatosPlanes
| Campo Origen (OSB) | Transformación/Script | Campo Destino (conDatosPlanes) |
|-------------------|----------------------|-------------------------------|
| ACCOUNT_NUMBER | Directo | PV_CUENTA |
| ORG | Directo | PV_ORG |
| Header/Region/SourceBank | convertirCodigoPais("OSB-ISO3") | PV_CODIGO_PAIS |

**Transformación convertirCodigoPais:**
```xquery
convertirCodigoPais("OSB-ISO3", "HN01") → "HND"
```

## Tablas de Mapeo de Salida

### Mapeo conDatosPlanes Response → OSB Response
| Campo Origen (conDatosPlanes) | Transformación/Script | Campo Destino (OSB) |
|------------------------------|----------------------|-------------------|
| Column[@name='org'] | data($org) | ORG |
| Column[@name='cuenta'] | data($account) | ACCOUNT |
| Column[@name='numseq'] | data($seqNumber) | SEQ_NUMBER |
| Column[@name='logo'] | data($logo) | LOGO |
| Column[@name='numplan'] | data($planNumber) | PLAN_NUMBER |
| Column[@name='total_due'] | data($payMinimum) | PAY_MINIMUM |
| Column[@name='tipo_plan'] | data($type) | TYPE_PLAN |
| Column[@name='int_rate'] | data($intRate) | INT_RATE |
| Column[@name='int_rat1_base'] | data($intRateBase) | INT_RATE_BASE |
| Column[@name='balanceactual'] | data($currentBalance) | CURRENT_BALANCE |
| Column[@name='fecplan'] | fn-bea:dateTime-to-string-with-format('yyyyMMdd', $datePlan) | DATE_PLAN |
| Column[@name='acrd_int'] | data($acrdInt) | ACRD_INT |
| Column[@name='mora_acrd_int'] | data($delaysAcrdInt) | DELAYS_ACRD_INT |
| Column[@name='d2ps_mora_int_per_diem'] | data($accumulatedDelaysInt) | ACCUMULATED_DELAYS_INT |

**Transformación de Fecha:**
```xquery
if($datePlan != '') then
  fn-bea:dateTime-to-string-with-format('yyyyMMdd', $datePlan)
else()
```

## Reglas de Negocio Detectadas

### 1. Validación de Entrada
- **Ubicación**: ConsultaPlanesCreditoHN.proxy - Stage "FlujoEntrada"
- **Regla**: Validación de esquema XSD obligatoria
- **Implementación**: 
```xml
<con2:validate>
  <con2:schema ref="Middleware/v2/BusinessServices/MasterDataHN/conDatosPlanes/xsd/conDatosPlanes_sp"/>
  <con2:schemaElement>con:InputParameters</con2:schemaElement>
</con2:validate>
```

### 2. Conversión de Código de País
- **Ubicación**: conDatosPlanesHNIn.xq
- **Regla**: Conversión de código OSB a ISO3
- **Implementación**:
```xquery
convertirCodigoPais("OSB-ISO3", $header/aut:RequestHeader/Region/SourceBank/text())
```

### 3. Validación de Respuesta de BD
- **Ubicación**: ConsultaPlanesCreditoHN.proxy - Response Transform
- **Regla**: errorCode != '-1' indica éxito
- **Implementación**:
```xquery
if($errorCode != '-1') then
  string($RSPConDatosPlanes/con1:MensajeError/text())
else('')
```

### 4. Formateo de Fecha
- **Ubicación**: consultaPlanesCreditoHNOut.xq
- **Regla**: Fechas se formatean a YYYYMMDD solo si no están vacías
- **Implementación**:
```xquery
if($datePlan != '') then
  <DATE_PLAN>{fn-bea:dateTime-to-string-with-format('yyyyMMdd',$datePlan)}</DATE_PLAN>
else()
```

### 5. Manejo de Errores Específico de HN01
- **Ubicación**: ConsultaPlanesCreditoHN.proxy - Response Stage
- **Regla**: successIndicator incluye el código de error específico (diferente a otras regiones)
- **Implementación**:
```xml
<aut:ResponseHeader>
  <successIndicator>{ $errorCode }</successIndicator>
  <messages>{$validationMessage}</messages>
</aut:ResponseHeader>
```

### 6. Construcción de Response Header Exitoso
- **Ubicación**: ConsultaPlanesCreditoHN.proxy - Response Stage
- **Regla**: successIndicator = "Success" cuando validationMessage está vacío
- **Implementación**:
```xml
<aut:ResponseHeader>
  <successIndicator>Success</successIndicator>
</aut:ResponseHeader>
```

### 7. Manejo de Errores en Error Handler
- **Ubicación**: ConsultaPlanesCreditoHN.proxy - Error Handler
- **Regla**: Errores incluyen el código de error específico del fault
- **Implementación**:
```xml
<aut:ResponseHeader>
  <messageId>-1</messageId>
  <successIndicator>{ string($fault/ctx:errorCode) }</successIndicator>
  <messages>{ string($fault/ctx:reason/text()) }</messages>
</aut:ResponseHeader>
```

## Diferencias Específicas de HN01

### 1. Manejo de Errores Diferenciado
A diferencia de otras regiones, HN01 incluye el código de error específico en el successIndicator:
```xml
<!-- HN01 -->
<successIndicator>{ $errorCode }</successIndicator>

<!-- Otras regiones -->
<successIndicator>ERROR</successIndicator>
```

### 2. Transport Configuration
- **Transport Provider**: HTTP (similar a GT01)
- **Endpoint**: `/Middleware/v2/ProxyServices/ConsultaPlanesCreditoHN`
- **SOAP Selector**: SOAP body

### 3. Variables de Response
- Utiliza `$RSPConDatosPlanes` (con mayúscula en "Con")
- Otras regiones utilizan `$RSPconDatosPlanes` (minúscula en "con")

### 4. Namespace en Error Handler
- Incluye `messageId` en el error response header
- Utiliza `string($fault/ctx:errorCode)` en lugar de literal "ERROR"