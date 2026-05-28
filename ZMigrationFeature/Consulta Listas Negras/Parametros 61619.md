##### DynamoDB Parameter - Librería de parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#PAYMENT_EXECUTION_MAINTENANCE#PARAM#execute-loan-repayment",
  "sk": "V#0001",
  "name": "execute-loan-repayment",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true
    },
    {
      "region": "GT01-GT01",
      "enabled": true
    },
    {
      "region": "NI01-NI01",
      "enabled": true
    },
    {
      "region": "PA01-PA01",
      "enabled": true,
      "param-name": "ban-pan-ic-comp-parm-connection-absnks-db-<env>",
      "secret-name": "ban-pan-ic-comp-secm-connection-abanks-db-<env>"
    }
  ],
  "type": "JSON",
  "description": "CONFIG OF PAYMENT_EXECUTION_MAINTENANCE BY METHOD",
  "country": "XRS",
  "domain": "PAYMENT_EXECUTION_MAINTENANCE",
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
"ban-pan-ic-comp-parm-connection-absnks-db-<env>"
{
  "host": "10.242.35.121",
  "port": "1521",
  "database": "ABANKSPA.FICO.TGU.COM"
}
```

##### AWS Systems Manager SecretManager

```json
"ban-pan-ic-comp-secm-connection-abanks-db-<env>"
{
  "user": "ora_bank",
  "password": "Desarrollo#2024"
}
```

##### Constantes para almacenar en ConfigMap

```json
{
  "connectionType": "jdbc",
  "operationType": "query",
  "catalogeName": "ORA_BANK",
  "procedureName": "INT_P_CONSULTA_LISTAS"
}
```
##### Registro en Dynamo Librería Homologación de datos


##### Registro en Dynamo Componente de idempotencia

##### Ejemplo del request para consumo API Idempotencia



##### Ejemplo mensaje en Event Brigde para componente de Idempotencia


##### Request ejemplo consumo Wrapper Proxy Abanks
```json
{
  "connection": {
    "parm": "ban-pan-ic-comp-parm-connection-absnks-db-<env>",
    "secm": "ban-pan-ic-comp-secm-connection-abanks-db-<env>"
  },
  "connectionType": "jca",
  "operationType": "query",
  "catalogueName": "ORA_BANK",
  "procedureName": "INT_P_CONSULTA_LISTAS",
  "params": {
    "Pv_Legal_ID": "001466391221"
  }
}
```