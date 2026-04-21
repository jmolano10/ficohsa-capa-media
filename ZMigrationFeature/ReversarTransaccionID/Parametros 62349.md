##### DynamoDB Parameter - Librería de parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#PAYMENT_EXECUTION_PROCESSING#PARAM#REVERSAL_CARD_REGISTER",
  "sk": "V#0001",
  "name": "REVERSAL_CARD_REGISTER",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "param-name": "ban-xrs-ic-comp-parm-pagos-db-dev",
      "secret-name": "ban-xrs-ic-comp-secm-pagos-db-dev"
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

**Nombre:** `ban-xrs-ic-comp-parm-pagos-db-dev` 

```json
{
  "host": "172.23.176.22",
  "port": "1970",
  "database": "pagoswsd"
}
```

##### AWS Systems Manager SecretManager

**Nombre:** `ban-xrs-ic-comp-secm-pagos-db-dev`

```json
{
  "username": "PAGOSWSTC",
  "password": "desarrollo"
}
```

##### Constantes para almacenar en ConfigMap

```json
{
  "caller-service":  "PAYMENT_EXECUTION_PROCESSING-PRODUCT-REVERSAL_CARD_REGISTER",
  "operationType": "update",
  "schema": "PAGOSWSTC",
  "procedureName": "OSB_P_REGISTRA_REVERSION_TC_CB"
}
```



##### Ejemplo de request Wrapper Pagos WSTC

```json
{
  "connection": {
    "parm": "ban-xrs-ic-comp-parm-pagos-db-dev",
    "secm": "ban-xrs-ic-comp-secm-pagos-db-dev"
  },
  "schema": "PAGOSWSTC",
  "package": "OSB_K_RECAUDO_BROKER_GT",
  "procedureName": "OSB_P_REGISTRA_REVERSION_TC_CB",
  "operationType": "update",
  "parameters": {
    "Pv_Transaction_Id": "FT24001HN123456"
  }
}
```

##### Ejemplo de Response Wrapper Pagos WSTC

```json
{
  "success": true,
  "data": {
    "outputParameters": {
      "Pv_ErrorCode": "SUCCESS",
      "Pv_ErrorMessage": ""
    },
    "resultSets": []
  },
  "metadata": {
    "procedureName": "request.procedureName",
    "executionTime": 1234,
    "timestamp": "2025-01-15T10:30:00Z"
  }
}
```
## Homologación de errores ## SP: OSB_P_REGISTRA_REVERSION_TC_CB

Homologación de los posibles resultados del stored procedure `OSB_P_REGISTRA_REVERSION_TC_CB`, que registra la reversión de un pago de tarjeta de crédito eliminando un registro previo de reversión (si existe) e insertando uno nuevo basado en el pago original encontrado en `TRC_PAGOS_HN`.

| `Pv_ErrorCode` | `Pv_ErrorMessage` | Escenario | Código HTTP | Descripción HTTP |
|---------------|-------------------|-----------|-------------|-----------------|
| **SUCCESS** | *(vacío)* | DELETE + SELECT + INSERT ejecutados correctamente; reversión registrada en `TRC_PAGOS_HN` | **200** | OK |
| **ERROR** | `ORA-01403: no data found` | `NO_DATA_FOUND` en el `SELECT INTO` — no existe transacción de pago (TIPO_OPERACION=`'C'`, TIPO_TRANSACCION=`1`, APLICADO=`'S'`) para el `SECUENCIA_MOVIMIENTO` recibido | **404** | Not Found |
| **ERROR** | `ORA-00001: unique constraint (...) violated` | El INSERT falla por restricción de unicidad — ya existe un registro de reversión idéntico en `TRC_PAGOS_HN` para ese `SECUENCIA_MOVIMIENTO` | **409** | Conflict |
| **ERROR** | `ORA-01400: cannot insert NULL into (...)` | El INSERT falla porque un campo NOT NULL del registro origen tiene valor nulo — indica corrupción o datos incompletos en el pago original | **500** | Internal Server Error |
| **ERROR** | `ORA-12899: value too large for column (...)` | El INSERT falla porque un valor del registro origen excede el tamaño de columna destino | **500** | Internal Server Error |
| **ERROR** | `ORA-00942: table or view does not exist` | La tabla `TRC_PAGOS_HN` no existe o el usuario `PAGOSWSTC` no tiene permisos sobre ella | **500** | Internal Server Error |
| **ERROR** | *(otro `SQLERRM`)* | `WHEN OTHERS` — cualquier otro error inesperado de base de datos; el SP ejecuta `ROLLBACK` antes de retornar | **500** | Internal Server Error |

> **Nota:** El SP solo retorna dos valores posibles en `Pv_ErrorCode`: `'SUCCESS'` o `'ERROR'`. Cuando ocurre cualquier excepción, ejecuta `ROLLBACK` completo (deshaciendo el DELETE previo si ya se había ejecutado) y devuelve el mensaje nativo de Oracle en `Pv_ErrorMessage` vía `SQLERRM`. La distinción del código HTTP 404 vs 409 vs 500 debe inferirse del contenido de `Pv_ErrorMessage` en la capa de mediación OSB.