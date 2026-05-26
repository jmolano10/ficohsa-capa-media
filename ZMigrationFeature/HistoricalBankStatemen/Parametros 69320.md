##### 4.1.3.1. DynamoDB - Parámetros regionalización, negocio y conexión:
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#PENSION_FUND_ADMIN_INFORMATION#PARAM#RETRIEVE_ACCOUNT_STATUS",
  "sk": "V#0001",
  "name": "RETRIEVE_ACCOUNT_STATUS",
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
  "description": "CONFIG OF PENSION_FUND_ADMIN_INFORMATION BY METHOD",
  "country": "XRS",
  "domain": "PENSION_FUND_ADMIN_INFORMATION",
  "tags": [],
  "precedence": 10,
  "effective_from": "",
  "effective_to": "",
  "status": "active",
  "updated_at": "2026-05-25T10:00:00Z",
  "updated_by": "david.j.molano@ficohsa.com"
}
```

```json
//REGISTRO EN DYNAMODB PARAMETER - COMPONENTE DE HOMOLOGACIÓN (TIPO DE IDENTIFICACIÓN)
{
  "pk": "COUNTRY#XRS#DOMAIN#IDENTIFICATION_TYPE#PARAM#CATALOGATE",
  "sk": "V#0001",
  "name": "CATALOGATE",
  "type": "JSON",
  "description": "CONFIG OF IDENTIFICATION_TYPE BY BACKEND",
  "country": "XRS",
  "domain": "IDENTIFICATION_TYPE",
  "value": [
    {
      "name": "1",
      "description": "Cédula de Ciudadanía",
      "ficopen": "CC",
      "visionPlus": "",
      "abanks": ""
    },
    {
      "name": "2",
      "description": "Carnet",
      "ficopen": "CAR",
      "visionPlus": "",
      "abanks": ""
    },
    {
      "name": "4",
      "description": "Pasaporte",
      "ficopen": "PAS",
      "visionPlus": "",
      "abanks": ""
    },
    {
      "name": "5",
      "description": "NIT - Número de Identificación Tributaria",
      "ficopen": "NIT",
      "visionPlus": "",
      "abanks": ""
    }
  ],
  "status": "active",
  "updated_at": "2026-05-25T10:00:00Z"
}
```

##### 4.1.3.2. AWS Systems Manager Parameter Store

**Nombre Parámetro**: `ban-hnd-ic-wpr-parm-ficopen-user-<env>` (Existente)

```yaml
// DEV: DEVFICOPENBUS
// STG: QAFICOPENBUS
```

##### 4.1.3.3. AWS Systems Manager SecretManager

**Nombre Secreto**: `ban-hnd-ic-wpr-secm-ficopen-user-<env>` (Existente)

```yaml
// DEV: 4UFIdA5Z8ruV8Z9rOHRjO3PLN6B1Scxs
// STG: VwvUMFhmiuzD5gwBWXu6MHV8IchAEsQA
```

##### 4.1.3.4. Constantes para almacenar en ConfigMap

```json
{
  "caller-service": "PENSION_FUND_ADMIN_INFORMATION-PRODUCT-RETRIEVE_ACCOUNT_STATUS",
  "operation": "create",
  "path": "/api/v2/estados-cuentas/historicos"
}
```
##### 4.1.3.5. Request ejemplo para consumir el Wrapper FICOPEN - Método 1: POST - /market-operations/pension-fund-admin-information/v1/retrieve-account-status
```json
{
  "operation": "create",
  "path": "/api/v2/estados-cuentas/historicos",
  "data": {
    "tipoIdentificacion": "<data.identificationType (Homologado)>",
    "numeroIdentificacion": "<data.customerReference>",
    "fechaInicio": "<data.startDate>",
    "fechaFinal": "<data.endDate>"
  },
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
  "message": "Incoming request: POST /market-operations/pension-fund-admin-information/v1/retrieve-account-status",
  "correlationId": "{header.correlation-Id}",
  "layer": "api-product",
  "version": "1.0.0",
  "bianMethodName": "retrieve-account-status",
  "logType": "Req",
  "environment": "dev",
  "applicationId": "{header.application-Id}",
  "serviceName": "ms-ii-pfa-pension_fund_admin_information-prod",
  "sourceBank": "HN01",
  "channel": "{header.channel}",
  "callerService": "PENSION_FUND_ADMIN_INFORMATION-PRODUCT-RETRIEVE_ACCOUNT_STATUS",
  "data": {
    "httpMethod": "POST",
    "url": "/market-operations/pension-fund-admin-information/v1/retrieve-account-status",
    "timestampRequest": "2026-05-25T10:15:00.000Z",
    "requestBody": {
      "data": {
        "identificationType": "1",
        "customerReference": "0801199012345",
        "startDate": "2026-01-01",
        "endDate": "2026-06-30"
      }
    }
  },
  "maskfields": ["customerReference/m_id"]
}
```

**Response**

```json
{
  "transactionDate": "2026-05-25T10:15:02.135Z",
  "logLevel": "INFO",
  "message": "Outbound response: POST .../v1/retrieve-account-status - 200 2135ms",
  "correlationId": "{header.correlation-Id}",
  "layer": "api-product",
  "logType": "Res",
  "environment": "dev",
  "serviceName": "ms-ii-pfa-pension_fund_admin_information-prod",
  "data": {
    "httpMethod": "POST",
    "status": 200,
    "providerLatencyMs": 2135,
    "durationMs": 2135,
    "customerName": "string",
    "customerEmail": "string",
    "customerNumber": "string",
    "accountNumber": "string"
  },
  "maskfields": [
    "customerName/m_name",
    "customerEmail/m_email",
    "customerNumber/m_id",
    "accountNumber/m_account"
  ]
}
```
