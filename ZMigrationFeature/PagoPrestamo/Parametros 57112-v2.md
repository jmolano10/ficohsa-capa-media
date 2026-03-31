##### DynamoDB Parameter - Librería de parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#CORRESPONDENT_MANAGEMENT-EXP#PARAM#EXCEUTE_LOAN_REPAYMENT",
  "sk": "V#0001",
  "name": "EXCEUTE_LOAN_REPAYMENT",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "transactionTypeValidate": "2",
      "paymentType": "ACCOUNT_DEBIT",
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
  "version": "0001",
  "description": "CONFIG OF CORRESPONDENT_MANAGEMENT-EXP BY METHOD",
  "country": "XRS",
  "domain": "CORRESPONDENT_MANAGEMENT-EXP",
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
  "procedureName": "REGISTRA_TRANSACCION_CANAL",
  "caller-service": "CORRESPONDENT_MANAGEMENT-EXP-EXCEUTE_LOAN_REPAYMENT"
}
```
##### Registro en Dynamo Wrapper RegionDB

```json
{
  "pk": "COUNTRY#HND#DOMAIN#WRAPPER_REGION_DB#PARAM#CORRESPONDENT_MANAGEMENT-PRODUCT-EXCEUTE_LOAN_REPAYMENT",
  "sk": "V#0001",
  "name": "CORRESPONDENT_MANAGEMENT-PRODUCT-EXCEUTE_LOAN_REPAYMENT",
  "value": {
    "param-name": "ban-hnd-ic-comp-parm-connection-region-db-dev",
    "secret-name": "ban-hnd-ic-comp-secm-connection-trx-asincrono-db-dev",
  },
  "type": "number",
  "version": "0001",
  "description": "Parametros Wrapper RegionDB Pago Prestamo",
  "country": "HND",
  "domain": "WRAPPER_REGION_DB",
  "tags": [],
  "precedence": 10,
  "effective_from": "2025-01-01T00:00:00Z",
  "effective_to": "9999-12-31T23:59:59Z",
  "status": "active",
  "updated_at": "2025-09-23T18:10:00Z",
  "updated_by": "joe@ficohsa.com"
}
```
