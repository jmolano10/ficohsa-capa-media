# Ejemplos de Request/Response y Mapeo de Datos - HN01 (Honduras)

## Request OSB (ejemplo JSON/XML)

### getConsolidatedCustomerRisk Request
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <tns:getConsolidatedCustomerRisk_params xmlns:tns="http://xmlns.oracle.com/MWBanking/GetConsolidatedCustomerRisk_PS">
      <tns:legalId>0801199012345</tns:legalId>
      <tns:DestinationBank>HN01</tns:DestinationBank>
      <tns:ApplicationId>MOBILE_BANKING</tns:ApplicationId>
      <tns:SourceBank>HN01</tns:SourceBank>
      <tns:Language>ES</tns:Language>
      <tns:Nit>08011990123456789</tns:Nit>
      <tns:FirstName>JUAN</tns:FirstName>
      <tns:LastName>PEREZ</tns:LastName>
      <tns:BirthDate>1990-01-08</tns:BirthDate>
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
        <com:SourceBank>HN01</com:SourceBank>
        <com:DestinationBank>HN01</com:DestinationBank>
        <com:Language>ES</com:Language>
        <com:GlobalId>12345678-1234-1234-1234-123456789012</com:GlobalId>
      </cred:GeneralInfo>
      <cred:CaseId>123456</cred:CaseId>
      <cred:ProductNature>PERSONAL_LOAN</cred:ProductNature>
      <cred:CustomerInfo>
        <cred:Id>0801199012345</cred:Id>
        <cred:Age>34</cred:Age>
        <cred:TotalSalary>25000.00</cred:TotalSalary>
        <cred:NetSalary>20000.00</cred:NetSalary>
        <cred:PayrollSalary>25000.00</cred:PayrollSalary>
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
        <com:GlobalId>12345678-1234-1234-1234-123456789012</com:GlobalId>
        <com:SuccessIndicator>SUCCESS</com:SuccessIndicator>
        <com:Messages>Consulta exitosa</com:Messages>
      </cred:StatusInfo>
      <cred:GetConsolidatedCustomerRisk>
        <cred:LoanMaintenance>
          <cred:CustomerInfo>
            <cred:Id>0801199012345</cred:Id>
            <cred:Age>34</cred:Age>
            <cred:Salary>25000.00</cred:Salary>
            <cred:ExternalScore>750</cred:ExternalScore>
            <cred:ScoreInfo>
              <cred:ScoreCalculation>750</cred:ScoreCalculation>
              <cred:Qualification>EXCELLENT</cred:Qualification>
              <cred:RiskLevel>LOW</cred:RiskLevel>
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
        <com:GlobalId>12345678-1234-1234-1234-123456789012</com:GlobalId>
        <com:SuccessIndicator>SUCCESS</com:SuccessIndicator>
        <com:Messages>Ofertas obtenidas exitosamente</com:Messages>
      </cred:StatusInfo>
      <cred:GetCreditOffers>
        <cred:CaseId>123456</cred:CaseId>
        <cred:InternalScore>750</cred:InternalScore>
        <cred:InternalRiskLevel>LOW</cred:InternalRiskLevel>
        <cred:ResolutionOffers>
          <cred:Offer>
            <cred:ProductCode>PERSONAL_LOAN</cred:ProductCode>
            <cred:Rate>12.50</cred:Rate>
            <cred:MaxOffer>500000.00</cred:MaxOffer>
            <cred:For12Months>450000.00</cred:For12Months>
            <cred:For24Months>400000.00</cred:For24Months>
            <cred:For36Months>350000.00</cred:For36Months>
          </cred:Offer>
        </cred:ResolutionOffers>
      </cred:GetCreditOffers>
    </cred:getCreditOffersResponse>
  </soap:Body>
</soap:Envelope>
```

## Requests/Responses internos a servicios dependientes

### Request a DataWareHouseHN (consulta_ONBASE_V2)
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <ns1:consulta_ONBASE_V2 xmlns:ns1="http://tempuri.org/">
      <ns1:PV_CEDULA>0801199012345</ns1:PV_CEDULA>
      <ns1:PV_NIT>08011990123456789</ns1:PV_NIT>
      <ns1:PV_NOMBRE>JUAN</ns1:PV_NOMBRE>
      <ns1:PV_APELLIDO>PEREZ</ns1:PV_APELLIDO>
      <ns1:PV_FECHA_NACIMIENTO>1990-01-08</ns1:PV_FECHA_NACIMIENTO>
      <ns1:PV_CODIGO_APLICACION>MOBILE_BANKING</ns1:PV_CODIGO_APLICACION>
    </ns1:consulta_ONBASE_V2>
  </soap:Body>
</soap:Envelope>
```

### Response de DataWareHouseHN
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <ns1:consulta_ONBASE_V2Response xmlns:ns1="http://tempuri.org/">
      <ns1:PV_CODIGO_ERROR>SUCCESS</ns1:PV_CODIGO_ERROR>
      <ns1:PV_DESCRIPCION_ERROR>Consulta exitosa</ns1:PV_DESCRIPCION_ERROR>
      <ns1:PV_SCORE_EXTERNO>750</ns1:PV_SCORE_EXTERNO>
      <ns1:PV_CALIFICACION>EXCELLENT</ns1:PV_CALIFICACION>
      <ns1:PV_NIVEL_RIESGO>LOW</ns1:PV_NIVEL_RIESGO>
      <ns1:PV_SALARIO>25000.00</ns1:PV_SALARIO>
      <ns1:PV_EDAD>34</ns1:PV_EDAD>
    </ns1:consulta_ONBASE_V2Response>
  </soap:Body>
</soap:Envelope>
```

### Request a RulesManagement (BLAZE)
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <blaze:executeRules xmlns:blaze="http://blaze.advisor.com/">
      <blaze:customerId>0801199012345</blaze:customerId>
      <blaze:salary>25000.00</blaze:salary>
      <blaze:age>34</blaze:age>
      <blaze:externalScore>750</blaze:externalScore>
      <blaze:productNature>PERSONAL_LOAN</blaze:productNature>
      <blaze:region>HN01</blaze:region>
    </blaze:executeRules>
  </soap:Body>
</soap:Envelope>
```

### Response de RulesManagement (BLAZE)
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <blaze:executeRulesResponse xmlns:blaze="http://blaze.advisor.com/">
      <blaze:offers>
        <blaze:offer>
          <blaze:productCode>PERSONAL_LOAN</blaze:productCode>
          <blaze:maxAmount>500000.00</blaze:maxAmount>
          <blaze:rate>12.50</blaze:rate>
          <blaze:term12>450000.00</blaze:term12>
          <blaze:term24>400000.00</blaze:term24>
          <blaze:term36>350000.00</blaze:term36>
        </blaze:offer>
      </blaze:offers>
    </blaze:executeRulesResponse>
  </soap:Body>
</soap:Envelope>
```

## Cadenas de conexión detectadas y credenciales

### Base de Datos - DataWareHouseHN
- **Nombre de la Base de Datos**: DataWareHouseHN
- **Stored Procedure**: consulta_ONBASE_V2
- **Esquema**: ONBASE_V2
- **Package**: No especificado
- **Connection String**: Referenciado como DataWareHouseHN_BS (Business Service)

### Servicios WSDL - RulesManagement
- **Endpoint WSDL**: RulesManagement/RequestorServices/ProxyServices/v1.0/GetCreditOffers
- **Operación**: getCreditOffers
- **Binding**: SOAP 1.1
- **Transport**: HTTP

### Servicios WSDL - BLAZE Integration
- **Endpoint**: Configurado dinámicamente a través de BLAZE Advisor
- **Operación**: executeRules
- **Protocolo**: SOAP/HTTP

## Tablas de mapeo de entrada por cada llamada a servicio dependiente

### Mapeo OSB → DataWareHouseHN (consulta_ONBASE_V2)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (servicio interno) |
|-------------------|----------------------|----------------------------------|
| legalId | fn:data($body/get1:getConsolidatedCustomerRisk_params/get1:legalId) | PV_CEDULA |
| Nit | fn:data($body/get1:getConsolidatedCustomerRisk_params/get1:Nit) | PV_NIT |
| FirstName | fn:data($body/get1:getConsolidatedCustomerRisk_params/get1:FirstName) | PV_NOMBRE |
| LastName | fn:data($body/get1:getConsolidatedCustomerRisk_params/get1:LastName) | PV_APELLIDO |
| BirthDate | fn:data($body/get1:getConsolidatedCustomerRisk_params/get1:BirthDate) | PV_FECHA_NACIMIENTO |
| ApplicationId | fn:data($body/get1:getConsolidatedCustomerRisk_params/get1:ApplicationId) | PV_CODIGO_APLICACION |

### Mapeo OSB → RulesManagement (BLAZE)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (servicio interno) |
|-------------------|----------------------|----------------------------------|
| CustomerInfo/Id | fn:data($body/cred:getCreditOffersRequest/cred:CustomerInfo/cred:Id) | customerId |
| CustomerInfo/TotalSalary | fn:data($body/cred:getCreditOffersRequest/cred:CustomerInfo/cred:TotalSalary) | salary |
| CustomerInfo/Age | fn:data($body/cred:getCreditOffersRequest/cred:CustomerInfo/cred:Age) | age |
| ExternalScore | fn:data($body/cred:getCreditOffersRequest/cred:ExternalScore) | externalScore |
| ProductNature | fn:data($body/cred:getCreditOffersRequest/cred:ProductNature) | productNature |
| GeneralInfo/SourceBank | fn:data($body/cred:getCreditOffersRequest/cred:GeneralInfo/com:SourceBank) | region |

## Tablas de mapeo de salida por cada respuesta de servicio dependiente

### Mapeo DataWareHouseHN → OSB Response

| Campo Origen (servicio interno) | Transformación/Script | Campo Destino (OSB) |
|--------------------------------|----------------------|-------------------|
| PV_CODIGO_ERROR | if($response/ns1:PV_CODIGO_ERROR = 'SUCCESS') then 'SUCCESS' else 'ERROR' | StatusInfo/SuccessIndicator |
| PV_DESCRIPCION_ERROR | fn:data($response/ns1:PV_DESCRIPCION_ERROR) | StatusInfo/Messages |
| PV_SCORE_EXTERNO | fn:data($response/ns1:PV_SCORE_EXTERNO) | GetConsolidatedCustomerRisk/LoanMaintenance/CustomerInfo/ExternalScore |
| PV_CALIFICACION | fn:data($response/ns1:PV_CALIFICACION) | GetConsolidatedCustomerRisk/LoanMaintenance/CustomerInfo/ScoreInfo/Qualification |
| PV_NIVEL_RIESGO | fn:data($response/ns1:PV_NIVEL_RIESGO) | GetConsolidatedCustomerRisk/LoanMaintenance/CustomerInfo/ScoreInfo/RiskLevel |
| PV_SALARIO | fn:data($response/ns1:PV_SALARIO) | GetConsolidatedCustomerRisk/LoanMaintenance/CustomerInfo/Salary |
| PV_EDAD | fn:data($response/ns1:PV_EDAD) | GetConsolidatedCustomerRisk/LoanMaintenance/CustomerInfo/Age |

### Mapeo RulesManagement (BLAZE) → OSB Response

| Campo Origen (servicio interno) | Transformación/Script | Campo Destino (OSB) |
|--------------------------------|----------------------|-------------------|
| offers/offer/productCode | fn:data($blazeResponse/blaze:offers/blaze:offer/blaze:productCode) | GetCreditOffers/ResolutionOffers/Offer/ProductCode |
| offers/offer/maxAmount | fn:data($blazeResponse/blaze:offers/blaze:offer/blaze:maxAmount) | GetCreditOffers/ResolutionOffers/Offer/MaxOffer |
| offers/offer/rate | fn:data($blazeResponse/blaze:offers/blaze:offer/blaze:rate) | GetCreditOffers/ResolutionOffers/Offer/Rate |
| offers/offer/term12 | fn:data($blazeResponse/blaze:offers/blaze:offer/blaze:term12) | GetCreditOffers/ResolutionOffers/Offer/For12Months |
| offers/offer/term24 | fn:data($blazeResponse/blaze:offers/blaze:offer/blaze:term24) | GetCreditOffers/ResolutionOffers/Offer/For24Months |
| offers/offer/term36 | fn:data($blazeResponse/blaze:offers/blaze:offer/blaze:term36) | GetCreditOffers/ResolutionOffers/Offer/For36Months |

## Reglas de negocio detectadas

### Validación Regional
- **Ubicación**: Pipeline CommonParams stage "Valida Servicio Regional"
- **Regla**: `dvm:lookupValue('CommonResources/DVM/RegionalParameters', 'ServiceName', $serviceName, 'Value', 'Not found',('Name',fn:concat('SourceBank.',$sourceBank,'.DestinationBank.',$destinationBank)))`
- **Condición**: `$dvmValueResponse!='Active'`
- **Acción**: Error MW-0003 "INVALID REGION REQUEST"

### Asignación de Códigos de Servicio
- **Ubicación**: Pipeline CommonParams stage
- **Reglas**:
  - getConsolidatedCustomerRisk: `'3'`
  - getCreditOffers: `'8'`
  - getCustomerSecondOffer: `'43'`
  - refGetCustomerOffer: `'8'`

### Manejo de DestinationBank
- **Ubicación**: Pipeline CommonParams stage
- **Regla**: 
```xquery
if($body/*/GeneralInfo/com:DestinationBank)
then
  if(fn:data($body/*/GeneralInfo/com:DestinationBank)!='') then
    fn:data($body/*/GeneralInfo/com:DestinationBank)
  else
    fn:data($body/*/GeneralInfo/com:SourceBank)
else
  fn:data($body/*/GeneralInfo/com:SourceBank)
```

### Generación de UUID
- **Ubicación**: Pipeline request-N3f5776ff.N1b0c9075.0.18061bcda9a.N7ffd
- **Regla**:
```xquery
if (fn:data($body/cred:getCreditOffersRequest/cred:GeneralInfo/com:GlobalId)!='')
then
  fn:data($body/cred:getCreditOffersRequest/cred:GeneralInfo/com:GlobalId)
else
  fn-bea:uuid()
```

### Mapeo de Códigos de Error HTTP
- **Ubicación**: Pipeline response stages "FlujoSalida"
- **Regla**: 
```xquery
if($body/*:getCreditOffersResponse/*:ErrorInfo) then
  <http:http-response-code>{fn:data($body/*:getCreditOffersResponse/*:ErrorInfo/com:Code)}</http:http-response-code>
```