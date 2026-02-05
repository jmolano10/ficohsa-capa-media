##### DynamoDB Parameter - Lambda Parámetros
```json
{
  "pk": "COUNTRY#XRS#DOMAIN#REDEEM_LOYALTY_POINTS#PARAM#PARAM",
  "sk": "V#0001",
  "name": "PARAM",
  "type": "JSON",
  "description": "CONFIG OF REDEEM_LOYALTY_POINTS BY BACKEND",
  "country": "HND",
  "domain": "REDEEM_LOYALTY_POINTS",
  "methos": {
    "initiate": [
      {
        "key": "debit-retrieve-loyalty-points-attributeName",
        "value": "BIN"
      },
      {
        "key": "debit-retrieve-loyalty-points-comparisonOperator",
        "value": "EQ"
      }
    ]
  }
  "status": "active",
  "updated_at": "2025-09-23T18:10:00Z"
}
```
##### AWS Systems Manager Parameter Store

```json
"ban-hnd-lc-canje-puntos-efectivo-param-wsdl-<env>"
{
  "connection": "ConnectionProxyAbanksHN",
  "connectionType": "jdbc",
  "operationType": "update", 
  "catalogueName": "proxyabankspa",
  "procedureName": "PL_P_CANJE_PUNTOS_EFECTIVO"
}
```
