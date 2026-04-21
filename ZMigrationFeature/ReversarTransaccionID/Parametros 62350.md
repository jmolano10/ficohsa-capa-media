##### DynamoDB Parameter - Librería de parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#PAYMENT_EXECUTION_PROCESSING#PARAM#EXECUTE_CARD_REVERSAL",
  "sk": "V#0001",
  "name": "EXECUTE_CARD_REVERSAL",
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
  "type": "list",
  "description": "CONFIG OF PAYMENT_EXECUTION_PROCESSING BY METHOD",
  "country": "XRS",
  "domain": "PAYMENT_EXECUTION_PROCESSING",
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

**Nombre:** `ban-hnd-ic-comp-param-t24-reversion-pago-tc-tengo-wsdl-dev` 

```json
{
  "host": "172.23.177.15",
  "port": "7003",
  "basePath": "/svcReversarTransaccionCB/services"
}
```
**Nombre:** `ban-hnd-ic-comp-param-t24-reversion-pago-tc-tengo-wsdl-stg` 

```json
{
  "host": "http://10.242.15.43",
  "port": "7020",
  "basePath": "/svcReversarTransaccionCB/services"
}
```

##### AWS Systems Manager SecretManager

**Nombre:** `ban-hnd-ic-comp-secm-t24-reversion-pago-tc-tengo-wsdl-dev`

```json
{
  "username": "HNITINTB",
  "password": "intb2013$HN"
}
```

**Nombre:** `ban-hnd-ic-comp-secm-t24-reversion-pago-tc-tengo-wsdl-stg`

```json
{
  "username": "HNITINTB",
  "password": "intb2013$HN"
}
```

##### Constantes para almacenar en ConfigMap

```json
{
  "caller-service":  "PAYMENT_EXECUTION_PROCESSING-PRODUCT-EXECUTE_CARD_REVERSAL",
  "operation": "ReversionPagoTCTengo",
  "type": "TELLERFINANCIALSERVICESFICOREVTXNUUIDTFSType"
}
```
##### Registro en Dynamo Wrapper T24

```json
{
  "pk": "COUNTRY#HND#DOMAIN#WRAPPER_T24#PARAM#srv-itintb|PAYMENT_EXECUTION_PROCESSING-PRODUCT-EXECUTE_CARD_REVERSAL",
  "sk": "V#0001",
  "name": "srv-itintb|PAYMENT_EXECUTION_PROCESSING-PRODUCT-EXECUTE_CARD_REVERSAL",
  "value": {
    "secret-name": "ban-hnd-ic-comp-secm-t24-reversion-pago-tc-tengo-wsdl-dev",
    "param-name": "ban-hnd-ic-comp-param-t24-reversion-pago-tc-tengo-wsdl-dev"
  },
  "type": "json",
  "description": "Credenciales de la operación ReversionPagoTCTengo del PAYMENT_EXECUTION_PROCESSING-PRODUCT-EXECUTE_CARD_REVERSAL",
  "country": "HND",
  "domain": "WRAPPER_T24",
  "tags": [
    "ReversionPagoTCTengo"
  ],
  "precedence": 1,
  "effective_from": "",
  "effective_to": "",
  "status": "active",
  "updated_at": "2025-10-25T18:10:00Z",
  "updated_by": "david.j.molano@ficohsa.com"
}
```

##### Ejemplo de request Wrapper T24 Operacion OP: ReversionPagoTCTengo
```json
postman request POST 'http://localhost:8080/t24-wrapper-hnd/v2/Depositoenefectivofase11' \
  --header 'Content-Type: application/json' \
  --header 'Correlation-Id: de957188-87a4-4808-a97e-d5da44a7798f' \
  --header 'Accept-Language: es' \
  --header 'Authorization: Bearer token.ok.ok' \
  --header 'Caller-Service: PAYMENT_EXECUTION_PROCESSING-PRODUCT-EXECUTE_CARD_REVERSAL' \
  --header 'Channel: C001' \
  --header 'APP_CONTEXTUAL: 1' \
  --header 'Destination-Bank: test' \
  --header 'Source-Bank: test' \
  --header 'Application-Id: srv-itintb' \
  --body '{
  "operation": "ReversionPagoTCTengo",
  "payload": {
    "type": "TELLERFINANCIALSERVICESFICOREVTXNUUIDTFSType",
    "data": {
      "TELLERFINANCIALSERVICESFICOREVTXNUUIDTFSType": {
        "attribute": {
            "id": "FT24001HN123456"
        }
      }
    }
  }
}'
```

##### Ejemplo de Response Wrapper T24

```json
{
    "meta": {
        "serviceName": "T24Wrapper",
        "serviceDomain": "IntegrationComposition",
        "timestamp": "2026-03-04T23:05:26.216993194Z"
    },
    "data": {
        "body": {
            "reversionPagoTCTengoResponse": {
                "status": {
                    "transactionId": "FT24001HN654321",
                    "messageId": "",
                    "successIndicator": "Success",
                    "application": "TELLER.FINANCIAL.SERVICES"
                },
                "tELLERFINANCIALSERVICESType": {
                    "BOOKINGDATE": "20240415",
                    "PRIMARYCUSTOMER": "100123",
                    "PRIMARYACCOUNT": "HN01001234567890",
                    "PRIMARYACCOUNTINT": "1",
                    "gTRANSACTION": {
                        "mTRANSACTION": {
                            "TRANSACTION": "FT24001HN123456",
                            "TRANSACTIONINT": "1",
                            "ACCOUNTDR": "HN01001234567890",
                            "CURRENCYDR": "HNL",
                            "AMOUNTDR": "5000.00",
                            "AMOUNTDRLCY": "5000.00",
                            "ACCOUNTCR": "HN01009876543210",
                            "CURRENCYCR": "HNL",
                            "AMOUNTCR": "5000.00",
                            "AMOUNTCRLCY": "5000.00",
                            "CURRENCY": "HNL",
                            "AMOUNT": "5000.00",
                            "AMOUNTLCY": "5000.00",
                            "CRVALUEDATE": "20240415",
                            "DRVALUEDATE": "20240415",
                            "CARDNUMBER": "4111111111111234",
                            "DCREVERSEMARK": "Y",
                            "REVERSALMARK": "Y"
                        }
                    },
                    "RECORDSTATUS": "LIVE",
                    "CURRNO": "1",
                    "gINPUTTER": {
                        "INPUTTER": "1_OFS.DEFAULT_HND"
                    },
                    "gDATETIME": {
                        "DATETIME": "240415121530"
                    }
                }
            }
        }
    },
    "links": {
        "self": "/t24-wrapper-hnd/v2/ReversionPagoTCTengo"
    }
}
```
##### Homologación de errores OP: ReversionPagoTCTengo

Homologación de los valores posibles del campo `Status/successIndicator` retornados por la operación `ReversionPagoTCTengo` del Business Service `svcReversarTransaccionCB`, hacia códigos HTTP semánticos. El proxy captura este valor mediante `fn:upper-case(fn:string($RSPRevTC/Status/successIndicator/text()))` y lo evalúa para construir la respuesta final.

| `Status/successIndicator` | `Status/messages` | Escenario | Código HTTP | Descripción HTTP |
|--------------------------|-------------------|-----------|-------------|-----------------|
| **Success** | *(vacío)* | Reversión de pago TC procesada exitosamente en T24; el proxy continúa a registrar en Master Data (`conReversarPagoTCRG`) y retorna `T24_REFERENCE`, `TRANSACTION_ID` y `REFERENCE_CB` | **200** | OK |
| **TWSError** | Mensaje de error del Web Service | Error en la comunicación con el Web Service de T24; falla en la capa de transporte antes de llegar al core bancario | **502** | Bad Gateway |
| **T24Error** | Mensaje de error del core T24 | El core bancario T24 rechazó o no pudo procesar la reversión (p.ej. transacción no encontrada, ya reversada, fondos insuficientes) | **500** | Internal Server Error |
| **T24Override** | Mensaje descriptivo del override | T24 requiere una autorización adicional (override) para completar la reversión; la transacción queda en estado pendiente de aprobación | **202** | Accepted |
| **T24Offline** | Mensaje de sistema no disponible | T24 se encuentra fuera de línea o en mantenimiento; no es posible procesar la reversión en este momento | **503** | Service Unavailable |

> **Nota:** El proxy uppercasea el `successIndicator` antes de la comparación (`fn:upper-case`), por lo que `Success` del XSD se evalúa como `SUCCESS`. Solo el valor `SUCCESS` habilita el flujo exitoso; cualquier otro valor resulta en una respuesta SOAP con `successIndicator=ERROR` y el campo `messageId` poblado con el contenido de `Status/messages`. El mapeo HTTP es semántico — la capa SOAP retorna siempre HTTP 200 en el transporte; los códigos aquí representan la intención de negocio para la capa REST/API Gateway.

##### Ejemplo request consumo T24 OP: ReversionPagoTCTengo

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:t24="T24WebServicesImpl">
   <soapenv:Header/>
   <soapenv:Body>
      <t24:ReversionPagoTCTengo>
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
         <TELLERFINANCIALSERVICESFICOREVTXNUUIDTFSType id="?">
            <!--Optional:-->
            <PrimaryAccount>?</PrimaryAccount>
            <!--Optional:-->
            <gTRANSACTION g="?">
               <!--Zero or more repetitions:-->
               <mTRANSACTION m="?">
                  <!--Optional:-->
                  <Transaction>?</Transaction>
                  <!--Optional:-->
                  <SurrogateAccount>?</SurrogateAccount>
                  <!--Optional:-->
                  <Currency>?</Currency>
                  <!--Optional:-->
                  <Amount>?</Amount>
                  <!--Optional:-->
                  <SortCode>?</SortCode>
                  <!--Optional:-->
                  <ChequeNumber>?</ChequeNumber>
               </mTRANSACTION>
            </gTRANSACTION>
            <!--Optional:-->
            <LRMINAMT>?</LRMINAMT>
            <!--Optional:-->
            <LRMAXAMT>?</LRMAXAMT>
            <!--Optional:-->
            <LROTHAMT>?</LROTHAMT>
            <!--Optional:-->
            <CREDITCARDNUM>?</CREDITCARDNUM>
            <!--Optional:-->
            <LRCRCCY>?</LRCRCCY>
            <!--Optional:-->
            <gLR.CONSOL.TXN g="?">
               <!--Zero or more repetitions:-->
               <mLR.CONSOL.TXN m="?">
                  <!--Optional:-->
                  <LRCONSOLTXN>?</LRCONSOLTXN>
                  <!--Optional:-->
                  <LRCONSOLAMT>?</LRCONSOLAMT>
               </mLR.CONSOL.TXN>
            </gLR.CONSOL.TXN>
            <!--Optional:-->
            <LRCONSOLTOT>?</LRCONSOLTOT>
            <!--Optional:-->
            <LRAMTPAY>?</LRAMTPAY>
            <!--Optional:-->
            <LRCONSUMEAMT>?</LRCONSUMEAMT>
            <!--Optional:-->
            <LRDESC>?</LRDESC>
            <!--Optional:-->
            <gLR.ECONOMIC.ACT g="?">
               <!--Zero or more repetitions:-->
               <mLR.ECONOMIC.ACT m="?">
                  <!--Optional:-->
                  <LRECONOMICACT>?</LRECONOMICACT>
                  <!--Optional:-->
                  <LRCUSTRATE>?</LRCUSTRATE>
                  <!--Optional:-->
                  <LRFCYDECNO>?</LRFCYDECNO>
                  <!--Optional:-->
                  <CLIENTID>?</CLIENTID>
                  <!--Optional:-->
                  <LRORIGINITEM>?</LRORIGINITEM>
                  <!--Optional:-->
                  <LRHALFPYMT>?</LRHALFPYMT>
                  <!--Optional:-->
                  <LRRESIDENT>?</LRRESIDENT>
               </mLR.ECONOMIC.ACT>
            </gLR.ECONOMIC.ACT>
            <!--Optional:-->
            <LRREFTENGO>?</LRREFTENGO>
         </TELLERFINANCIALSERVICESFICOREVTXNUUIDTFSType>
      </t24:ReversionPagoTCTengo>
   </soapenv:Body>
</soapenv:Envelope>
```

##### Ejemplo Response T24 OP: ReversionPagoTCTengo

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:t24="T24WebServicesImpl">
   <soapenv:Header/>
   <soapenv:Body>
      <t24:ReversionPagoTCTengoResponse>
         <Status>
            <transactionId>FT24001HN654321</transactionId>
            <messageId></messageId>
            <successIndicator>Success</successIndicator>
            <application>TELLER.FINANCIAL.SERVICES</application>
         </Status>
         <TELLERFINANCIALSERVICESType>
            <BOOKINGDATE>20240415</BOOKINGDATE>
            <PRIMARYCUSTOMER>100123</PRIMARYCUSTOMER>
            <PRIMARYACCOUNT>HN01001234567890</PRIMARYACCOUNT>
            <PRIMARYACCOUNTINT>1</PRIMARYACCOUNTINT>
            <gTRANSACTION g="1">
               <mTRANSACTION m="1">
                  <TRANSACTION>FT24001HN123456</TRANSACTION>
                  <TRANSACTIONINT>1</TRANSACTIONINT>
                  <ACCOUNTDR>HN01001234567890</ACCOUNTDR>
                  <CURRENCYDR>HNL</CURRENCYDR>
                  <AMOUNTDR>5000.00</AMOUNTDR>
                  <AMOUNTDRLCY>5000.00</AMOUNTDRLCY>
                  <ACCOUNTCR>HN01009876543210</ACCOUNTCR>
                  <CURRENCYCR>HNL</CURRENCYCR>
                  <AMOUNTCR>5000.00</AMOUNTCR>
                  <AMOUNTCRLCY>5000.00</AMOUNTCRLCY>
                  <CURRENCY>HNL</CURRENCY>
                  <AMOUNT>5000.00</AMOUNT>
                  <AMOUNTLCY>5000.00</AMOUNTLCY>
                  <CRVALUEDATE>20240415</CRVALUEDATE>
                  <DRVALUEDATE>20240415</DRVALUEDATE>
                  <CARDNUMBER>4111111111111234</CARDNUMBER>
                  <DCREVERSEMARK>Y</DCREVERSEMARK>
                  <REVERSALMARK>Y</REVERSALMARK>
               </mTRANSACTION>
            </gTRANSACTION>
            <RECORDSTATUS>LIVE</RECORDSTATUS>
            <CURRNO>1</CURRNO>
            <gINPUTTER g="1">
               <INPUTTER>1_OFS.DEFAULT_HND</INPUTTER>
            </gINPUTTER>
            <gDATETIME g="1">
               <DATETIME>240415121530</DATETIME>
            </gDATETIME>
         </TELLERFINANCIALSERVICESType>
      </t24:ReversionPagoTCTengoResponse>
   </soapenv:Body>
</soapenv:Envelope>
```