##### DynamoDB Parameter - Librería de parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#REGISTER_CHANNEL_TRANSACTION_STATUS#PARAM#REGISTER",
  "sk": "V#0001",
  "name": "REGISTER",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "param-name": "ban-hnd-ic-sys-parm-connection-collections-db-dev",
      "secret-name": "ban-hnd-ic-sys-secm-connection-collections-db-dev"
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
  "description": "CONFIG OF REGISTER_CHANNEL_TRANSACTION_STATUS BY METHOD",
  "country": "XRS",
  "domain": "REGISTER_CHANNEL_TRANSACTION_STATUS",
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

**Nombre Paramétro**: `ban-hnd-ic-sys-parm-connection-collections-db-dev` 
```json
{
  "ip": "172.23.177.182",
  "port": "1521",
  "database": "regiondb"
}
```
																	
##### AWS Systems Manager SecretManager

**Nombre Secreto**: `ban-hnd-ic-sys-secm-connection-collections-db-dev` 
```json
{
  "user": "Collections",
  "password": "desarrollo"
}
```


##### Constantes para almacenar en ConfigMap

```json
{
  "caller-service":  "REGISTER_CHANNEL_TRANSACTION_STATUS-SYSTEM-REGISTER",
  "schema": "COLLECTIONS",
  "package": "OSB_P_MANEJO_TRANSACCIONES",
  "procedureName": "REGISTRA_TRANSACCION_CANAL"
}
```

##### Homologación de errores SP: REGISTRA_TRANSACCION_CANAL

| `Pv_ErrorCode` | `Pv_ErrorMessage` | Origen | Código HTTP | Descripción HTTP |
|----------------|-------------------|--------|-------------|------------------|
| `SUCCESS` | *(vacío)* | INSERT + COMMIT exitoso | 201 | Created |
| `ERROR` | `El monto no puede ser cero.` | Validación de negocio (monto = 0) | 400 | Bad Request |
| `ERROR` | `ORA-00001: unique constraint violated` | WHEN OTHERS — clave duplicada en `TRANS_DIARIAS_CANAL_BANK` | 409 | Conflict |
| `ERROR` | `ORA-01400: cannot insert NULL into (...)` | WHEN OTHERS — campo obligatorio sin valor | 422 | Unprocessable Entity |
| `ERROR` | `ORA-02291: integrity constraint violated (parent key not found)` | WHEN OTHERS — FK inválida (ej. código de canal, corresponsal) | 422 | Unprocessable Entity |
| `ERROR` | `ORA-12899: value too large for column (...)` | WHEN OTHERS — dato excede longitud de columna | 400 | Bad Request |
| `ERROR` | `ORA-00904: invalid identifier` | WHEN OTHERS — error estructural del SP (config/despliegue) | 500 | Internal Server Error |
| `ERROR` | `ORA-01031: insufficient privileges` | WHEN OTHERS — permisos insuficientes sobre la tabla | 500 | Internal Server Error |
| `ERROR` | `ORA-12541: TNS no listener` / `ORA-12170: TNS connect timeout` | WHEN OTHERS — error de conectividad con la base de datos | 503 | Service Unavailable |
| `ERROR` | Cualquier otro `SQLERRM` no contemplado arriba | WHEN OTHERS — excepción Oracle genérica | 500 | Internal Server Error |

**Notas de Implementación**

- El bloque `WHEN OTHERS` ejecuta `ROLLBACK` antes de retornar, garantizando que ningún registro quede pendiente de commit ante cualquier falla.
- El `Pv_ErrorCode` solo toma dos valores posibles (`SUCCESS` / `ERROR`); la distinción entre tipos de error debe hacerse inspeccionando el contenido de `Pv_ErrorMessage`.
- Los errores `ORA-00001` y `ORA-02291` indican un problema en los datos enviados por el canal, por lo que corresponden a respuestas 4xx.
- Los errores de conectividad (`ORA-12541`, `ORA-12170`) deben mapearse a **503** con cabecera `Retry-After` para permitir reintentos automáticos por parte del cliente.