# Ejemplos de Request/Response y Mapeo de Datos - GT01 (Guatemala)

## Request OSB (Ejemplo SOAP/XML)

### SOAP Envelope Completo
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:RequestHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <Authentication>
        <UserName>userGT01</UserName>
        <Password>passwordGT01</Password>
      </Authentication>
      <Region>
        <SourceBank>GT01</SourceBank>
        <DestinationBank>GT01</DestinationBank>
      </Region>
      <TransactionId>TXN-GT-20241201-001</TransactionId>
      <Timestamp>2024-12-01T10:30:00</Timestamp>
    </aut:RequestHeader>
  </soap:Header>
  <soap:Body>
    <con:consultaPlanesCredito xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaPlanesCreditoTypes">
      <ACCOUNT_NUMBER>4532123456789012</ACCOUNT_NUMBER>
      <ORG>GT01</ORG>
    </con:consultaPlanesCredito>
  </soap:Body>
</soap:Envelope>
```

### Body Request
```xml
<con:consultaPlanesCredito xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaPlanesCreditoTypes">
  <ACCOUNT_NUMBER>4532123456789012</ACCOUNT_NUMBER>
  <ORG>GT01</ORG>
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
      <TransactionId>TXN-GT-20241201-001</TransactionId>
      <Timestamp>2024-12-01T10:30:05</Timestamp>
    </aut:ResponseHeader>
  </soap:Header>
  <soap:Body>
    <con:consultaPlanesCreditoResponse xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaPlanesCreditoTypes">
      <CREDIT_PLANS>
        <CREDIT_PLAN>
          <ORG>GT01</ORG>
          <ACCOUNT>4532123456789012</ACCOUNT>
          <SEQ_NUMBER>001</SEQ_NUMBER>
          <LOGO>VISA</LOGO>
          <PLAN_NUMBER>PL001</PLAN_NUMBER>
          <PAY_MINIMUM>150.00</PAY_MINIMUM>
          <TYPE_PLAN>REVOLVING</TYPE_PLAN>
          <INT_RATE>24.50</INT_RATE>
          <INT_RATE_BASE>18.00</INT_RATE_BASE>
          <CURRENT_BALANCE>2500.75</CURRENT_BALANCE>
          <DATE_PLAN>20241201</DATE_PLAN>
          <ACRD_INT>45.25</ACRD_INT>
          <DELAYS_ACRD_INT>0.00</DELAYS_ACRD_INT>
          <ACCUMULATED_DELAYS_INT>0.00</ACCUMULATED_DELAYS_INT>
        </CREDIT_PLAN>
        <CREDIT_PLAN>
          <ORG>GT01</ORG>
          <ACCOUNT>4532123456789012</ACCOUNT>
          <SEQ_NUMBER>002</SEQ_NUMBER>
          <LOGO>MASTERCARD</LOGO>
          <PLAN_NUMBER>PL002</PLAN_NUMBER>
          <PAY_MINIMUM>75.00</PAY_MINIMUM>
          <TYPE_PLAN>INSTALLMENT</TYPE_PLAN>
          <INT_RATE>18.75</INT_RATE>
          <INT_RATE_BASE>15.00</INT_RATE_BASE>
          <CURRENT_BALANCE>1200.00</CURRENT_BALANCE>
          <DATE_PLAN>20241115</DATE_PLAN>
          <ACRD_INT>22.50</ACRD_INT>
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
  <con1:PV_REGION>GT01</con1:PV_REGION>
  <con1:PV_USUARIO>userGT01</con1:PV_USUARIO>
</con1:InputParameters>
```

#### Response de consultaRutaRegional
```xml
<con1:OutputParameters xmlns:con1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRutaRegional">
  <con1:PV_CODIGO_ERROR>SUCCESS</con1:PV_CODIGO_ERROR>
  <con1:PV_MENSAJE_ERROR></con1:PV_MENSAJE_ERROR>
  <con1:PV_UBICACION>Middleware/v2/ProxyServices/ConsultaPlanesCreditoGT</con1:PV_UBICACION>
</con1:OutputParameters>
```

### 2. Consulta Base de Datos (MasterDataGT)

#### Request a conDatosPlanes_db
```xml
<con1:InputParameters xmlns:con1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatosPlanes">
  <con1:PV_CUENTA>4532123456789012</con1:PV_CUENTA>
  <con1:PV_ORG>GT01</con1:PV_ORG>
  <con1:PV_CODIGO_PAIS>GTM</con1:PV_CODIGO_PAIS>
</con1:InputParameters>
```

#### Response de conDatosPlanes_db
```xml
<con1:OutputParameters xmlns:con1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatosPlanes">
  <con1:CodigoError>-1</con1:CodigoError>
  <con1:MensajeError></con1:MensajeError>
  <con1:RowSet>
    <con1:Row>
      <con1:Column name="org">GT01</con1:Column>
      <con1:Column name="cuenta">4532123456789012</con1:Column>
      <con1:Column name="numseq">001</con1:Column>
      <con1:Column name="logo">VISA</con1:Column>
      <con1:Column name="numplan">PL001</con1:Column>
      <con1:Column name="total_due">150.00</con1:Column>
      <con1:Column name="tipo_plan">REVOLVING</con1:Column>
      <con1:Column name="int_rate">24.50</con1:Column>
      <con1:Column name="int_rat1_base">18.00</con1:Column>
      <con1:Column name="balanceactual">2500.75</con1:Column>
      <con1:Column name="fecplan">2024-12-01T00:00:00</con1:Column>
      <con1:Column name="acrd_int">45.25</con1:Column>
      <con1:Column name="mora_acrd_int">0.00</con1:Column>
      <con1:Column name="d2ps_mora_int_per_diem">0.00</con1:Column>
    </con1:Row>
    <con1:Row>
      <con1:Column name="org">GT01</con1:Column>
      <con1:Column name="cuenta">4532123456789012</con1:Column>
      <con1:Column name="numseq">002</con1:Column>
      <con1:Column name="logo">MASTERCARD</con1:Column>
      <con1:Column name="numplan">PL002</con1:Column>
      <con1:Column name="total_due">75.00</con1:Column>
      <con1:Column name="tipo_plan">INSTALLMENT</con1:Column>
      <con1:Column name="int_rate">18.75</con1:Column>
      <con1:Column name="int_rat1_base">15.00</con1:Column>
      <con1:Column name="balanceactual">1200.00</con1:Column>
      <con1:Column name="fecplan">2024-11-15T00:00:00</con1:Column>
      <con1:Column name="acrd_int">22.50</con1:Column>
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
- **Endpoint**: https://172.23.13.19:8004/Middleware/OperationsAndExecution/Cards/ConsultaPlanesCredito
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
convertirCodigoPais("OSB-ISO3", "GT01") → "GTM"
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
- **Ubicación**: ConsultaPlanesCreditoGT.proxy - Stage "FlujoEntrada"
- **Regla**: Validación de esquema XSD obligatoria
- **Implementación**: 
```xml
<con1:validate>
  <con1:schema ref="Middleware/v2/BusinessServices/MasterDataGT/conDatosPlanes/xsd/conDatosPlanes_sp"/>
  <con1:schemaElement>con3:InputParameters</con1:schemaElement>
</con1:validate>
```

### 2. Conversión de Código de País
- **Ubicación**: conDatosPlanesGTIn.xq
- **Regla**: Conversión de código OSB a ISO3
- **Implementación**:
```xquery
convertirCodigoPais("OSB-ISO3", $header/aut:RequestHeader/Region/SourceBank/text())
```

### 3. Validación de Respuesta de BD
- **Ubicación**: ConsultaPlanesCreditoGT.proxy - Response Transform
- **Regla**: errorCode != '-1' indica éxito
- **Implementación**:
```xquery
if($errorCode != '-1') then
  string($RSPconDatosPlanes/con1:MensajeError/text())
else('')
```

### 4. Formateo de Fecha
- **Ubicación**: consultaPlanesCreditoGTOut.xq
- **Regla**: Fechas se formatean a YYYYMMDD solo si no están vacías
- **Implementación**:
```xquery
if($datePlan != '') then
  <DATE_PLAN>{fn-bea:dateTime-to-string-with-format('yyyyMMdd',$datePlan)}</DATE_PLAN>
else()
```

### 5. Manejo de Errores
- **Ubicación**: ConsultaPlanesCreditoGT.proxy - Error Handler
- **Regla**: Errores se mapean a través del servicio MapeoErrores
- **Implementación**:
```xml
<con:param name="MENSAJE_ERROR">
  <con:path>fn:concat("FICBCO0321","$#$", $errorMessage)</con:path>
</con:param>
```

### 6. Construcción de Response Header
- **Ubicación**: ConsultaPlanesCreditoGT.proxy - Response Stage
- **Regla**: successIndicator = "Success" cuando validationMessage está vacío
- **Implementación**:
```xml
<aut:ResponseHeader>
  <successIndicator>Success</successIndicator>
</aut:ResponseHeader>
```