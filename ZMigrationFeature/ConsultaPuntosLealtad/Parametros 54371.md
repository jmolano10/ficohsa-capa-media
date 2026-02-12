##### DynamoDB Parameter - Lambda Parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#XX#PARAM#retrieve-points",
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
  "description": "CONFIG OF XX BY METHOD",
  "country": "HND",
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
"ban-xrs-ic-parm-vision-plus-service-wsdl-<env> (Parámetro ya creado - Reutilizar)"
{
  "ip": "https://172.28.1.146",
  "port": "7802",
  "basePath": "VisionPlusService"
}
```

##### Constantes para almacenar en ConfigMap

```json
{
  "operation": "PointsAdjustmentInquiry"
}
```