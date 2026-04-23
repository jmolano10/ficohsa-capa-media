##### DynamoDB Parameter - Librería de parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#EXECUTE_REVERSION#PARAM#EXECUTE",
  "sk": "V#0001",
  "name": "EXECUTE",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      // Consumo API 62348
      "codigoEstado": "0",
      // Evento API 62351
      "errorCode": 0,
      "errorMessage": "temp",
      // Consumo API 62319
      "statusType": "R",
      // Consumo API 62320
      "coreTransactionReference": "", 
      "interceptorIndicator": "3"
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
  "description": "CONFIG OF EXECUTE_REVERSION BY METHOD",
  "country": "XRS",
  "domain": "EXECUTE_REVERSION",
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


##### AWS Systems Manager SecretManager


##### Constantes para almacenar en ConfigMap

```json
{
  "caller-service":  "EXECUTE_REVERSION-COMP-EXECUTE"
}
```


---