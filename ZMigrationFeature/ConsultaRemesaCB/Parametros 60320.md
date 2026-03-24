##### DynamoDB Parameter - Lambda Parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#CORRESPONDENT_BANK_REMITTANCES#PARAM#RETRIEVE",
  "sk": "V#0001",
  "name": "RETRIEVE",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "param-name": "ban-xrs-ic-comp-parm-retrieve-remittance-osb-wsdl-dev",
      "secret-name": "ban-xrs-ic-comp-secm-retrieve-remittance-osb-wsdl-dev"
    },
    {
      "region": "GT01-GT01",
      "enabled": false
    },
    {
      "region": "NI01-NI01",
      "enabled": false
    },
    {
      "region": "PA01-PA01",
      "enabled": false
    }
  ],
  "type": "JSON",
  "description": "CONFIG OF CORRESPONDENT_BANK_REMITTANCES BY METHOD",
  "country": "XRS",
  "domain": "CORRESPONDENT_BANK_REMITTANCES",
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
"ban-xrs-ic-comp-parm-retrieve-remittance-osb-wsdl-dev"
{
  "host": "172.23.177.15",
  "port": "8004",
  "basepath": "Middleware/OperationsAndExecution/Payments/ConsultaRemesas_v2"
}
```

##### AWS Systems Manager SecretManager

```json
"ban-xrs-ic-comp-secm-retrieve-remittance-osb-wsdl-dev"
{
  "user": "srv-itintb",
  "password": "Helios2k12$"
}
```

##### Constantes para almacenar en ConfigMap

```json
{
  "operation": "consultaRemesas"
}
```
##### Request ejemplo consumo Servicio Proxy OSB (SOAP) ConsultaRemesas

**Consulta por ID de Remesa**
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:cons="http://www.ficohsa.com.hn/middleware.services/consultaRemesasTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>USRHNDEMO</UserName>
            <Password>password123</Password>
         </Authentication>
         <Region>
            <SourceBank>HN01</SourceBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <cons:consultaRemesas>
         <REMITTANCE_ID>REM123456789</REMITTANCE_ID>
      </cons:consultaRemesas>
   </soapenv:Body>
</soapenv:Envelope>
```

 **Consulta por Nombres**
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:cons="http://www.ficohsa.com.hn/middleware.services/consultaRemesasTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>USRHNDEMO</UserName>
            <Password>password123</Password>
         </Authentication>
         <Region>
            <SourceBank>HN01</SourceBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <cons:consultaRemesas>
         <REMITTER_FIRSTNAME>JUAN</REMITTER_FIRSTNAME>
         <REMITTER_FIRSTSURNAME>PEREZ</REMITTER_FIRSTSURNAME>
         <BENEFICIARY_FIRSTNAME>MARIA</BENEFICIARY_FIRSTNAME>
         <BENEFICIARY_FIRSTSURNAME>LOPEZ</BENEFICIARY_FIRSTSURNAME>
      </cons:consultaRemesas>
   </soapenv:Body>
</soapenv:Envelope>
```

**Response OSB (Ejemplo JSON/XML)**

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                  xmlns:cons="http://www.ficohsa.com.hn/middleware.services/consultaRemesasTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>SUCCESS</successIndicator>
         <messages>Consulta exitosa</messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <cons:consultaRemesasResponse>
         <consultaRemesasResponseType>
            <consultaRemesasResponseRecordType>
               <REMITTANCE_ID>REM123456789</REMITTANCE_ID>
               <REMITTER_ID>RMT001</REMITTER_ID>
               <REMITTER_NAME>JUAN CARLOS PEREZ MARTINEZ</REMITTER_NAME>
               <BENEFICIARY_NAME>MARIA ELENA LOPEZ GARCIA</BENEFICIARY_NAME>
               <BRANCH_NAME>SUCURSAL TEGUCIGALPA</BRANCH_NAME>
               <PAYMENT_DATE>2024-01-15</PAYMENT_DATE>
               <CURRENCY>HNL</CURRENCY>
               <EXCHANGE_RATE>24.75</EXCHANGE_RATE>
               <REMITTANCE_STATUS>DISPONIBLE</REMITTANCE_STATUS>
               <REMITTANCE_AMOUNT>2500.00</REMITTANCE_AMOUNT>
               <REMITTANCE_SOURCE_AMOUNT>100.00</REMITTANCE_SOURCE_AMOUNT>
               <ORIGIN_COUNTRY>USA</ORIGIN_COUNTRY>
            </consultaRemesasResponseRecordType>
         </consultaRemesasResponseType>
      </cons:consultaRemesasResponse>
   </soapenv:Body>
</soapenv:Envelope>
```