##### DynamoDB Parameter - Lambda Parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#REWARD_POINTS_ACCOUNT_RETRIEVES#PARAM#retrieve-points",
  "sk": "V#0001",
  "name": "retrieve-points",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "param-name": "ban-xrs-ic-parm-vision-plus-service-wsdl-<env>"
    },
    {
      "region": "GT01-GT01",
      "enabled": true,
      "param-name": "ban-xrs-ic-parm-vision-plus-service-wsdl-<env>"
    },
    {
      "region": "NI01-NI01",
      "enabled": true,
      "param-name": "ban-xrs-ic-parm-vision-plus-service-wsdl-<env>"
    },
    {
      "region": "PA01-PA01",
      "enabled": true,
      "param-name": "ban-xrs-ic-parm-vision-plus-service-wsdl-<env>"
    }
  ],
  "type": "JSON",
  "description": "CONFIG OF XX BY METHOD",
  "country": "XRS",
  "domain": "REWARD_POINTS_ACCOUNT_RETRIEVES",
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
"ban-hnd-xx-procesos-hn-param-db-<env>"
{
  "serverName": "172.23.177.172",
  "port": "64102",
  "databaseName": "OSB"
}
```
##### AWS Systems Manager SecretManager

```json
"ban-hnd-xx-procesos-hn-secm-db-<env>"
{
  "user": "usrOSB",
  "password": "FicohsaHN2021"
}
```

##### Constantes para almacenar en ConfigMap

```json
{
  "package": "dbo",
  "procedureName": "OSBConInfoLealtad"
}
```