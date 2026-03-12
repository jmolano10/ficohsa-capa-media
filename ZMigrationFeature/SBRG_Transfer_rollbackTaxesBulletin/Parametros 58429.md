##### DynamoDB Parameter - Lambda Parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#HND#DOMAIN#PAYMENT_EXECUTION_TAXES#PARAM#INITIATE_RESERVAL_BULLTETINS",
  "sk": "V#0001",
  "name": "INITIATE_RESERVAL_BULLTETINS",
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
  "description": "CONFIG OF PAYMENT_EXECUTION_TAXES BY METHOD",
  "country": "HND",
  "domain": "PAYMENT_EXECUTION_TAXES",
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
"ban-hnd-ic-comp-parm-t24-rollback-taxes-bulletins-wsdl-dev"
{
  "ip": "http://172.23.177.15",
  "port": "7003",
  "basePath": "/RollbackTaxesBulletin/services"
}
```

```json
"ban-hnd-ic-comp-parm-t24-rollback-taxes-bulletins-wsdl-qa"
{
  "ip": "10.242.15.43",
  "port": "7020",
  "basePath": "/RollbackTaxesBulletin/services"
}
```

##### AWS Systems Manager SecretManager

```json
"ban-hnd-ic-comp-secm-t24-rollback-taxes-bulletins-wsdl-dev"
{
  "username": "HNITINTB",
  "password": "intb2013$HN"
}
```

##### Constantes para almacenar en ConfigMap

```json
{
  "operation": "rollbackTaxesBulletin",
  "caller-service": "payment_execution_taxes-product-inititate_reversal_bulletins"
}
```

##### Registro en Dynamo Wrapper T24 Operación rollbackTaxesBulletin

```json
{
  "pk": "COUNTRY#HND#DOMAIN#WRAPPER_T24#PARAM#srv-itintb|payment_execution_taxes-product-inititate_reversal_bulletins",
  "sk": "V#0001",
  "name": "srv-itintb|payment_execution_taxes-product-inititate_reversal_bulletins",
  "value": {
    "secret-name": "ban-hnd-ic-comp-secm-t24-rollback-taxes-bulletins-wsdl-dev",
    "param-name": "ban-hnd-ic-comp-parm-t24-rollback-taxes-bulletins-wsdl-dev"
  },
  "type": "json",
  "description": "Credenciales de la operación rollbackTaxesBulletin del payment_execution_taxes-product-inititate_reversal_bulletins",
  "country": "HND",
  "domain": "WRAPPER_T24",
  "tags": [
    "rollbackTaxesBulletin",
    "secret-manager-key"
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

##### Ejemplo del request para consumo API Idempotencia

##### Ejemplo mensaje en Event Brigde para componente de Idempotencia

##### Ejemplo de request Wrapper T24

**Operacion rollbackTaxesBulletin**

```json
postman request POST 'http://localhost:8080/t24-wrapper-hnd/v2/Depositocombinado' \
  --header 'Content-Type: application/json' \
  --header 'Correlation-Id: de957188-87a4-4808-a97e-d5da44a7798f' \
  --header 'Accept-Language: es' \
  --header 'Authorization: Bearer token.ok.ok' \
  --header 'Caller-Service: payment_execution_taxes-product-inititate_reversal_bulletins' \
  --header 'Channel: C001' \
  --header 'APP_CONTEXTUAL: 1' \
  --header 'Destination-Bank: test' \
  --header 'Source-Bank: test' \
  --header 'Application-Id: srv-itintb' \
  --body '{
  "operation": "rollbackTaxesBulletin",
  "payload": {
    "type": "FUNDSTRANSFERREFCOLLACTRFREVCOPYType",
    "data": {
      "FUNDSTRANSFERREFCOLLACTRFREVCOPYType": {
        "transactionId": "FT24001123456"
      }
    }
  }
}'
```

##### Ejemplo request consumo operacion rollbackTaxesBulletin
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:t24="T24WebServicesImpl">
   <soapenv:Header/>
   <soapenv:Body>
      <t24:rollbackTaxesBulletin>
         <!--Optional:-->
         <WebRequestCommon>
            <userName>?</userName>
            <password>?</password>
            <!--Optional:-->
            <company>?</company>
         </WebRequestCommon>
         <!--Optional:-->
         <FUNDSTRANSFERREFCOLLACTRFREVCOPYType>
            <!--Optional:-->
            <transactionId>?</transactionId>
         </FUNDSTRANSFERREFCOLLACTRFREVCOPYType>
      </t24:rollbackTaxesBulletin>
   </soapenv:Body>
</soapenv:Envelope>
```

