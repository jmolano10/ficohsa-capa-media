##### DynamoDB Parameter - Librería de parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#PAYMENT_EXECUTION_PROCESSING#PARAM#EXECUTE_REVERSE_TRANSACTION",
  "sk": "V#0001",
  "name": "EXECUTE_REVERSE_TRANSACTION",
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

**Nombre:** `ban-hnd-ic-comp-param-t24-reversar-transaccion-tengo-eeh-wsdl-dev` 

```json
{
  "host": "172.23.177.15",
  "port": "7003",
  "basePath": "/svcGestionesTrxSEEHTENGO/services"
}
```
**Nombre:** `ban-hnd-ic-comp-param-t24-reversar-transaccion-tengo-eeh-wsdl-stg` 

```json
{
  "host": "http://10.242.15.43",
  "port": "7020",
  "basePath": "/svcGestionesTrxSEEHTENGO/services"
}
```

##### AWS Systems Manager SecretManager

**Nombre:** `ban-hnd-ic-comp-secm-t24-reversar-transaccion-tengo-eeh-wsdl-dev`

```json
{
  "username": "HNITINTB",
  "password": "intb2013$HN"
}
```

**Nombre:** `ban-hnd-ic-comp-secm-t24-reversar-transaccion-tengo-eeh-wsdl-stg`

```json
{
  "username": "HNITINTB",
  "password": "intb2013$HN"
}
```

##### Constantes para almacenar en ConfigMap

```json
{
  "caller-service":  "PAYMENT_EXECUTION_PROCESSING-PRODUCT-EXECUTE_REVERSE_TRANSACTION",
  "operation": "ReversarTransaccionTENGOEEH",
  "type": "FUNDSTRANSFERTENGOEEHREVERSIONType"
}
```
##### Registro en Dynamo Wrapper T24

```json
{
  "pk": "COUNTRY#HND#DOMAIN#WRAPPER_T24#PARAM#srv-itintb|PAYMENT_EXECUTION_PROCESSING-PRODUCT-EXECUTE_REVERSE_TRANSACTION",
  "sk": "V#0001",
  "name": "srv-itintb|PAYMENT_EXECUTION_PROCESSING-PRODUCT-EXECUTE_REVERSE_TRANSACTION",
  "value": {
    "secret-name": "ban-hnd-ic-comp-secm-t24-reversar-transaccion-tengo-eeh-wsdl-dev",
    "param-name": "ban-hnd-ic-comp-param-t24-reversar-transaccion-tengo-eeh-wsdl-dev"
  },
  "type": "json",
  "description": "Credenciales de la operación ReversarTransaccionTENGOEEH del PAYMENT_EXECUTION_PROCESSING-PRODUCT-EXECUTE_REVERSE_TRANSACTION",
  "country": "HND",
  "domain": "WRAPPER_T24",
  "tags": [
    "ReversarTransaccionTENGOEEH"
  ],
  "precedence": 1,
  "effective_from": "",
  "effective_to": "",
  "status": "active",
  "updated_at": "2025-10-25T18:10:00Z",
  "updated_by": "david.j.molano@ficohsa.com"
}
```

##### Ejemplo de request Wrapper T24 Operacion OP: ReversarTransaccionTENGOEEH
```json
postman request POST 'http://localhost:8080/t24-wrapper-hnd/v2/Depositoenefectivofase11' \
  --header 'Content-Type: application/json' \
  --header 'Correlation-Id: de957188-87a4-4808-a97e-d5da44a7798f' \
  --header 'Accept-Language: es' \
  --header 'Authorization: Bearer token.ok.ok' \
  --header 'Caller-Service: PAYMENT_EXECUTION_PROCESSING-PRODUCT-EXECUTE_REVERSE_TRANSACTION' \
  --header 'Channel: C001' \
  --header 'APP_CONTEXTUAL: 1' \
  --header 'Destination-Bank: test' \
  --header 'Source-Bank: test' \
  --header 'Application-Id: srv-itintb' \
  --body '{
  "operation": "ReversarTransaccionTENGOEEH",
  "payload": {
    "type": "FUNDSTRANSFERTENGOEEHREVERSIONType",
    "data": {
      "FUNDSTRANSFERTENGOEEHREVERSIONType": {
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
            "ReversarTransaccionTENGOEEHResponse": {
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
        "self": "/t24-wrapper-hnd/v2/ReversarTransaccionTENGOEEH"
    }
}
```
##### Homologación de errores OP: ReversarTransaccionTENGOEEH

Homologación de los valores posibles del campo `Status/successIndicator` retornados por la operación `ReversarTransaccionTENGOEEH` del Business Service `svcGestionesTrxSEEHTENGO`. Esta operación se invoca cuando `$tipoTransaccion = 'PAGO_EEH'`. El proxy captura el resultado mediante `fn:upper-case(fn:string($RSPRevTransGenerica/Status/successIndicator/text()))` y lo almacena en `$successIndicator`; el mensaje de error se toma de `$RSPRevTransGenerica/Status/messages` hacia `$errorCode`.

| `Status/successIndicator` | `Status/messages` | Escenario | Código HTTP | Descripción HTTP |
|--------------------------|-------------------|-----------|-------------|-----------------|
| **Success** | *(vacío)* | Reversión de transacción SEEH/TENGO procesada exitosamente en T24; el proxy continúa al stage `ActualizarEstadoTransaccion` para actualizar el estado en base de datos y retorna `T24_REFERENCE`, `TRANSACTION_ID` y `REFERENCE_CB` | **200** | OK |
| **TWSError** | Mensaje de error del Web Service | Error en la comunicación con el Web Service de T24; falla en la capa de transporte antes de llegar al core bancario | **502** | Bad Gateway |
| **T24Error** | Mensaje de error del core T24 | El core bancario T24 rechazó o no pudo procesar la reversión de la transacción SEEH/TENGO (p.ej. transacción inválida, ya reversada, error de procesamiento) | **500** | Internal Server Error |
| **T24Override** | Mensaje descriptivo del override | T24 requiere una autorización adicional (override) para completar la reversión; la transacción queda pendiente de aprobación | **202** | Accepted |
| **T24Offline** | Mensaje de sistema no disponible | T24 se encuentra fuera de línea o en mantenimiento; no es posible procesar la reversión en este momento | **503** | Service Unavailable |

> **Nota:** A diferencia de `ReversionPagoTCTengo`, esta operación no tiene un paso intermedio de registro en una tabla de tarjetas de crédito antes de llamar a T24. El resultado de `ReversarTransaccionTENGOEEH` fluye directamente al stage `ActualizarEstadoTransaccion`, donde solo si `$successIndicator = 'SUCCESS'` se actualiza el estado de la transacción en base de datos. Cualquier valor distinto de `SUCCESS` resulta en una respuesta SOAP con `successIndicator=ERROR` y el campo `messageId` poblado con el contenido de `Status/messages`.

##### Ejemplo request consumo T24 OP: ReversarTransaccionTENGOEEH

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:t24="T24WebServicesImpl">
  <soapenv:Header/>
  <soapenv:Body>
   <t24:ReversarTransaccionTENGOEEH>
     <!--Optional:-->
     <WebRequestCommon>
      <userName>?</userName>
      <password>?</password>
      <!--Optional:-->
      <company>?</company>
     </WebRequestCommon>
     <!--Optional:-->
     <FUNDSTRANSFERTENGOEEHREVERSIONType>
      <!--Optional:-->
      <transactionId>?</transactionId>
     </FUNDSTRANSFERTENGOEEHREVERSIONType>
   </t24:ReversarTransaccionTENGOEEH>
  </soapenv:Body>
</soapenv:Envelope>
```

##### Ejemplo Response T24 OP: ReversarTransaccionTENGOEEH

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:t24="T24WebServicesImpl">
  <soapenv:Header/>
  <soapenv:Body>
    <t24:ReversarTransaccionTENGOEEHResponse>
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
    </t24:ReversarTransaccionTENGOEEHResponse>
  </soapenv:Body>
</soapenv:Envelope>
```