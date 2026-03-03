##### DynamoDB Parameter - Lambda Parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#HND#DOMAIN#LOAN_ADMIN#PARAM#EXECUTE REPAYMENT",
  "sk": "V#0001",
  "name": "EXECUTE REPAYMENT",
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
"ban-hnd-ic-comp-param-t24-cash-deposit-11-wsdl-dev"
{
  "ip": "http://172.23.177.15",
  "port": "7003",
  "basePath": "/svcTransferenciasFaseUnoHelios/services"
}
```

```json
"ban-hnd-ic-comp-param-t24-cash-deposit-11-wsdl-qa"
{
  "ip": "http://10.242.15.43",
  "port": "7020",
  "basePath": "/svcTransferenciasFaseUnoHelios/services"
}
```

```json
"ban-hnd-ic-comp-param-t24-cash-deposit-12-wsdl-dev"
{
  "ip": "http://172.23.177.15",
  "port": "7003",
  "basePath": "/svcTransferenciasFaseUnoHelios/services"
}
```

```json
"ban-hnd-ic-comp-param-t24-cash-deposit-12-wsdl-qa"
{
  "ip": "http://10.242.15.43",
  "port": "7020",
  "basePath": "/svcTransferenciasFaseUnoHelios/services"
}
```

##### AWS Systems Manager SecretManager

```json
"ban-hnd-ic-comp-secm-t24-cash-deposit-11-wsdl-dev"
{
  "username": "HNITINTB",
  "password": "intb2013$HN"
}
```
```json
"ban-hnd-ic-comp-secm-t24-cash-deposit-12-wsdl-dev"
{
  "username": "HNITINTB",
  "password": "intb2013$HN"
}
```

##### Constantes para almacenar en ConfigMap

```json
{
  "operationHnl": "Depositoenefectivofase11",
  "operationUsd": "Depositoenefectivofase12",
  "caller-service-hnl": "LOAN_ADMIN-product-EXECUTE_REPAYMENT_Depositoenefectivofase11",
  "caller-service-usd": "LOAN_ADMIN-product-EXECUTE_REPAYMENT_Depositoenefectivofase12"
}
```
##### Registro en Dynamo Wrapper T24

**Operacion Depositoenefectivofase11**

```json
{
  "pk": "COUNTRY#HND#DOMAIN#WRAPPER_T24#PARAM#srv-itintb|LOAN_ADMIN-product-EXECUTE_REPAYMENT_Depositoenefectivofase11",
  "sk": "V#0001",
  "name": "srv-itintb|LOAN_ADMIN-product-EXECUTE_REPAYMENT_Depositoenefectivofase11",
  "value": {
    "secret-name": "ban-hnd-ic-comp-secm-t24-cash-deposit-11-wsdl-dev",
    "param-name": "ban-hnd-ic-comp-param-t24-cash-deposit-11-wsdl-dev"
  },
  "type": "json",
  "description": "Credenciales de la operación ConsultaFinanciamientosCliente del LOAN_ADMIN-product-EXECUTE_REPAYMENT_Depositoenefectivofase11",
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

**Operacion Depositoenefectivofase12**

```json
{
  "pk": "COUNTRY#HND#DOMAIN#WRAPPER_T24#PARAM#srv-itintb|LOAN_ADMIN-product-EXECUTE_REPAYMENT_Depositoenefectivofase12",
  "sk": "V#0001",
  "name": "srv-itintb|LOAN_ADMIN-product-EXECUTE_REPAYMENT_Depositoenefectivofase12",
  "value": {
    "secret-name": "ban-hnd-ic-comp-secm-t24-cash-deposit-12-wsdl-dev",
    "param-name": "ban-hnd-ic-comp-param-t24-cash-deposit-12-wsdl-dev"
  },
  "type": "json",
  "description": "Credenciales de la operación ConsultaFinanciamientosCliente del LOAN_ADMIN-product-EXECUTE_REPAYMENT_Depositoenefectivofase12",
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

##### Ejemplo de request Wrapper T24 Operacion Depositoenefectivofase11
```json
postman request POST 'http://localhost:8080/t24-wrapper-hnd/v2/Depositoenefectivofase11' \
  --header 'Content-Type: application/json' \
  --header 'Correlation-Id: de957188-87a4-4808-a97e-d5da44a7798f' \
  --header 'Accept-Language: es' \
  --header 'Authorization: Bearer token.ok.ok' \
  --header 'Caller-Service: LOAN_ADMIN-product-EXECUTE_REPAYMENT_Depositoenefectivofase11' \
  --header 'Channel: C001' \
  --header 'APP_CONTEXTUAL: 1' \
  --header 'Destination-Bank: test' \
  --header 'Source-Bank: test' \
  --header 'Application-Id: srv-itintb' \
  --body '{
  "operation": "Depositoenefectivofase11",
  "payload": {
    "type": "TELLERFICOLCYCASHINTMP1Type",
    "data": {
      "OfsFunction": {
        "messageId": "",
        "noOfAuth": "0"
      },
      "TELLERFICOLCYCASHINTMP1Type": {
        "gTRANSACTION": {
          "attribute": {
              "g": "1"
          },
          "mTRANSACTION": {
            "attribute": {
                "m": "1"
            },
            "DepositAmount": "12345"
          }
        }
      }
    }
  }
}'
```

##### Ejemplo de request Wrapper T24 Operacion Depositoenefectivofase12
```json
postman request POST 'http://localhost:8080/t24-wrapper-hnd/v2/Depositoenefectivofase12' \
  --header 'Content-Type: application/json' \
  --header 'Correlation-Id: de957188-87a4-4808-a97e-d5da44a7798f' \
  --header 'Accept-Language: es' \
  --header 'Authorization: Bearer token.ok.ok' \
  --header 'Caller-Service: LOAN_ADMIN-product-EXECUTE_REPAYMENT_Depositoenefectivofase12' \
  --header 'Channel: C001' \
  --header 'APP_CONTEXTUAL: 1' \
  --header 'Destination-Bank: test' \
  --header 'Source-Bank: test' \
  --header 'Application-Id: srv-itintb' \
  --body '{
  "operation": "Depositoenefectivofase12",
  "payload": {
    "type": "TELLERFICOLCYCASHINTMP1Type",
    "data": {
      "OfsFunction": {
        "messageId": "",
        "noOfAuth": "0"
      },
      "TELLERFICOLCYCASHINTMP1Type": {
        "CurrencyDeposited": "USD",
        "gTRANSACTION": {
          "attribute": {
              "g": "1"
          },
          "mTRANSACTION": {
            "attribute": {
                "m": "1"
            },
            "DepositAmount": "12345"
          }
        }
      }
    }
  }
}'
```


##### Request consumo operaciones T24

**Operacion Depositoenefectivofase11**

```xml 
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:t24="T24WebServicesImpl">
   <soapenv:Header/>
   <soapenv:Body>
      <t24:Depositoenefectivofase11>
         <!--Optional:-->
         <WebRequestCommon>
            <userName>?</userName>
            <password>?</password>
            <!--Optional:-->
            <company>?</company>
         </WebRequestCommon>
         <!--Optional:-->
         <OfsFunction>
            <!--Optional:-->
            <gtsControl>?</gtsControl>
            <!--Optional:-->
            <messageId>?</messageId>
            <!--Optional:-->
            <noOfAuth>?</noOfAuth>
            <!--Optional:-->
            <replace>?</replace>
         </OfsFunction>
         <!--Optional:-->
         <TELLERFICOLCYCASHINTMP1Type id="?">
            <!--Optional:-->
            <TransactionCode>?</TransactionCode>
            <!--Optional:-->
            <DrCrMarker>?</DrCrMarker>
            <!--Optional:-->
            <Currency>?</Currency>
            <!--Optional:-->
            <gACCOUNT1 g="?">
               <!--Zero or more repetitions:-->
               <mACCOUNT1 m="?">
                  <!--Optional:-->
                  <InternalAccount>?</InternalAccount>
                  <!--Optional:-->
                  <DepositAmount>?</DepositAmount>
               </mACCOUNT1>
            </gACCOUNT1>
            <!--Optional:-->
            <CreditAccount>?</CreditAccount>
            <!--Optional:-->
            <Customer>?</Customer>
            <!--Optional:-->
            <NetCredit>?</NetCredit>
            <!--Optional:-->
            <ValueDate>?</ValueDate>
            <!--Optional:-->
            <gNARRATIVE2 g="?">
               <!--Zero or more repetitions:-->
               <Narrative>?</Narrative>
            </gNARRATIVE2>
            <!--Optional:-->
            <WaiveCharges>?</WaiveCharges>
         </TELLERFICOLCYCASHINTMP1Type>
      </t24:Depositoenefectivofase11>
   </soapenv:Body>
</soapenv:Envelope>
```

**Operacion Depositoenefectivofase12**
```xml 
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:t24="T24WebServicesImpl">
   <soapenv:Header/>
   <soapenv:Body>
      <t24:Depositoenefectivofase12>
         <!--Optional:-->
         <WebRequestCommon>
            <userName>?</userName>
            <password>?</password>
            <!--Optional:-->
            <company>?</company>
         </WebRequestCommon>
         <!--Optional:-->
         <OfsFunction>
            <!--Optional:-->
            <gtsControl>?</gtsControl>
            <!--Optional:-->
            <messageId>?</messageId>
            <!--Optional:-->
            <noOfAuth>?</noOfAuth>
            <!--Optional:-->
            <replace>?</replace>
         </OfsFunction>
         <!--Optional:-->
         <TELLERFICOFCYCASHINTMP1Type id="?">
            <!--Optional:-->
            <DrCrMarker>?</DrCrMarker>
            <!--Optional:-->
            <CurrencyDeposited>?</CurrencyDeposited>
            <!--Optional:-->
            <gACCOUNT1 g="?">
               <!--Zero or more repetitions:-->
               <mACCOUNT1 m="?">
                  <!--Optional:-->
                  <InternalAccount>?</InternalAccount>
                  <!--Optional:-->
                  <AmountDeposited>?</AmountDeposited>
               </mACCOUNT1>
            </gACCOUNT1>
            <!--Optional:-->
            <ExchangeRate>?</ExchangeRate>
            <!--Optional:-->
            <CreditCurrency>?</CreditCurrency>
            <!--Optional:-->
            <Account>?</Account>
            <!--Optional:-->
            <Customer>?</Customer>
            <!--Optional:-->
            <NetAmount>?</NetAmount>
            <!--Optional:-->
            <ValueDate>?</ValueDate>
            <!--Optional:-->
            <gNARRATIVE2 g="?">
               <!--Zero or more repetitions:-->
               <Narrative>?</Narrative>
            </gNARRATIVE2>
            <!--Optional:-->
            <ChargeAmountLocal>?</ChargeAmountLocal>
            <!--Optional:-->
            <ChargeAmountForeign>?</ChargeAmountForeign>
            <!--Optional:-->
            <ChargeCode>?</ChargeCode>
            <!--Optional:-->
            <WaiveCharges>?</WaiveCharges>
         </TELLERFICOFCYCASHINTMP1Type>
      </t24:Depositoenefectivofase12>
   </soapenv:Body>
</soapenv:Envelope>
```

##### Response consumo operaciones T24

**Operacion Depositoenefectivofase11**
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:t24="T24WebServicesImpl">
   <soapenv:Header/>
   <soapenv:Body>
      <t24:Depositoenefectivofase11Response>
         <!--Optional:-->
         <Status>
            <!--Optional:-->
            <transactionId>?</transactionId>
            <!--Optional:-->
            <messageId>?</messageId>
            <!--Optional:-->
            <successIndicator>?</successIndicator>
            <!--Optional:-->
            <application>?</application>
            <!--Zero or more repetitions:-->
            <messages>?</messages>
         </Status>
         <!--Optional:-->
         <TELLERType id="?">
            <!--Optional:-->
            <TRANSACTIONCODE>?</TRANSACTIONCODE>
            <!--Optional:-->
            <TELLERID1>?</TELLERID1>
            <!--Optional:-->
            <DRCRMARKER>?</DRCRMARKER>
            <!--Optional:-->
            <CURRENCY1>?</CURRENCY1>
            <!--Optional:-->
            <CUSTOMER1>?</CUSTOMER1>
            <!--Optional:-->
            <gACCOUNT1 g="?">
               <!--Zero or more repetitions:-->
               <mACCOUNT1 m="?">
                  <!--Optional:-->
                  <ACCOUNT1>?</ACCOUNT1>
                  <!--Optional:-->
                  <AMOUNTLOCAL1>?</AMOUNTLOCAL1>
                  <!--Optional:-->
                  <AMOUNTFCY1>?</AMOUNTFCY1>
                  <!--Optional:-->
                  <sgNARRATIVE1 sg="?">
                     <!--Zero or more repetitions:-->
                     <NARRATIVE1>?</NARRATIVE1>
                  </sgNARRATIVE1>
               </mACCOUNT1>
            </gACCOUNT1>
            <!--Optional:-->
            <RATE1>?</RATE1>
            <!--Optional:-->
            <VALUEDATE1>?</VALUEDATE1>
            <!--Optional:-->
            <EXPOSUREDATE1>?</EXPOSUREDATE1>
            <!--Optional:-->
            <CURRMARKET1>?</CURRMARKET1>
            <!--Optional:-->
            <POSTYPE1>?</POSTYPE1>
            <!--Optional:-->
            <DEALRATE>?</DEALRATE>
            <!--Optional:-->
            <CURRENCY2>?</CURRENCY2>
            <!--Optional:-->
            <TELLERID2>?</TELLERID2>
            <!--Optional:-->
            <ACCOUNT2>?</ACCOUNT2>
            <!--Optional:-->
            <CUSTOMER2>?</CUSTOMER2>
            <!--Optional:-->
            <AMOUNTLOCAL2>?</AMOUNTLOCAL2>
            <!--Optional:-->
            <RATE2>?</RATE2>
            <!--Optional:-->
            <AMOUNTFCY2>?</AMOUNTFCY2>
            <!--Optional:-->
            <NETAMOUNT>?</NETAMOUNT>
            <!--Optional:-->
            <VALUEDATE2>?</VALUEDATE2>
            <!--Optional:-->
            <EXPOSUREDATE2>?</EXPOSUREDATE2>
            <!--Optional:-->
            <CURRMARKET2>?</CURRMARKET2>
            <!--Optional:-->
            <POSTYPE2>?</POSTYPE2>
            <!--Optional:-->
            <gNARRATIVE2 g="?">
               <!--Zero or more repetitions:-->
               <NARRATIVE2>?</NARRATIVE2>
            </gNARRATIVE2>
            <!--Optional:-->
            <gCHEQUENUMBER g="?">
               <!--Zero or more repetitions:-->
               <mCHEQUENUMBER m="?">
                  <!--Optional:-->
                  <CHEQUENUMBER>?</CHEQUENUMBER>
                  <!--Optional:-->
                  <CHEQUEBANKCDE>?</CHEQUEBANKCDE>
                  <!--Optional:-->
                  <CHEQUEACCTNO>?</CHEQUEACCTNO>
               </mCHEQUENUMBER>
            </gCHEQUENUMBER>
            <!--Optional:-->
            <gCHARGECUSTOMER g="?">
               <!--Zero or more repetitions:-->
               <mCHARGECUSTOMER m="?">
                  <!--Optional:-->
                  <CHARGECUSTOMER>?</CHARGECUSTOMER>
                  <!--Optional:-->
                  <CHARGEACCOUNT>?</CHARGEACCOUNT>
                  <!--Optional:-->
                  <CHARGECATEGORY>?</CHARGECATEGORY>
                  <!--Optional:-->
                  <CHRGDRTXNCDE>?</CHRGDRTXNCDE>
                  <!--Optional:-->
                  <CHRGCRTXNCDE>?</CHRGCRTXNCDE>
                  <!--Optional:-->
                  <CHRGAMTLOCAL>?</CHRGAMTLOCAL>
                  <!--Optional:-->
                  <CHRGAMTFCCY>?</CHRGAMTFCCY>
                  <!--Optional:-->
                  <CHARGECODE>?</CHARGECODE>
               </mCHARGECUSTOMER>
            </gCHARGECUSTOMER>
            <!--Optional:-->
            <WAIVECHARGES>?</WAIVECHARGES>
            <!--Optional:-->
            <THEIRREFERENCE>?</THEIRREFERENCE>
            <!--Optional:-->
            <OURREFERENCE>?</OURREFERENCE>
            <!--Optional:-->
            <gDENOMINATION g="?">
               <!--Zero or more repetitions:-->
               <mDENOMINATION m="?">
                  <!--Optional:-->
                  <DENOMINATION>?</DENOMINATION>
                  <!--Optional:-->
                  <UNIT>?</UNIT>
                  <!--Optional:-->
                  <sgSERIALNO sg="?">
                     <!--Zero or more repetitions:-->
                     <SERIALNO>?</SERIALNO>
                  </sgSERIALNO>
               </mDENOMINATION>
            </gDENOMINATION>
            <!--Optional:-->
            <gDRDENOM g="?">
               <!--Zero or more repetitions:-->
               <mDRDENOM m="?">
                  <!--Optional:-->
                  <DRDENOM>?</DRDENOM>
                  <!--Optional:-->
                  <DRUNIT>?</DRUNIT>
                  <!--Optional:-->
                  <sgDRSERIALNO sg="?">
                     <!--Zero or more repetitions:-->
                     <DRSERIALNO>?</DRSERIALNO>
                  </sgDRSERIALNO>
               </mDRDENOM>
            </gDRDENOM>
            <!--Optional:-->
            <TRUSTCUSTOMER>?</TRUSTCUSTOMER>
            <!--Optional:-->
            <ROUNDINGAMOUNT>?</ROUNDINGAMOUNT>
            <!--Optional:-->
            <gNEWCUSTBAL g="?">
               <!--Zero or more repetitions:-->
               <NEWCUSTBAL>?</NEWCUSTBAL>
            </gNEWCUSTBAL>
            <!--Optional:-->
            <AMOUNTDEPOSITED>?</AMOUNTDEPOSITED>
            <!--Optional:-->
            <MKTEXCHPROFIT>?</MKTEXCHPROFIT>
            <!--Optional:-->
            <TRUSTSETTLECUST>?</TRUSTSETTLECUST>
            <!--Optional:-->
            <EXPOSURECCY>?</EXPOSURECCY>
            <!--Optional:-->
            <gEXPACCT g="?">
               <!--Zero or more repetitions:-->
               <mEXPACCT m="?">
                  <!--Optional:-->
                  <EXPACCT>?</EXPACCT>
                  <!--Optional:-->
                  <sgEXPSPTDAT sg="?">
                     <!--Zero or more repetitions:-->
                     <EXPSPTDAT s="?">
                        <!--Optional:-->
                        <EXPSPTDAT>?</EXPSPTDAT>
                        <!--Optional:-->
                        <EXPSPTAMT>?</EXPSPTAMT>
                     </EXPSPTDAT>
                  </sgEXPSPTDAT>
               </mEXPACCT>
            </gEXPACCT>
            <!--Optional:-->
            <DEALERDESK>?</DEALERDESK>
            <!--Optional:-->
            <CHEQTYPE>?</CHEQTYPE>
            <!--Optional:-->
            <STOCKREGISTER>?</STOCKREGISTER>
            <!--Optional:-->
            <SERIESID>?</SERIESID>
            <!--Optional:-->
            <STOCKNUMBER>?</STOCKNUMBER>
            <!--Optional:-->
            <CONTRACTGRP>?</CONTRACTGRP>
            <!--Optional:-->
            <AUTHDATE>?</AUTHDATE>
            <!--Optional:-->
            <CONTRACTMATDATE>?</CONTRACTMATDATE>
            <!--Optional:-->
            <POSSDUPDATE>?</POSSDUPDATE>
            <!--Optional:-->
            <CARDNUMBER>?</CARDNUMBER>
            <!--Optional:-->
            <gCARDTXNDETAIL g="?">
               <!--Zero or more repetitions:-->
               <CARDTXNDETAIL>?</CARDTXNDETAIL>
            </gCARDTXNDETAIL>
            <!--Optional:-->
            <TFSREFERENCE>?</TFSREFERENCE>
            <!--Optional:-->
            <CHEQUEDRAWN>?</CHEQUEDRAWN>
            <!--Optional:-->
            <RESERVED4>?</RESERVED4>
            <!--Optional:-->
            <RESERVED3>?</RESERVED3>
            <!--Optional:-->
            <RESERVED2>?</RESERVED2>
            <!--Optional:-->
            <RESERVED1>?</RESERVED1>
            <!--Optional:-->
            <gSTMTNO g="?">
               <!--Zero or more repetitions:-->
               <STMTNO>?</STMTNO>
            </gSTMTNO>
            <!--Optional:-->
            <gOVERRIDE g="?">
               <!--Zero or more repetitions:-->
               <OVERRIDE>?</OVERRIDE>
            </gOVERRIDE>
            <!--Optional:-->
            <RECORDSTATUS>?</RECORDSTATUS>
            <!--Optional:-->
            <CURRNO>?</CURRNO>
            <!--Optional:-->
            <gINPUTTER g="?">
               <!--Zero or more repetitions:-->
               <INPUTTER>?</INPUTTER>
            </gINPUTTER>
            <!--Optional:-->
            <gDATETIME g="?">
               <!--Zero or more repetitions:-->
               <DATETIME>?</DATETIME>
            </gDATETIME>
            <!--Optional:-->
            <AUTHORISER>?</AUTHORISER>
            <!--Optional:-->
            <COCODE>?</COCODE>
            <!--Optional:-->
            <DEPTCODE>?</DEPTCODE>
            <!--Optional:-->
            <AUDITORCODE>?</AUDITORCODE>
            <!--Optional:-->
            <AUDITDATETIME>?</AUDITDATETIME>
            <!--Optional:-->
            <gSTOCK.CODE g="?">
               <!--Zero or more repetitions:-->
               <mSTOCK.CODE m="?">
                  <!--Optional:-->
                  <STOCKCODE>?</STOCKCODE>
                  <!--Optional:-->
                  <QUANTITY>?</QUANTITY>
               </mSTOCK.CODE>
            </gSTOCK.CODE>
            <!--Optional:-->
            <DISCITEM>?</DISCITEM>
            <!--Optional:-->
            <PARTPAYMENT>?</PARTPAYMENT>
            <!--Optional:-->
            <BALREPAYMENT>?</BALREPAYMENT>
            <!--Optional:-->
            <gTRANS.REF g="?">
               <!--Zero or more repetitions:-->
               <TRANSREF>?</TRANSREF>
            </gTRANS.REF>
            <!--Optional:-->
            <gPEND.STOCK.CODE g="?">
               <!--Zero or more repetitions:-->
               <mPEND.STOCK.CODE m="?">
                  <!--Optional:-->
                  <PENDSTOCKCODE>?</PENDSTOCKCODE>
                  <!--Optional:-->
                  <PENDINGAMOUNT>?</PENDINGAMOUNT>
               </mPEND.STOCK.CODE>
            </gPEND.STOCK.CODE>
            <!--Optional:-->
            <SHORTNAME>?</SHORTNAME>
            <!--Optional:-->
            <LRTRMNLID>?</LRTRMNLID>
            <!--Optional:-->
            <LRPAYCODE>?</LRPAYCODE>
            <!--Optional:-->
            <gLR.INVOICE.NO g="?">
               <!--Zero or more repetitions:-->
               <mLR.INVOICE.NO m="?">
                  <!--Optional:-->
                  <LRINVOICENO>?</LRINVOICENO>
                  <!--Optional:-->
                  <LRINVOICEDT>?</LRINVOICEDT>
                  <!--Optional:-->
                  <LRDUEDATE>?</LRDUEDATE>
                  <!--Optional:-->
                  <LRAMT>?</LRAMT>
                  <!--Optional:-->
                  <LRPENALITYAMT>?</LRPENALITYAMT>
                  <!--Optional:-->
                  <LRPARTIALAMT>?</LRPARTIALAMT>
                  <!--Optional:-->
                  <LRTOTALAMT>?</LRTOTALAMT>
                  <!--Optional:-->
                  <LRPAYYN>?</LRPAYYN>
               </mLR.INVOICE.NO>
            </gLR.INVOICE.NO>
            <!--Optional:-->
            <LRIDENCODE>?</LRIDENCODE>
            <!--Optional:-->
            <LRTAXYEAR>?</LRTAXYEAR>
            <!--Optional:-->
            <gLR.TAX.PAY.NAME g="?">
               <!--Zero or more repetitions:-->
               <LRTAXPAYNAME>?</LRTAXPAYNAME>
            </gLR.TAX.PAY.NAME>
            <!--Optional:-->
            <LRTOTTAXDUE>?</LRTOTTAXDUE>
            <!--Optional:-->
            <gLR.MONTH g="?">
               <!--Zero or more repetitions:-->
               <mLR.MONTH m="?">
                  <!--Optional:-->
                  <LRMONTH>?</LRMONTH>
                  <!--Optional:-->
                  <LRAMTTOPAY>?</LRAMTTOPAY>
                  <!--Optional:-->
                  <LRTAXPAY>?</LRTAXPAY>
               </mLR.MONTH>
            </gLR.MONTH>
            <!--Optional:-->
            <LRAGCLIENTID>?</LRAGCLIENTID>
            <!--Optional:-->
            <LRCCARDNO>?</LRCCARDNO>
            <!--Optional:-->
            <LRPPORTVAL>?</LRPPORTVAL>
            <!--Optional:-->
            <LRPPORTPLACE>?</LRPPORTPLACE>
            <!--Optional:-->
            <LRPPORTTYPE>?</LRPPORTTYPE>
            <!--Optional:-->
            <LRAPPOINTNO>?</LRAPPOINTNO>
            <!--Optional:-->
            <LRAPPOINTDT>?</LRAPPOINTDT>
            <!--Optional:-->
            <LRAPPOINTCHG>?</LRAPPOINTCHG>
            <!--Optional:-->
            <LRAPPOINTTIME>?</LRAPPOINTTIME>
            <!--Optional:-->
            <LRPAYTYPE>?</LRPAYTYPE>
            <!--Optional:-->
            <LRORDPARID>?</LRORDPARID>
            <!--Optional:-->
            <LRORDNAME>?</LRORDNAME>
            <!--Optional:-->
            <LRDESTCNTRY>?</LRDESTCNTRY>
            <!--Optional:-->
            <LRBENID>?</LRBENID>
            <!--Optional:-->
            <LRBENNAME>?</LRBENNAME>
            <!--Optional:-->
            <LRRECMODE>?</LRRECMODE>
            <!--Optional:-->
            <LRRECDATE>?</LRRECDATE>
            <!--Optional:-->
            <LRREMITCODE>?</LRREMITCODE>
            <!--Optional:-->
            <RTEFORM>?</RTEFORM>
            <!--Optional:-->
            <LRIDNUMBER>?</LRIDNUMBER>
            <!--Optional:-->
            <LRDATEBIRTH>?</LRDATEBIRTH>
            <!--Optional:-->
            <gLR.STK.CODE g="?">
               <!--Zero or more repetitions:-->
               <mLR.STK.CODE m="?">
                  <!--Optional:-->
                  <LRSTKCODE>?</LRSTKCODE>
                  <!--Optional:-->
                  <LRPRODQUANT>?</LRPRODQUANT>
                  <!--Optional:-->
                  <LRUNITPRICE>?</LRUNITPRICE>
               </mLR.STK.CODE>
            </gLR.STK.CODE>
            <!--Optional:-->
            <CLIENTID>?</CLIENTID>
            <!--Optional:-->
            <LRTTDRAMT>?</LRTTDRAMT>
            <!--Optional:-->
            <LRMETHODPAY>?</LRMETHODPAY>
            <!--Optional:-->
            <LRNXTISTAMT>?</LRNXTISTAMT>
            <!--Optional:-->
            <LRNXTISTDAT>?</LRNXTISTDAT>
            <!--Optional:-->
            <LROUTSDAMT>?</LROUTSDAMT>
            <!--Optional:-->
            <LRWAIVECHG>?</LRWAIVECHG>
            <!--Optional:-->
            <LRWAIVETYPE>?</LRWAIVETYPE>
            <!--Optional:-->
            <LRWAVPARAMT>?</LRWAVPARAMT>
            <!--Optional:-->
            <LRARRMENTID>?</LRARRMENTID>
            <!--Optional:-->
            <LRDLSLIPPR>?</LRDLSLIPPR>
            <!--Optional:-->
            <LRPAYDATE>?</LRPAYDATE>
            <!--Optional:-->
            <LRPARPAYAMT>?</LRPARPAYAMT>
            <!--Optional:-->
            <LRPAYPARDAT>?</LRPAYPARDAT>
            <!--Optional:-->
            <LRSENNAME>?</LRSENNAME>
            <!--Optional:-->
            <LRCERTCHQNUM>?</LRCERTCHQNUM>
            <!--Optional:-->
            <LRCERTCHQISS>?</LRCERTCHQISS>
            <!--Optional:-->
            <LREMPCODE>?</LREMPCODE>
            <!--Optional:-->
            <LREMPNAME>?</LREMPNAME>
            <!--Optional:-->
            <LRTOTAMTPAY>?</LRTOTAMTPAY>
            <!--Optional:-->
            <LRPAYMODE>?</LRPAYMODE>
            <!--Optional:-->
            <LRBALAMT>?</LRBALAMT>
            <!--Optional:-->
            <gLR.BL.BATCH g="?">
               <!--Zero or more repetitions:-->
               <mLR.BL.BATCH m="?">
                  <!--Optional:-->
                  <LRBLBATCH>?</LRBLBATCH>
                  <!--Optional:-->
                  <LRBATCHAMT>?</LRBATCHAMT>
               </mLR.BL.BATCH>
            </gLR.BL.BATCH>
            <!--Optional:-->
            <gLR.BL.REG.NO g="?">
               <!--Zero or more repetitions:-->
               <mLR.BL.REG.NO m="?">
                  <!--Optional:-->
                  <LRBLREGNO>?</LRBLREGNO>
                  <!--Optional:-->
                  <LRBILLAMOUNT>?</LRBILLAMOUNT>
                  <!--Optional:-->
                  <LRBLSTATUS>?</LRBLSTATUS>
               </mLR.BL.REG.NO>
            </gLR.BL.REG.NO>
            <!--Optional:-->
            <LRBLCURRENCY>?</LRBLCURRENCY>
            <!--Optional:-->
            <LRNOOFBILLS>?</LRNOOFBILLS>
            <!--Optional:-->
            <LRTOTBILLAMT>?</LRTOTBILLAMT>
            <!--Optional:-->
            <LRBILLLOC>?</LRBILLLOC>
            <!--Optional:-->
            <LRTENTXT>?</LRTENTXT>
            <!--Optional:-->
            <DAOBRANCH>?</DAOBRANCH>
            <!--Optional:-->
            <LRHALFPYMT>?</LRHALFPYMT>
            <!--Optional:-->
            <LRRESIDENT>?</LRRESIDENT>
            <!--Optional:-->
            <LRTTCRAMT>?</LRTTCRAMT>
            <!--Optional:-->
            <LRCATEGORY>?</LRCATEGORY>
            <!--Optional:-->
            <LRSUBCATEG>?</LRSUBCATEG>
            <!--Optional:-->
            <LRITEM>?</LRITEM>
            <!--Optional:-->
            <LRSUBITEM>?</LRSUBITEM>
            <!--Optional:-->
            <LRGROUP>?</LRGROUP>
            <!--Optional:-->
            <UNUSED>?</UNUSED>
            <!--Optional:-->
            <LRRECALCULATE>?</LRRECALCULATE>
            <!--Optional:-->
            <LRBALDUE>?</LRBALDUE>
            <!--Optional:-->
            <LRIDENTYPE>?</LRIDENTYPE>
            <!--Optional:-->
            <gLR.NARRATIVE g="?">
               <!--Zero or more repetitions:-->
               <LRNARRATIVE>?</LRNARRATIVE>
            </gLR.NARRATIVE>
            <!--Optional:-->
            <LRPAYNOTES>?</LRPAYNOTES>
            <!--Optional:-->
            <LRREMITMSG>?</LRREMITMSG>
            <!--Optional:-->
            <LRAGRCLIENT>?</LRAGRCLIENT>
            <!--Optional:-->
            <gLR.REMIT.ADD g="?">
               <!--Zero or more repetitions:-->
               <LRREMITADD>?</LRREMITADD>
            </gLR.REMIT.ADD>
            <!--Optional:-->
            <LRREMITMOBILE>?</LRREMITMOBILE>
            <!--Optional:-->
            <LRCOUNTRY>?</LRCOUNTRY>
            <!--Optional:-->
            <LRCITY>?</LRCITY>
            <!--Optional:-->
            <LRREMITTID>?</LRREMITTID>
            <!--Optional:-->
            <LRCHQUEDEPSIT>?</LRCHQUEDEPSIT>
            <!--Optional:-->
            <LRCRTCARDNUM>?</LRCRTCARDNUM>
            <!--Optional:-->
            <LRCLRZONECDE>?</LRCLRZONECDE>
            <!--Optional:-->
            <LRCHQDPSTTME>?</LRCHQDPSTTME>
            <!--Optional:-->
            <LRCHARGEACCT>?</LRCHARGEACCT>
            <!--Optional:-->
            <LRDEPCUSTID>?</LRDEPCUSTID>
            <!--Optional:-->
            <LRDESTINCCY>?</LRDESTINCCY>
            <!--Optional:-->
            <LRDESTINACCT>?</LRDESTINACCT>
            <!--Optional:-->
            <LRCHQEXPDATE>?</LRCHQEXPDATE>
            <!--Optional:-->
            <LRACCTOFFICER>?</LRACCTOFFICER>
            <!--Optional:-->
            <LROTHEROFFCER>?</LROTHEROFFCER>
            <!--Optional:-->
            <LRCUSTTYPE>?</LRCUSTTYPE>
            <!--Optional:-->
            <LRNATIONALITY>?</LRNATIONALITY>
            <!--Optional:-->
            <LRGENDER>?</LRGENDER>
            <!--Optional:-->
            <LRMARSTATUS>?</LRMARSTATUS>
            <!--Optional:-->
            <LRDOB>?</LRDOB>
            <!--Optional:-->
            <LRDICORPNO>?</LRDICORPNO>
            <!--Optional:-->
            <LRAGENCYCODE>?</LRAGENCYCODE>
            <!--Optional:-->
            <TYPEOFCOMPANY>?</TYPEOFCOMPANY>
            <!--Optional:-->
            <LRLEGALISEDID>?</LRLEGALISEDID>
            <!--Optional:-->
            <LRFCYDECNO>?</LRFCYDECNO>
            <!--Optional:-->
            <LRALCANCNFNO>?</LRALCANCNFNO>
            <!--Optional:-->
            <LREXPIRYDATE>?</LREXPIRYDATE>
            <!--Optional:-->
            <LRORIGINITEM>?</LRORIGINITEM>
            <!--Optional:-->
            <LREXCHRTBR>?</LREXCHRTBR>
            <!--Optional:-->
            <LRDAYDATE>?</LRDAYDATE>
            <!--Optional:-->
            <LRNAME>?</LRNAME>
            <!--Optional:-->
            <LREMAILID>?</LREMAILID>
            <!--Optional:-->
            <LRCLIENTTYPE>?</LRCLIENTTYPE>
            <!--Optional:-->
            <LRAUCALLOW>?</LRAUCALLOW>
            <!--Optional:-->
            <LRSUBCATEGORY>?</LRSUBCATEGORY>
            <!--Optional:-->
            <LOANNUMBER>?</LOANNUMBER>
            <!--Optional:-->
            <LRECONOMICACT>?</LRECONOMICACT>
            <!--Optional:-->
            <LRITEMSUBITM>?</LRITEMSUBITM>
            <!--Optional:-->
            <LRFICOAUCTION>?</LRFICOAUCTION>
            <!--Optional:-->
            <LRUSDCRAMT>?</LRUSDCRAMT>
            <!--Optional:-->
            <LRUSDAUCAMT>?</LRUSDAUCAMT>
            <!--Optional:-->
            <LRRATEOPTION>?</LRRATEOPTION>
            <!--Optional:-->
            <LRAUCRATE>?</LRAUCRATE>
            <!--Optional:-->
            <LRBNKAUCAMT>?</LRBNKAUCAMT>
            <!--Optional:-->
            <LRAUCINPREF>?</LRAUCINPREF>
            <!--Optional:-->
            <LRMAPID>?</LRMAPID>
            <!--Optional:-->
            <LRPPISSUEDT>?</LRPPISSUEDT>
            <!--Optional:-->
            <LRPPVALDATE>?</LRPPVALDATE>
            <!--Optional:-->
            <LRRSCHGLCY>?</LRRSCHGLCY>
            <!--Optional:-->
            <LRRSCHGFCY>?</LRRSCHGFCY>
            <!--Optional:-->
            <LRCUSTRATE>?</LRCUSTRATE>
            <!--Optional:-->
            <gLR.SEC.BEN.NAME g="?">
               <!--Zero or more repetitions:-->
               <LRSECBENNAME>?</LRSECBENNAME>
            </gLR.SEC.BEN.NAME>
            <!--Optional:-->
            <LRFRQCUSTNUM>?</LRFRQCUSTNUM>
            <!--Optional:-->
            <LRDATEOFBIR>?</LRDATEOFBIR>
            <!--Optional:-->
            <gLR.OCCUPATION g="?">
               <!--Zero or more repetitions:-->
               <LROCCUPATION>?</LROCCUPATION>
            </gLR.OCCUPATION>
            <!--Optional:-->
            <LRAGENTCNTRY>?</LRAGENTCNTRY>
            <!--Optional:-->
            <LRAGENTCITY>?</LRAGENTCITY>
            <!--Optional:-->
            <LRBENFIRNAME>?</LRBENFIRNAME>
            <!--Optional:-->
            <LRBENLASNAME>?</LRBENLASNAME>
            <!--Optional:-->
            <LRREMFIRNAM>?</LRREMFIRNAM>
            <!--Optional:-->
            <LRREMLASNAM>?</LRREMLASNAM>
            <!--Optional:-->
            <LRSTATE>?</LRSTATE>
            <!--Optional:-->
            <LRTYPECLIENT>?</LRTYPECLIENT>
            <!--Optional:-->
            <LRREJRESON>?</LRREJRESON>
            <!--Optional:-->
            <gLR.GVT.ACC.NAME g="?">
               <!--Zero or more repetitions:-->
               <LRGVTACCNAME>?</LRGVTACCNAME>
            </gLR.GVT.ACC.NAME>
            <!--Optional:-->
            <LRPARTQUANT>?</LRPARTQUANT>
         </TELLERType>
      </t24:Depositoenefectivofase11Response>
   </soapenv:Body>
</soapenv:Envelope>
```
**Operacion Depositoenefectivofase12**
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:t24="T24WebServicesImpl">
   <soapenv:Header/>
   <soapenv:Body>
      <t24:Depositoenefectivofase12Response>
         <!--Optional:-->
         <Status>
            <!--Optional:-->
            <transactionId>?</transactionId>
            <!--Optional:-->
            <messageId>?</messageId>
            <!--Optional:-->
            <successIndicator>?</successIndicator>
            <!--Optional:-->
            <application>?</application>
            <!--Zero or more repetitions:-->
            <messages>?</messages>
         </Status>
         <!--Optional:-->
         <TELLERType id="?">
            <!--Optional:-->
            <TRANSACTIONCODE>?</TRANSACTIONCODE>
            <!--Optional:-->
            <TELLERID1>?</TELLERID1>
            <!--Optional:-->
            <DRCRMARKER>?</DRCRMARKER>
            <!--Optional:-->
            <CURRENCY1>?</CURRENCY1>
            <!--Optional:-->
            <CUSTOMER1>?</CUSTOMER1>
            <!--Optional:-->
            <gACCOUNT1 g="?">
               <!--Zero or more repetitions:-->
               <mACCOUNT1 m="?">
                  <!--Optional:-->
                  <ACCOUNT1>?</ACCOUNT1>
                  <!--Optional:-->
                  <AMOUNTLOCAL1>?</AMOUNTLOCAL1>
                  <!--Optional:-->
                  <AMOUNTFCY1>?</AMOUNTFCY1>
                  <!--Optional:-->
                  <sgNARRATIVE1 sg="?">
                     <!--Zero or more repetitions:-->
                     <NARRATIVE1>?</NARRATIVE1>
                  </sgNARRATIVE1>
               </mACCOUNT1>
            </gACCOUNT1>
            <!--Optional:-->
            <RATE1>?</RATE1>
            <!--Optional:-->
            <VALUEDATE1>?</VALUEDATE1>
            <!--Optional:-->
            <EXPOSUREDATE1>?</EXPOSUREDATE1>
            <!--Optional:-->
            <CURRMARKET1>?</CURRMARKET1>
            <!--Optional:-->
            <POSTYPE1>?</POSTYPE1>
            <!--Optional:-->
            <DEALRATE>?</DEALRATE>
            <!--Optional:-->
            <CURRENCY2>?</CURRENCY2>
            <!--Optional:-->
            <TELLERID2>?</TELLERID2>
            <!--Optional:-->
            <ACCOUNT2>?</ACCOUNT2>
            <!--Optional:-->
            <CUSTOMER2>?</CUSTOMER2>
            <!--Optional:-->
            <AMOUNTLOCAL2>?</AMOUNTLOCAL2>
            <!--Optional:-->
            <RATE2>?</RATE2>
            <!--Optional:-->
            <AMOUNTFCY2>?</AMOUNTFCY2>
            <!--Optional:-->
            <NETAMOUNT>?</NETAMOUNT>
            <!--Optional:-->
            <VALUEDATE2>?</VALUEDATE2>
            <!--Optional:-->
            <EXPOSUREDATE2>?</EXPOSUREDATE2>
            <!--Optional:-->
            <CURRMARKET2>?</CURRMARKET2>
            <!--Optional:-->
            <POSTYPE2>?</POSTYPE2>
            <!--Optional:-->
            <gNARRATIVE2 g="?">
               <!--Zero or more repetitions:-->
               <NARRATIVE2>?</NARRATIVE2>
            </gNARRATIVE2>
            <!--Optional:-->
            <gCHEQUENUMBER g="?">
               <!--Zero or more repetitions:-->
               <mCHEQUENUMBER m="?">
                  <!--Optional:-->
                  <CHEQUENUMBER>?</CHEQUENUMBER>
                  <!--Optional:-->
                  <CHEQUEBANKCDE>?</CHEQUEBANKCDE>
                  <!--Optional:-->
                  <CHEQUEACCTNO>?</CHEQUEACCTNO>
               </mCHEQUENUMBER>
            </gCHEQUENUMBER>
            <!--Optional:-->
            <gCHARGECUSTOMER g="?">
               <!--Zero or more repetitions:-->
               <mCHARGECUSTOMER m="?">
                  <!--Optional:-->
                  <CHARGECUSTOMER>?</CHARGECUSTOMER>
                  <!--Optional:-->
                  <CHARGEACCOUNT>?</CHARGEACCOUNT>
                  <!--Optional:-->
                  <CHARGECATEGORY>?</CHARGECATEGORY>
                  <!--Optional:-->
                  <CHRGDRTXNCDE>?</CHRGDRTXNCDE>
                  <!--Optional:-->
                  <CHRGCRTXNCDE>?</CHRGCRTXNCDE>
                  <!--Optional:-->
                  <CHRGAMTLOCAL>?</CHRGAMTLOCAL>
                  <!--Optional:-->
                  <CHRGAMTFCCY>?</CHRGAMTFCCY>
                  <!--Optional:-->
                  <CHARGECODE>?</CHARGECODE>
               </mCHARGECUSTOMER>
            </gCHARGECUSTOMER>
            <!--Optional:-->
            <WAIVECHARGES>?</WAIVECHARGES>
            <!--Optional:-->
            <THEIRREFERENCE>?</THEIRREFERENCE>
            <!--Optional:-->
            <OURREFERENCE>?</OURREFERENCE>
            <!--Optional:-->
            <gDENOMINATION g="?">
               <!--Zero or more repetitions:-->
               <mDENOMINATION m="?">
                  <!--Optional:-->
                  <DENOMINATION>?</DENOMINATION>
                  <!--Optional:-->
                  <UNIT>?</UNIT>
                  <!--Optional:-->
                  <sgSERIALNO sg="?">
                     <!--Zero or more repetitions:-->
                     <SERIALNO>?</SERIALNO>
                  </sgSERIALNO>
               </mDENOMINATION>
            </gDENOMINATION>
            <!--Optional:-->
            <gDRDENOM g="?">
               <!--Zero or more repetitions:-->
               <mDRDENOM m="?">
                  <!--Optional:-->
                  <DRDENOM>?</DRDENOM>
                  <!--Optional:-->
                  <DRUNIT>?</DRUNIT>
                  <!--Optional:-->
                  <sgDRSERIALNO sg="?">
                     <!--Zero or more repetitions:-->
                     <DRSERIALNO>?</DRSERIALNO>
                  </sgDRSERIALNO>
               </mDRDENOM>
            </gDRDENOM>
            <!--Optional:-->
            <TRUSTCUSTOMER>?</TRUSTCUSTOMER>
            <!--Optional:-->
            <ROUNDINGAMOUNT>?</ROUNDINGAMOUNT>
            <!--Optional:-->
            <gNEWCUSTBAL g="?">
               <!--Zero or more repetitions:-->
               <NEWCUSTBAL>?</NEWCUSTBAL>
            </gNEWCUSTBAL>
            <!--Optional:-->
            <AMOUNTDEPOSITED>?</AMOUNTDEPOSITED>
            <!--Optional:-->
            <MKTEXCHPROFIT>?</MKTEXCHPROFIT>
            <!--Optional:-->
            <TRUSTSETTLECUST>?</TRUSTSETTLECUST>
            <!--Optional:-->
            <EXPOSURECCY>?</EXPOSURECCY>
            <!--Optional:-->
            <gEXPACCT g="?">
               <!--Zero or more repetitions:-->
               <mEXPACCT m="?">
                  <!--Optional:-->
                  <EXPACCT>?</EXPACCT>
                  <!--Optional:-->
                  <sgEXPSPTDAT sg="?">
                     <!--Zero or more repetitions:-->
                     <EXPSPTDAT s="?">
                        <!--Optional:-->
                        <EXPSPTDAT>?</EXPSPTDAT>
                        <!--Optional:-->
                        <EXPSPTAMT>?</EXPSPTAMT>
                     </EXPSPTDAT>
                  </sgEXPSPTDAT>
               </mEXPACCT>
            </gEXPACCT>
            <!--Optional:-->
            <DEALERDESK>?</DEALERDESK>
            <!--Optional:-->
            <CHEQTYPE>?</CHEQTYPE>
            <!--Optional:-->
            <STOCKREGISTER>?</STOCKREGISTER>
            <!--Optional:-->
            <SERIESID>?</SERIESID>
            <!--Optional:-->
            <STOCKNUMBER>?</STOCKNUMBER>
            <!--Optional:-->
            <CONTRACTGRP>?</CONTRACTGRP>
            <!--Optional:-->
            <AUTHDATE>?</AUTHDATE>
            <!--Optional:-->
            <CONTRACTMATDATE>?</CONTRACTMATDATE>
            <!--Optional:-->
            <POSSDUPDATE>?</POSSDUPDATE>
            <!--Optional:-->
            <CARDNUMBER>?</CARDNUMBER>
            <!--Optional:-->
            <gCARDTXNDETAIL g="?">
               <!--Zero or more repetitions:-->
               <CARDTXNDETAIL>?</CARDTXNDETAIL>
            </gCARDTXNDETAIL>
            <!--Optional:-->
            <TFSREFERENCE>?</TFSREFERENCE>
            <!--Optional:-->
            <CHEQUEDRAWN>?</CHEQUEDRAWN>
            <!--Optional:-->
            <RESERVED4>?</RESERVED4>
            <!--Optional:-->
            <RESERVED3>?</RESERVED3>
            <!--Optional:-->
            <RESERVED2>?</RESERVED2>
            <!--Optional:-->
            <RESERVED1>?</RESERVED1>
            <!--Optional:-->
            <gSTMTNO g="?">
               <!--Zero or more repetitions:-->
               <STMTNO>?</STMTNO>
            </gSTMTNO>
            <!--Optional:-->
            <gOVERRIDE g="?">
               <!--Zero or more repetitions:-->
               <OVERRIDE>?</OVERRIDE>
            </gOVERRIDE>
            <!--Optional:-->
            <RECORDSTATUS>?</RECORDSTATUS>
            <!--Optional:-->
            <CURRNO>?</CURRNO>
            <!--Optional:-->
            <gINPUTTER g="?">
               <!--Zero or more repetitions:-->
               <INPUTTER>?</INPUTTER>
            </gINPUTTER>
            <!--Optional:-->
            <gDATETIME g="?">
               <!--Zero or more repetitions:-->
               <DATETIME>?</DATETIME>
            </gDATETIME>
            <!--Optional:-->
            <AUTHORISER>?</AUTHORISER>
            <!--Optional:-->
            <COCODE>?</COCODE>
            <!--Optional:-->
            <DEPTCODE>?</DEPTCODE>
            <!--Optional:-->
            <AUDITORCODE>?</AUDITORCODE>
            <!--Optional:-->
            <AUDITDATETIME>?</AUDITDATETIME>
            <!--Optional:-->
            <gSTOCK.CODE g="?">
               <!--Zero or more repetitions:-->
               <mSTOCK.CODE m="?">
                  <!--Optional:-->
                  <STOCKCODE>?</STOCKCODE>
                  <!--Optional:-->
                  <QUANTITY>?</QUANTITY>
               </mSTOCK.CODE>
            </gSTOCK.CODE>
            <!--Optional:-->
            <DISCITEM>?</DISCITEM>
            <!--Optional:-->
            <PARTPAYMENT>?</PARTPAYMENT>
            <!--Optional:-->
            <BALREPAYMENT>?</BALREPAYMENT>
            <!--Optional:-->
            <gTRANS.REF g="?">
               <!--Zero or more repetitions:-->
               <TRANSREF>?</TRANSREF>
            </gTRANS.REF>
            <!--Optional:-->
            <gPEND.STOCK.CODE g="?">
               <!--Zero or more repetitions:-->
               <mPEND.STOCK.CODE m="?">
                  <!--Optional:-->
                  <PENDSTOCKCODE>?</PENDSTOCKCODE>
                  <!--Optional:-->
                  <PENDINGAMOUNT>?</PENDINGAMOUNT>
               </mPEND.STOCK.CODE>
            </gPEND.STOCK.CODE>
            <!--Optional:-->
            <SHORTNAME>?</SHORTNAME>
            <!--Optional:-->
            <LRTRMNLID>?</LRTRMNLID>
            <!--Optional:-->
            <LRPAYCODE>?</LRPAYCODE>
            <!--Optional:-->
            <gLR.INVOICE.NO g="?">
               <!--Zero or more repetitions:-->
               <mLR.INVOICE.NO m="?">
                  <!--Optional:-->
                  <LRINVOICENO>?</LRINVOICENO>
                  <!--Optional:-->
                  <LRINVOICEDT>?</LRINVOICEDT>
                  <!--Optional:-->
                  <LRDUEDATE>?</LRDUEDATE>
                  <!--Optional:-->
                  <LRAMT>?</LRAMT>
                  <!--Optional:-->
                  <LRPENALITYAMT>?</LRPENALITYAMT>
                  <!--Optional:-->
                  <LRPARTIALAMT>?</LRPARTIALAMT>
                  <!--Optional:-->
                  <LRTOTALAMT>?</LRTOTALAMT>
                  <!--Optional:-->
                  <LRPAYYN>?</LRPAYYN>
               </mLR.INVOICE.NO>
            </gLR.INVOICE.NO>
            <!--Optional:-->
            <LRIDENCODE>?</LRIDENCODE>
            <!--Optional:-->
            <LRTAXYEAR>?</LRTAXYEAR>
            <!--Optional:-->
            <gLR.TAX.PAY.NAME g="?">
               <!--Zero or more repetitions:-->
               <LRTAXPAYNAME>?</LRTAXPAYNAME>
            </gLR.TAX.PAY.NAME>
            <!--Optional:-->
            <LRTOTTAXDUE>?</LRTOTTAXDUE>
            <!--Optional:-->
            <gLR.MONTH g="?">
               <!--Zero or more repetitions:-->
               <mLR.MONTH m="?">
                  <!--Optional:-->
                  <LRMONTH>?</LRMONTH>
                  <!--Optional:-->
                  <LRAMTTOPAY>?</LRAMTTOPAY>
                  <!--Optional:-->
                  <LRTAXPAY>?</LRTAXPAY>
               </mLR.MONTH>
            </gLR.MONTH>
            <!--Optional:-->
            <LRAGCLIENTID>?</LRAGCLIENTID>
            <!--Optional:-->
            <LRCCARDNO>?</LRCCARDNO>
            <!--Optional:-->
            <LRPPORTVAL>?</LRPPORTVAL>
            <!--Optional:-->
            <LRPPORTPLACE>?</LRPPORTPLACE>
            <!--Optional:-->
            <LRPPORTTYPE>?</LRPPORTTYPE>
            <!--Optional:-->
            <LRAPPOINTNO>?</LRAPPOINTNO>
            <!--Optional:-->
            <LRAPPOINTDT>?</LRAPPOINTDT>
            <!--Optional:-->
            <LRAPPOINTCHG>?</LRAPPOINTCHG>
            <!--Optional:-->
            <LRAPPOINTTIME>?</LRAPPOINTTIME>
            <!--Optional:-->
            <LRPAYTYPE>?</LRPAYTYPE>
            <!--Optional:-->
            <LRORDPARID>?</LRORDPARID>
            <!--Optional:-->
            <LRORDNAME>?</LRORDNAME>
            <!--Optional:-->
            <LRDESTCNTRY>?</LRDESTCNTRY>
            <!--Optional:-->
            <LRBENID>?</LRBENID>
            <!--Optional:-->
            <LRBENNAME>?</LRBENNAME>
            <!--Optional:-->
            <LRRECMODE>?</LRRECMODE>
            <!--Optional:-->
            <LRRECDATE>?</LRRECDATE>
            <!--Optional:-->
            <LRREMITCODE>?</LRREMITCODE>
            <!--Optional:-->
            <RTEFORM>?</RTEFORM>
            <!--Optional:-->
            <LRIDNUMBER>?</LRIDNUMBER>
            <!--Optional:-->
            <LRDATEBIRTH>?</LRDATEBIRTH>
            <!--Optional:-->
            <gLR.STK.CODE g="?">
               <!--Zero or more repetitions:-->
               <mLR.STK.CODE m="?">
                  <!--Optional:-->
                  <LRSTKCODE>?</LRSTKCODE>
                  <!--Optional:-->
                  <LRPRODQUANT>?</LRPRODQUANT>
                  <!--Optional:-->
                  <LRUNITPRICE>?</LRUNITPRICE>
               </mLR.STK.CODE>
            </gLR.STK.CODE>
            <!--Optional:-->
            <CLIENTID>?</CLIENTID>
            <!--Optional:-->
            <LRTTDRAMT>?</LRTTDRAMT>
            <!--Optional:-->
            <LRMETHODPAY>?</LRMETHODPAY>
            <!--Optional:-->
            <LRNXTISTAMT>?</LRNXTISTAMT>
            <!--Optional:-->
            <LRNXTISTDAT>?</LRNXTISTDAT>
            <!--Optional:-->
            <LROUTSDAMT>?</LROUTSDAMT>
            <!--Optional:-->
            <LRWAIVECHG>?</LRWAIVECHG>
            <!--Optional:-->
            <LRWAIVETYPE>?</LRWAIVETYPE>
            <!--Optional:-->
            <LRWAVPARAMT>?</LRWAVPARAMT>
            <!--Optional:-->
            <LRARRMENTID>?</LRARRMENTID>
            <!--Optional:-->
            <LRDLSLIPPR>?</LRDLSLIPPR>
            <!--Optional:-->
            <LRPAYDATE>?</LRPAYDATE>
            <!--Optional:-->
            <LRPARPAYAMT>?</LRPARPAYAMT>
            <!--Optional:-->
            <LRPAYPARDAT>?</LRPAYPARDAT>
            <!--Optional:-->
            <LRSENNAME>?</LRSENNAME>
            <!--Optional:-->
            <LRCERTCHQNUM>?</LRCERTCHQNUM>
            <!--Optional:-->
            <LRCERTCHQISS>?</LRCERTCHQISS>
            <!--Optional:-->
            <LREMPCODE>?</LREMPCODE>
            <!--Optional:-->
            <LREMPNAME>?</LREMPNAME>
            <!--Optional:-->
            <LRTOTAMTPAY>?</LRTOTAMTPAY>
            <!--Optional:-->
            <LRPAYMODE>?</LRPAYMODE>
            <!--Optional:-->
            <LRBALAMT>?</LRBALAMT>
            <!--Optional:-->
            <gLR.BL.BATCH g="?">
               <!--Zero or more repetitions:-->
               <mLR.BL.BATCH m="?">
                  <!--Optional:-->
                  <LRBLBATCH>?</LRBLBATCH>
                  <!--Optional:-->
                  <LRBATCHAMT>?</LRBATCHAMT>
               </mLR.BL.BATCH>
            </gLR.BL.BATCH>
            <!--Optional:-->
            <gLR.BL.REG.NO g="?">
               <!--Zero or more repetitions:-->
               <mLR.BL.REG.NO m="?">
                  <!--Optional:-->
                  <LRBLREGNO>?</LRBLREGNO>
                  <!--Optional:-->
                  <LRBILLAMOUNT>?</LRBILLAMOUNT>
                  <!--Optional:-->
                  <LRBLSTATUS>?</LRBLSTATUS>
               </mLR.BL.REG.NO>
            </gLR.BL.REG.NO>
            <!--Optional:-->
            <LRBLCURRENCY>?</LRBLCURRENCY>
            <!--Optional:-->
            <LRNOOFBILLS>?</LRNOOFBILLS>
            <!--Optional:-->
            <LRTOTBILLAMT>?</LRTOTBILLAMT>
            <!--Optional:-->
            <LRBILLLOC>?</LRBILLLOC>
            <!--Optional:-->
            <LRTENTXT>?</LRTENTXT>
            <!--Optional:-->
            <DAOBRANCH>?</DAOBRANCH>
            <!--Optional:-->
            <LRHALFPYMT>?</LRHALFPYMT>
            <!--Optional:-->
            <LRRESIDENT>?</LRRESIDENT>
            <!--Optional:-->
            <LRTTCRAMT>?</LRTTCRAMT>
            <!--Optional:-->
            <LRCATEGORY>?</LRCATEGORY>
            <!--Optional:-->
            <LRSUBCATEG>?</LRSUBCATEG>
            <!--Optional:-->
            <LRITEM>?</LRITEM>
            <!--Optional:-->
            <LRSUBITEM>?</LRSUBITEM>
            <!--Optional:-->
            <LRGROUP>?</LRGROUP>
            <!--Optional:-->
            <UNUSED>?</UNUSED>
            <!--Optional:-->
            <LRRECALCULATE>?</LRRECALCULATE>
            <!--Optional:-->
            <LRBALDUE>?</LRBALDUE>
            <!--Optional:-->
            <LRIDENTYPE>?</LRIDENTYPE>
            <!--Optional:-->
            <gLR.NARRATIVE g="?">
               <!--Zero or more repetitions:-->
               <LRNARRATIVE>?</LRNARRATIVE>
            </gLR.NARRATIVE>
            <!--Optional:-->
            <LRPAYNOTES>?</LRPAYNOTES>
            <!--Optional:-->
            <LRREMITMSG>?</LRREMITMSG>
            <!--Optional:-->
            <LRAGRCLIENT>?</LRAGRCLIENT>
            <!--Optional:-->
            <gLR.REMIT.ADD g="?">
               <!--Zero or more repetitions:-->
               <LRREMITADD>?</LRREMITADD>
            </gLR.REMIT.ADD>
            <!--Optional:-->
            <LRREMITMOBILE>?</LRREMITMOBILE>
            <!--Optional:-->
            <LRCOUNTRY>?</LRCOUNTRY>
            <!--Optional:-->
            <LRCITY>?</LRCITY>
            <!--Optional:-->
            <LRREMITTID>?</LRREMITTID>
            <!--Optional:-->
            <LRCHQUEDEPSIT>?</LRCHQUEDEPSIT>
            <!--Optional:-->
            <LRCRTCARDNUM>?</LRCRTCARDNUM>
            <!--Optional:-->
            <LRCLRZONECDE>?</LRCLRZONECDE>
            <!--Optional:-->
            <LRCHQDPSTTME>?</LRCHQDPSTTME>
            <!--Optional:-->
            <LRCHARGEACCT>?</LRCHARGEACCT>
            <!--Optional:-->
            <LRDEPCUSTID>?</LRDEPCUSTID>
            <!--Optional:-->
            <LRDESTINCCY>?</LRDESTINCCY>
            <!--Optional:-->
            <LRDESTINACCT>?</LRDESTINACCT>
            <!--Optional:-->
            <LRCHQEXPDATE>?</LRCHQEXPDATE>
            <!--Optional:-->
            <LRACCTOFFICER>?</LRACCTOFFICER>
            <!--Optional:-->
            <LROTHEROFFCER>?</LROTHEROFFCER>
            <!--Optional:-->
            <LRCUSTTYPE>?</LRCUSTTYPE>
            <!--Optional:-->
            <LRNATIONALITY>?</LRNATIONALITY>
            <!--Optional:-->
            <LRGENDER>?</LRGENDER>
            <!--Optional:-->
            <LRMARSTATUS>?</LRMARSTATUS>
            <!--Optional:-->
            <LRDOB>?</LRDOB>
            <!--Optional:-->
            <LRDICORPNO>?</LRDICORPNO>
            <!--Optional:-->
            <LRAGENCYCODE>?</LRAGENCYCODE>
            <!--Optional:-->
            <TYPEOFCOMPANY>?</TYPEOFCOMPANY>
            <!--Optional:-->
            <LRLEGALISEDID>?</LRLEGALISEDID>
            <!--Optional:-->
            <LRFCYDECNO>?</LRFCYDECNO>
            <!--Optional:-->
            <LRALCANCNFNO>?</LRALCANCNFNO>
            <!--Optional:-->
            <LREXPIRYDATE>?</LREXPIRYDATE>
            <!--Optional:-->
            <LRORIGINITEM>?</LRORIGINITEM>
            <!--Optional:-->
            <LREXCHRTBR>?</LREXCHRTBR>
            <!--Optional:-->
            <LRDAYDATE>?</LRDAYDATE>
            <!--Optional:-->
            <LRNAME>?</LRNAME>
            <!--Optional:-->
            <LREMAILID>?</LREMAILID>
            <!--Optional:-->
            <LRCLIENTTYPE>?</LRCLIENTTYPE>
            <!--Optional:-->
            <LRAUCALLOW>?</LRAUCALLOW>
            <!--Optional:-->
            <LRSUBCATEGORY>?</LRSUBCATEGORY>
            <!--Optional:-->
            <LOANNUMBER>?</LOANNUMBER>
            <!--Optional:-->
            <LRECONOMICACT>?</LRECONOMICACT>
            <!--Optional:-->
            <LRITEMSUBITM>?</LRITEMSUBITM>
            <!--Optional:-->
            <LRFICOAUCTION>?</LRFICOAUCTION>
            <!--Optional:-->
            <LRUSDCRAMT>?</LRUSDCRAMT>
            <!--Optional:-->
            <LRUSDAUCAMT>?</LRUSDAUCAMT>
            <!--Optional:-->
            <LRRATEOPTION>?</LRRATEOPTION>
            <!--Optional:-->
            <LRAUCRATE>?</LRAUCRATE>
            <!--Optional:-->
            <LRBNKAUCAMT>?</LRBNKAUCAMT>
            <!--Optional:-->
            <LRAUCINPREF>?</LRAUCINPREF>
            <!--Optional:-->
            <LRMAPID>?</LRMAPID>
            <!--Optional:-->
            <LRPPISSUEDT>?</LRPPISSUEDT>
            <!--Optional:-->
            <LRPPVALDATE>?</LRPPVALDATE>
            <!--Optional:-->
            <LRRSCHGLCY>?</LRRSCHGLCY>
            <!--Optional:-->
            <LRRSCHGFCY>?</LRRSCHGFCY>
            <!--Optional:-->
            <LRCUSTRATE>?</LRCUSTRATE>
            <!--Optional:-->
            <gLR.SEC.BEN.NAME g="?">
               <!--Zero or more repetitions:-->
               <LRSECBENNAME>?</LRSECBENNAME>
            </gLR.SEC.BEN.NAME>
            <!--Optional:-->
            <LRFRQCUSTNUM>?</LRFRQCUSTNUM>
            <!--Optional:-->
            <LRDATEOFBIR>?</LRDATEOFBIR>
            <!--Optional:-->
            <gLR.OCCUPATION g="?">
               <!--Zero or more repetitions:-->
               <LROCCUPATION>?</LROCCUPATION>
            </gLR.OCCUPATION>
            <!--Optional:-->
            <LRAGENTCNTRY>?</LRAGENTCNTRY>
            <!--Optional:-->
            <LRAGENTCITY>?</LRAGENTCITY>
            <!--Optional:-->
            <LRBENFIRNAME>?</LRBENFIRNAME>
            <!--Optional:-->
            <LRBENLASNAME>?</LRBENLASNAME>
            <!--Optional:-->
            <LRREMFIRNAM>?</LRREMFIRNAM>
            <!--Optional:-->
            <LRREMLASNAM>?</LRREMLASNAM>
            <!--Optional:-->
            <LRSTATE>?</LRSTATE>
            <!--Optional:-->
            <LRTYPECLIENT>?</LRTYPECLIENT>
            <!--Optional:-->
            <LRREJRESON>?</LRREJRESON>
            <!--Optional:-->
            <gLR.GVT.ACC.NAME g="?">
               <!--Zero or more repetitions:-->
               <LRGVTACCNAME>?</LRGVTACCNAME>
            </gLR.GVT.ACC.NAME>
            <!--Optional:-->
            <LRPARTQUANT>?</LRPARTQUANT>
         </TELLERType>
      </t24:Depositoenefectivofase12Response>
   </soapenv:Body>
</soapenv:Envelope>
```

##### Registro en Dynamo Componente de idempotencia Operacion Depositoenefectivofase11

```json
{
    "PK": "LOAN_ADMIN-product-EXECUTE_REPAYMENT_Depositoenefectivofase11",
    "SK": "1.0|ACTIVE",
    "version": "1.0",
    "stage": "ACTIVE",
    "callerService": "LOAN_ADMIN-product-EXECUTE_REPAYMENT_Depositoenefectivofase11",
    "service": "loan-admin-product",
    "method": "execute-repayment",
    "domain": "loan-admin",
    "typeUsage": "IDEM",
    "hashFields": [
        "transactionReference"

    ],
    "cache": {
        "enabled": true,
        "ttlSeconds": 1800 
    },
    "activeIndex": "ACTIVE", 
    "updated_at": "2025-11-05T21:32:45.237-06:00",
    "updated_by": "david.j.molano@ficohsa.com",
    "tags": [
        "cash-deposit",
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
    "PK": "LOAN_ADMIN-product-EXECUTE_REPAYMENT_Depositoenefectivofase12",
    "SK": "1.0|ACTIVE",
    "version": "1.0",
    "stage": "ACTIVE",
    "callerService": "LOAN_ADMIN-product-EXECUTE_REPAYMENT_Depositoenefectivofase12",
    "service": "loan-admin-product",
    "method": "execute-repayment",
    "domain": "loan-admin",
    "typeUsage": "IDEM",
    "hashFields": [
        "transactionReference"

    ],
    "cache": {
        "enabled": true,
        "ttlSeconds": 1800 
    },
    "activeIndex": "ACTIVE", 
    "updated_at": "2025-11-05T21:32:45.237-06:00",
    "updated_by": "david.j.molano@ficohsa.com",
    "tags": [
        "cash-deposit",
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
--header 'Caller-Service: LOAN_ADMIN-product-EXECUTE_REPAYMENT_Depositoenefectivofase11' \
--header 'Correlation-Id: b1f6f6f5-d611-4c1f-843f-89a1c8aaaaee' \
--header 'Authorization: Bearer my.token.loko' \
--header 'Source-Bank: HN01' \
--header 'Application-Id: 123456789' \
--header 'Channel: my-channel' \
--header 'Content-Type: application/json' \
--data '{
  "methodVersion": "1.0",
  "dataPayload": {
    "ofsFunction": {
      "gtsControl": "string",
      "authorizationsNumber": "string",
      "replaceIndicator": "string"
    },
    "loanRepaymentTypeId": "string",
    "transactionReference": "string",
    "debitCreditMarker": "string",
    "currencyCode": "string",
    "currencyCodeExt": "string",
    "exchangeRate": "string",
    "creditCurrency": "string",
    "creditAccount": "string",
    "accountNumber": "string",
    "customerReference": "string",
    "repaymentAmount": "string",
    "repaymentNetAmount": "string",
    "repaymentValueDate": "string",
    "chargeAmountLocal": "string",
    "chargeAmountExt": "string",
    "chargeCode": "string",
    "waiveChargesIndicator": "string",
    "loanRepaymentAccountMultiple": [
      {
        "internalAccount": "string",
        "depositAmount": "string",
        "amountDeposited": "string"
      }
    ],
    "loanRepaymentNarrative": [
      "string"
    ]
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
        "callerService": "LOAN_ADMIN-product-EXECUTE_REPAYMENT_Depositoenefectivofase11",
        "channel": "rest-api",
        "transactionStatus": "success", // || "timeout" ||  "error" || "fault",
        "payload": { 
            "host": "http://abanks-url",
            "headers": {}, // headers etc
            "body": {
              "ofsFunction": {
                "gtsControl": "string",
                "authorizationsNumber": "string",
                "replaceIndicator": "string"
              },
              "loanRepaymentTypeId": "string",
              "transactionReference": "string",
              "debitCreditMarker": "string",
              "currencyCode": "string",
              "currencyCodeExt": "string",
              "exchangeRate": "string",
              "creditCurrency": "string",
              "creditAccount": "string",
              "accountNumber": "string",
              "customerReference": "string",
              "repaymentAmount": "string",
              "repaymentNetAmount": "string",
              "repaymentValueDate": "string",
              "chargeAmountLocal": "string",
              "chargeAmountExt": "string",
              "chargeCode": "string",
              "waiveChargesIndicator": "string",
              "loanRepaymentAccountMultiple": [
                {
                  "internalAccount": "string",
                  "depositAmount": "string",
                  "amountDeposited": "string"
                }
              ],
              "loanRepaymentNarrative": [
                "string"
              ]
            }
        }
    }
}
```