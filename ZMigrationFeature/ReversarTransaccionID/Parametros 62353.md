##### DynamoDB Parameter - Librería de parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#SSSS#PARAM#MMMM",
  "sk": "V#0001",
  "name": "MMMM",
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
  "description": "CONFIG OF SSSS BY METHOD",
  "country": "XRS",
  "domain": "SSSS",
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

**Nombre:** `ban-hnd-ic-comp-param-t24-reversion-deposito-tengo-wsdl-dev` 

```json
{
  "host": "172.23.177.15",
  "port": "7003",
  "basePath": "/svcReversarTransaccionCB/services"
}
```
**Nombre:** `ban-hnd-ic-comp-param-t24-reversion-deposito-tengo-wsdl-stg` 

```json
{
  "host": "http://10.242.15.43",
  "port": "7020",
  "basePath": "/svcReversarTransaccionCB/services"
}
```

##### AWS Systems Manager SecretManager

**Nombre:** `ban-hnd-ic-comp-secm-t24-reversion-deposito-tengo-wsdl-dev`

```json
{
  "username": "HNITINTB",
  "password": "intb2013$HN"
}
```

**Nombre:** `ban-hnd-ic-comp-secm-t24-reversion-deposito-tengo-wsdl-stg`

```json
{
  "username": "HNITINTB",
  "password": "intb2013$HN"
}
```

##### Constantes para almacenar en ConfigMap

```json
{
  "caller-service":  "SSSS-PRODUCT-MMMM",
  "operation": "ReversionDepositoTengo",
  "type": "FUNDSTRANSFERFICOREVTXNUUIDFTType"
}
```
##### Registro en Dynamo Wrapper T24

```json
{
  "pk": "COUNTRY#HND#DOMAIN#WRAPPER_T24#PARAM#srv-itintb|SSSS-PRODUCT-MMMM",
  "sk": "V#0001",
  "name": "srv-itintb|SSSS-PRODUCT-MMMM",
  "value": {
    "secret-name": "ban-hnd-ic-comp-secm-t24-reversion-deposito-tengo-wsdl-dev",
    "param-name": "ban-hnd-ic-comp-param-t24-reversion-deposito-tengo-wsdl-dev"
  },
  "type": "json",
  "description": "Credenciales de la operación ReversionDepositoTengo del SSSS-PRODUCT-MMMM",
  "country": "HND",
  "domain": "WRAPPER_T24",
  "tags": [
    "ReversionDepositoTengo"
  ],
  "precedence": 1,
  "effective_from": "",
  "effective_to": "",
  "status": "active",
  "updated_at": "2025-10-25T18:10:00Z",
  "updated_by": "david.j.molano@ficohsa.com"
}
```

##### Ejemplo de request Wrapper T24 Operacion OP: ReversionDepositoTengo
```json
postman request POST 'http://localhost:8080/t24-wrapper-hnd/v2/Depositoenefectivofase11' \
  --header 'Content-Type: application/json' \
  --header 'Correlation-Id: de957188-87a4-4808-a97e-d5da44a7798f' \
  --header 'Accept-Language: es' \
  --header 'Authorization: Bearer token.ok.ok' \
  --header 'Caller-Service: SSSS-PRODUCT-MMMM' \
  --header 'Channel: C001' \
  --header 'APP_CONTEXTUAL: 1' \
  --header 'Destination-Bank: test' \
  --header 'Source-Bank: test' \
  --header 'Application-Id: srv-itintb' \
  --body '{
  "operation": "ReversionDepositoTengo",
  "payload": {
    "type": "FUNDSTRANSFERFICOREVTXNUUIDFTType",
    "data": {
      "FUNDSTRANSFERFICOREVTXNUUIDFTType": {
        "transactionId": "FT24001HN123456"        
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
            "ReversionDepositoTengoResponse": {
                "status": {
                    "transactionId": "FT24001HN654321",
                    "messageId": "",
                    "successIndicator": "Success",
                    "application": "TELLER.FINANCIAL.SERVICES"
                }
            }
        }
    },
    "links": {
        "self": "/t24-wrapper-hnd/v2/ReversionDepositoTengo"
    }
}
```
##### Homologación de errores OP: ReversionDepositoTengo

Homologación de los valores posibles del campo `Status/successIndicator` retornados por la operación `ReversionDepositoTengo` del Business Service `svcReversarTransaccionCB`, hacia códigos HTTP semánticos. El proxy invoca esta operación en la rama `default` del stage `ReversarTransaccion` — es decir, cuando `$tipoTransaccion` no es `PAGO_TC` ni `PAGO_EEH` (transacciones de depósito Tengo genéricas). El resultado se captura mediante `fn:upper-case(fn:string($RSPRevDeposito/Status/successIndicator/text()))` hacia `$successIndicator`; el mensaje de error se toma de `$RSPRevDeposito/Status/messages` hacia `$errorCode`; y la referencia T24 de `$RSPRevDeposito/Status/transactionId` hacia `$statusT24`.

| `Status/successIndicator` | `Status/messages` | Escenario | Código HTTP | Descripción HTTP |
|--------------------------|-------------------|-----------|-------------|-----------------|
| **Success** | *(vacío)* | Reversión de depósito Tengo procesada exitosamente en T24; el proxy continúa al stage `ActualizarEstadoTransaccion` para actualizar el estado en base de datos y retorna `T24_REFERENCE`, `TRANSACTION_ID` y `REFERENCE_CB` | **200** | OK |
| **TWSError** | Mensaje de error del Web Service | Error en la comunicación con el Web Service de T24; falla en la capa de transporte antes de llegar al core bancario | **502** | Bad Gateway |
| **T24Error** | Mensaje de error del core T24 | El core bancario T24 rechazó o no pudo procesar la reversión del depósito Tengo (p.ej. transacción inválida, ya reversada, error de procesamiento interno) | **500** | Internal Server Error |
| **T24Override** | Mensaje descriptivo del override | T24 requiere una autorización adicional (override) para completar la reversión; la transacción queda pendiente de aprobación | **202** | Accepted |
| **T24Offline** | Mensaje de sistema no disponible | T24 se encuentra fuera de línea o en mantenimiento; no es posible procesar la reversión del depósito en este momento | **503** | Service Unavailable |

> **Nota:** El proxy uppercasea el `successIndicator` antes de la comparación (`fn:upper-case`), por lo que `Success` del XSD se evalúa como `SUCCESS`. Solo el valor `SUCCESS` habilita el flujo hacia `ActualizarEstadoTransaccion`; cualquier otro valor resulta en una respuesta SOAP con `successIndicator=ERROR` y el campo `messageId` poblado con el contenido de `Status/messages`. Esta operación comparte el mismo Business Service (`svcReversarTransaccionCB`) que `ReversionPagoTCTengo`, pero se distingue por la operación invocada y por ser el camino `default` (depósitos) frente a `PAGO_TC`. El mapeo HTTP es semántico — la capa SOAP retorna siempre HTTP 200 en el transporte; los códigos aquí representan la intención de negocio para la capa REST/API Gateway.

##### Ejemplo request consumo T24 OP: ReversionDepositoTengo

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:t24="T24WebServicesImpl">
   <soapenv:Header/>
   <soapenv:Body>
      <t24:ReversionDepositoTengo>
         <!--Optional:-->
         <WebRequestCommon>
            <userName>?</userName>
            <password>?</password>
            <!--Optional:-->
            <company>?</company>
         </WebRequestCommon>
         <!--Optional:-->
         <FUNDSTRANSFERFICOREVTXNUUIDFTType>
            <!--Optional:-->
            <transactionId>?</transactionId>
         </FUNDSTRANSFERFICOREVTXNUUIDFTType>
      </t24:ReversionDepositoTengo>
   </soapenv:Body>
</soapenv:Envelope>
```

##### Ejemplo Response T24 OP: ReversionDepositoTengo

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:t24="T24WebServicesImpl">
   <soapenv:Header/>
   <soapenv:Body>
      <t24:ReversionDepositoTengoResponse>
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
      </t24:ReversionDepositoTengoResponse>
   </soapenv:Body>
</soapenv:Envelope>
```