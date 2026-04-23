##### DynamoDB Parameter - Librería de parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#REGISTER_REVERSE_CREDIT_CARD#PARAM#REGISTER",
  "sk": "V#0001",
  "name": "REGISTER",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "param-name": "ban-hnd-ic-comp-parm-connection-tarjetas-pagos-tc-db-dev",
      "secret-name": "ban-hnd-ic-comp-secm-connection-tarjetas-pagos-tc-db-dev"
    },
    {
      "region": "GT01-GT01",
      "enabled": true,
      "param-name": "ban-gtm-ic-comp-parm-connection-tarjetas-pagos-tc-db-dev",
      "secret-name": "ban-gtm-ic-comp-secm-connection-tarjetas-pagos-tc-db-dev"
    },
    {
      "region": "NI01-NI01",
      "enabled": true,
      "param-name": "ban-nic-ic-comp-parm-connection-tarjetas-pagos-tc-db-dev",
      "secret-name": "ban-nic-ic-comp-secm-connection-tarjetas-pagos-tc-db-dev"
    },
    {
      "region": "PA01-PA01",
      "enabled": true,
      "param-name": "ban-pan-ic-comp-parm-connection-tarjetas-pagos-tc-db-dev",
      "secret-name": "ban-pan-ic-comp-secm-connection-tarjetas-pagos-tc-db-dev"
    }
  ],
  "type": "list",
  "description": "CONFIG OF REGISTER_REVERSE_CREDIT_CARD BY METHOD",
  "country": "XRS",
  "domain": "REGISTER_REVERSE_CREDIT_CARD",
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

**Nombre Paramétro Honduras**: `ban-hnd-ic-comp-parm-connection-tarjetas-pagos-tc-db-dev` 
```json
{
  "ip": "172.23.177.175",
  "port": "1433",
  "database": "PagosTC"
}
```

**Nombre Paramétro Guatemala**: `ban-gtm-ic-comp-parm-connection-tarjetas-pagos-tc-db-dev` 
```json
{
  "ip": "172.23.177.175",
  "port": "1433",
  "database": "PagosTC"
}
```

**Nombre Paramétro Nicaragua**: `ban-nic-ic-comp-parm-connection-tarjetas-pagos-tc-db-dev` 
```json
{
  "ip": "172.23.177.175",
  "port": "1433",
  "database": "PagosTC"
}
```

**Nombre Paramétro Panamá**: `ban-pan-ic-comp-parm-connection-tarjetas-pagos-tc-db-dev` 
```json
{
  "ip": "172.23.177.175",
  "port": "1433",
  "database": "PagosTC"
}
```
																	
##### AWS Systems Manager SecretManager

**Nombre Secreto Honduras**: `ban-hnd-ic-comp-secm-connection-tarjetas-pagos-tc-db-dev` 
```json
{
  "user": "UsrOSB",
  "password": "FicohsaTC2021"
}
```

**Nombre Secreto Guatemala**: `ban-gtm-ic-comp-secm-connection-tarjetas-pagos-tc-db-dev` 
```json
{
  "user": "UsrOSB",
  "password": "FicohsaTC2021"
}
```

**Nombre Secreto Nicaragua**: `ban-nic-ic-comp-secm-connection-tarjetas-pagos-tc-db-dev` 
```json
{
  "user": "UsrOSB",
  "password": "FicohsaTC2021"
}
```

**Nombre Secreto Panamá**: `ban-hnd-ic-comp-secm-connection-tarjetas-pagos-tc-db-dev` 
```json
{
  "user": "UsrOSB",
  "password": "FicohsaTC2021"
}
```

##### Constantes para almacenar en ConfigMap

```json
{
  "caller-service":  "REGISTER_REVERSE_CREDIT_CARD-SYSTEM-REGISTER",
  "caller-service-retry":  "retry_handler_execution",
  "schema": "dbo",
  "procedureName": "OSBRegistraReversaTC"
}
```



##### Homologación de errores SP: OSBRegistraReversaTC

Homologación de los posibles resultados del stored procedure `OSBRegistraReversaTC` (esquema `dbo`), que registra una reversa de pago de tarjeta de crédito copiando el registro original (`TipoOperacion='C'`) a `bfemDetallePagos_*` con `TipoOperacion='R'`. El SP opera sobre tablas por país (HND, GTM, PAN, NIC) y busca primero en transacciones pendientes (`bfemDetallePagos_*`) y luego en transacciones procesadas (`bfemPagosProcesados_*`).

| `@CodigoError` | `@MensajeError` | Escenario | Código HTTP | Descripción HTTP |
|---------------|----------------|-----------|-------------|-----------------|
| **NULL / 0** | *(vacío)* | Pago original (`TipoOperacion='C'`) encontrado en `bfemDetallePagos_*` o `bfemPagosProcesados_*` y no existe reversa previa; `INSERT` completado exitosamente | **200** | OK |
| **NULL / 0** | *(vacío)* | Pago original encontrado en `bfemDetallePagos_*` pero ya existe reversa (`TipoOperacion='R'`) en la misma tabla; el SP omite el `INSERT` sin señalizar error | **200** | OK |
| **NULL / 0** | *(vacío)* | Pago original encontrado en `bfemPagosProcesados_*` pero ya existe reversa (`TipoOperacion='R'`) en la misma tabla; el SP omite el `INSERT` sin señalizar error | **200** | OK |
| **-2** | `NO EXISTE PAGO PARA LA REVERSA` | La `SecuenciaMovimiento` no existe como pago (`TipoOperacion='C'`) ni en `bfemDetallePagos_*` ni en `bfemPagosProcesados_*` para el país indicado | **404** | Not Found — No existe pago original para reversar |
| **NULL / 0** | *(vacío)* | El parámetro `@Pais` no coincide con ninguno de los valores soportados (`HND`, `GTM`, `PAN`, `NIC`); el SP no ejecuta ningún bloque y retorna sin acción ni error | **200** | OK |
| *Código SQL* | *Mensaje de excepción* | Error de base de datos capturado por `BEGIN TRY`; fallo en `INSERT`, violación de constraint, timeout u otro error de motor SQL | **500** | Internal Server Error |

> **Nota:** El SP no diferencia entre "reversa ya existe" y "operación exitosa" — en ambos casos `@CodigoError` queda en NULL/0. La distinción para el mapeo a **409** es responsabilidad de la capa de integración, que debe verificar la existencia previa de la reversa o evaluar `@@ROWCOUNT` para determinar si el `INSERT` realmente se ejecutó. El único error explícito del SP es **-2** para el caso de pago no encontrado.


##### Registro en Dynamo para componente de idempotencia y reintentos

```json
{
    "PK": "REGISTER_REVERSE_CREDIT_CARD-SYSTEM-REGISTER",
    "SK": "1.0|ACTIVE",
    "version": "1.0",
    "stage": "ACTIVE",
    "callerService": "REGISTER_REVERSE_CREDIT_CARD-SYSTEM-REGISTER",
    "service": "/register-reverse-credit-card/v1",
    "method": "/register",
    "domain": "Composition",
    "typeUsage": "INT",
    "hashFields": [
        "organizationReference",
        "transactionReferenceReverse",
        "operationType"
    ],
    "retryPolicy": {
        "enabled": true,
        "maxAttempts": 9,
        "delaySeconds": 120,
        "initialDelaySeconds": 120
    },
    "cache": {
        "enabled": true,
        "ttlSeconds": 1800
    },
    "activeIndex": "ACTIVE",
    "updated_at": "2025-11-05T21:32:45.237-06:00",
    "updated_by": "david.j.molano@ficohsa.com",
    "tags": [
        "masterData",
        "register-reverse-credit-card"
    ],
    "flowRetry": {
        "retrySame": {
            "method": "POST",
            "path": "/register",
            "fieldMapping": {
                "transactionReference": "$.transactionReference",
                "transactionReferenceReverse": "$.transactionReferenceReverse",
                "operationType": "$.operationType",
                "errorCode": "$.errorCode",
                "errorMessage": "$.errorMessage"
            }
        }
    },
    "integrity": {
        "confirmSuccessCodes": [
            "00",
            "000"
        ],
        "timeoutErrorCodes": [
            "500",
            "501",
            "10"
        ],
        "businessErrorCodes": [
            "2501",
            "5010",
            "654"
        ]
    }
}
```

##### Ejemplo del request para consumo API Idempotencia

```json
curl --location 'http://internal-ban-xrs-ic-elb-alb-master-dev-548527349.us-east-1.elb.amazonaws.com:17396/integrity-handler/v1/idempotency/generate' \
--header 'Caller-Service: REGISTER_REVERSE_CREDIT_CARD-SYSTEM-REGISTER' \
--header 'Correlation-Id: b1f6f6f5-d611-4c1f-843f-89a1c8aaaaee' \
--header 'Authorization: Bearer my.token.loko' \
--header 'Source-Bank: HN01' \
--header 'Application-Id: 123456789' \
--header 'Channel: my-channel' \
--header 'Content-Type: application/json' \
--data '{
    "methodVersion": "1.0",
    "dataPayload": {
        "organizationReference": "str",
        "transactionReferenceReverse": "string",
        "operationType": "s",
        "errorCode": 0,
        "errorMessage": "temp"
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
        "callerService": "REGISTER_REVERSE_CREDIT_CARD-SYSTEM-REGISTER",
        "channel": "rest-api",
        "transactionStatus": "success", // || "timeout" ||  "error" || "fault",
        "payload": { 
            "host": "http://abanks-url",
            "headers": {
                "Source-Bank": "HN01",
                "Application-Id": "123456789"
            },
            "body": {
                "organizationReference": "str",
                "transactionReferenceReverse": "string",
                "operationType": "s",
                "errorCode": 0,
                "errorMessage": "temp"
            }
        }
    }
}
```