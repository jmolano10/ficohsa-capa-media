##### DynamoDB Parameter - Librería de parámetros
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
##### Ejemplo de request librería parámetros

```json
{
  "op": "GetParameter",
  "correlationId": "e1b3b0a7-8a8c-4e4b-9b2e-5c4cd7a1f3b1",
  "country": "HND",
  "domain": "WRAPPER_REGION_DB",
  "name": "CORRESPONDENT_MANAGEMENT-PRODUCT-EXCEUTE_LOAN_REPAYMENT",
  "atTime": "2025-09-25T12:34:56Z",
  "version": "0001"
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

