# DynamoDB Parameter - Librería de parámetros

```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#HND#DOMAIN#PAYMENT_EXECUTION_TRANSFER#PARAM#INITIATE_LOAN_PAYMENT",
  "sk": "V#0001",
  "name": "INITIATE_LOAN_PAYMENT",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": false
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
      "enabled": true
    }
  ],
  "type": "JSON",
  "description": "CONFIG OF PAYMENT_EXECUTION_TRANSFER BY METHOD",
  "country": "HND",
  "domain": "PAYMENT_EXECUTION_TRANSFER",
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

##### AWS Systems Manager SecretManager

##### Constantes para almacenar en ConfigMap

```json
{
    "caller-service": "payment_execution_transfer-product-initiate_loan_payment",
    "connectionTypeGT": "jca",
    "operationTypeGT": "update",
    "catalogueNameGT": "proxyabanksgt",
    "procedureNameGT": "OSB_P_PAGO_PRESTAMO",
    "connectionTypePA": "jca",
    "operationTypePA": "update",
    "catalogueNamePA": "proxyabankspa",
    "procedureNamePA": "OSB_P_PAGO_PRESTAMO", 
    "operationNI": "OpPagarPrestamo"
}
```

##### Registro en Dynamo Componente de idempotencia

```json
{
    "PK": "payment_execution_transfer-product-initiate_loan_payment",
    "SK": "1.0|ACTIVE",
    "version": "1.0",
    "stage": "ACTIVE",
    "callerService": "payment_execution_transfer-product-initiate_loan_payment",
    "service": "current-account-mgmt-product",
    "method": "initiate-check-deposit",
    "domain": "current-account",
    "typeUsage": "IDEM",
    "hashFields": [
        "loanId",
        "debitAccountReference",
        "paymentAmount"

    ],
    "cache": {
        "enabled": true,
        "ttlSeconds": 300
    },
    "activeIndex": "ACTIVE", 
    "updated_at": "2025-11-05T21:32:45.237-06:00",
    "updated_by": "david.j.molano@ficohsa.com",
    "tags": [
        "check-deposit",
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
--header 'Caller-Service: payment_execution_transfer-product-initiate_loan_payment' \
--header 'Correlation-Id: b1f6f6f5-d611-4c1f-843f-89a1c8aaaaee' \
--header 'Authorization: Bearer my.token.loko' \
--header 'Source-Bank: HN01' \
--header 'Application-Id: 123456789' \
--header 'Channel: my-channel' \
--header 'Content-Type: application/json' \
--data '{
    "methodVersion": "1.0",
    "dataPayload": {
        "transactionContext": {
            "interfaceReferenceNumber": "string",
            "consumerIPAddress": "string"
        },
        "paymentTransaction": {
            "paymentAmount": 0
        },
        "loanArrangement": {
            "productInstance": {
                "loanId": "string"
            }
        },
        "accountArrangement": {
            "debitAccountReference": "string"
        },
        "locationReference": {
            "branchReference": "string"
        },
        "currency": {
            "currencyCode": "string"
        },
        "channel": {
            "serviceReference": "string"
        }
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
        "callerService": "payment_execution_transfer-product-initiate_loan_payment",
        "channel": "rest-api",
        "transactionStatus": "success", // || "timeout" ||  "error" || "fault",
        "payload": { 
            "host": "http://abanks-url",
            "headers": {}, // headers etc
            "body": {
                "transactionContext": {
                    "interfaceReferenceNumber": "string",
                    "consumerIPAddress": "string"
                },
                "paymentTransaction": {
                    "paymentAmount": 0
                },
                "loanArrangement": {
                    "productInstance": {
                        "loanId": "string"
                    }
                },
                "accountArrangement": {
                    "debitAccountReference": "string"
                },
                "locationReference": {
                    "branchReference": "string"
                },
                "currency": {
                    "currencyCode": "string"
                },
                "channel": {
                    "serviceReference": "string"
                }
            }
        }
    }
}

```

**Request ejemplo consumo Wrapper Proxy Abanks**:

```json
{
  "connectionType": "jca",
  "operationType": "query",
  "catalogueName": "proxyabanksgt",
  "procedureName": "OSB_P_PAGO_PRESTAMO",
  "params": {
    "LOAN_NUMBER": "001466391221",
    "PAYMENT_AMOUNT": "1000",
    "DEBIT_ACCOUNT": "HNL151450001",
    "INTERFACE_REFERENCE_NO": "",
    "USERNAME": "HNITINTB"
  }
}
```

**Request ejemplo consumo Wrapper CTS Cobis**:

```json
{
    "operation": "OpPagarPrestamo",
    "flagcache": false,
    "payload": [
        {
            "type": "contextoTransaccional",
            "identificadorTransaccional": "1234456",
            "codCanalOriginador": "1",
            "ipConsumidor": "OMNICANAL"

        },
        {
            "type": "transaccion",
            "valMonto": "123123"
        },
        {
            "type": "prestamo",
            "producto": {
                "valNumeroProducto": "986875671532"
            }
        },
        {
            "type": "cuenta",
            "codCuentaHabiente": "77666555"
        },
        {
            "type": "oficina",
            "codOficina": 1
        },
        {
            "type": "moneda",
            "multimoneda": "N"
        },
        {
            "type": "canal",
            "servicio": "10
        }
    ]
}
```
