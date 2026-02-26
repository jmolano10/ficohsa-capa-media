##### DynamoDB Parameter - Lambda Parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#REWARD_POINTS_ACCOUNT_ADMIN#PARAM#PARAM",
  "sk": "V#0001",
  "name": "PARAM",
  "type": "JSON",
  "description": "CONFIG OF REWARD_POINTS_ACCOUNT_ADMIN BY BACKEND",
  "country": "XRS",
  "domain": "REWARD_POINTS_ACCOUNT_ADMIN",
  "methods": {
    "initiate-loyalty-points": [
      {
        "key": "HN01",
        "value": "ban-xrs-lc-mastercard-ws-param-wsdl-<env>"
      },
      {
        "key": "HN01-2",
        "value": "ban-xrs-ic-parm-vision-plus-service-wsdl-<env>"
      },
      {
        "key": "GT01",
        "value": "ban-xrs-ic-parm-vision-plus-service-wsdl-<env>"
      },
      {
        "key": "PA01",
        "value": "ban-xrs-ic-parm-vision-plus-service-wsdl-<env>"
      },
      {
        "key": "NI01-1",
        "value": "ban-xrs-lc-mastercard-ws-param-wsdl-<env>"
      },
      {
        "key": "NI01-2",
        "value": "ban-xrs-ic-parm-vision-plus-service-wsdl-<env>"
      },
      {
        "key": "INSTITUTIONNAME",
        "value": "banficohsahnd"
      },
      {
        "key": "confirmationEmailSw",
        "value": false
      },
      {
        "key": "confirmationEmailAddr",
        "value": "info@ficohsa.com"
      },
      {
        "key": "newShippingAddressSw",
        "value": true
      },
      {
        "key": "poBoxAddressSw",
        "value": false
      },
      {
        "key": "language",
        "value": "en_US"
      }
    ]
  },
  "status": "active",
  "updated_at": "2025-09-23T18:10:00Z"
}
```
##### AWS Systems Manager Parameter Store

```json
"ban-xrs-lc-mastercard-ws-param-wsdl-<dev>"
{
  "ip": "https://192.168.55.21",
  "port": "7011",
  "basePath": "/mastercard-webservices/RedemptionService"
}
```
```json
"ban-xrs-lc-mastercard-ws-param-wsdl-<qa>"
{
  "ip": "https://192.168.50.54",
  "port": "7021",
  "basePath": "/mastercard-webservices/RedemptionService"
}
```
```json
"ban-xrs-ic-parm-vision-plus-service-wsdl-<env> (Parámetro ya creado - Reutilizar)"
{
  "ip": "https://172.28.1.146",
  "port": "7802",
  "basePath": "VisionPlusService"
}
```
##### AWS Systems Manager SecretManager


##### Constantes para almacenar en ConfigMap

```json
{
  "operationMastercard": "doItemRedemption",
  "operationVisa": "PointsRedeem"
}
```
