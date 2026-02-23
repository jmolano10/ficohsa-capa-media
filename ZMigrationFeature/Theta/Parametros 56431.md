##### DynamoDB Parameter - Lambda Parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#REGULATORY_COMPLIANCE_ADMIN#PARAM#evaluate-customer-check",
  "sk": "V#0001",
  "name": "evaluate-customer-check",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": false
    },
    {
      "region": "GT01-GT01",
      "enabled": true,
      "param-name": "ban-xrs-ic-comp-param-thetaray-rest-<env>",
      "caseStatusUrl": "/regulations-and-compliance/regulatory-compilance-retrieves/v1/retrieve-status-extended"
    },
    {
      "region": "NI01-NI01",
      "enabled": true,
      "param-name": "ban-xrs-ic-comp-param-thetaray-rest-<env>",
      "caseStatusUrl": "/regulations-and-compliance/regulatory-compilance-retrieves/v1/retrieve-status-extended"
    },
    {
      "region": "PA01-PA01",
      "enabled": false
    }
  ],
  "type": "JSON",
  "description": "CONFIG OF REGULATORY_COMPLIANCE_ADMIN BY METHOD",
  "country": "XRS",
  "domain": "REGULATORY_COMPLIANCE_ADMIN",
  "tags": [],
  "precedence": 10,
  "effective_from": "",
  "effective_to": "",
  "status": "active",
  "updated_at": "2025-12-19T18:10:00Z",
  "updated_by": "eudis.perdomo@ficohsa.com"
}
```
##### AWS Systems Manager Parameter Store

```json
"ban-xrs-ic-comp-param-thetaray-rest-<env>"
{
  "basePath": "https://apps-pre-screening.ficohsa.thetaray.cloud"
}
```
##### AWS Systems Manager SecretManager


##### Constantes para almacenar en ConfigMap

```json
{
  "path": "/screening/customer/check"
}
```
##### Registro en BD Dynamo ban-xrs-rc-ddb-transactions-thetaray-<env> para control de transacciones

```json
//REGISTRO EN DYNAMODB TRANSACTIONS THETARAY
{
  "headers": {
      "Source-Bank": "HN01",
      "Destination-Bank": "HN01",
      "CorrelationId": "e1b3b0a7-8a8c-4e4b-9b2e-5c4cd7a1f3b1",
      "Application-Id": "123456",
      "Application-User": "User 1",
      "Caller-Service": "Caller Service",
      "Channel": "MOBILE",
      "Transaction-Date": "2024-03-29T12:00:00Z",
      "Accept-Language": "es"
  },
  "status": "RECEIVED | SYNC_COMPLETED | RESOLVED | FINISHED_ERROR ",
  "origin": "CHECK | BULK",
  "statusCallback": " | PENDING | COMPLETED",
  "requestReference": "582d1c1c-57c8-496a-b6f4-17c8212c552a",
  "customer": {
      "customerReference": "0ac8ba6f-2ed2-453f-9073-20b8481f40ad",
      "customerType": "individual",
      "customerName": "John Doe",
      "identityDocuments": [
          {
              "number": 123456789
          }
      ],
      "nationalities": [
          "US"
      ],
      "customerAddresses": [
          "New York, USA"
      ]
  },
  "screeningProfile": "DEFAULT",
  "saveForRescreening": false,
  "rescreeningProfiles": [
      "CUSTOM1",
      "CUSTOM2"
  ],
  "screeningResultContainer": {
    "screeningOutcome": "MATCH | NO_MATCH | FAILED",
    "resolution": "APROVED | BLOCK |"
  }
}
```