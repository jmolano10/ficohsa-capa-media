##### 4.1.3.1. DynamoDB - Parámetros regionalización, negocio y conexión:
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#PENSION_FUND_ADMINISTRATION_RETRIEVE#PARAM#RETRIEVE_FUND_WITHDRAWAL",
  "sk": "V#0001",
  "name": "RETRIEVE_FUND_WITHDRAWAL",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "param-name": "ban-xrs-ic-wpr-parm-ficopen-user-<env>",
      "secret-name": "ban-xrs-ic-wpr-secm-ficopen-user-<env>"
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
  "type": "list",
  "description": "CONFIG OF PENSION_FUND_ADMINISTRATION_RETRIEVE BY METHOD",
  "country": "XRS",
  "domain": "PENSION_FUND_ADMINISTRATION_RETRIEVE",
  "tags": [],
  "precedence": 10,
  "effective_from": "",
  "effective_to": "",
  "status": "active",
  "updated_at": "2026-07-17T10:00:00Z",
  "updated_by": "david.j.molano@ficohsa.com"
}
```

##### 4.1.3.2. AWS Systems Manager Parameter Store

**Nombre Parámetro**: `ban-xrs-ic-wpr-parm-ficopen-user-<env>` (Existente)


##### 4.1.3.3. AWS Systems Manager SecretManager

**Nombre Secreto**: `ban-xrs-ic-wpr-secm-ficopen-user-<env>` (Existente)


##### 4.1.3.4. Constantes para almacenar en ConfigMap

```json
{
  "caller-service": "PENSION_FUND_ADMINISTRATION_RETRIEVE-PRODUCT-RETRIEVE_FUND_WITHDRAWAL",
  "operation": "query",
  "path": "/api/v2/retiros"
}
```
##### 4.1.3.5. Request ejemplo para consumir el Wrapper FICOPEN - Método 5: GET - /market-operations/pension-fund-administration-retrieve/v1/retrieve-fund-withdrawal
```json
{
  "operation": "query",
  "path": "/api/v2/retiros?numeroSolicitud={data.requestNumber}&numeroIdentificacion={data.customerReference}",
  "paramName": "ban-xrs-ic-wpr-parm-ficopen-user-<env>",
  "secretName": "ban-xrs-ic-wpr-secm-ficopen-user-<env>"
}
```

##### 4.1.3.6 Ejemplo uso de librería para envío a logs

**Request**
```json
{
  "transactionDate": "2026-03-31T14:27:16.211Z",
  "pod": "local",
  "logLevel": "INFO",
  "message": "Incoming request: POST /market-operations/pension-fund-administration-retrieve/v1/retrieve-fund-withdrawal",
  "correlationId": "{header.correlation-Id}",
  "layer": "api-product",
  "version": "1.0.0",
  "bianMethodName": "retrieve-fund-withdrawal",
  "logType": "Req",
  "environment": "dev",
  "applicationId": "{header.application-Id}",
  "serviceName": "ms-ii-pfa-pension_fund_admin_retrieve-product",
  "sourceBank": "HN01",
  "channel": "{header.channel}",
  "callerService": "PENSION_FUND_ADMINISTRATION_RETRIEVE-PRODUCT-RETRIEVE_FUND_WITHDRAWAL",
  "data": {
    "httpMethod": "POST",
    "url": "/market-operations/pension-fund-administration-retrieve/v1/retrieve-fund-withdrawal",
    "timestampRequest": "2026-03-31T14:27:16.210Z",
    "requestBody": {
      "data": {
        "requestNumber": "123456789",
        "customerReference": "12344412"
      }
    }
  },
  "maskfields": ["data/default"]
}
```

**Response**

```json
{
  "transactionDate": "2026-03-31T15:42:43.023Z",
  "logLevel": "INFO",
  "message": "Outbound response: POST .../v1/retrieve-fund-withdrawal - 200 1513ms",
  "correlationId": "{header.correlation-Id}",
  "layer": "api-product",
  "logType": "Res",
  "environment": "dev",
  "serviceName": "ms-ii-pfa-pension_fund_admin_retrieve-product",
  "data": {
    "httpMethod": "POST",
    "status": 200,
    "providerLatencyMs": 1513,
    "durationMs": 1513,
    "accountNumber": "string",
    "customerName": "string",
    "identificationNumber": "string",
    "amountValue": "string",
    "destinationAccountNumber": "string"

  },
  "maskfields": [
    "accountNumber/default",
    "customerName/default",
    "identificationNumber/default",
    "amountValue/default",
    "destinationAccountNumber/default"
  ]
}
```