##### DynamoDB Parameter - Librería de parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#RETRIEVE_CORRESPONDENT_COMISSION#PARAM#RETRIEVE",
  "sk": "V#0001",
  "name": "RETRIEVE",
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
  "description": "CONFIG OF RETRIEVE_CORRESPONDENT_COMISSION BY METHOD",
  "country": "XRS",
  "domain": "RETRIEVE_CORRESPONDENT_COMISSION",
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
  "caller-service":  "RETRIEVE_CORRESPONDENT_COMISSION-SYSTEM-RETRIEVE",
  "userDB": "dbadmin",
  "procedureName": "ban-xrs-ic-sp-get-comission-cb-{env}"
}
```

##### Homologación de errores SP: ban-xrs-ic-sp-get_corban_commission

El SP expone dos parámetros de salida: `p_response_code` y `p_response_message`. Su propósito es **consultar (lectura pura)** la parametrización de comisión en la tabla `corbanManagement.commission_rate_schedule` dado un tipo de transacción, moneda, rango de monto y usuario originador.

> **Equivalente Oracle:** `MIDDLEWARE.MW_P_CON_COMISION_CORBAN`

### Tabla de Homologación

| `p_response_code` | `p_response_message` (patrón) | Excepción PL/pgSQL | Código HTTP | Descripción HTTP | Causa raíz |
|---|---|---|---|---|---|
| `SUCCESS` | *(vacío — `p_commission_amount` y `p_commission_currency` populados)* | — | 200 | OK | Comisión encontrada y retornada exitosamente |
| `ERROR` | `ERROR: PARAMETRO p_amount DEBE SER MAYOR O IGUAL A CERO.` | Validación de entrada | 400 | Bad Request | `p_amount` recibido es nulo o negativo |
| `ERROR` | `ERROR: PARAMETRO DE ENTRADA p_currency_code ES REQUERIDO.` | Validación de entrada | 400 | Bad Request | `p_currency_code` recibido es nulo o vacío |
| `ERROR` | `ERROR: PARAMETRO DE ENTRADA p_transaction_type ES REQUERIDO.` | Validación de entrada | 400 | Bad Request | `p_transaction_type` recibido es nulo |
| `ERROR` | `ERROR: PARAMETRO DE ENTRADA p_transaction_user ES REQUERIDO.` | Validación de entrada | 400 | Bad Request | `p_transaction_user` recibido es nulo o vacío |
| `ERROR` | `No se encontró parametrización de comisión para el tipo de transacción {X} moneda {Y} y monto {Z}` | `NO_DATA_FOUND` | 404 | Not Found | No existe registro en `commission_rate_schedule` para la combinación tipo/moneda/monto/usuario enviada |
| `ERROR` | `Se encontró más de una parametrización de comisión para el tipo de transacción {X} moneda {Y} y monto {Z}` | `TOO_MANY_ROWS` | 409 | Conflict | Solapamiento de rangos en la tabla de parametrización — más de un registro coincide con los criterios |
| `ERROR` | `ERROR EN CONSULTA COMISION: <SQLERRM>` | `WHEN OTHERS` (bloque SELECT) | 500 | Internal Server Error | Error inesperado al ejecutar el SELECT sobre `commission_rate_schedule` |
| `ERROR` | `ERROR GENERAL SP sp_get_corban_commission: <SQLERRM>` | `WHEN OTHERS` (bloque externo) | 500 | Internal Server Error | Excepción PL/pgSQL no controlada fuera del bloque de consulta |

### Notas de Implementación

- El SP **no ejecuta escrituras** (solo `SELECT INTO STRICT`), por lo que no hay `COMMIT` ni `ROLLBACK` implicados.
- El `p_response_code` solo toma dos valores posibles (`SUCCESS` / `ERROR`); la distinción entre tipos de error debe hacerse inspeccionando el prefijo fijo del `p_response_message`.
- Los errores de validación de entrada (HTTP 400) deben detectarse **antes** de invocar el SP cuando sea posible, para evitar round-trips innecesarios a la base de datos.
- El error `NO_DATA_FOUND` (HTTP 404) indica que la parametrización no cubre la combinación enviada. El microservicio debe tratar este escenario como **error de negocio controlado** (no reintentar sin cambiar los parámetros).
- El error `TOO_MANY_ROWS` (HTTP 409) indica un solapamiento de rangos en los datos de configuración. El microservicio debe reportarlo como **error interno** y escalar a operaciones para corregir la parametrización en `commission_rate_schedule`.
- A diferencia del SP Oracle original (que capturaba `TOO_MANY_ROWS` dentro de `WHEN OTHERS`), en Aurora PostgreSQL ambas excepciones están **diferenciadas explícitamente**, lo que permite mensajes de diagnóstico más precisos.
