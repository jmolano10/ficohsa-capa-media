##### DynamoDB Parameter - Librería de parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#HND#DOMAIN#LOAN_ADMIN#PARAM#EXECUTE_LOAN_REPAYMENT",
  "sk": "V#0001",
  "name": "EXECUTE_LOAN_REPAYMENT",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true
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
  "description": "CONFIG OF LOAN_ADMIN BY METHOD",
  "country": "HND",
  "domain": "LOAN_ADMIN",
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
"ban-hnd-ic-comp-param-t24-tengo-transactions-wsdl-dev"
{
  "ip": "http://172.23.177.15",
  "port": "7003",
  "basePath": "svcRegistraTransaccionTengo/services "
}
```

```json
"ban-hnd-ic-comp-param-t24-tengo-transactions-wsdl-qa"
{
  "ip": "10.242.15.43",
  "port": "7020",
  "basePath": "svcRegistraTransaccionTengo/services "
}
```

##### AWS Systems Manager SecretManager

```json
"ban-hnd-ic-comp-secm-t24-tengo-transactions-wsdl-dev"
{
  "username": "HNITINTB",
  "password": "intb2013$HN"
}
```

##### Constantes para almacenar en ConfigMap

```json
{
  "operation": "RetiroEfectivoTengo",
  "caller-service": "LOAN_ADMIN-product-EXECUTE_LOAN_REPAYMENT"
}
```
##### Registro en Dynamo Wrapper T24

**Operacion Retiro En Efectivo**

```json
{
  "pk": "COUNTRY#HND#DOMAIN#WRAPPER_T24#PARAM#srv-itintb|LOAN_ADMIN-product-EXECUTE_LOAN_REPAYMENT",
  "sk": "V#0001",
  "name": "srv-itintb|LOAN_ADMIN-product-EXECUTE_LOAN_REPAYMENT",
  "value": {
    "secret-name": "ban-hnd-ic-comp-secm-t24-tengo-transactions-wsdl-dev",
    "param-name": "ban-hnd-ic-comp-param-t24-tengo-transactions-wsdl-dev"
  },
  "type": "json",
  "description": "Credenciales de la operación ConsultaFinanciamientosCliente del LOAN_ADMIN-product-EXECUTE_LOAN_REPAYMENT",
  "country": "HND",
  "domain": "WRAPPER_T24",
  "tags": [
    "tengo-cahs-withdrawal",
  ],
  "precedence": 1,
  "effective_from": "",
  "effective_to": "",
  "status": "active",
  "updated_at": "2025-10-25T18:10:00Z",
  "updated_by": "david.j.molano@ficohsa.com"
}
```

##### Registro en Dynamo Componente de idempotencia

```json
{
  "PK": "loan_admin-product-EXECUTE_LOAN_REPAYMENT",
  "SK": "1.0|ACTIVE",
  "version": "1.0",
  "stage": "ACTIVE",
  "callerService": "loan_admin-product-EXECUTE_LOAN_REPAYMENT",
  "service": "current-account-mgmt-product",
  "method": "initiate-check-deposit",
  "domain": "current-account",
  "typeUsage": "IDEM",
  "hashFields": [
    "transactionType",
    "debitAccountNumber",
    "debitCurrencyCode",
    "debitAmount",
    "creditAccountNumber",
    "paymentDetailsDescription",
    "tengoReference"
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
--header 'Caller-Service: LOAN_ADMIN-product-EXECUTE_LOAN_REPAYMENT' \
--header 'Correlation-Id: b1f6f6f5-d611-4c1f-843f-89a1c8aaaaee' \
--header 'Authorization: Bearer my.token.loko' \
--header 'Source-Bank: HN01' \
--header 'Application-Id: 123456789' \
--header 'Channel: my-channel' \
--header 'Content-Type: application/json' \
--data '{
  "methodVersion": "1.0",
  "dataPayload": {
    "OfsFunction": {
      "gtsControl": "string",
      "authorizationsNumber": "string",
      "replaceIndicator": "string"
    },
    "FundsTransferRetailInternationalType": {
      "transactionType": "string",
      "debitAccountNumber": "string",
      "debitCurrencyCode": "string",
      "debitAmount": "string",
      "creditAccountNumber": "string",
      "creditCurrencyCode": "string",
      "processingDate": "2024-01-15",
      "orderingBankDetails": {
        "groupAttribute": "string",
        "orderingBankReference": [
          "string"
        ]
      },
      "paymentDetails": {
        "groupAttribute": "string",
        "paymentDetailsDescription": [
          "string"
        ]
      },
      "chargesAccountNumber": "string",
      "chargeCode": "string",
      "chargeTypeDetails": {
        "groupAttribute": "string",
        "chargeTypeMultigroup": [
          {
            "multigroupAttribute": "string",
            "chargeType": "string",
            "chargeAmount": "string",
            "chargeParty": "string"
          }
        ]
      },
      "profitCenterDepartment": "string",
      "amountDebited": "string",
      "amountCredited": "string",
      "beneficiaryName": "string",
      "categoryCode": "string",
      "subcategoryCode": "string",
      "itemCode": "string",
      "subitemCode": "string",
      "groupCode": "string",
      "bankIdentificationCodeLR": "string",
      "foreignCurrencyDeclarationNumber": "string",
      "auctionIdentification": "string",
      "usdCreditAmount": "string",
      "rateOptionCode": "string",
      "auctionRate": "string",
      "economicActivityCode": "string",
      "usdAuctionAmount": "string",
      "verifierName": "string",
      "customerRate": "string",
      "beneficiaryPaymentAccountIdentification": "string",
      "narrativeAddendum": "string",
      "paymentAchType": "string",
      "tengoReference": "string"
    }
  }
}'
```

##### Ejemplo mensaje en Event Brigde para componente de Idempotencia
```json
{
  "Source": "microservice.response",
  "DetailType": "provider.response",
  "Detail": {
    "correlation-id": "header.correlation-id",
    "callerService": "LOAN_ADMIN-product-EXECUTE_LOAN_REPAYMENT",
    "channel": "rest-api",
    "transactionStatus": "success", // || "timeout" || "error" || "fault"
    "payload": {
      "host": "http://abanks-url",
      "headers": {}, // headers etc
      "body": {
        "OfsFunction": {
          "gtsControl": "string",
          "authorizationsNumber": "string",
          "replaceIndicator": "string"
        },
        "FundsTransferRetailInternationalType": {
          "transactionType": "string",
          "debitAccountNumber": "string",
          "debitCurrencyCode": "string",
          "debitAmount": "string",
          "creditAccountNumber": "string",
          "creditCurrencyCode": "string",
          "processingDate": "2024-01-15",
          "orderingBankDetails": {
            "groupAttribute": "string",
            "orderingBankReference": [
              "string"
            ]
          },
          "paymentDetails": {
            "groupAttribute": "string",
            "paymentDetailsDescription": [
              "string"
            ]
          },
          "chargesAccountNumber": "string",
          "chargeCode": "string",
          "chargeTypeDetails": {
            "groupAttribute": "string",
            "chargeTypeMultigroup": [
              {
                "multigroupAttribute": "string",
                "chargeType": "string",
                "chargeAmount": "string",
                "chargeParty": "string"
              }
            ]
          },
          "profitCenterDepartment": "string",
          "amountDebited": "string",
          "amountCredited": "string",
          "beneficiaryName": "string",
          "categoryCode": "string",
          "subcategoryCode": "string",
          "itemCode": "string",
          "subitemCode": "string",
          "groupCode": "string",
          "bankIdentificationCodeLR": "string",
          "foreignCurrencyDeclarationNumber": "string",
          "auctionIdentification": "string",
          "usdCreditAmount": "string",
          "rateOptionCode": "string",
          "auctionRate": "string",
          "economicActivityCode": "string",
          "usdAuctionAmount": "string",
          "verifierName": "string",
          "customerRate": "string",
          "beneficiaryPaymentAccountIdentification": "string",
          "narrativeAddendum": "string",
          "paymentAchType": "string",
          "tengoReference": "string"
        }
      }
    }
  }
}
```
##### Ejemplo de request Wrapper T24
```json
postman request POST 'http://localhost:8080/t24-wrapper-hnd/v2/RetiroEfectivoTengo' \
  --header 'Content-Type: application/json' \
  --header 'Correlation-Id: de957188-87a4-4808-a97e-d5da44a7798f' \
  --header 'Accept-Language: es' \
  --header 'Authorization: Bearer token.ok.ok' \
  --header 'Caller-Service: LOAN_ADMIN-product-EXECUTE_LOAN_REPAYMENT' \
  --header 'Channel: C001' \
  --header 'APP_CONTEXTUAL: 1' \
  --header 'Destination-Bank: test' \
  --header 'Source-Bank: test' \
  --header 'Application-Id: srv-itintb' \
  --body '{
  "operation": "RetiroEfectivoTengo",
  "payload": {
    "type": "FUNDSTRANSFERRETAILINTSALEWSType",
    "data": {
      "OfsFunction": {
        "messageId": "de957188-87a4-4808-a97e-d5da44a7798f"
      },
      "FUNDSTRANSFERRETAILINTSALEWSType": {
        "TransactionType": "ACPH",
        "DebitAccount": "HNL151450001",
        "DebitCurrency": "HNL",
        "DebitAmount": "100",
        "CreditAccount": "HNL160150055",
        "gPAYMENTDETAILS": {
            "attribute": {
                "g": "1"
            },
            "PaymentDetails": "PTM-001466391221"
        },
        "LRREFTENGO": "123456789984443"
      }
    }
  }
}'
```

##### Ejemplo request consumo operacion RetiroEfectivoTengo T24

```xml
<soapenv:Body xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
  <t24:RetiroEfectivoTengo xmlns:t24="T24WebServicesImpl">
    <WebRequestCommon>
      <userName>HNITINTB</userName>
      <password>intb2013$HN</password>
    </WebRequestCommon>
    <OfsFunction>
      <messageId>02241b9e9108-4a2a-4f55-8c92-a0bf137480e7</messageId>
    </OfsFunction>
    <FUNDSTRANSFERRETAILINTSALEWSType>
      <TransactionType>ACPH</TransactionType>
      <DebitAccount>HNL151450001</DebitAccount>
      <DebitCurrency>HNL</DebitCurrency>
      <DebitAmount>1</DebitAmount>
      <CreditAccount>HNL160150055</CreditAccount>
      <gPAYMENTDETAILS g="1">
        <PaymentDetails>PTM-001466391221</PaymentDetails>
      </gPAYMENTDETAILS>
      <LRREFTENGO>123456789984443</LRREFTENGO>
    </FUNDSTRANSFERRETAILINTSALEWSType>
  </t24:RetiroEfectivoTengo>
</soapenv:Body>
```

##### Ejemplo response consumo operación RetiroEfectivoTengo T24

```xml
<S:Body xmlns:S="http://schemas.xmlsoap.org/soap/envelope/">
  <ns2:RetiroEfectivoTengoResponse xmlns:ns2="T24WebServicesImpl">
    <Status>
      <transactionId>FT230830SJYY</transactionId>
      <messageId>02241b9e9108-4a2a-4f55-8c92-a0bf137480e7</messageId>
      <successIndicator>Success</successIndicator>
      <application>FUNDS.TRANSFER</application>
    </Status>
    <FUNDSTRANSFERType id="FT230830SJYY">
      <TRANSACTIONTYPE>ACPH</TRANSACTIONTYPE>
      <DEBITACCTNO>HNL151450001</DEBITACCTNO>
      <CURRENCYMKTDR>1</CURRENCYMKTDR>
      <DEBITCURRENCY>HNL</DEBITCURRENCY>
      <DEBITAMOUNT>1.00</DEBITAMOUNT>
      <DEBITVALUEDATE>20230324</DEBITVALUEDATE>
      <CREDITACCTNO>HNL160150055</CREDITACCTNO>
      <CURRENCYMKTCR>1</CURRENCYMKTCR>
      <CREDITCURRENCY>HNL</CREDITCURRENCY>
      <CREDITVALUEDATE>20230324</CREDITVALUEDATE>
      <PROCESSINGDATE>20230324</PROCESSINGDATE>
      <gORDERINGBANK>
        <ORDERINGBANK>999999</ORDERINGBANK>
      </gORDERINGBANK>
      <gPAYMENTDETAILS>
        <PAYMENTDETAILS>PTM-001466391221</PAYMENTDETAILS>
      </gPAYMENTDETAILS>
      <CHARGECOMDISPLAY>NO</CHARGECOMDISPLAY>
      <COMMISSIONCODE>WAIVE</COMMISSIONCODE>
      <CHARGECODE>WAIVE</CHARGECODE>
      <PROFITCENTREDEPT>1</PROFITCENTREDEPT>
      <RETURNTODEPT>NO</RETURNTODEPT>
      <FEDFUNDS>NO</FEDFUNDS>
      <POSITIONTYPE>TR</POSITIONTYPE>
      <AMOUNTDEBITED>HNL1.00</AMOUNTDEBITED>
      <AMOUNTCREDITED>HNL1.00</AMOUNTCREDITED>
      <CREDITCOMPCODE>HN0010001</CREDITCOMPCODE>
      <DEBITCOMPCODE>HN0010001</DEBITCOMPCODE>
      <LOCAMTDEBITED>1.00</LOCAMTDEBITED>
      <LOCAMTCREDITED>1.00</LOCAMTCREDITED>
      <DRADVICEREQDYN>N</DRADVICEREQDYN>
      <CRADVICEREQDYN>N</CRADVICEREQDYN>
      <TOTRECCOMM>0</TOTRECCOMM>
      <TOTRECCOMMLCL>0</TOTRECCOMMLCL>
      <TOTRECCHG>0</TOTRECCHG>
      <TOTRECCHGLCL>0</TOTRECCHGLCL>
      <RATEFIXING>NO</RATEFIXING>
      <TOTRECCHGCRCCY>0</TOTRECCHGCRCCY>
      <TOTSNDCHGCRCCY>0</TOTSNDCHGCRCCY>
      <AUTHDATE>20230324</AUTHDATE>
      <ROUNDTYPE>NATURAL</ROUNDTYPE>
      <gSTMTNOS>
        <STMTNOS>212406374863672.01</STMTNOS>
        <STMTNOS>1-2</STMTNOS>
      </gSTMTNOS>
      <CURRNO>1</CURRNO>
      <gINPUTTER>
        <INPUTTER>63748_HN.ITINTB__OFS_TWS</INPUTTER>
      </gINPUTTER>
      <gDATETIME>
        <DATETIME>2602241741</DATETIME>
      </gDATETIME>
      <AUTHORISER>63748_HN.ITINTB_OFS_TWS</AUTHORISER>
      <COCODE>HN0010001</COCODE>
      <DEPTCODE>1</DEPTCODE>
      <LRHALFPYMT>3</LRHALFPYMT>
      <LRRESIDENT>2</LRRESIDENT>
      <LROTHEROFFCER>110000000000</LROTHEROFFCER>
      <LRDAYDATE>20230324</LRDAYDATE>
      <LRCLIENTTYPE>Non-Legal</LRCLIENTTYPE>
      <LRVERNAME>FICO.USDRSBUY</LRVERNAME>
      <IFEVENTFILTER>N</IFEVENTFILTER>
      <LRREFTENGO>123456789984443</LRREFTENGO>
    </FUNDSTRANSFERType>
  </ns2:RetiroEfectivoTengoResponse>
</S:Body>
```