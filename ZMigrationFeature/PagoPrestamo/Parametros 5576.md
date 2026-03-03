##### DynamoDB Parameter - Lambda Parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#PAYMENT_EXECUTION_MAINTENANCE#PARAM#execute-loan-repayment",
  "sk": "V#0001",
  "name": "execute-loan-repayment",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "param-name": "ban-hnd-ic-comp-param-connection-interbanca-param-db-<env>",
      "secret-name": "ban-hnd-ic-comp-secm-connection-interbanca-param-db-<env>"
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
"ban-hnd-ic-comp-param-connection-interbanca-param-db-<env>"
{
  "host": "172.23.176.46",
  "port": "1521",
  "database": "VIRHND"
}
```

##### AWS Systems Manager SecretManager

```json
"ban-hnd-ic-comp-secm-connection-interbanca-param-db-<env>"
{
  "user": "ora_bank",
  "password": "desarrollo"
}
```

##### Constantes para almacenar en ConfigMap

```json
{
  "connectionType": "jca",
  "operationType": "update",
  "catalogeName": "ORA_BANK",
  "packageCB": "PSB_K_PAGO_PRESTAMO",
  "procedureNameCB": "TOPLEVEL$OSB_PAG_PRESTAMO_CAJ",
  "procedureNameT24": "OSB_PAG_PRESTAMO_T24",
  "caller-service": "payment_execution_maintenance-product-execute-loan-repayment"
}
```
##### Registro en Dynamo Librería Homologación de datos


##### Registro en Dynamo Componente de idempotencia

```json
{
    "PK": "payment_execution_maintenance-product-execute-loan-repayment",
    "SK": "1.0|ACTIVE",
    "version": "1.0",
    "stage": "ACTIVE",
    "callerService": "payment_execution_maintenance-product-execute-loan-repayment",
    "service": "payment_execution_maintenance-product",
    "method": "execute-loan-repayment",
    "domain": "PAYMENT_EXECUTION_MAINTENANCE",
    "typeUsage": "IDEM",
    "hashFields": [
        "loanId",
        "transactionReference"
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
##### Ejemplo del request para consumo API Idempotencia

```json
curl --location 'http://internal-ban-xrs-ic-elb-alb-master-dev-548527349.us-east-1.elb.amazonaws.com:17396/integrity-handler/v1/idempotency/generate' \
--header 'Caller-Service: payment_execution_maintenance-product-execute-loan-repayment' \
--header 'Correlation-Id: b1f6f6f5-d611-4c1f-843f-89a1c8aaaaee' \
--header 'Authorization: Bearer my.token.loko' \
--header 'Source-Bank: HN01' \
--header 'Application-Id: 123456789' \
--header 'Channel: my-channel' \
--header 'Content-Type: application/json' \
--data '{
    "methodVersion": "1.0",
    "dataPayload": {
      "loanId": "string",
      "paymentAmount": "string",
      "currencyCode": "string",
      "paymentType": "ACCOUNT_DEBIT",
      "accountNumber": "string",
      "chequeNumber": "string",
      "bankCode": "string",
      "interfaceReferenceNumber": "string",
      "transactionReference": "string",
      "transactionReferenceBC": "string",
      "paymentDescription": "string"
    }
}'
```

##### Ejemplo mensaje en Event Brigde para componente de Idempotencia
```json
{
    "Source": "microservice.response",
    "DetailType": "provider.response ",
    "Detail": {
        "correlation-id": "header.correlation-id",
        "callerService": "payment_execution_maintenance-product-execute-loan-repayment",
        "channel": "rest-api",
        "transactionStatus": "success", // || "timeout" ||  "error" || "fault",
        "payload": { 
            "host": "http://abanks-url",
            "headers": {}, // headers etc
            "body": {
              "loanId": "string",
              "paymentAmount": "string",
              "currencyCode": "string",
              "paymentType": "ACCOUNT_DEBIT",
              "accountNumber": "string",
              "chequeNumber": "string",
              "bankCode": "string",
              "interfaceReferenceNumber": "string",
              "transactionReference": "string",
              "transactionReferenceBC": "string",
              "paymentDescription": "string"
            }
        }
    }
}
```

##### Request ejemplo consumo Wrapper Proxy Abanks
```json
{
  "connection": {
    "parm": "ban-hnd-ic-comp-param-connection-interbanca-param-db-<env>",
    "secm": "ban-hnd-ic-comp-secm-connection-interbanca-param-db-<env>"
  },
  "connectionType": "jca",
  "operationType": "query",
  "catalogueName": "ORA_BANK",
  "procedureName": "TOPLEVEL$OSB_PAG_PRESTAMO_CAJ",
  "params": {
    "LOAN_NUMBER": "001466391221",
    "PAYMENT_AMOUNT": "1000",
    "DEBIT_ACCOUNT": "HNL151450001",
    "INTERFACE_REFERENCE_NO": "",
    "DESCRIPTION": "CODIGO_CORRESPONSAL",
    "USERNAME": "HNITINTB",
    "TRANSACTIONID": "FT230830SJYY",
    "PAYMENT_METHOD": "ACCOUNT_DEBIT",
    "PAYMENT_TYPE": "123456789984443"
  }
}
```