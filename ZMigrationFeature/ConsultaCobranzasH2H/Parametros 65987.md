##### 4.1.3.1. DynamoDB - Parámetros regionalización, negocio y conexión:
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#AVAILABLE_REQUESTS_ADMIN#PARAM#RETRIEVE",
  "sk": "V#0001",
  "name": "RETRIEVE",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "param-name": "ban-hnd-ic-sys-parm-connection-proxyabankshn-db-dev",
      "secret-name": "ban-hnd-ic-sys-secm-connection-proxyabankshn-db-dev"
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
  "description": "CONFIG OF AVAILABLE_REQUESTS_ADMIN BY METHOD",
  "country": "XRS",
  "domain": "AVAILABLE_REQUESTS_ADMIN",
  "tags": [],
  "precedence": 10,
  "effective_from": "",
  "effective_to": "",
  "status": "active",
  "updated_at": "2026-07-15T18:10:00Z",
  "updated_by": "david.j.molano@ficohsa.com"
}
```

##### 4.1.3.2. AWS Systems Manager Parameter Store

**Nombre Parámetro**: `ban-hnd-ic-sys-parm-connection-proxyabankshn-db-dev` 
```json
{
  "ip": "172.23.176.20",
  "port": "1970",
  "database": "interfazdev"
}
```

##### 4.1.3.3. AWS Systems Manager SecretManager

**Nombre Secreto**: `ban-hnd-ic-sys-secm-connection-proxyabankshn-db-dev` 
```json
{
  "user": "PROXYABANKSHN",
  "password": "desarrollo"
}
```

##### 4.1.3.2. Constantes para almacenar en ConfigMap

```json
{
  "caller-service":  "AVAILABLE_REQUESTS_ADMIN-SYSTEM-RETRIEVE",
  "schema": "PROXYABANKSHN",
  "package": "HTH_K_GENERALES",
  "procedureName": "HTH_P_CONSULTA_REG_CONS_X_SERV"
}
```
