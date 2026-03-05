##### DynamoDB Parameter - Lambda Parámetros

```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#LOAN_PAYMENT#PARAM#EXECUTION",
  "sk": "V#0001",
  "name": "EXECUTION",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "param-name": "ban-hnd-xx-connection-interbanca-param-db-<env>",
      "T24T057.INTACCOUNT.USERS": "SRV-ITPEUS||SRV-ITSABF||SRV-ITUTSP||SRV-ITUSAC||SRV-ITVHUR||SRV-ITSIAF||SRV-ITPMS2||HNBNINTTSP||SRV-ITUT24||SRV-ITLBTR||HNBNSVCSAP||HNBNSVCOMNRBT||HNBNSVCDSRFACT||HNBNSVCQAFACT||SRV-ITALCN||HNBNQASCORE||HNBNQAONBASE||SRV-ITPMSV||HNBNAQABTPRESTA||HNBNDSRLBTRPWS", // Validar uso de este parámetro, no se evidencia en el flujo
      "orderingbank": "999999",
      "hu5576": {
        "desciption-cb": "CODIGO_CORRESPONSAL",
        "paymentType": "ACCOUNT_DEBIT"
      },
      "hu57003": {
        "noOfAuth": "0",
        "accountGroup": "1", 
        "accountMultiple": "1"
      },
      "hu57060": {
        "chequeNoOfAuth": "0",
        "groupAttribute": "1",
        "multiGroupAttribute": "1",
        "transaction": "CLEARING"
      },
      "hu57119": {
        "paymentGroupAttribute": "1",
        "T24T134.HNLCREDITACCTNO": "HNL160150055",
        "T24T134.USDCREDITACCTNO": "USD160150057",
        "T24T133.TXNTYPELOANPYMT": "ACPH"
      }       
    },
    {
      "region": "GT01-GT01",
      "enabled": false
    },
    {
      "region": "NI01-NI01",
      "enabled": false,
      "channelOr": "1",
      "ipAddress": "OMNICANAL",
      "branchReference": "1",
      "currencyCode": "N",
      "serviceReference": "10"

    },
    {
      "region": "PA01-PA01",
      "enabled": false
    }
  ],
  "type": "JSON",
  "description": "CONFIG OF LOAN_PAYMENT BY METHOD",
  "country": "XRS",
  "domain": "LOAN_PAYMENT",
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
    "callerService": "customer_loan_fulfill-product-EXECUTION",
    "service": "customer_loan_fulfill-product",
    "method": "EXECUTION",
    "domain": "LOAN_PAYMENT",
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
        "callerService": "customer_loan_fulfill-product-EXECUTION",
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
