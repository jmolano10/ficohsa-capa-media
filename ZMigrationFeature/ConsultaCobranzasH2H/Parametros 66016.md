##### 4.1.3.1. DynamoDB - Parámetros regionalización, negocio y conexión:
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#COLLECTION_RETRIEVE#PARAM#RETRIEVE-COLLECTION-FIELD",
  "sk": "V#0001",
  "name": "RETRIEVE-COLLECTION-FIELD",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "param-name": "ban-hnd-ic-comp-parm-connection-proxyabankshm-dev",
      "secret-name": "ban-hnd-ic-comp-secm-connection-proxyabankshm-dev"
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
  "type": "list",
  "description": "CONFIG OF COLLECTION_RETRIEVE BY METHOD",
  "country": "XRS",
  "domain": "COLLECTION_RETRIEVE",
  "tags": [],
  "precedence": 10,
  "effective_from": "",
  "effective_to": "",
  "status": "active",
  "updated_at": "2026-07-17T10:00:00Z",
  "updated_by": "david.j.molano@ficohsa.com"
}
```

##### 4.1.3.2. AWS Systems Manager Parameter Store

**Nombre Parámetro**: `ban-hnd-ic-comp-parm-connection-proxyabankshm-dev`
```json
{
  "ip": "172.23.176.20",
  "port": "1970",
  "database": "interfazdev"
}
```

##### 4.1.3.3. AWS Systems Manager SecretManager

**Nombre Secreto**: `ban-hnd-ic-comp-secm-connection-proxyabankshm-dev`
```json
{
  "user": "PROXYABANKSHN",
  "password": "desarrollo"
}
```

##### 4.1.3.4. Constantes para almacenar en ConfigMap

```json
{
  "caller-service": "COLLECTION_RETRIEVE-PRODUCT-RETRIEVE-COLLECTION-FIELD",
  "schema": "PROXYABANKSHM",
  "package": "PROXYABANKSHM",
  "procedureName": "HTH_P_CONS_CAMPOS_CBR_X_SERV"
}
```
