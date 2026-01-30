##### DynamoDB Parameter - Lambda Parámetros
```json
{
  "pk": "COUNTRY#XRS#DOMAIN#XXXXXX#PARAM#PARAM",
  "sk": "V#0001",
  "name": "PARAM",
  "type": "JSON",
  "description": "CONFIG OF XXXXXX BY BACKEND",
  "country": "XRS",
  "domain": "XXXXXX",
  "value": [
    {
      "region": "HN01",
      "param-name": "ban-hnd-XX-canje-puntos-efectivo-param-wsdl-<env>"
    },
    {
      "region": "GT01",
      "param-name": "ban-gtm-XX-canje-puntos-efectivo-param-wsdl-<env>"
    },
    {
      "region": "PA01",
      "param-name": "ban-pan-XX-canje-puntos-efectivo-param-wsdl-<env>"
    },
    {
      "region": "NI01",
      "param-name": "ban-nic-XX-canje-puntos-efectivo-param-wsdl-<env>"
    }
  ],
  "status": "active",
  "updated_at": "2025-09-23T18:10:00Z"
}
```
##### AWS Systems Manager Parameter Store

```json
"ban-hnd-XX-canje-puntos-efectivo-param-wsdl-<env>"
{
  "ip": "172.23.177.185",
  "port": "1970",
  "connectionType": "jdbc",
  "bd": "mdwdbdev", 
  "procedureName": "PL_P_CANJE_PUNTOS_EFECTIVO"
}
```

```json
"ban-gtm-XX-canje-puntos-efectivo-param-wsdl-<env>"
{
  "connection": "ConnectionProxyAbanksPA",
  "connectionType": "jdbc",
  "operationType": "update", 
  "catalogueName": "proxyabankspa",
  "procedureName": "PL_P_CANJE_PUNTOS_EFECTIVO"
}
```

```json
"ban-pan-XX-canje-puntos-efectivo-param-wsdl-<env>"
{
  "connection": "ConnectionProxyAbanksPA",
  "connectionType": "jdbc",
  "operationType": "update", 
  "catalogueName": "proxyabankspa",
  "procedureName": "PL_P_CANJE_PUNTOS_EFECTIVO"
}
```

```json
"ban-nic-XX-canje-puntos-efectivo-param-wsdl-<env>"
{
  "connection": "",
  "connectionType": "jdbc",
  "operationType": "update", 
  "catalogueName": "proxynicaragua",
  "procedureName": "PL_P_CANJE_PUNTOS_EFECTIVO"
}
```