##### DynamoDB Parameter - Lambda Parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#HND#DOMAIN#REVERSAL_CARD_PURCHASE#PARAM#EXECUTION",
  "sk": "V#0001",
  "name": "EXECUTION",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "requestType": "R",
      "pOSUserData": "ATX",
      "numberOfInstallments": "00",
      "mCCType": "6010",
      "track2Length": 0000,
      "track2Data": "0000",
      "cardValidationValue": "000"
    },
    {
      "region": "GT01-GT01",
      "enabled": true,
      "requestType": "R",
      "pOSUserData": "ATX",
      "numberOfInstallments": "00",
      "mCCType": "6010",
      "track2Length": 0000,
      "track2Data": "0000",
      "cardValidationValue": "000"
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
  "description": "CONFIG OF REVERSAL_CARD_PURCHASE BY METHOD",
  "country": "HND",
  "domain": "REVERSAL_CARD_PURCHASE",
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

##### Registro en Dynamo Wrapper T24 Operación rollbackTaxesBulletin

##### Registro en Dynamo Componente de idempotencia

##### Ejemplo del request para consumo API Idempotencia

##### Ejemplo mensaje en Event Brigde para componente de Idempotencia

##### Ejemplo de request Wrapper T24

##### Ejemplo request consumo operacion rollbackTaxesBulletin


