##### DynamoDB Parameter - Lambda Parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#HND#DOMAIN#CREDIT_CARD_OPERATIONS#PARAM#UPDATE_PURCHASE_REVERSAL",
  "sk": "V#0001",
  "name": "UPDATE_PURCHASE_REVERSAL",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "param-name": "ban-hnd-lc-ccard-parm-otws-v4-wsdl-<env>"
    },
    {
      "region": "GT01-GT01",
      "enabled": true,
      "param-name": "ban-gtm-lc-ccard-parm-otws-v4-wsdl-<env>"
    },
    {
      "region": "NI01-NI01",
      "enabled": true,
      "param-name": "ban-nic-lc-ccard-parm-otws-v4-wsdl-<env>"
    },
    {
      "region": "PA01-PA01",
      "enabled": true,
      "param-name": "ban-pan-lc-ccard-parm-otws-v4-wsdl-<env>"
    }
  ],
  "type": "JSON",
  "description": "CONFIG OF CREDIT_CARD_OPERATIONS BY METHOD",
  "country": "HND",
  "domain": "CREDIT_CARD_OPERATIONS",
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
"ban-hnd-lc-ccard-parm-vision-plus-otws-v4-wsdl-dev"
{
  "ip": "http://172.28.1.146",
  "port": "7802",
  "basePath": "/OTWS/v4 "
}
```

```json
"ban-gtm-lc-ccard-parm-vision-plus-otws-v4-wsdl-dev"
{
  "ip": "172.28.1.146",
  "port": "7802",
  "basePath": "/OTWS/v4 "
}
```

```json
"ban-nic-lc-ccard-parm-vision-plus-otws-v4-wsdl-dev"
{
  "ip": "172.28.1.146",
  "port": "7802",
  "basePath": "/OTWS/v4 "
}
```

```json
"ban-pan-lc-ccard-parm-vision-plus-otws-v4-wsdl-dev"
{
  "ip": "172.28.1.146",
  "port": "7802",
  "basePath": "/OTWS/v4 "
}
```

##### AWS Systems Manager SecretManager


##### Constantes para almacenar en ConfigMap

```json
{
  "operationHN": "OnlineUpdateCard",
  "operationGT": "OnlineUpdateCard",
  "operationNI": "OnlineUpdateCard",
  "operationPA": "OnlineUpdateCard",
  "caller-service": "credit-card-operations-product-update-purchase-reversal"
}
```

##### Registro en Dynamo Componente de idempotencia

##### Ejemplo del request para consumo API Idempotencia

##### Ejemplo mensaje en Event Brigde para componente de Idempotencia

##### Ejemplo request consumo operacion OnlineUpdateCard Vision Plus
```xml

```

