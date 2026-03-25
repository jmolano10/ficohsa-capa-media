##### DynamoDB Parameter - Lambda Parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#CREDIT_CARD_TRANSACTION_RETRIEVES#PARAM#RETRIEVE_RECURRING_CHARGES",
  "sk": "V#0001",
  "name": "RETRIEVE_RECURRING_CHARGES",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "param-name": "ban-hnd-lc-ccard-parm-visa-transaction-wsdl-dev",
      "secret-name": "ban-hnd-lc-ccard-secm-visa-transaction-wsdl-dev",
      "matrix-afiliation": "018002000",
      "matrix-terminal": "18002000"
    },
    {
      "region": "GT01-GT01",
      "enabled": false
    },
    {
      "region": "NI01-NI01",
      "enabled": true,
      "param-name": "ban-nic-lc-ccard-parm-visa-transaction-wsdl-dev",
      "secret-name": "ban-nic-lc-ccard-secm-visa-transaction-wsdl-dev",
      "matrix-afiliation": "000000123456789",
      "matrix-terminal": "12345678"
    },
    {
      "region": "PA01-PA01",
      "enabled": false
    }
  ],
  "type": "JSON",
  "descrhosttion": "CONFIG OF CREDIT_CARD_TRANSACTION_RETRIEVES BY METHOD",
  "country": "XRS",
  "domain": "CREDIT_CARD_TRANSACTION_RETRIEVES",
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

**Nombre Paramétro Honduras**: `ban-hnd-lc-ccard-parm-visa-transaction-wsdl-dev`
```json
{
  "host": "https://192.168.125.188",
  "port": "",
  "basePath": "WSVisaTransaction.asmx"
}
```

**Nombre Paramétro Nicaragua**: `ban-nic-lc-ccard-parm-visa-transaction-wsdl-dev`
```json
{
  "host": "https://192.168.125.16",
  "port": "9443",
  "basePath": "WSVisaTransaction.asmx"
}
``` 
																	
##### AWS Systems Manager SecretManager

**Nombre Secreto Honduras**: `ban-hnd-lc-ccard-secm-visa-transaction-wsdl-dev`
```json
{
  "user": "ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOP",
  "password": "ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOP"
}
```

**Nombre Secreto Nicaragua**: `ban-nic-lc-ccard-secm-visa-transaction-wsdl-dev`
```json
{
  "user": "ABCDEFGHIJKLMNOPABCDEFGHIJKLMNOPABCDEFGHIJKLMNOPABCDEFGHIJKLMNOP",
  "password": "ABCDEFGHIJKLMNOPABCDEFGHIJKLMNOPABCDEFGHIJKLMNOPABCDEFGHIJKLMNOP"
}
```

##### Constantes para almacenar en ConfigMap

```json
{
  "operationHND": "QueryCardTransaction",
  "operationNIC": "QueryCardTransaction"
}
```
##### Ejemplo Request Servicio VisaNet

```xml
<tem:QueryCardTransaction xmlns:tem="http://tempuri.org/">
    <tem:input>
        <tem:strUser>usuario_visanet_hn</tem:strUser>
        <tem:strPassword>password_visanet_hn</tem:strPassword>
        <tem:strCardacqMatrizId>CARDACQ_HN_001</tem:strCardacqMatrizId>
        <tem:strTerminalMatrizId>TERM_HN_001</tem:strTerminalMatrizId>
        <tem:strCardNumber>4111111111111111</tem:strCardNumber>
        <tem:strDateIn>2024-01-15</tem:strDateIn>
        <tem:strDateOut>2024-01-15</tem:strDateOut>
    </tem:input>
</tem:QueryCardTransaction>
```

##### Ejemplo Response Servicio VisaNet
```xml
<tem:QueryCardTransactionResponse xmlns:tem="http://tempuri.org/">
    <tem:QueryCardTransactionResult>
        <tem:strQueryCode>000</tem:strQueryCode>
        <tem:strQueryMessage>Consulta exitosa</tem:strQueryMessage>
        <tem:strResponseDetail>
            <tem:ResponseDetail>
                <tem:strTransactionResponseCode>00</tem:strTransactionResponseCode>
                <tem:strTransactionDate>1/15/2024 10:30:00 AM</tem:strTransactionDate>
                <tem:strTransactionAmount>150.00</tem:strTransactionAmount>
                <tem:strCurrencyCode>HNL</tem:strCurrencyCode>
                <tem:strCommerceName>COMERCIO EJEMPLO SA</tem:strCommerceName>
            </tem:ResponseDetail>
            <tem:ResponseDetail>
                <tem:strTransactionResponseCode>05</tem:strTransactionResponseCode>
                <tem:strTransactionDate>1/15/2024 2:45:00 PM</tem:strTransactionDate>
                <tem:strTransactionAmount>75.50</tem:strTransactionAmount>
                <tem:strCurrencyCode>USD</tem:strCurrencyCode>
                <tem:strCommerceName>SUPERMERCADO XYZ</tem:strCommerceName>
            </tem:ResponseDetail>
        </tem:strResponseDetail>
    </tem:QueryCardTransactionResult>
</tem:QueryCardTransactionResponse>
```