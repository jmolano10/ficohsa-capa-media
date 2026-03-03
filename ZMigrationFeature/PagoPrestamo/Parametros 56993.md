##### DynamoDB Parameter - Lambda Parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#XXXX#PARAM#MMMM",
  "sk": "V#0001",
  "name": "MMMM",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "param-name": "ban-hnd-xx-connection-interbanca-param-db-<env>",
      "hu5576": {
        "desciption-cb": "CODIGO_CORRESPONSAL",
        "paymentType": "ACCOUNT_DEBIT"
      },
      "hu57003": {
        "noOfAuth": "0",
        "gAccount": "1", 
        "mAccount": "1",
        "currencyCode": "USD En este campo se debe enviar el valor del tipo de moneda "
      },
      "hu57060": {
        "noOfAuth": "0",
        "gTransaction": "1",
        "mTransaction": "1",
        "transaction": "CLEARING"
      }      
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
  "description": "CONFIG OF XXXX BY METHOD",
  "country": "XRS",
  "domain": "XXXX",
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
"ban-hnd-xx-connection-interbanca-param-db-<env>"
{
  "connection": "ConectionInterbanca",
  "connectionType": "jca",
  "operationType": "update",
  "catalogueName": "ORA_BANK"
}
```
##### AWS Systems Manager SecretManager


##### Constantes para almacenar en ConfigMap

```json
{
  "packageCB": "PSB_K_PAGO_PRESTAMO",
  "procedureNameCB": "TOPLEVEL$OSB_PAG_PRESTAMO_CAJ",
  "procedureNameT24": "OSB_PAG_PRESTAMO_T24",
}
```
##### Registro en Dynamo Librería Homologación de datos


##### Registro en Dynamo Componente de idempotencia

```json
{
    "PK": "transaction_collection_mgmt-comp_reverse_transaction",
    "SK": "1.0|ACTIVE",
    "version": "1.0",
    "stage": "ACTIVE",
    "callerService": "customer_loan_fulfill-product-MMMM",
    "service": "customer_loan_fulfill-product",
    "method": "MMMM",
    "domain": "XXXX",
    "typeUsage": "IDEM",
    "hashFields": [
        "campos_del_request_para_calcular_hash"
    ],
    "cache": {
        "enabled": true,
        "ttlSeconds": 1800 // Validar TTL
    },
    "activeIndex": "ACTIVE", 
    "updated_at": "2025-11-05T21:32:45.237-06:00",
    "updated_by": "juan.erazo@ficohsa.com",
    "tags": [
        "abanks",
        "loanPayment"
    ],
    "integrity": {
        "confirmSuccessCodes": [
            "200",
            "000"
        ],
        "timeoutErrorCodes": [
            "500",
            "501",
            "10"
        ],
        "businessErrorCodes": [
            "",
            "",
            ""
        ]
    }
}  
```

```json
{
    "Source": "microservice.response",
    "DetailType": "provider.response",
    "Detail": {
        "correlation-id": "header.correlation-id",
        "callerService": "customer_loan_fulfill-product-MMMM",
        "channel": "rest-api",
        "transactionStatus": "success", // || "timeout" ||  "error" || "fault",
        "payload": { // Validar con JOE
            "host": "http://abanks-url",
            "headers": {}, // headers etc
            "customerIdentification": "00329699",
            "receivableBatchReference": 8772,
            "abanksResponseCode": "0", // Si success
            "abanksResponseMessage": "Success"
        }
    }
}
```