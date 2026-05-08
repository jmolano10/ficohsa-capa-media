##### DynamoDB Parameter - Librería de parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#CORRESPONDENT_BANKING#PARAM#INITIATE_CASH_WITHDRAWAL",
  "sk": "V#0001",
  "name": "INITIATE_CASH_WITHDRAWAL",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      // HU 7761, 7035, 62887
      "transactionTypeT24": 4,
      // HU 7034, 62321
      "transactionType": "1",
      "commissionReferenceT24": "", 
      "channelCode": "1", 
      "transactionStatus": "REGISTRADO",
      "reversalTransactionReferenceT24": "",
      "transactionReferenceT24": "", 
      // HU 6294
      "operationCode": "1",
      // HU 62321
      "transactionTypeUpdate": "RETIRO",
      "queryType": "1",
      "updateType": "RETIRO"
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
  "description": "CONFIG OF CORRESPONDENT_BANKING BY METHOD",
  "country": "XRS",
  "domain": "CORRESPONDENT_BANKING",
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
  "caller-service":  "CORRESPONDENT_BANKING-SYSTEM-INITIATE_CASH_WITHDRAWAL"
}
```
