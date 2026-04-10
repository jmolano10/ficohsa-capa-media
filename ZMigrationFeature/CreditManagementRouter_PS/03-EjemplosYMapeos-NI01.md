# Ejemplos de Request/Response y Mapeo de Datos - NI01 (Nicaragua)

## Request OSB (ejemplo JSON/XML)

### getConsolidatedCustomerRisk Request
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <tns:getConsolidatedCustomerRisk_params xmlns:tns="http://xmlns.oracle.com/MWBanking/GetConsolidatedCustomerRisk_PS">
      <tns:legalId>001-150485-0001A</tns:legalId>
      <tns:DestinationBank>NI01</tns:DestinationBank>
      <tns:ApplicationId>MOBILE_BANKING</tns:ApplicationId>
      <tns:SourceBank>NI01</tns:SourceBank>
      <tns:Language>ES</tns:Language>
      <tns:Nit>J0310000000001</tns:Nit>
      <tns:FirstName>CARLOS</tns:FirstName>
      <tns:LastName>MARTINEZ</tns:LastName>
      <tns:BirthDate>1985-04-15</tns:BirthDate>
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
        <com:SourceBank>NI01</com:SourceBank>
        <com:DestinationBank>NI01</com:DestinationBank>
        <com:Language>ES</com:Language>
        <com:GlobalId>11111111-2222-3333-4444-555555555555</com:GlobalId>
      </cred:GeneralInfo>
      <cred:CaseId>789012</cred:CaseId>
      <cred:ProductNature>PERSONAL_LOAN</cred:ProductNature>
      <cred:CustomerInfo>
        <cred:Id>001-150485-0001A</cred:Id>
        <cred:Age>39</cred:Age>
        <cred:TotalSalary>15000.00</cred:TotalSalary>
        <cred:NetSalary>12000.00</cred:NetSalary>
        <cred:PayrollSalary>15000.00</cred:PayrollSalary>
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
        <com:GlobalId>11111111-2222-3333-4444-555555555555</com:GlobalId>
        <com:SuccessIndicator>SUCCESS</com:SuccessIndicator>
        <com:Messages>Consulta exitosa Nicaragua</com:Messages>
      </cred:StatusInfo>
      <cred:GetConsolidatedCustomerRisk>
        <cred:LoanMaintenance>
          <cred:CustomerInfo>
            <cred:Id>001-150485-0001A</cred:Id>
            <cred:Age>39</cred:Age>
            <cred:Salary>15000.00</cred:Salary>
            <cred:ExternalScore>620</cred:ExternalScore>
            <cred:ScoreInfo>
              <cred:ScoreCalculation>620</cred:ScoreCalculation>
              <cred:Qualification>FAIR</cred:Qualification>
              <cred:RiskLevel>MEDIUM_HIGH</cred:RiskLevel>
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
        <com:GlobalId>11111111-2222-3333-4444-555555555555</com:GlobalId>
        <com:SuccessIndicator>SUCCESS</com:SuccessIndicator>
        <com:Messages>Ofertas obtenidas exitosamente Nicaragua</com:Messages>
      </cred:StatusInfo>
      <cred:GetCreditOffers>
        <cred:CaseId>789012</cred:CaseId>
        <cred:InternalScore>620</cred:InternalScore>
        <cred:InternalRiskLevel>MEDIUM_HIGH</cred:InternalRiskLevel>
        <cred:ResolutionOffers>
          <cred:Offer>
            <cred:ProductCode>PERSONAL_LOAN</cred:ProductCode>
            <cred:Rate>18.50</cred:Rate>
            <cred:MaxOffer>180000.00</cred:MaxOffer>
            <cred:For12Months>160000.00</cred:For12Months>
            <cred:For24Months>140000.00</cred:For24Months>
            <cred:For36Months>120000.00</cred:For36Months>
          </cred:Offer>
        </cred:ResolutionOffers>
      </cred:GetCreditOffers>
    </cred:getCreditOffersResponse>
  </soap:Body>
</soap:Envelope>
```

## Requests/Responses internos a servicios dependientes

### Request a DataWareHouse NI (consulta_ONBASE_V2)
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <ns1:consulta_ONBASE_V2 xmlns:ns1="http://tempuri.org/">
      <ns1:PV_CEDULA>001-150485-0001A</ns1:PV_CEDULA>
      <ns1:PV_RUC>J0310000000001</ns1:PV_RUC>
      <ns1:PV_NOMBRE>CARLOS</ns1:PV_NOMBRE>
      <ns1:PV_APELLIDO>MARTINEZ</ns1:PV_APELLIDO>
      <ns1:PV_FECHA_NACIMIENTO>1985-04-15</ns1:PV_FECHA_NACIMIENTO>
      <ns1:PV_CODIGO_APLICACION>MOBILE_BANKING</ns1:PV_CODIGO_APLICACION>
      <ns1:PV_REGION>NI01</ns1:PV_REGION>
    </ns1:consulta_ONBASE_V2>
  </soap:Body>
</soap:Envelope>
```

### Response de DataWareHouse NI
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <ns1:consulta_ONBASE_V2Response xmlns:ns1="http://tempuri.org/">
      <ns1:PV_CODIGO_ERROR>SUCCESS</ns1:PV_CODIGO_ERROR>
      <ns1:PV_DESCRIPCION_ERROR>Consulta exitosa Nicaragua</ns1:PV_DESCRIPCION_ERROR>
      <ns1:PV_SCORE_EXTERNO>620</ns1:PV_SCORE_EXTERNO>
      <ns1:PV_CALIFICACION>FAIR</ns1:PV_CALIFICACION>
      <ns1:PV_NIVEL_RIESGO>MEDIUM_HIGH</ns1:PV_NIVEL_RIESGO>
      <ns1:PV_SALARIO>15000.00</ns1:PV_SALARIO>
      <ns1:PV_EDAD>39</ns1:PV_EDAD>
      <ns1:PV_MONEDA_LOCAL>NIO</ns1:PV_MONEDA_LOCAL>
      <ns1:PV_FACTOR_CAMBIO>36.50</ns1:PV_FACTOR_CAMBIO>
    </ns1:consulta_ONBASE_V2Response>
  </soap:Body>
</soap:Envelope>
```

### Request a RulesManagement NI (BLAZE)
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <blaze:executeRules xmlns:blaze="http://blaze.advisor.com/">
      <blaze:customerId>001-150485-0001A</blaze:customerId>
      <blaze:salary>15000.00</blaze:salary>
      <blaze:age>39</blaze:age>
      <blaze:externalScore>620</blaze:externalScore>
      <blaze:productNature>PERSONAL_LOAN</blaze:productNature>
      <blaze:region>NI01</blaze:region>
      <blaze:currency>NIO</blaze:currency>
      <blaze:exchangeRate>36.50</blaze:exchangeRate>
    </blaze:executeRules>
  </soap:Body>
</soap:Envelope>
```

### Response de RulesManagement NI (BLAZE)
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <blaze:executeRulesResponse xmlns:blaze="http://blaze.advisor.com/">
      <blaze:offers>
        <blaze:offer>
          <blaze:productCode>PERSONAL_LOAN</blaze:productCode>
          <blaze:maxAmount>180000.00</blaze:maxAmount>
          <blaze:rate>18.50</blaze:rate>
          <blaze:currency>NIO</blaze:currency>
          <blaze:term12>160000.00</blaze:term12>
          <blaze:term24>140000.00</blaze:term24>
          <blaze:term36>120000.00</blaze:term36>
        </blaze:offer>
      </blaze:offers>
    </blaze:executeRulesResponse>
  </soap:Body>
</soap:Envelope>
```

## Cadenas de conexión detectadas y credenciales

### Base de Datos - DataWareHouse NI
- **Nombre de la Base de Datos**: DataWareHouseNI
- **Stored Procedure**: consulta_ONBASE_V2
- **Esquema**: ONBASE_V2
- **Package**: No especificado
- **Connection String**: Referenciado como DataWareHouseNI_BS (Business Service)

### Servicios WSDL - RulesManagement NI
- **Endpoint WSDL**: RulesManagement/RequestorServices/ProxyServices/v1.0/GetCreditOffers/GetCreditOffersNI_PS
- **Operación**: getCreditOffers
- **Binding**: SOAP 1.1
- **Transport**: HTTP

### Servicios WSDL - BLAZE Integration NI
- **Endpoint**: Configurado dinámicamente a través de BLAZE Advisor NI
- **Operación**: executeRules
- **Protocolo**: SOAP/HTTP
- **JAR Específico**: CreditOffersNI.jar, ConsolidatedCustomerRiskNI.jar

## Tablas de mapeo de entrada por cada llamada a servicio dependiente

### Mapeo OSB → DataWareHouse NI (consulta_ONBASE_V2)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (servicio interno) |
|-------------------|----------------------|----------------------------------|
| legalId | fn:data($body/get1:getConsolidatedCustomerRisk_params/get1:legalId) | PV_CEDULA |
| Nit | fn:data($body/get1:getConsolidatedCustomerRisk_params/get1:Nit) | PV_RUC |
| FirstName | fn:data($body/get1:getConsolidatedCustomerRisk_params/get1:FirstName) | PV_NOMBRE |
| LastName | fn:data($body/get1:getConsolidatedCustomerRisk_params/get1:LastName) | PV_APELLIDO |
| BirthDate | fn:data($body/get1:getConsolidatedCustomerRisk_params/get1:BirthDate) | PV_FECHA_NACIMIENTO |
| ApplicationId | fn:data($body/get1:getConsolidatedCustomerRisk_params/get1:ApplicationId) | PV_CODIGO_APLICACION |
| SourceBank | 'NI01' | PV_REGION |

### Mapeo OSB → RulesManagement NI (BLAZE)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (servicio interno) |
|-------------------|----------------------|----------------------------------|
| CustomerInfo/Id | fn:data($body/cred:getCreditOffersRequest/cred:CustomerInfo/cred:Id) | customerId |
| CustomerInfo/TotalSalary | fn:data($body/cred:getCreditOffersRequest/cred:CustomerInfo/cred:TotalSalary) | salary |
| CustomerInfo/Age | fn:data($body/cred:getCreditOffersRequest/cred:CustomerInfo/cred:Age) | age |
| ExternalScore | fn:data($body/cred:getCreditOffersRequest/cred:ExternalScore) | externalScore |
| ProductNature | fn:data($body/cred:getCreditOffersRequest/cred:ProductNature) | productNature |
| GeneralInfo/SourceBank | fn:data($body/cred:getCreditOffersRequest/cred:GeneralInfo/com:SourceBank) | region |
| Constante | 'NIO' | currency |
| Constante | 36.50 | exchangeRate |

## Tablas de mapeo de salida por cada respuesta de servicio dependiente

### Mapeo DataWareHouse NI → OSB Response

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

### Mapeo RulesManagement NI (BLAZE) → OSB Response

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

### Validación Regional NI01
- **Ubicación**: Pipeline CommonParams stage "Valida Servicio Regional"
- **Regla**: `dvm:lookupValue('CommonResources/DVM/RegionalParameters', 'ServiceName', $serviceName, 'Value', 'Not found',('Name',fn:concat('SourceBank.NI01.DestinationBank.NI01')))`
- **Condición**: `$dvmValueResponse!='Active'`
- **Acción**: Error MW-0003 "INVALID REGION REQUEST"

### Transformaciones Específicas NI01
- **Ubicación**: XQuery files específicos para NI
- **Archivos**:
  - Tx_GetConsolidatedCustomerNIRisk_To_consulta_ONBASE_V2.xqy
  - Tx_consulta_ONBASE_V2_To_GetConsolidatedCustomerRiskNIResponse.xqy
  - Tx_GetCreditOffersNI_To_BLAZE.xqy
  - Tx_BLAZE_To_GetCreditOffersNIResponse.xqy

### Manejo de Moneda Local NI01
- **Ubicación**: Transformaciones específicas NI
- **Regla**: 
```xquery
let $currency := 'NIO'
let $exchangeRate := 36.50
return (
  <currency>{$currency}</currency>,
  <exchangeRate>{$exchangeRate}</exchangeRate>
)
```

### Cálculo de Ofertas en Córdobas
- **Ubicación**: BLAZE NI transformations
- **Regla**:
```xquery
let $amountUSD := fn:data($offer/maxAmount)
let $amountNIO := $amountUSD * 36.50
return <maxAmountNIO>{$amountNIO}</maxAmountNIO>
```

### Validación de Documentos NI01
- **Ubicación**: Validaciones específicas NI
- **Regla**:
```xquery
if(matches($cedula, '^[0-9]{3}-[0-9]{6}-[0-9]{4}[A-Z]$')) then
  'VALID_NI_CEDULA'
else if(matches($ruc, '^J[0-9]{13}$')) then
  'VALID_NI_RUC'
else
  'INVALID_NI_DOCUMENT'
```

### Mapeo de Tasas de Interés NI01
- **Ubicación**: RulesManagement NI
- **Reglas**:
  - Score > 700: Tasa base + 3%
  - Score 600-700: Tasa base + 5%
  - Score < 600: Tasa base + 8%
  - Tasa base NI01: 15.5%

### Límites de Crédito por Región NI01
- **Ubicación**: BLAZE NI rules
- **Reglas**:
  - Salario < C$10,000: Máximo C$100,000
  - Salario C$10,000-C$20,000: Máximo C$250,000
  - Salario > C$20,000: Máximo C$500,000

### Conversión de Monedas NI01
- **Ubicación**: Response transformations NI
- **Regla**:
```xquery
let $usdAmount := fn:data($amount)
let $nioAmount := $usdAmount * $exchangeRate
return (
  <amountUSD>{$usdAmount}</amountUSD>,
  <amountNIO>{$nioAmount}</amountNIO>
)
```

### Validación de Cédula Nicaragüense
- **Ubicación**: Request validation NI
- **Regla**:
```xquery
let $cedula := fn:data($request/cedula)
let $pattern := '^[0-9]{3}-[0-9]{6}-[0-9]{4}[A-Z]$'
return 
  if(matches($cedula, $pattern)) then
    'VALID'
  else
    fn:error(xs:QName('NI-0001'), 'CEDULA NICARAGUENSE INVALIDA')
```

### Validación de RUC Nicaragüense
- **Ubicación**: Request validation NI
- **Regla**:
```xquery
let $ruc := fn:data($request/ruc)
let $pattern := '^J[0-9]{13}$'
return 
  if(matches($ruc, $pattern)) then
    'VALID'
  else
    fn:error(xs:QName('NI-0002'), 'RUC NICARAGUENSE INVALIDO')
```