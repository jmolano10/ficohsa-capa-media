##### 4.1.3.1. DynamoDB - Parámetros regionalización, negocio y conexión:
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#PENSION_FUND_ADMINISTRATION_RETRIEVE#PARAM#RETRIEVE_PENSION_FUNDS",
  "sk": "V#0001",
  "name": "RETRIEVE_PENSION_FUNDS",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "param-name": "ban-hnd-ic-wpr-parm-ficopen-user-<env>",
      "secret-name": "ban-hnd-ic-wpr-secm-ficopen-user-<env>"
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
  "updated_at": "2026-05-25T10:00:00Z",
  "updated_by": "david.j.molano@ficohsa.com"
}
```

##### 4.1.3.2. AWS Systems Manager Parameter Store

**Nombre Parámetro**: `ban-hnd-ic-wpr-parm-ficopen-user-<env>` (Existente)


##### 4.1.3.3. AWS Systems Manager SecretManager

**Nombre Secreto**: `ban-hnd-ic-wpr-secm-ficopen-user-<env>` (Existente)


##### 4.1.3.4. Constantes para almacenar en ConfigMap

```json
{
  "caller-service": "PENSION_FUND_ADMINISTRATION_RETRIEVE-PRODUCT-RETRIEVE_PENSION_FUNDS",
  "operation": "query",
  "path": "/api/v2/clientes/fondos/pensiones"
}
```
##### 4.1.3.5. Request ejemplo para consumir el Wrapper FICOPEN - Método 7: POST - /market-operations/pension-fund-administration-retrieve/v1/retrieve-pension-funds
```json
{
  "operation": "query",
  "path": "/api/v2/clientes/fondos/pensiones?codigoTipoIdentificacion={data.identificationType}&numeroIdentificacion={data.customerReference}&codigoCliente={data.customerCode}",
  "paramName": "ban-hnd-ic-wpr-parm-ficopen-user-<env>",
  "secretName": "ban-hnd-ic-wpr-secm-ficopen-user-<env>"
}
```

##### 4.1.3.6 Ejemplo uso de librería para envío a logs

**Request**
```json
{
  "transactionDate": "2026-05-25T10:15:00.000Z",
  "pod": "local",
  "logLevel": "INFO",
  "message": "Incoming request: POST /market-operations/pension-fund-administration-retrieve/v1/retrieve-pension-funds",
  "correlationId": "{header.correlation-Id}",
  "layer": "api-product",
  "version": "1.0.0",
  "bianMethodName": "retrieve-pension-funds",
  "logType": "Req",
  "environment": "dev",
  "applicationId": "{header.application-Id}",
  "serviceName": "ms-ii-pfa-pension_fund_admin_retrieve-product",
  "sourceBank": "HN01",
  "channel": "{header.channel}",
  "callerService": "PENSION_FUND_ADMINISTRATION_RETRIEVE-PRODUCT-RETRIEVE_PENSION_FUNDS",
  "data": {
    "httpMethod": "POST",
    "url": "/market-operations/pension-fund-administration-retrieve/v1/retrieve-pension-funds",
    "timestampRequest": "2026-05-25T10:15:00.000Z",
    "requestBody": {
      "data": {
        "identificationType": "1",
        "customerReference": "0801199012345",
        "customerCode": "CLI-001234"
      }
    }
  },
  "maskfields": ["customerReference/m_id", "customerCode/m_id"]
}
```

**Response**

```json
{
  "transactionDate": "2026-05-25T10:15:01.513Z",
  "logLevel": "INFO",
  "message": "Outbound response: POST .../v1/retrieve-pension-funds - 200 1513ms",
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
    "identificationNumber": "string",
    "customerCode": "string",
    "accountCode": "string"
  },
  "maskfields": [
    "identificationNumber/m_id",
    "customerCode/m_id",
    "accountCode/m_account"
  ]
}
```
