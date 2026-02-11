##### DynamoDB Parameter - Lambda Parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#REWARD_POINTS_ACCOUNT_ADMIN#PARAM#initiate-conversion",
  "sk": "V#0001",
  "name": "initiate-conversion",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "param-name": "ban-hnd-ic-consumo-wrapper-abanks-db-<env>"
    },
    {
      "region": "GT01-GT01",
      "enabled": true,
      "param-name": "ban-gtm-ic-consumo-wrapper-abanks-gt-db-<env>"
    },
    {
      "region": "NI01-NI01",
      "enabled": true,
      "param-name": "ban-pan-ic-consumo-wrapper-abanks-db-<env>"
    },
    {
      "region": "PA01-PA01",
      "enabled": true,
      "param-name": "ban-xrs-ic-consumo-wrapper-abanks-pa-wsdl-<env>"
    }
  ],
  "type": "JSON",
  "description": "CONFIG OF REWARD_POINTS_ACCOUNT_ADMIN BY METHOD",
  "country": "XRS",
  "domain": "REWARD_POINTS_ACCOUNT_ADMIN",
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
"ban-hnd-ic-consumo-wrapper-abanks-db-<env>"
{
  "connection": "ConnectionProxyAbanksHN",
  "connectionType": "jca",
  "operationType": "query", 
  "catalogueName": "proxyabankspa"
}
```

```json
"ban-gtm-ic-consumo-wrapper-abanks-gt-db-<env>"
{
  "connection": "ConnectionProxyAbanksPA",
  "connectionType": "jca",
  "operationType": "query", 
  "catalogueName": "proxyabankspa"
}
```

```json
"ban-pan-ic-consumo-wrapper-abanks-db-<env>"
{
  "connection": "",
  "connectionType": "jca",
  "operationType": "query", 
  "catalogueName": "proxynicaragua"
}
```

```json
"ban-pan-ic-consumo-wrapper-abanks-db-<env>"
{
  "connection": "ConnectionProxyAbanksPA",
  "connectionType": "jca",
  "operationType": "query", 
  "catalogueName": "proxyabankspa"
}
```

##### Constantes para almacenar en ConfigMap

```json
{
  "procedureName": "PL_P_CANJE_PUNTOS_EFECTIVO"
}
```