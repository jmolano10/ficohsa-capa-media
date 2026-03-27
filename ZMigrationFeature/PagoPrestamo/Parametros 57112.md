##### DynamoDB Parameter - Librería de parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#HND#DOMAIN#CORRESPONDENT_MANAGEMENT#PARAM#EXCEUTE_LOAN_REPAYMENT",
  "sk": "V#0001",
  "name": "EXCEUTE_LOAN_REPAYMENT",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "transactionTypeValidate": "2",
      "paymentType": "ACCOUNT_DEBIT",
      "param-name": "ban-hnd-ic-comp-parm-connection-region-db-dev",
      "secret-name": "ban-hnd-ic-comp-secm-connection-trx-asincrono-db-dev",
      "transactionTypeRegister": "4",
      "channelCode": 1,
      "transactionState": "REGISTRADO",
      "t24Reference": ""
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

**Nombre**: `ban-hnd-ic-comp-parm-connection-region-db-dev`
```json
{
  "host": "172.23.177.182",
  "port": 1521,
  "database": "regiondb"
}
```

##### AWS Systems Manager SecretManager

**Nombre**: `ban-hnd-ic-comp-secm-connection-trx-asincrono-db-dev`
```json
{
  "username": "TRX_BATCH_CB",
  "password": "desarrollo"
}
```

##### Constantes para almacenar en ConfigMap

```json
{
  "connectionType": "jdbc",
  "operationType": "update",
  "catalogueName": "TRX_BATCH_CB",
  "packageName": "OSB_P_ATB_REGISTRAR_CB",
  "procedureName": "REGISTRA_TRANSACCION_CANAL"
}
```
##### Registro en Dynamo Wrapper T24

##### Registro en Dynamo Componente de idempotencia

##### Ejemplo del request para consumo API Idempotencia

##### Ejemplo mensaje en Event Brigde para componente de Idempotencia

##### Ejemplo de request Wrapper T24

##### Ejemplo request consumo operacion RetiroEfectivoTengo T24

##### Ejemplo response consumo operación RetiroEfectivoTengo T24
