##### DynamoDB Parameter - Lambda Parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#HND#DOMAIN#CURRENT_ACCOUNT_MGMT#PARAM#INITIATE_CHECK_DEPOSIT",
  "sk": "V#0001",
  "name": "INITIATE_CHECK_DEPOSIT",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "t24ChqAccountHNL": "HNL160150057",
      "t24ChqAccountUSD": "USD160150058",
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
  "description": "CONFIG OF CURRENT_ACCOUNT_MGMT BY METHOD",
  "country": "HND",
  "domain": "CURRENT_ACCOUNT_MGMT",
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
"ban-hnd-ic-comp-param-t24-cheque-deposit-wsdl-dev"
{
  "ip": "http://172.23.177.15",
  "port": "7003",
  "basePath": "/svcDepositos/services"
}
```

```json
"ban-hnd-ic-comp-param-t24-cheque-deposit-wsdl-qa"
{
  "ip": "10.242.15.43",
  "port": "7020",
  "basePath": "/svcDepositos/services"
}
```

##### AWS Systems Manager SecretManager

```json
"ban-hnd-ic-comp-secm-t24-cheque-deposit-wsdl-dev"
{
  "username": "HNITINTB",
  "password": "intb2013$HN"
}
```

##### Constantes para almacenar en ConfigMap

```json
{
  "operation": "Depositocombinado"
}
```
##### Registro en Dynamo Wrapper T24

**Operacion Depósito Combinado**

```json
{
  "pk": "COUNTRY#HND#DOMAIN#WRAPPER_T24#PARAM#srv-itintb|CURRENT_ACCOUNT_MGMT-product-INITIATE_CHECK_DEPOSIT",
  "sk": "V#0001",
  "name": "srv-itintb|CURRENT_ACCOUNT_MGMT-product-INITIATE_CHECK_DEPOSIT",
  "value": {
    "secret-name": "ban-hnd-ic-comp-secm-t24-cheque-deposit-wsdl-dev",
    "param-name": "ban-hnd-ic-comp-param-t24-cheque-deposit-wsdl-dev"
  },
  "type": "json",
  "description": "Credenciales de la operación ConsultaFinanciamientosCliente del CURRENT_ACCOUNT_MGMT-product-INITIATE_CHECK_DEPOSIT",
  "country": "HND",
  "domain": "WRAPPER_T24",
  "tags": [
    "cash-deposit-11",
    "secret-manager-key"
  ],
  "precedence": 1,
  "effective_from": "",
  "effective_to": "",
  "status": "active",
  "updated_at": "2025-10-25T18:10:00Z",
  "updated_by": "alejandro@ficohsa.com"
}
```

##### Registro en Dynamo Componente de idempotencia

```json
{
    "PK": "current-account-mgmt-product-initiate-check-deposit",
    "SK": "1.0|ACTIVE",
    "version": "1.0",
    "stage": "ACTIVE",
    "callerService": "current-account-mgmt-product-initiate-check-deposit",
    "service": "current-account-mgmt-product",
    "method": "initiate-check-deposit",
    "domain": "current-account",
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
    "updated_by": "david.j.molano@ficohsa.com",
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

##### Ejemplo de request Wrapper T24
```json
postman request POST 'http://localhost:8080/t24-wrapper-hnd/v2/Depositocombinado' \
  --header 'Content-Type: application/json' \
  --header 'Correlation-Id: de957188-87a4-4808-a97e-d5da44a7798f' \
  --header 'Accept-Language: es' \
  --header 'Authorization: Bearer token.ok.ok' \
  --header 'Caller-Service: Solicituddechequera_Validate' \
  --header 'Channel: C001' \
  --header 'APP_CONTEXTUAL: 1' \
  --header 'Destination-Bank: test' \
  --header 'Source-Bank: test' \
  --header 'Application-Id: srv-itintb' \
  --body '{
  "operation": "Depositocombinado",
  "payload": {
    "type": "TELLERFINANCIALSERVICESFICOINPUTWSType",
    "data": {
      "OfsFunction": {
        "messageId": "",
        "noOfAuth": "0"
      },
      "TELLERFINANCIALSERVICESFICOINPUTWSType": {
        "DepositAccount": "123456",
        "gTRANSACTION": {
            "attribute": {
                "g": "1"
            },
            "mTRANSACTION": {
                "attribute": {
                    "m": "1"
                },
                "TRANSACTION": "CLEARING",
                "CURRENCY": "HNL",
                "AMOUNT": "987655555",
                "SORTCODE": "BANCOL",
                "CHEQUE_NUMBER": "12345"
            }
        }
      }
    }
  }
}'
```

##### Request consumo operaciones T24

**Operacion Depositocombinado HNL**

```xml 
<soapenv:Body xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
    <t24:Depositocombinado xmlns:t24="T24WebServicesImpl">
        <WebRequestCommon>
            <userName>HNITINTB</userName>
            <password>intb2013$HN</password>
        </WebRequestCommon>
        <OfsFunction>
            <messageId>02240493c97b-5091-4592-834c-7ca08cf8b837</messageId>
            <noOfAuth>0</noOfAuth>
        </OfsFunction>
        <TELLERFINANCIALSERVICESFICOINPUTWSType>
            <DepositAccount>HNL160150057</DepositAccount>
            <gTRANSACTION g="1">
                <mTRANSACTION m="1">
                    <TRANSACTION>CLEARING</TRANSACTION>
                    <CURRENCY>HNL</CURRENCY>
                    <AMOUNT>1</AMOUNT>
                    <SORTCODE>1</SORTCODE>
                    <CHEQUENUMBER>234234433</CHEQUENUMBER>
                </mTRANSACTION>
            </gTRANSACTION>
        </TELLERFINANCIALSERVICESFICOINPUTWSType>
    </t24:Depositocombinado>
</soapenv:Body>
```

**Operacion Depositocombinado USD**
```xml 
<soapenv:Body xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
    <t24:Depositocombinado xmlns:t24="T24WebServicesImpl">
        <WebRequestCommon>
            <userName>HNITINTB</userName>
            <password>intb2013$HN</password>
        </WebRequestCommon>
        <OfsFunction>
            <messageId>02240493c97b-5091-4592-834c-7ca08cf8b837</messageId>
            <noOfAuth>0</noOfAuth>
        </OfsFunction>
        <TELLERFINANCIALSERVICESFICOINPUTWSType>
            <DepositAccount>HNL160150057</DepositAccount>
            <gTRANSACTION g="1">
                <mTRANSACTION m="1">
                    <TRANSACTION>CLEARING</TRANSACTION>
                    <CURRENCY>USD</CURRENCY>
                    <AMOUNT>1</AMOUNT>
                    <SORTCODE>1</SORTCODE>
                    <CHEQUENUMBER>234234433</CHEQUENUMBER>
                </mTRANSACTION>
            </gTRANSACTION>
        </TELLERFINANCIALSERVICESFICOINPUTWSType>
    </t24:Depositocombinado>
</soapenv:Body>
```

##### Response consumo operaciones T24

```xml
<S:Body xmlns:S="http://schemas.xmlsoap.org/soap/envelope/">
    <ns2:DepositocombinadoResponse xmlns:ns2="T24WebServicesImpl">
        <Status>
            <transactionId>TFS23083BHZ53</transactionId>
            <messageId>02240493c97b-5091-4592-834c-7ca08cf8b837</messageId>
            <successIndicator>Success</successIndicator>
            <application>TELLER.FINANCIAL.SERVICES</application>
        </Status>
        <TELLERFINANCIALSERVICESType id="TFS23083BHZ53">
            <BOOKINGDATE>20230324</BOOKINGDATE>
            <PRIMARYACCOUNT>HNL160150057</PRIMARYACCOUNT>
            <PRIMARYACCOUNTINT>HNL160150057</PRIMARYACCOUNTINT>
            <CONSOLINSTRUCTION>NO</CONSOLINSTRUCTION>
            <gTRANSACTION>
                <mTRANSACTION>
                    <TRANSACTION>CLEARING</TRANSACTION>
                    <TRANSACTIONINT>CLEARING</TRANSACTIONINT>
                    <SURROGATEAC>HNL160150057</SURROGATEAC>
                    <ACCOUNTDR>HNL140258855</ACCOUNTDR>
                    <CURRENCYDR>HNL</CURRENCYDR>
                    <CCYDRINT>HNL</CCYDRINT>
                    <EXCHTXNDR>1</EXCHTXNDR>
                    <AMOUNTDR>1.00</AMOUNTDR>
                    <AMOUNTDRLCY>1,00</AMOUNTDRLCY>
                    <ACCOUNTCR>HNL160150057</ACCOUNTCR>
                    <CURRENCYCR>HNL</CURRENCYCR>
                    <CCYCRINT>HNL</CCYCRINT>
                    <EXCHTXNCR>1</EXCHTXNCR>
                    <AMOUNTCR>1.00</AMOUNTCR>
                    <AMOUNTCRLCY>1.00</AMOUNTCRLCY>
                    <CURRENCY>HNL</CURRENCY>
                    <CURRENCYINT>HNL</CURRENCYINT>
                    <AMOUNT>1.00</AMOUNT>
                    <AMOUNTINT>1.00</AMOUNTINT>
                    <AMOUNTLCY>1.00</AMOUNTLCY>
                    <DEALRATE>1</DEALRATE>
                    <DEALRATEINT>1</DEALRATEINT>
                    <WAIVECHARGE>NO</WAIVECHARGE>
                    <CRVALUEDATE>20230324</CRVALUEDATE>
                    <DRVALUEDATE>20230324</DRVALUEDATE>
                    <SORTCODE>1</SORTCODE>
                    <CHEQUENUMBER>234234433</CHEQUENUMBER>
                    <CREXPDATE>20230324</CREXPDATE>
                    <DREXPDATE>20230324</DREXPDATE>
                    <DRCURRMKT>1</DRCURRMKT>
                    <CRCURRMKT>1</CRCURRMKT>
                    <UNDERLYING>TT23083LFRJK</UNDERLYING>
                    <ULSTATUS>AUT</ULSTATUS>
                    <sgULSTMTNO>
                        <ULSTMTNO>212406374864156.03</ULSTMTNO>
                        <ULSTMTNO>1-2</ULSTMTNO>
                    </sgULSTMTNO>
                    <ULCOMPANY>HN0010001</ULCOMPANY>
                </mTRANSACTION>
            </gTRANSACTION>
            <gRTACCOUNTNO>
                <mRTACCOUNTNO>
                    <RTACCOUNTNO>HNL160150057</RTACCOUNTNO>
                    <RUNNINGTOTAL>1.00</RUNNINGTOTAL>
                </mRTACCOUNTNO>
                <mRTACCOUNTNO>
                    <RTACCOUNTNO>HNL140258855</RTACCOUNTNO>
                    <RUNNINGTOTAL>-1.00</RUNNINGTOTAL>
                </mRTACCOUNTNO>
            </gRTACCOUNTNO>
            <gOVERRIDE>
                <OVERRIDE>
                    EB-NO.DEP.CUST.ID}ID DE DEPOSITO DE CLIENTE NO INGRESADO !O-10632
                </OVERRIDE>
            </gOVERRIDE>
            <CURRNO>1</CURRNO>
            <gINPUTTER>
                <INPUTTER>63748_HN.ITINTB__OFS_TWS_TT23083R2PFH</INPUTTER>
            </gINPUTTER>
            <gDATETIME>
                <DATETIME>2602241749</DATETIME>
            </gDATETIME>
            <AUTHORISER>63748_HN.ITINTB_OFS_TWS_TT23083R2PFH</AUTHORISER>
            <COCODE>HN0010001</COCODE>
            <DEPTCODE>1</DEPTCODE>
            <LRCRCCY>HNL</LRCRCCY>
            <LRTELLERID>8855</LRTELLERID>
            <LRAGENCYCODE>1110000000000</LRAGENCYCODE>
            <gLR.CONSOL.TXN>
                <mLR.CONSOL.TXN>
                    <LRCONSOLTXN>CLEARING</LRCONSOLTXN>
                    <LRCONSOLAMT>1</LRCONSOLAMT>
                </mLR.CONSOL.TXN>
            </gLR.CONSOL.TXN>
            <LRCONSOLTOT>1</LRCONSOLTOT>
            <RTEFORM>NO</RTEFORM>
            <gLR.ECONOMIC.ACT>
                <mLR.ECONOMIC.ACT>
                    <LRECONOMICACT>99</LRECONOMICACT>
                    <LRFCYDECNO>0</LRFCYDECNO>
                </mLR.ECONOMIC.ACT>
            </gLR.ECONOMIC.ACT>
        </TELLERFINANCIALSERVICESType>
    </ns2:DepositocombinadoResponse>
</S:Body>
```