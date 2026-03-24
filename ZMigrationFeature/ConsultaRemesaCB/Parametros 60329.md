##### DynamoDB Parameter - Lambda Parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#HND#DOMAIN#CORRESPONDENT_MANAGEMENT#PARAM#RETRIEVE_REMITTANCES",
  "sk": "V#0001",
  "name": "RETRIEVE_REMITTANCES",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "transactionType": "9",
      "algorithm": "AWS_ENCRYPTION_SDK",
      "param-name": "ban-xrs-ic-comp-parm-aurora-postgresql-db-<env>",
      "arn-secret": "arn:aws:secretsmanager:us-east-1:628835453395:secret:rds!cluster-9b8b1d20-96c6-4fe4-9db7-ca1af021a7a8-pSFoon"
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
  "description": "CONFIG OF CORRESPONDENT_MANAGEMENT BY METHOD",
  "country": "HND",
  "domain": "CORRESPONDENT_MANAGEMENT",
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
"ban-xrs-ic-comp-parm-aurora-postgresql-db-<env>"
{
  "host": "ban-xrs-ic-rds-aurora-postgresql-dev.cluster-cexie6wsupzo.us-east-1.rds.amazonaws.com",
  "port": "5432",
  "dbname": "postgres"
}
```

##### AWS Systems Manager SecretManager

##### Constantes para almacenar en ConfigMap

```json
{
  "userDB": "dbadmin",
  "procedureName": "ban-xrs-ic-sp-register-remittance-{env}"
}
```
##### Registro en Dynamo Wrapper T24

##### Registro en Dynamo Componente de idempotencia

##### Ejemplo del request para consumo API Idempotencia

##### Ejemplo mensaje en Event Brigde para componente de Idempotencia

##### Ejemplo de request Wrapper T24

##### Ejemplo request consumo operacion RetiroEfectivoTengo T24

##### Ejemplo response consumo operación RetiroEfectivoTengo T24
