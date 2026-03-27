##### DynamoDB Parameter - Librería de parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#CREDIT_CARD_TRANSACTION_RETRIEVES#PARAM#RETRIEVE_CREDIT_PLANS",
  "sk": "V#0001",
  "name": "RETRIEVE_CREDIT_PLANS",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "param-name": "ban-hnd-lc-ccard-parm-connection-tarjetas-db-dev",
      "secret-name": "ban-hnd-lc-ccard-secm-connection-tarjetas-db-dev"
    },
    {
      "region": "GT01-GT01",
      "enabled": true,
      "param-name": "ban-gtm-lc-ccard-parm-connection-tarjetas-db-dev",
      "secret-name": "ban-gtm-lc-ccard-secm-connection-tarjetas-db-dev"
    },
    {
      "region": "NI01-NI01",
      "enabled": true,
      "param-name": "ban-nic-lc-ccard-parm-connection-tarjetas-db-dev",
      "secret-name": "ban-nic-lc-ccard-secm-connection-tarjetas-db-dev"
    },
    {
      "region": "PA01-PA01",
      "enabled": true,
      "param-name": "ban-pan-lc-ccard-parm-connection-tarjetas-db-dev",
      "secret-name": "ban-pan-lc-ccard-secm-connection-tarjetas-db-dev"
    }
  ],
  "type": "JSON",
  "description": "CONFIG OF CREDIT_CARD_TRANSACTION_RETRIEVES BY METHOD",
  "country": "XRS",
  "domain": "CREDIT_CARD_TRANSACTION_RETRIEVES",
  "tags": [],
  "precedence": 10,
  "effective_from": "",
  "effective_to": "",
  "status": "active",
  "updated_at": "2025-12-19T18:10:00Z",
  "updated_by": "david.j.molano@ficohsa.com"
}
```
##### AWS Systems Manager Parameter Store

**Nombre Paramétro Honduras**: `ban-hnd-lc-ccard-parm-connection-tarjetas-db-dev`
```json
{
  "ip": "172.23.177.175",
  "port": "1433",
  "database": "OSB"
}
```

**Nombre Paramétro Guatemala**: `ban-gtm-lc-ccard-parm-connection-tarjetas-db-dev`
```json
{
  "ip": "172.23.177.175",
  "port": "1433",
  "database": "OSB"
}
```

**Nombre Paramétro Nicaragua**: `ban-nic-lc-ccard-parm-connection-tarjetas-db-dev`
```json
{
  "ip": "172.23.177.175",
  "port": "1433",
  "database": "OSB"
}
```

**Nombre Paramétro Panamá**: `ban-pan-lc-ccard-parm-connection-tarjetas-db-dev`
```json
{
  "ip": "172.23.177.175",
  "port": "1433",
  "database": "OSB"
}
```
																	
##### AWS Systems Manager SecretManager

**Nombre Secreto Honduras**: `ban-hnd-lc-ccard-secm-connection-tarjetas-db-dev`
```json
{
  "user": "UsrOSB",
  "password": "FicohsaTC2021"
}
```

**Nombre Secreto Guatemala**: `ban-gtm-lc-ccard-secm-connection-tarjetas-db-dev`
```json
{
  "user": "UsrOSB",
  "password": "FicohsaTC2021"
}
```

**Nombre Secreto Nicaragua**: `ban-nic-lc-ccard-secm-connection-tarjetas-db-dev`
```json
{
  "user": "UsrOSB",
  "password": "FicohsaTC2021"
}
```

**Nombre Secreto Panamá**: `ban-hnd-lc-ccard-secm-connection-tarjetas-db-dev`
```json
{
  "user": "UsrOSB",
  "password": "FicohsaTC2021"
}
```

##### Constantes para almacenar en ConfigMap

```json
{
  "procedureNameHND": "OSBConDatoPlanes",
  "procedureNameGTM": "OSBConDatoPlanes",
  "procedureNameNIC": "OSBConDatoPlanes",
  "procedureNamePAN": "OSBConDatoPlanes"
}
```
