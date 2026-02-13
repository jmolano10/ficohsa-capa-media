##### DynamoDB Parameter - Lambda Parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#ISSUED_DEV_ADMIN_RETRIEVES#PARAM#retrieve-customer",
  "sk": "V#0001",
  "name": "retrieve-customer",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "secret-name": "ban-hnd-lc-process-hn-secm-db-<env>",
      "param-name": "ban-hnd-lc-process-hn-param-db-<env>"
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
  "description": "CONFIG OF ISSUED_DEV_ADMIN_RETRIEVES BY METHOD",
  "country": "XRS",
  "domain": "ISSUED_DEV_ADMIN_RETRIEVES",
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
"ban-hnd-lc-process-hn-param-db-<env>"
{
  "serverName": "172.23.177.172",
  "port": "64102",
  "databaseName": "OSB"
}
```
##### AWS Systems Manager SecretManager

```json
"ban-hnd-lc-process-hn-secm-db-<env>"
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
##### Registro en Dynamo Librería Homologación de datos
```json
{
  "pk": "COUNTRY#XRS#DOMAIN#COUNTRY_CODE#PARAM#CATALOGATE",
  "sk": "V#0001",
  "type": "JSON",
  "country": "XRS",
  "domain": "COUNTRY_CODE",
  "name": "CATALOGATE",
  "description": "CATALOGATE OF COUNTRY CODE",
  "value": [
    {
      "description": "Honduras",
      "Ficohsa": "HN01",
      "canalx": "HND",
      "ISO2": "HN",
      "ISO3": "HND"
    },
    {
      "description": "Panamá",
      "Ficohsa": "PA01",
      "ISO2": "PA",
      "ISO3": "PAN"
    },
    {
      "description": "Guatemala",
      "Ficohsa": "GT01",
      "ISO2": "GT",
      "ISO3": "GTM"
    },
    {
      "description": "Nicaragua",
      "Ficohsa": "NI01",
      "ISO2": "NI",
      "ISO3": "NIC"
    }
  ],
  "status": "active",
  "updated_at": "2026-01-20T18:10:00Z",
  "updated_by": "alejandro.caballero@ficohsa.com"
}
```