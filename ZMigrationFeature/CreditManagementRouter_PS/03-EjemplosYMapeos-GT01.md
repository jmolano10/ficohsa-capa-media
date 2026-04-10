# Ejemplos de Request/Response y Mapeo de Datos - GT01 (Guatemala)

## Request OSB (ejemplo JSON/XML)

### getConsolidatedCustomerRisk Request
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <tns:getConsolidatedCustomerRisk_params xmlns:tns="http://xmlns.oracle.com/MWBanking/GetConsolidatedCustomerRisk_PS">
      <tns:legalId>1234567890123</tns:legalId>
      <tns:DestinationBank>GT01</tns:DestinationBank>
      <tns:ApplicationId>MOBILE_BANKING</tns:ApplicationId>
      <tns:SourceBank>GT01</tns:SourceBank>
      <tns:Language>ES</tns:Language>
      <tns:Nit>12345678901234567</tns:Nit>
      <tns:FirstName>MARIA</tns:FirstName>
      <tns:LastName>GONZALEZ</tns:LastName>
      <tns:BirthDate>1985-03-15</tns:BirthDate>
    </tns:getConsolidatedCustomerRisk_params>
  </soap:Body>
</soap:Envelope>
```

### getCreditOffers Request
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <cred:getCreditOffersRequest xmlns:cred="http://www.ficohsa.com.hn/middleware.services/creditManagement" xmlns:com="http://www.ficohsa.com.hn/middleware.services/commonTypes">
      <cred:GeneralInfo>
        <com:SourceBank>GT01</com:SourceBank>
        <com:DestinationBank>GT01</com:DestinationBank>
        <com:Language>ES</com:Language>
        <com:GlobalId>87654321-4321-4321-4321-210987654321</com:GlobalId>
      </cred:GeneralInfo>
      <cred:CaseId>654321</cred:CaseId>
      <cred:ProductNature>PERSONAL_LOAN</cred:ProductNature>
      <cred:CustomerInfo>
        <cred:Id>1234567890123</cred:Id>
        <cred:Age>39</cred:Age>
        <cred:TotalSalary>8000.00</cred:TotalSalary>
        <cred:NetSalary>6500.00</cred:NetSalary>
        <cred:PayrollSalary>8000.00</cred:PayrollSalary>
      </cred:CustomerInfo>
    </cred:getCreditOffersRequest>
  </soap:Body>
</soap:Envelope>
```

## Response OSB (ejemplo JSON/XML)

### getConsolidatedCustomerRisk Response
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <cred:getConsolidatedCustomerRiskResponse xmlns:cred="http://www.ficohsa.com.hn/middleware.services/creditManagement" xmlns:com="http://www.ficohsa.com.hn/middleware.services/commonTypes">
      <cred:StatusInfo>
        <com:GlobalId>87654321-4321-4321-4321-210987654321</com:GlobalId>
        <com:SuccessIndicator>SUCCESS</com:SuccessIndicator>
        <com:Messages>Consulta exitosa Guatemala</com:Messages>
      </cred:StatusInfo>
      <cred:GetConsolidatedCustomerRisk>
        <cred:LoanMaintenance>
          <cred:CustomerInfo>
            <cred:Id>1234567890123</cred:Id>
            <cred:Age>39</cred:Age>
            <cred:Salary>8000.00</cred:Salary>
            <cred:ExternalScore>680</cred:ExternalScore>
            <cred:ScoreInfo>
              <cred:ScoreCalculation>680</cred:ScoreCalculation>
              <cred:Qualification>GOOD</cred:Qualification>
              <cred:RiskLevel>MEDIUM</cred:RiskLevel>
            </cred:ScoreInfo>
          </cred:CustomerInfo>
        </cred:LoanMaintenance>
      </cred:GetConsolidatedCustomerRisk>
    </cred:getConsolidatedCustomerRiskResponse>
  </soap:Body>
</soap:Envelope>
```

### getCreditOffers Response
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <cred:getCreditOffersResponse xmlns:cred="http://www.ficohsa.com.hn/middleware.services/creditManagement" xmlns:com="http://www.ficohsa.com.hn/middleware.services/commonTypes">
      <cred:StatusInfo>
        <com:GlobalId>87654321-4321-4321-4321-210987654321</com:GlobalId>
        <com:SuccessIndicator>SUCCESS</com:SuccessIndicator>
        <com:Messages>Ofertas obtenidas exitosamente Guatemala</com:Messages>
      </cred:StatusInfo>
      <cred:GetCreditOffers>
        <cred:CaseId>654321</cred:CaseId>
        <cred:InternalScore>680</cred:InternalScore>
        <cred:InternalRiskLevel>MEDIUM</cred:InternalRiskLevel>
        <cred:ResolutionOffers>
          <cred:Offer>
            <cred:ProductCode>PERSONAL_LOAN</cred:ProductCode>
            <cred:Rate>15.75</cred:Rate>
            <cred:MaxOffer>120000.00</cred:MaxOffer>
            <cred:For12Months>110000.00</cred:For12Months>
            <cred:For24Months>100000.00</cred:For24Months>
            <cred:For36Months>90000.00</cred:For36Months>
          </cred:Offer>
        </cred:ResolutionOffers>
      </cred:GetCreditOffers>
    </cred:getCreditOffersResponse>
  </soap:Body>
</soap:Envelope>
```

## Requests/Responses internos a servicios dependientes

### Request a DataWareHouse GT (consulta_ONBASE_V2)
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <ns1:consulta_ONBASE_V2 xmlns:ns1="http://tempuri.org/">
      <ns1:PV_CEDULA>1234567890123</ns1:PV_CEDULA>
      <ns1:PV_NIT>12345678901234567</ns1:PV_NIT>
      <ns1:PV_NOMBRE>MARIA</ns1:PV_NOMBRE>
      <ns1:PV_APELLIDO>GONZALEZ</ns1:PV_APELLIDO>
      <ns1:PV_FECHA_NACIMIENTO>1985-03-15</ns1:PV_FECHA_NACIMIENTO>
      <ns1:PV_CODIGO_APLICACION>MOBILE_BANKING</ns1:PV_CODIGO_APLICACION>
      <ns1:PV_REGION>GT01</ns1:PV_REGION>
    </ns1:consulta_ONBASE_V2>
  </soap:Body>
</soap:Envelope>
```

### Response de DataWareHouse GT
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <ns1:consulta_ONBASE_V2Response xmlns:ns1="http://tempuri.org/">
      <ns1:PV_CODIGO_ERROR>SUCCESS</ns1:PV_CODIGO_ERROR>
      <ns1:PV_DESCRIPCION_ERROR>Consulta exitosa Guatemala</ns1:PV_DESCRIPCION_ERROR>
      <ns1:PV_SCORE_EXTERNO>680</ns1:PV_SCORE_EXTERNO>
      <ns1:PV_CALIFICACION>GOOD</ns1:PV_CALIFICACION>
      <ns1:PV_NIVEL_RIESGO>MEDIUM</ns1:PV_NIVEL_RIESGO>
      <ns1:PV_SALARIO>8000.00</ns1:PV_SALARIO>
      <ns1:PV_EDAD>39</ns1:PV_EDAD>
      <ns1:PV_MONEDA_LOCAL>GTQ</ns1:PV_MONEDA_LOCAL>
      <ns1:PV_FACTOR_CAMBIO>7.75</ns1:PV_FACTOR_CAMBIO>
    </ns1:consulta_ONBASE_V2Response>
  </soap:Body>
</soap:Envelope>
```

### Request a RulesManagement GT (BLAZE)
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <blaze:executeRules xmlns:blaze="http://blaze.advisor.com/">
      <blaze:customerId>1234567890123</blaze:customerId>
      <blaze:salary>8000.00</blaze:salary>
      <blaze:age>39</blaze:age>
      <blaze:externalScore>680</blaze:externalScore>
      <blaze:productNature>PERSONAL_LOAN</blaze:productNature>
      <blaze:region>GT01</blaze:region>
      <blaze:currency>GTQ</blaze:currency>
      <blaze:exchangeRate>7.75</blaze:exchangeRate>
    </blaze:executeRules>
  </soap:Body>
</soap:Envelope>
```

### Response de RulesManagement GT (BLAZE)
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <blaze:executeRulesResponse xmlns:blaze="http://blaze.advisor.com/">
      <blaze:offers>
        <blaze:offer>
          <blaze:productCode>PERSONAL_LOAN</blaze:productCode>
          <blaze:maxAmount>120000.00</blaze:maxAmount>
          <blaze:rate>15.75</blaze:rate>
          <blaze:currency>GTQ</blaze:currency>
          <blaze:term12>110000.00</blaze:term12>
          <blaze:term24>100000.00</blaze:term24>
          <blaze:term36>90000.00</blaze:term36>
        </blaze:offer>
      </blaze:offers>
    </blaze:executeRulesResponse>
  </soap:Body>
</soap:Envelope>
```

## Cadenas de conexión detectadas y credenciales

### Base de Datos - DataWareHouse GT
- **Nombre de la Base de Datos**: DataWareHouseGT
- **Stored Procedure**: consulta_ONBASE_V2
- **Esquema**: ONBASE_V2
- **Package**: No especificado
- **Connection String**: Referenciado como DataWareHouseGT_BS (Business Service)

### Servicios WSDL - RulesManagement GT
- **Endpoint WSDL**: RulesManagement/RequestorServices/ProxyServices/v1.0/GetCreditOffers/GetCreditOffersGT_PS
- **Operación**: getCreditOffers
- **Binding**: SOAP 1.1
- **Transport**: HTTP

### Servicios WSDL - BLAZE Integration GT
- **Endpoint**: Configurado dinámicamente a través de BLAZE Advisor GT
- **Operación**: executeRules
- **Protocolo**: SOAP/HTTP
- **JAR Específico**: CreditOffersGT.jar, ConsolidatedCustomerRiskGT.jar

## Tablas de mapeo de entrada por cada llamada a servicio dependiente

### Mapeo OSB → DataWareHouse GT (consulta_ONBASE_V2)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (servicio interno) |
|-------------------|----------------------|----------------------------------|
| legalId | fn:data($body/get1:getConsolidatedCustomerRisk_params/get1:legalId) | PV_CEDULA |
| Nit | fn:data($body/get1:getConsolidatedCustomerRisk_params/get1:Nit) | PV_NIT |
| FirstName | fn:data($body/get1:getConsolidatedCustomerRisk_params/get1:FirstName) | PV_NOMBRE |
| LastName | fn:data($body/get1:getConsolidatedCustomerRisk_params/get1:LastName) | PV_APELLIDO |
| BirthDate | fn:data($body/get1:getConsolidatedCustomerRisk_params/get1:BirthDate) | PV_FECHA_NACIMIENTO |
| ApplicationId | fn:data($body/get1:getConsolidatedCustomerRisk_params/get1:ApplicationId) | PV_CODIGO_APLICACION |
| SourceBank | 'GT01' | PV_REGION |

### Mapeo OSB → RulesManagement GT (BLAZE)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (servicio interno) |
|-------------------|----------------------|----------------------------------|
| CustomerInfo/Id | fn:data($body/cred:getCreditOffersRequest/cred:CustomerInfo/cred:Id) | customerId |
| CustomerInfo/TotalSalary | fn:data($body/cred:getCreditOffersRequest/cred:CustomerInfo/cred:TotalSalary) | salary |
| CustomerInfo/Age | fn:data($body/cred:getCreditOffersRequest/cred:CustomerInfo/cred:Age) | age |
| ExternalScore | fn:data($body/cred:getCreditOffersRequest/cred:ExternalScore) | externalScore |
| ProductNature | fn:data($body/cred:getCreditOffersRequest/cred:ProductNature) | productNature |
| GeneralInfo/SourceBank | fn:data($body/cred:getCreditOffersRequest/cred:GeneralInfo/com:SourceBank) | region |
| Constante | 'GTQ' | currency |
| Constante | 7.75 | exchangeRate |

## Tablas de mapeo de salida por cada respuesta de servicio dependiente

### Mapeo DataWareHouse GT → OSB Response

| Campo Origen (servicio interno) | Transformación/Script | Campo Destino (OSB) |
|--------------------------------|----------------------|-------------------|
| PV_CODIGO_ERROR | if($response/ns1:PV_CODIGO_ERROR = 'SUCCESS') then 'SUCCESS' else 'ERROR' | StatusInfo/SuccessIndicator |
| PV_DESCRIPCION_ERROR | fn:data($response/ns1:PV_DESCRIPCION_ERROR) | StatusInfo/Messages |
| PV_SCORE_EXTERNO | fn:data($response/ns1:PV_SCORE_EXTERNO) | GetConsolidatedCustomerRisk/LoanMaintenance/CustomerInfo/ExternalScore |
| PV_CALIFICACION | fn:data($response/ns1:PV_CALIFICACION) | GetConsolidatedCustomerRisk/LoanMaintenance/CustomerInfo/ScoreInfo/Qualification |
| PV_NIVEL_RIESGO | fn:data($response/ns1:PV_NIVEL_RIESGO) | GetConsolidatedCustomerRisk/LoanMaintenance/CustomerInfo/ScoreInfo/RiskLevel |
| PV_SALARIO | fn:data($response/ns1:PV_SALARIO) | GetConsolidatedCustomerRisk/LoanMaintenance/CustomerInfo/Salary |
| PV_EDAD | fn:data($response/ns1:PV_EDAD) | GetConsolidatedCustomerRisk/LoanMaintenance/CustomerInfo/Age |
| PV_MONEDA_LOCAL | fn:data($response/ns1:PV_MONEDA_LOCAL) | GetConsolidatedCustomerRisk/LoanMaintenance/CustomerInfo/Currency |
| PV_FACTOR_CAMBIO | fn:data($response/ns1:PV_FACTOR_CAMBIO) | GetConsolidatedCustomerRisk/LoanMaintenance/CustomerInfo/ExchangeFactor |

### Mapeo RulesManagement GT (BLAZE) → OSB Response

| Campo Origen (servicio interno) | Transformación/Script | Campo Destino (OSB) |
|--------------------------------|----------------------|-------------------|
| offers/offer/productCode | fn:data($blazeResponse/blaze:offers/blaze:offer/blaze:productCode) | GetCreditOffers/ResolutionOffers/Offer/ProductCode |
| offers/offer/maxAmount | fn:data($blazeResponse/blaze:offers/blaze:offer/blaze:maxAmount) | GetCreditOffers/ResolutionOffers/Offer/MaxOffer |
| offers/offer/rate | fn:data($blazeResponse/blaze:offers/blaze:offer/blaze:rate) | GetCreditOffers/ResolutionOffers/Offer/Rate |
| offers/offer/currency | fn:data($blazeResponse/blaze:offers/blaze:offer/blaze:currency) | GetCreditOffers/ResolutionOffers/Offer/Currency |
| offers/offer/term12 | fn:data($blazeResponse/blaze:offers/blaze:offer/blaze:term12) | GetCreditOffers/ResolutionOffers/Offer/For12Months |
| offers/offer/term24 | fn:data($blazeResponse/blaze:offers/blaze:offer/blaze:term24) | GetCreditOffers/ResolutionOffers/Offer/For24Months |
| offers/offer/term36 | fn:data($blazeResponse/blaze:offers/blaze:offer/blaze:term36) | GetCreditOffers/ResolutionOffers/Offer/For36Months |

## Reglas de negocio detectadas

### Validación Regional GT01
- **Ubicación**: Pipeline CommonParams stage "Valida Servicio Regional"
- **Regla**: `dvm:lookupValue('CommonResources/DVM/RegionalParameters', 'ServiceName', $serviceName, 'Value', 'Not found',('Name',fn:concat('SourceBank.GT01.DestinationBank.GT01')))`
- **Condición**: `$dvmValueResponse!='Active'`
- **Acción**: Error MW-0003 "INVALID REGION REQUEST"

### Transformaciones Específicas GT01
- **Ubicación**: XQuery files específicos para GT
- **Archivos**:
  - Tx_GetConsolidatedCustomerGTRisk_To_consulta_ONBASE_V2.xqy
  - Tx_consulta_ONBASE_V2_To_GetConsolidatedCustomerRiskGTResponse.xqy
  - Tx_GetCreditOffersGT_To_BLAZE.xqy
  - Tx_BLAZE_To_GetCreditOffersGTResponse.xqy

### Manejo de Moneda Local GT01
- **Ubicación**: Transformaciones específicas GT
- **Regla**: 
```xquery
let $currency := 'GTQ'
let $exchangeRate := 7.75
return (
  <currency>{$currency}</currency>,
  <exchangeRate>{$exchangeRate}</exchangeRate>
)
```

### Cálculo de Ofertas en Quetzales
- **Ubicación**: BLAZE GT transformations
- **Regla**:
```xquery
let $amountUSD := fn:data($offer/maxAmount)
let $amountGTQ := $amountUSD * 7.75
return <maxAmountGTQ>{$amountGTQ}</maxAmountGTQ>
```

### Validación de Documentos GT01
- **Ubicación**: Validaciones específicas GT
- **Regla**:
```xquery
if(fn:string-length($cedula) = 13) then
  'VALID_GT_ID'
else if(fn:string-length($nit) = 17) then
  'VALID_GT_NIT'
else
  'INVALID_GT_DOCUMENT'
```

### Mapeo de Tasas de Interés GT01
- **Ubicación**: RulesManagement GT
- **Reglas**:
  - Score > 700: Tasa base + 2%
  - Score 600-700: Tasa base + 4%
  - Score < 600: Tasa base + 6%
  - Tasa base GT01: 12.5%

### Límites de Crédito por Región GT01
- **Ubicación**: BLAZE GT rules
- **Reglas**:
  - Salario < Q5,000: Máximo Q50,000
  - Salario Q5,000-Q10,000: Máximo Q150,000
  - Salario > Q10,000: Máximo Q300,000

### Conversión de Monedas
- **Ubicación**: Response transformations GT
- **Regla**:
```xquery
let $usdAmount := fn:data($amount)
let $gtqAmount := $usdAmount * $exchangeRate
return (
  <amountUSD>{$usdAmount}</amountUSD>,
  <amountGTQ>{$gtqAmount}</amountGTQ>
)
```