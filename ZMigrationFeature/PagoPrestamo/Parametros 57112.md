##### DynamoDB Parameter - Lambda Parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#HND#DOMAIN#CORRESPONDENT_MANAGEMENT#PARAM#INITIATE_TRANSACTION",
  "sk": "V#0001",
  "name": "INITIATE_TRANSACTION",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "transactionType": "2",
      "paymentType": "ACCOUNT_DEBIT"
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
  "description": "CONFIG OF CORRESPONDENT_MANAGEMENT BY METHOD",
  "country": "HND",
  "domain": "CORRESPONDENT_MANAGEMENT",
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
  "procedureNameValidaCB": "MW_P_VALIDA_CORBAN"
}
```
##### Registro en Dynamo Wrapper T24

##### Registro en Dynamo Componente de idempotencia

##### Ejemplo del request para consumo API Idempotencia

##### Ejemplo mensaje en Event Brigde para componente de Idempotencia

##### Ejemplo de request Wrapper T24

##### Ejemplo request consumo operacion RetiroEfectivoTengo T24

##### Ejemplo response consumo operación RetiroEfectivoTengo T24
