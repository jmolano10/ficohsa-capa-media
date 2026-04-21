##### DynamoDB Parameter - Librería de parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#PAYMENT_EXECUTION_PROCESSING#PARAM#RETRIEVE_TRANSACTION",
  "sk": "V#0001",
  "name": "RETRIEVE_TRANSACTION",
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

**Nombre:** `ban-hnd-ic-comp-parm-connection-region-db-dev` (Existente)

```json
{
  "host": "172.23.177.182",
  "port": "1521",
  "database": "regiondb"
}
```

##### AWS Systems Manager SecretManager

**Nombre:** `ban-hnd-ic-comp-secm-connection-trx-asincrono-db-dev` (Existente)

```json
{
  "username": "TRX_BATCH_CB",
  "password": "desarrollo"
}
```

##### Constantes para almacenar en ConfigMap

```json
{
  "caller-service":  "PAYMENT_EXECUTION_PROCESSING-PRODUCT-RETRIEVE_TRANSACTION",
  "connectionType": "jdbc",
  "operationType": "update",
  "catalogueName": "TRX_BATCH_CB",
  "packageName": "OSB_P_ATB_CONSULTA_CB",
  "procedureName": "CONSULTAR_TRANSACCIONES"
}
```

##### Registro en Dynamo Wrapper Region DB

```json
{
  "pk": "COUNTRY#HND#DOMAIN#WRAPPER_REGION_DB#PARAM#PAYMENT_EXECUTION_PROCESSING-PRODUCT-RETRIEVE_TRANSACTION",
  "sk": "V#0001",
  "name": "PAYMENT_EXECUTION_PROCESSING-PRODUCT-RETRIEVE_TRANSACTION",
  "value": {
    "param-name": "ban-hnd-ic-comp-parm-connection-region-db-dev",
    "secret-name": "ban-hnd-ic-comp-secm-connection-trx-asincrono-db-dev",
  },
  "type": "number",
  "version": "0001",
  "description": "Parametros Wrapper RegionDB Pago Prestamo",
  "country": "HND",
  "domain": "WRAPPER_REGION_DB",
  "tags": [],
  "precedence": 10,
  "effective_from": "2025-01-01T00:00:00Z",
  "effective_to": "9999-12-31T23:59:59Z",
  "status": "active",
  "updated_at": "2025-09-23T18:10:00Z",
  "updated_by": "joe@ficohsa.com"
}
```

##### Ejemplo de request Wrapper Region DB

```json
{
  "connectionType": "jdbc",
  "operationType": "update",
  "catalogueName": "TRX_BATCH_CB",
  "packageName": "OSB_P_ATB_CONSULTA_CB",
  "procedureName": "CONSULTAR_TRANSACCIONES",
  "params": {
    "PV_UUID": "550e8400-e29b-41d4-a716-446655440000",
    "PN_TIPO_CONSULTA": "1",
    "PN_CODIGO_ESTADO": "0"
  }
}
```

##### Ejemplo de Response Wrapper Region DB

```json
{
  "success": true,
  "data": {
    "outputParameters": {
      "Pv_Message": "SUCCESS",
      "Pv_FT": "NOGEN",
      "Pv_uuido": "REVERSA_TC",
      "Pv_refcb": "SUCCESS",
      "Pv_ErrorCode": "NOGEN",
      "Pv_ErrorMessage": "REVERSA_TC"
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
## Homologación de errores SP: CONSULTAR_TRANSACCIONES

Homologación de los posibles resultados del stored procedure `CONSULTAR_TRANSACCIONES`, que según el parámetro `PN_TIPO_CONSULTA` valida la existencia y estado de una transacción para determinar si puede ser reversada.

### Tipo de Consulta 1 — Verificar reversabilidad (tabla `ATB_TRANS_DIARIAS_CANAL_BANK`)

Busca por UUID (36 caracteres) o por `CLAVE_CORRESPONSAL`. Retorna si la transacción puede reversarse (estados `4` u `11`).

| `Pv_ErrorCode` | `Pv_Message` | Escenario | Código HTTP | Descripción HTTP |
|---------------|-------------|-----------|-------------|-----------------|
| **SUCCESS** | `TRUE` | Transacción encontrada con estado reversable (`4` o `11`) | **200** | OK |
| **SUCCESS** | `FALSE` | Transacción encontrada pero en estado **no** reversable (distinto de `4` y `11`). `Pv_ErrorMessage` = `'LA TRANSACCION NO SE PUEDE REVERSAR PORQUE NO SE ENCUENTRA EN UN ESTADO CORRECTO.'` | **409** | Conflict |
| **NO EXISTE REGISTRO PARA EL CODIGO SELECCIONADO** | `FALSE` | `NO_DATA_FOUND` — UUID o clave de corresponsal no existe en la tabla | **404** | Not Found |
| **ERROR** | *(vacío)* | `WHEN OTHERS` — error inesperado en base de datos (`SQLERRM`) | **500** | Internal Server Error |

### Tipo de Consulta 2 — Obtener código de estado UUID (tabla `ATB_UUID`)

Retorna el `CODIGO_ESTADO` asociado al UUID consultado.

| `Pv_ErrorCode` | `Pv_Message` | Escenario | Código HTTP | Descripción HTTP |
|---------------|-------------|-----------|-------------|-----------------|
| **SUCCESS** | *Valor de `CODIGO_ESTADO`* | UUID encontrado; `Pv_Message` contiene el código de estado | **200** | OK |
| **NO EXISTE REGISTRO PARA EL CODIGO SELECCIONADO** | `FALSE` | `NO_DATA_FOUND` — UUID no existe en `ATB_UUID` | **404** | Not Found |
| **ERROR** | *(vacío)* | `WHEN OTHERS` — error inesperado en base de datos (`SQLERRM`) | **500** | Internal Server Error |

### Tipo de Consulta 3 — Descripción de estado de transacción (tabla `ATB_TRANS_DIARIAS_CANAL_BANK`)

Retorna la descripción legible del estado de una transacción a partir de su UUID.

| `Pv_ErrorCode` | `Pv_Message` | Escenario | Código HTTP | Descripción HTTP |
|---------------|-------------|-----------|-------------|-----------------|
| **SUCCESS** | `'PENDIENTE DE APLICAR'` | Estado entre 7 y 8 (exclusive) | **200** | OK |
| **SUCCESS** | `'TRANSACCION SERA APLICADA EN LA NOCHE'` | Estado = `10` | **200** | OK |
| **SUCCESS** | `'EXITOSA'` | Estado = `11` | **200** | OK |
| **SUCCESS** | `'FALLIDA'` | Estado ≥ `12` | **200** | OK |
| **SUCCESS** | *Descripción de `ATB_ESTADOS_TRANSACCION`* | Cualquier otro estado; se resuelve desde la tabla de estados | **200** | OK |
| **NO EXISTE REGISTRO PARA EL CODIGO SELECCIONADO** | `FALSE` | `NO_DATA_FOUND` — UUID no existe o estado no tiene descripción en la tabla | **404** | Not Found |
| **ERROR** | *(vacío)* | `WHEN OTHERS` — error inesperado en base de datos (`SQLERRM`) | **500** | Internal Server Error |

### Tipo de Consulta 4 — Verificar reversabilidad genérica (tabla `atb_trans_genericas_cb_dia`)

Igual al tipo 1 pero sobre la tabla de transacciones genéricas. Solo el estado `4` habilita la reversión.

| `Pv_ErrorCode` | `Pv_Message` | Escenario | Código HTTP | Descripción HTTP |
|---------------|-------------|-----------|-------------|-----------------|
| **SUCCESS** | `TRUE` | Transacción genérica encontrada con estado reversable (`4`) | **200** | OK |
| **SUCCESS** | `FALSE` | Transacción genérica encontrada pero en estado **no** reversable (distinto de `4`). `Pv_ErrorMessage` = `'LA TRANSACCION NO SE PUEDE REVERSAR PORQUE NO SE ENCUENTRA EN UN ESTADO CORRECTO.'` | **409** | Conflict |
| **NO EXISTE REGISTRO PARA EL CODIGO SELECCIONADO** | `FALSE` | `NO_DATA_FOUND` — UUID o clave de corresponsal no existe en la tabla genérica | **404** | Not Found |
| **ERROR** | *(vacío)* | `WHEN OTHERS` — error inesperado en base de datos (`SQLERRM`) | **500** | Internal Server Error |

> **Nota general:** El SP retorna `SUCCESS` con `Pv_Message = 'FALSE'` cuando la transacción existe pero no cumple las condiciones de negocio para ser reversada. Esto no es un error técnico sino una respuesta de negocio negativa; se mapea a **409 Conflict** porque el estado actual del recurso impide la operación solicitada. Solo los valores `'NO EXISTE REGISTRO...'` y `'ERROR'` en `Pv_ErrorCode` representan fallos técnicos reales.

---