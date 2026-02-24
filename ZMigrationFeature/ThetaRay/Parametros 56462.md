##### DynamoDB Parameter - Lambda Parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#WRAPPER_THETA#PARAM#wrapper-theta",
  "sk": "V#0001",
  "name": "wrapper-theta",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": false
    },
    {
      "region": "GT01-GT01",
      "enabled": true,
      "secret-name": "ban-xrs-ic-comp-secm-thetaray-rest-<env>",
      "Content-Type": "application/json",
      "Cookie": "cookiesession1=678A3F00F54C5A7C7198490682A6D418",
      "path-token": "security/accessToken"
    },
    {
      "region": "NI01-NI01",
      "enabled": true,
      "secret-name": "ban-xrs-ic-comp-secm-thetaray-rest-<env>",
      "Content-Type": "application/json",
      "Cookie": "cookiesession1=678A3F00F54C5A7C7198490682A6D418",
      "path-token": "security/accessToken"
    },
    {
      "region": "PA01-PA01",
      "enabled": false
    }
  ],
  "type": "JSON",
  "description": "CONFIG OF WRAPPER_THETA BY METHOD",
  "country": "XRS",
  "domain": "WRAPPER_THETA",
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
"ban-xrs-ic-comp-param-thetaray-rest-<env>"
{
  "basepath": "https://apps-pre-screening.ficohsa.thetaray.cloud"
}
```

##### AWS Systems Manager SecretManager

```json
"ban-xrs-ic-comp-secm-thetaray-rest-<env>"
{
  "clientSecret": "thetaray"
}
```

##### Constantes para almacenar en ConfigMap


##### Registro en Dynamo Librería Homologación de datos
