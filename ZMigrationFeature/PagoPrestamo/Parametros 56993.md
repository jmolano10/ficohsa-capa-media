##### DynamoDB Parameter - Librería de parámetros

```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#LOAN_PAYMENT#PARAM#EXECUTION",
  "sk": "V#0001",
  "name": "EXECUTION",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "orderingbank": "999999",
      "desciption-cb": "CODIGO_CORRESPONSAL",
      "paymentType": "ACCOUNT_DEBIT",
      "noOfAuth": "0",
      "accountGroup": "1", 
      "accountMultiple": "1",
      "chequeNoOfAuth": "0",
      "groupAttribute": "1",
      "multiGroupAttribute": "1",
      "transaction": "CLEARING",
      "paymentGroupAttribute": "1",
      "T24T134.HNLCREDITACCTNO": "HNL160150055",
      "T24T134.USDCREDITACCTNO": "USD160150057",
      "T24T133.TXNTYPELOANPYMT": "ACPH"
    },
    {
      "region": "GT01-GT01",
      "enabled": true
    },
    {
      "region": "NI01-NI01",
      "enabled": true,
      "ipAddress": "OMNICANAL",
      "branchReference": "1",
      "currencyCode": "N",
      "serviceReference": "10"

    },
    {
      "region": "PA01-PA01",
      "enabled": true
    }
  ],
  "type": "JSON",
  "description": "CONFIG OF LOAN_PAYMENT BY METHOD",
  "country": "XRS",
  "domain": "LOAN_PAYMENT",
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

##### Registro en Dynamo Librería Homologación de datos

##### Registro en Dynamo Componente de idempotencia
