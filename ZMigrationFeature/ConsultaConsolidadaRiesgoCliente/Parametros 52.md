##### DynamoDB Parameter - Librería de parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#RETRIEVE_CUSTOMER_RISK#PARAM#RETRIEVE",
  "sk": "V#0001",
  "name": "RETRIEVE",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "param-name": "ban-hnd-ic-comp-parm-retrieve-customer-risk-osb-wsdl-dev",
      "secret-name": "ban-hnd-ic-comp-secm-retrieve-customer-risk-osb-wsdl-dev"
    },
    {
      "region": "GT01-GT01",
      "enabled": false,
      "param-name": "ban-gtm-ic-comp-parm-retrieve-customer-risk-osb-wsdl-dev",
      "secret-name": "ban-gtm-ic-comp-secm-retrieve-customer-risk-osb-wsdl-dev"
    },
    {
      "region": "NI01-NI01",
      "enabled": false,
      "param-name": "ban-nic-ic-comp-parm-retrieve-customer-risk-osb-wsdl-dev",
      "secret-name": "ban-nic-ic-comp-secm-retrieve-customer-risk-osb-wsdl-dev"
    },
    {
      "region": "PA01-PA01",
      "enabled": false
    }
  ],
  "type": "JSON",
  "description": "CONFIG OF RETRIEVE_CUSTOMER_RISK BY METHOD",
  "country": "XRS",
  "domain": "RETRIEVE_CUSTOMER_RISK",
  "tags": [],
  "precedence": 10,
  "effective_from": "",
  "effective_to": "",
  "status": "active",
  "updated_at": "2025-12-19T18:10:00Z",
  "updated_by": "david.j.molano@ficohsa.com"
}
```
##### AWS Systems Manager Parameter Store

```json
"ban-hnd-ic-comp-parm-retrieve-customer-risk-osb-wsdl-dev"
{
  "host": "172.23.177.130",
  "port": "8004",
  "basepath": "/Middleware/RiskAndCompliance/RegulationsAndCompliance/ConsultaConsolidadaRiesgoCliente"
}
```

```json
"ban-hnd-ic-comp-parm-retrieve-customer-risk-osb-wsdl-stg"
{
  "host": "https://mwomniqa",
  "port": "8006",
  "basepath": "/Middleware/RiskAndCompliance/RegulationsAndCompliance/ConsultaConsolidadaRiesgoCliente"
}
```

```json
"ban-gtm-ic-comp-parm-retrieve-customer-risk-osb-wsdl-dev"
{
  "host": "172.23.177.130",
  "port": "8004",
  "basepath": "/Middleware/RiskAndCompliance/RegulationsAndCompliance/ConsultaConsolidadaRiesgoCliente"
}
```

```json
"ban-gtm-ic-comp-parm-retrieve-customer-risk-osb-wsdl-stg"
{
  "host": "https://mwomniqa",
  "port": "8006",
  "basepath": "/Middleware/RiskAndCompliance/RegulationsAndCompliance/ConsultaConsolidadaRiesgoCliente"
}
```

```json
"ban-nic-ic-comp-parm-retrieve-customer-risk-osb-wsdl-dev"
{
  "host": "https://dynamoohsdev",
  "port": "9030",
  "basepath": "v1.0/credit-management "
}
```

```json
"ban-nic-ic-comp-parm-retrieve-customer-risk-osb-wsdl-stg"
{
  "host": "https://regionalFicohsa.......",
  "port": "8006",
  "basepath": "/Middleware/RiskAndCompliance/RegulationsAndCompliance/ConsultaConsolidadaRiesgoCliente"
}
```


##### AWS Systems Manager SecretManager

```json
"ban-hnd-ic-comp-secm-retrieve-customer-risk-osb-wsdl-dev"
{
  "user": "srv-itintb",
  "password": "Helios2k12$"
}
```

```json
"ban-gtm-ic-comp-secm-retrieve-customer-risk-osb-wsdl-dev"
{
  "user": "srv-itintb",
  "password": "Helios2k12$"
}
```

```json
"ban-nic-ic-comp-secm-retrieve-customer-risk-osb-wsdl-dev"
{
  "user": "",
  "password": ""
}
```

##### Constantes para almacenar en ConfigMap

```json
{
  "operationHnd": "ConsultaConsolidadaRiesgoCliente",
  "operationGtm": "ConsultaConsolidadaRiesgoCliente",
  "operationNic": "getConsolidatedCustomerRisk"
}
```
##### Request ejemplo consumos a servicios OSB

**Request ejemplo para ConsultaConsolidadaRiesgoCliente Honduras**

```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:RequestHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <Authentication>
        <UserName>usuario_sistema</UserName>
        <Password>password_sistema</Password>
      </Authentication>
      <SourceBank>HN01</SourceBank>
      <ServiceId>FICBCO0398</ServiceId>
    </aut:RequestHeader>
  </soap:Header>
  <soap:Body>
    <tns:consultaConsolidadaRiesgoCliente xmlns:tns="http://www.ficohsa.com.hn/middleware.services/consultaConsolidadaRiesgoClienteTypes">
      <CUSTOMER_LEGAL_ID>0801199012345</CUSTOMER_LEGAL_ID>
    </tns:consultaConsolidadaRiesgoCliente>
  </soap:Body>
</soap:Envelope>
```

**Request ejemplo para ConsultaConsolidadaRiesgoCliente Guatemala**
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:RequestHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <Authentication>
        <UserName>usuario_gt</UserName>
        <Password>password123</Password>
      </Authentication>
      <Region>
        <SourceBank>GT01</SourceBank>
      </Region>
    </aut:RequestHeader>
  </soap:Header>
  <soap:Body>
    <con:consultaConsolidadaRiesgoCliente xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaConsolidadaRiesgoClienteTypes">
      <CUSTOMER_LEGAL_ID>1234567890123</CUSTOMER_LEGAL_ID>
      <FISCAL_ID>12345678</FISCAL_ID>
      <FIRST_NAME>JUAN</FIRST_NAME>
      <LAST_NAME>PEREZ</LAST_NAME>
      <BIRTH_DATE>1985-05-15</BIRTH_DATE>
      <USER_NAME>usuario_gt</USER_NAME>
      <PERSON_TYPE>F</PERSON_TYPE>
      <PRODUCT_CODE>CREDITO</PRODUCT_CODE>
    </con:consultaConsolidadaRiesgoCliente>
  </soap:Body>
</soap:Envelope>
```

**Request ejemplo para ConsultaConsolidadaRiesgoCliente Nicaragua**
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

##### Response ejemplo consumos a servicios OSB

**Response ejemplo de ConsultaConsolidadaRiesgoCliente Honduras**
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <successIndicator>Success</successIndicator>
      <messages>Consulta exitosa</messages>
    </aut:ResponseHeader>
  </soap:Header>
  <soap:Body>
    <tns:consultaConsolidadaRiesgoClienteResponse xmlns:tns="http://www.ficohsa.com.hn/middleware.services/consultaConsolidadaRiesgoClienteTypes">
      <LOAN_MAINTENANCE>
        <CUSTOMER_INFO>
          <ID>0801199012345</ID>
          <TARGET>PREMIUM</TARGET>
          <DATE_OF_BIRTH>1990-01-01</DATE_OF_BIRTH>
          <AGE>34</AGE>
          <TYPE>PERSONA_NATURAL</TYPE>
          <SALARY>50000.00</SALARY>
          <PAYROLL_SALARY>45000.00</PAYROLL_SALARY>
          <CREDIT_MONTHS>12</CREDIT_MONTHS>
          <FLAG_BLAZE>Y</FLAG_BLAZE>
          <FLAG_HIT>N</FLAG_HIT>
          <EVALUATION_RESULT>APROBADO</EVALUATION_RESULT>
          <EXTERNAL_SCORE>750.0</EXTERNAL_SCORE>
          <SCORE_INFO>
            <SCORE_CALCULATION>720.5</SCORE_CALCULATION>
            <QUALIFICATION>A</QUALIFICATION>
            <RISK_LEVEL>BAJO</RISK_LEVEL>
          </SCORE_INFO>
          <ASSETS>
            <ASSET>
              <NUMBER>1234567890</NUMBER>
              <CATEGORY>AHORRO</CATEGORY>
              <CURRENCY>HNL</CURRENCY>
              <OPENING_DATE>2020-01-15</OPENING_DATE>
              <CURRENT_BALANCE>25000.50</CURRENT_BALANCE>
              <END_OF_MONTH_BALANCE>24500.00</END_OF_MONTH_BALANCE>
              <AVERAGE_BALANCE>23000.00</AVERAGE_BALANCE>
            </ASSET>
          </ASSETS>
          <LIABILITIES>
            <CREDIT_CARDS_INFO>
              <CREDIT_CARD>
                <ACCOUNT>4567890123456789</ACCOUNT>
                <BEHAVIOR_SCORE>680.0</BEHAVIOR_SCORE>
                <QUALIFICATION_SCORE>B</QUALIFICATION_SCORE>
                <STATUS>ACTIVA</STATUS>
                <CURRENT_LIMIT>100000.00</CURRENT_LIMIT>
                <CURRENT_BALANCE>15000.00</CURRENT_BALANCE>
                <AVAILABLE_CASH>85000.00</AVAILABLE_CASH>
              </CREDIT_CARD>
            </CREDIT_CARDS_INFO>
            <LOANS_INFO>
              <LOAN>
                <NUMBER>PTM-2023-001234</NUMBER>
                <OPENING_DATE>2023-01-15</OPENING_DATE>
                <INITIAL_AMOUNT>200000.00</INITIAL_AMOUNT>
                <CURRENT_BALANCE>150000.00</CURRENT_BALANCE>
                <PAYMENT_AMOUNT>5500.00</PAYMENT_AMOUNT>
                <RATE>12.5</RATE>
                <TERM>36.0</TERM>
              </LOAN>
            </LOANS_INFO>
          </LIABILITIES>
        </CUSTOMER_INFO>
      </LOAN_MAINTENANCE>
      <LOAN_ORIGINATIONS>
        <PRE_APPROVED_OFFERS>
          <OFFER>
            <TYPE>FICOCREDITO</TYPE>
            <DETAILS>
              <FOR_12_MONTHS>50000.00</FOR_12_MONTHS>
              <FOR_24_MONTHS>75000.00</FOR_24_MONTHS>
              <FOR_36_MONTHS>100000.00</FOR_36_MONTHS>
            </DETAILS>
            <INSTALLMENT>3500.00</INSTALLMENT>
            <RATE>15</RATE>
            <TIMES_INCOME>2</TIMES_INCOME>
          </OFFER>
        </PRE_APPROVED_OFFERS>
      </LOAN_ORIGINATIONS>
    </tns:consultaConsolidadaRiesgoClienteResponse>
  </soap:Body>
</soap:Envelope>
```

**Response ejemplo de ConsultaConsolidadaRiesgoCliente Guatemala**
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <successIndicator>Success</successIndicator>
    </aut:ResponseHeader>
  </soap:Header>
  <soap:Body>
    <con:consultaConsolidadaRiesgoClienteResponse xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaConsolidadaRiesgoClienteTypes">
      <LOAN_MAINTENANCE>
        <CUSTOMER_INFO>
          <ID>1234567890123</ID>
          <FISCAL_ID>12345678</FISCAL_ID>
          <FIRST_NAME>JUAN</FIRST_NAME>
          <LAST_NAME>PEREZ</LAST_NAME>
          <DATE_OF_BIRTH>1985-05-15</DATE_OF_BIRTH>
          <AGE>38</AGE>
          <TYPE>PERSONA_FISICA</TYPE>
          <SALARY>15000.00</SALARY>
          <FLAG_BLAZE>Y</FLAG_BLAZE>
          <ADDRESSES_INFO>
            <ADDRESS_ITEM>
              <ADDRESS>ZONA 10, GUATEMALA CITY</ADDRESS>
            </ADDRESS_ITEM>
          </ADDRESSES_INFO>
          <PHONES_INFO>
            <PHONE_ITEM>
              <PHONE>50212345678</PHONE>
            </PHONE_ITEM>
          </PHONES_INFO>
          <EXTERNAL_SCORE>750.5</EXTERNAL_SCORE>
          <LIABILITIES>
            <CREDIT_CARDS_INFO>
              <CREDIT_CARD>
                <ACCOUNT>4111111111111111</ACCOUNT>
                <BEHAVIOR_SCORE>720.0</BEHAVIOR_SCORE>
                <QUALIFICATION_SCORE>A</QUALIFICATION_SCORE>
                <STATUS>ACTIVA</STATUS>
                <CURRENT_LIMIT>50000.00</CURRENT_LIMIT>
                <CURRENT_BALANCE>15000.00</CURRENT_BALANCE>
              </CREDIT_CARD>
            </CREDIT_CARDS_INFO>
            <LOANS_INFO>
              <LOAN>
                <AGENCY_CODE>001</AGENCY_CODE>
                <INITIAL_AMOUNT>100000.00</INITIAL_AMOUNT>
                <CURRENT_BALANCE>75000.00</CURRENT_BALANCE>
                <RATE>12.5</RATE>
              </LOAN>
            </LOANS_INFO>
          </LIABILITIES>
          <REFERENCIA_SIB>GT123456789</REFERENCIA_SIB>
        </CUSTOMER_INFO>
      </LOAN_MAINTENANCE>
      <LOAN_ORIGINATIONS>
        <REFERENCES_DETAILS>
          <QUERIES>
            <QUERY_ITEM>
              <DATE>2023-10-15</DATE>
              <ENTITY>BANCO_INDUSTRIAL</ENTITY>
              <TYPE>CREDITO</TYPE>
              <MOTIVE>EVALUACION</MOTIVE>
            </QUERY_ITEM>
          </QUERIES>
          <REFERENCE_BUREAU_TUCA>
            <REFERENCE>
              <CREDITOR>BANCO_INDUSTRIAL</CREDITOR>
              <CREDIT_TYPE>PERSONAL</CREDIT_TYPE>
              <BALANCE>25000.00</BALANCE>
              <STATUS>VIGENTE</STATUS>
            </REFERENCE>
          </REFERENCE_BUREAU_TUCA>
          <REFERENCE_BUREAU_SIRC>
            <REFERENCE>
              <CREDITOR>BANCO_AGROMERCANTIL</CREDITOR>
              <ASSET_TYPE>PRESTAMO</ASSET_TYPE>
              <BALANCE>50000.00</BALANCE>
              <STATUS>VIGENTE</STATUS>
            </REFERENCE>
          </REFERENCE_BUREAU_SIRC>
        </REFERENCES_DETAILS>
      </LOAN_ORIGINATIONS>
    </con:consultaConsolidadaRiesgoClienteResponse>
  </soap:Body>
</soap:Envelope>
```

**Response ejemplo de  ConsultaConsolidadaRiesgoCliente Nicaragua**
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