##### DynamoDB Parameter - Librería de parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#CREATE_COUPON_WALLET_REGISTER#PARAM#REGISTER",
  "sk": "V#0001",
  "name": "REGISTER",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "param-name": "ban-xrs-ic-comp-parm-aurora-postgresql-db-<env>",
      "arn-secret": "arn:aws:secretsmanager:us-east-1:628835453395:secret:rds!cluster-9b8b1d20-96c6-4fe4-9db7-ca1af021a7a8-pSFoon"
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
  "description": "CONFIG OF CREATE_COUPON_WALLET_REGISTER BY METHOD",
  "country": "XRS",
  "domain": "CREATE_COUPON_WALLET_REGISTER",
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

**Nombre Paramétro**: `ban-xrs-ic-comp-parm-aurora-postgresql-db-<env>` (Validar Existencia)

```json
{
  "host": "ban-xrs-ic-rds-aurora-postgresql-dev.cluster-cexie6wsupzo.us-east-1.rds.amazonaws.com",
  "port": "5432",
  "database": "postgres"
}
```
																	
##### AWS Systems Manager SecretManager



##### Constantes para almacenar en ConfigMap

```json
{
  "caller-service":  "CREATE_COUPON_WALLET_REGISTER-SYSTEM-REGISTER",
  "userDB": "dbadmin",
  "procedureName": "ban-xrs-ic-sp-get-corban-commission-{env}"
}
```

##### Homologación de errores SP: ban-xrs-ic-sp-register-atm-coupon-withdrawal

El SP expone dos parámetros de salida: `p_response_code` y `p_response_message`. Su propósito es **registrar (escritura)** un retiro ATM realizado mediante cupón de billetera digital en la tabla `atmCouponManagement.atm_coupon_withdrawal_record`.

> **Equivalente Oracle:** `MIDDLEWARE.MW_P_REGISTRAR_BILLETERA_CUPON`

### Tabla de Homologación

| `p_response_code` | `p_response_message` (patrón) | Excepción PL/pgSQL | Código HTTP | Descripción HTTP | Causa raíz |
|---|---|---|---|---|---|
| `SUCCESS` | *(vacío — registro insertado y `COMMIT` ejecutado)* | — | 200 | OK | Registro insertado exitosamente en `atm_coupon_withdrawal_record` |
| `ERROR` | `ERROR: PARAMETRO DE ENTRADA p_retrieval_reference_number ES REQUERIDO.` | Validación de entrada | 400 | Bad Request | `p_retrieval_reference_number` recibido es nulo o vacío |
| `ERROR` | `ERROR: PARAMETRO DE ENTRADA p_transaction_reference_number ES REQUERIDO.` | Validación de entrada | 400 | Bad Request | `p_transaction_reference_number` recibido es nulo o vacío |
| `ERROR` | `ERROR: PARAMETRO DE ENTRADA p_terminal_id ES REQUERIDO.` | Validación de entrada | 400 | Bad Request | `p_terminal_id` recibido es nulo o vacío |
| `ERROR` | `ERROR: PARAMETRO DE ENTRADA p_coupon_id ES REQUERIDO.` | Validación de entrada | 400 | Bad Request | `p_coupon_id` recibido es nulo o vacío |
| `ERROR` | `ERROR: PARAMETRO DE ENTRADA p_transaction_amount ES REQUERIDO.` | Validación de entrada | 400 | Bad Request | `p_transaction_amount` recibido es nulo o vacío |
| `ERROR` | `ERROR: PARAMETRO DE ENTRADA p_currency_code ES REQUERIDO.` | Validación de entrada | 400 | Bad Request | `p_currency_code` recibido es nulo o vacío |
| `ERROR` | `<SQLERRM> ERROR` | `WHEN OTHERS` | 500 | Internal Server Error | Error inesperado al ejecutar el INSERT — violación de constraint, fallo de conexión u otra excepción PL/pgSQL no controlada; `ROLLBACK` ejecutado automáticamente |

### Notas de Implementación

- El SP **ejecuta escritura** (`INSERT` + `COMMIT`); ante cualquier error en el bloque `WHEN OTHERS` se ejecuta `ROLLBACK` explícito, garantizando que no queden registros parciales en la tabla.
- El `p_response_code` solo toma dos valores posibles (`SUCCESS` / `ERROR`); la distinción entre tipos de error debe hacerse inspeccionando el prefijo fijo del `p_response_message`.
- Los errores de validación de entrada (HTTP 400) deben detectarse **antes** de invocar el SP cuando sea posible, para evitar round-trips innecesarios a la base de datos.
- El error `WHEN OTHERS` (HTTP 500) puede originarse en violaciones de constraint (`CHECK`, `NOT NULL`), pérdida de conexión o cualquier excepción PL/pgSQL no prevista. El microservicio debe registrarlo en CloudWatch y **no reintentar** automáticamente sin investigar la causa raíz.
- A diferencia del SP Oracle original (que no tenía validaciones de entrada), en Aurora PostgreSQL se validan **todos los parámetros IN** de forma explícita, lo que permite emitir HTTP 400 con mensajes descriptivos por parámetro.
