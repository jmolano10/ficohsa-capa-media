##### DynamoDB Parameter - Librería de parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#PAYMENT_EXECUTION_PROCESSING#PARAM#RETRIEVE_GENERIC_TRANSACTION_TYPE",
  "sk": "V#0001",
  "name": "RETRIEVE_GENERIC_TRANSACTION_TYPE",
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
  "caller-service":  "PAYMENT_EXECUTION_PROCESSING-PRODUCT-RETRIEVE_GENERIC_TRANSACTION_TYPE",
  "connectionType": "jdbc",
  "operationType": "update",
  "catalogueName": "TRX_BATCH_CB",
  "packageName": "OSB_P_CTROL_TRANS_GENERICAS_CB",
  "procedureName": "OBTENER_TIPO_TRANSACCION"
}
```

##### Registro en Dynamo Wrapper Region DB

```json
{
  "pk": "COUNTRY#HND#DOMAIN#WRAPPER_REGION_DB#PARAM#PAYMENT_EXECUTION_PROCESSING-PRODUCT-RETRIEVE_GENERIC_TRANSACTION_TYPE",
  "sk": "V#0001",
  "name": "PAYMENT_EXECUTION_PROCESSING-PRODUCT-RETRIEVE_GENERIC_TRANSACTION_TYPE",
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
  "packageName": "OSB_P_ATB_REGISTRAR_CB",
  "procedureName": "REGISTRA_TRANSACCION_CANAL",
  "params": {
    "PV_COD_OSB": "PAGO_TC"
  }
}
```

##### Ejemplo de Response Wrapper Region DB

```json
{
  "success": true,
  "data": {
    "outputParameters": {
      "PV_ERROR_CODE": "SUCCESS",
      "Pv_ERRORMESSAGE": " ",
      "PV_MESSAGE": "NOGEN",
      "PV_TIPO_OPE": "REVERSA_TC"
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
## Homologación de errores SP: OBTENER_TIPO_TRANSACCION

Homologación de los posibles resultados del stored procedure `OBTENER_TIPO_TRANSACCION`, que valida si un código OSB existe en la tabla `TRX_BATCH_CB.ATB_CODIGOS_TRX_GEN_CB`.

| `PV_ERROR_CODE` | `PV_MESSAGE` | `PV_TIPO_OPE` | Escenario | Código HTTP | Descripción HTTP |
|----------------|-------------|--------------|-----------|-------------|-----------------|
| **SUCCESS** | `GEN` | `1` | Código OSB encontrado en tabla de transacciones genéricas | **200** | OK |
| **SUCCESS** | `NOGEN` | `0` | Código OSB **no** encontrado en tabla (flujo normal `COUNT = 0`) | **200** | OK |
| **SUCCESS** | `NOGEN` | `0` | `NO_DATA_FOUND` — `COUNT(*)` no devolvió filas (caso excepcional) | **200** | OK |
| **ERROR** | *(vacío)* | `0` | `WHEN OTHERS` — error inesperado en base de datos (`SQLERRM`) | **500** | Internal Server Error |

> **Nota:** Aunque `NOGEN` indica que el código no existe en la tabla, el SP retorna `SUCCESS` en ambos casos de ausencia. La distinción entre transacción generable (`GEN`) y no generable (`NOGEN`) es lógica de negocio, no un error técnico, por lo que se mapea a **200** en ambos. Solo `PV_ERROR_CODE = 'ERROR'` representa un fallo real de procesamiento.

---