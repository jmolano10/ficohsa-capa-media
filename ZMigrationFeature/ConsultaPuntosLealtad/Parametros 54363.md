##### DynamoDB Parameter - Lambda Parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#REWARD_POINTS_ACCOUNT_RETRIEVES#PARAM#available-loyalty-points",
  "sk": "V#0001",
  "name": "available-loyalty-points",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "param-name": "ban-xrs-lc-mastercard-ws-param-wsdl-<env>"
    },
    {
      "region": "GT01-GT01",
      "enabled": true,
      "param-name": "ban-xrs-lc-mastercard-ws-param-wsdl-<env>"
    },
    {
      "region": "NI01-NI01",
      "enabled": true,
      "param-name": "ban-xrs-lc-mastercard-ws-param-wsdl-<env>"
    },
    {
      "region": "PA01-PA01",
      "enabled": true,
      "param-name": "ban-xrs-lc-mastercard-ws-param-wsdl-<env>"
    }
  ],
  "type": "JSON",
  "description": "CONFIG OF REWARD_POINTS_ACCOUNT_RETRIEVES BY METHOD",
  "country": "XRS",
  "domain": "REWARD_POINTS_ACCOUNT_RETRIEVES",
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
"ban-xrs-lc-mastercard-ws-param-wsdl-<dev>"
{
  "ip": "https://192.168.55.21",
  "port": "7021",
  "basePath": "/mastercard-webservices/CustomerService"
}
```

```json
"ban-xrs-lc-mastercard-ws-param-wsdl-<qa>"
{
  "ip": "https://192.168.50.54",
  "port": "7021",
  "basePath": "/mastercard-webservices/CustomerService"
}
```

##### Constantes para almacenar en ConfigMap

```json
{
  "operation": "getPointDetails",
  "operationGt": "getRTRPreferences"
}
```