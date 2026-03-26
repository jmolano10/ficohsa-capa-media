##### DynamoDB Parameter - Lambda Parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#CUSTOMER_CASE_MGMT_RETRIEVE#PARAM#RETRIEVE_TRANSACTION_STATUS",
  "sk": "V#0001",
  "name": "RETRIEVE_TRANSACTION_STATUS",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "param-name": "ban-xrs-ic-wpr-parm-connection-interfazdev-db-dev",
      "secret-name": "ban-xrs-ic-wpr-secm-connection-interfaz-sfc-db-dev"
    },
    {
      "region": "GT01-GT01",
      "enabled": true,
      "param-name": "ban-xrs-ic-wpr-parm-connection-interfazdev-db-dev",
      "secret-name": "ban-xrs-ic-wpr-secm-connection-interfaz-sfc-db-dev"
    },
    {
      "region": "NI01-NI01",
      "enabled": false
    },
    {
      "region": "PA01-PA01",
      "enabled": true,
      "param-name": "ban-xrs-ic-wpr-parm-connection-interfazdev-db-dev",
      "secret-name": "ban-xrs-ic-wpr-secm-connection-interfaz-sfc-db-dev"
    }
  ],
  "type": "JSON",
  "description": "CONFIG OF CUSTOMER_CASE_MGMT_RETRIEVE BY METHOD",
  "country": "XRS",
  "domain": "CUSTOMER_CASE_MGMT_RETRIEVE",
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

```json
"ban-xrs-ic-wpr-parm-connection-interfazdev-db-dev"
{
  "host": "172.23.176.20",
  "port": "1970",
  "database": "interfazdev"
}
```

##### AWS Systems Manager SecretManager

```json
"ban-xrs-ic-wpr-secm-connection-interfaz-sfc-db-dev"
{
  "user": "SALESFORCE",
  "password": "desarrollo"
}
```

##### Constantes para almacenar en ConfigMap

```json
{
  "connectionType": "jca",
  "operationType": "update",
  "catalogeName": "SALESFORCE",
  "procedureName": "SFC_P_CON_GESTIONES_MONETARIAS",
  "caller-service": "customer-case-mgmt-retrieve-retrieve-transaction-status"

}
```
##### Request ejemplo consumo Wrapper Proxy Abanks Multidestino
```json
{
  "connection": {
    "parm": "ban-xrs-ic-wpr-parm-connection-interfazdev-db-dev",
    "secm": "ban-xrs-ic-wpr-secm-connection-interfaz-sfc-db-dev"
  },
  "connectionType": "jca",
  "operationType": "query",
  "catalogueName": "SALESFORCE",
  "procedureName": "SFC_P_CON_GESTIONES_MONETARIAS",
  "params": {
    "PV_NUMUSU": "1234567",
    "PV_PAIS": "HN01",
    "PV_DETALLE": "PRESTAMO_PERSONAL" 
  }
}
```