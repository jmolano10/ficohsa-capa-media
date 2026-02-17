##### DynamoDB Parameter - Lambda Parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#REDEEM_LOYALTY_POINTS#PARAM#retrieve-customer",
  "sk": "V#0001",
  "name": "retrieve-customer",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "param-name": "ban-xrs-ic-redeem-transaction-param-db-<env>",
      "institutionName": "banficohsahnd",
      "logoInfinite": "625",
      "matrixId": "45891",
      "description": "DESC 35",
      "conversionType": 2,
      "rewardItem-Default": "CANJE POR SALESFORC",
      "rewardItem-SRV-ITINTB": "CANJE POR T24",
      "rewardItem-HNBNDSRPTMC": "CANJE POR POS",
      "rewardItem-HNBNDSRPTCMC": "CANJE POR POS",
      "cardNumber": 0,
      "reasonCode": "01",
      "userData": "EM", 
      "couponDenom": 0, 
      "couponNbr": 0,
      "detailLevel": "customer"
    },
    {
      "region": "GT01-GT01",
      "enabled": true,
      "param-name": "ban-xrs-ic-redeem-transaction-param-db-<env>",
      "institutionName": "banficohsahnd",
      "conversionType": 2,
      "description": "DESC 35",
      "matrixId": "53198",
      "rewardItem-Default": "CANJE POR SALESFORC",
      "rewardItem-SRV-ITINTB": "CANJE POR T24",
      "rewardItem-HNBNDSRPTMC": "CANJE POR POS",
      "rewardItem-HNBNDSRPTCMC": "CANJE POR POS",
      "cardNumber": 0,
      "reasonCode": "01",
      "userData": "EM", 
      "couponDenom": 0, 
      "couponNbr": 0
    },
    {
      "region": "NI01-NI01",
      "enabled": true,
      "institutionName": "banficohsahnd",
      "affinityGroupReference": "000",
      "productCode": "TD0000",
      "matrixId": "53198",
      "rewardItem-Default": "CANJE POR SALESFORC",
      "rewardItem-SRV-ITINTB": "CANJE POR T24",
      "rewardItem-HNBNDSRPTMC": "CANJE POR POS",
      "rewardItem-HNBNDSRPTCMC": "CANJE POR POS",
      "cardNumber": 0,
      "reasonCode": "01",
      "userData": "EM", 
      "couponDenom": 0, 
      "couponNbr": 0
    },
    {
      "region": "PA01-PA01",
      "enabled": true,,
      "institutionName": "banficohsahnd",
      "matrixId": "53198",
      "rewardItem-Default": "CANJE POR SALESFORC",
      "rewardItem-SRV-ITINTB": "CANJE POR T24",
      "rewardItem-HNBNDSRPTMC": "CANJE POR POS",
      "rewardItem-HNBNDSRPTCMC": "CANJE POR POS",
      "cardNumber": 0,
      "reasonCode": "01",
      "userData": "EM", 
      "couponDenom": 0, 
      "couponNbr": 0
    }
  ],
  "type": "JSON",
  "description": "CONFIG OF REDEEM_LOYALTY_POINTS BY METHOD",
  "country": "XRS",
  "domain": "REDEEM_LOYALTY_POINTS",
  "tags": [],
  "precedence": 10,
  "effective_from": "",
  "effective_to": "",
  "status": "active",
  "updated_at": "2025-12-19T18:10:00Z",
  "updated_by": "eudis.perdomo@ficohsa.com"
}
```
##### AWS Systems Manager Parameter Store

```json
"ban-xrs-ic-redeem-transaction-param-db-<env>"
{
  "serverName": "172.23.177.172",
  "port": "64102",
  "databaseName": "OSB"
}
```

##### AWS Systems Manager SecretManager



##### Constantes para almacenar en ConfigMap

```json
{
  "package": "dbo",
  "procedureName": "OSBINSTransaccionRedencion"
}
```
