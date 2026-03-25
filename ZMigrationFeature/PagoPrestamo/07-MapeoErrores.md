# Mapeo de Errores - REGISTRA_TRANSACCION_CANAL

## Stored Procedure Analizado

**Nombre:** `REGISTRA_TRANSACCION_CANAL`
**Parámetros de salida:** `Pv_ErrorCode OUT VARCHAR2`, `Pv_ErrorMessage OUT VARCHAR2`

---

## Tabla de Mapeo de Errores a Códigos HTTP

| Pv_ErrorCode | Pv_ErrorMessage | Condición en el SP | Código HTTP | Descripción HTTP | Categoría | Retry |
|---|---|---|---|---|---|---|
| `SUCCESS` | _(vacío)_ | INSERT exitoso + UUID actualizado | **200** | OK | Éxito | No aplica |
| `ERROR` | `El monto no puede ser cero.` | `PN_MONTO = 0` | **400** | Bad Request | Validación | No |
| `ERROR` | `El codigo ingresado no existe, favor verificar` | UUID no encontrado en `ATB_UUID` (`NO_DATA_FOUND`) | **404** | Not Found | Recurso | No |
| `ERROR` | `El codigo ingresado tiene un estado diferente de REGISTRADO, favor verificar` | `codigo_estado != 1` en `ATB_UUID` | **409** | Conflict | Estado | No |
| `ERROR` | _(valor de `SQLERRM`)_ | Excepción no controlada (`WHEN OTHERS`) — incluye fallos en INSERT, integridad referencial, etc. | **500** | Internal Server Error | Sistema | Sí |
| `ERROR` _(propagado)_ | _(valor retornado por el SP interno)_ | Error retornado por `ACTUALIZAR_ESTADO_UUID` tras el COMMIT | **500** | Internal Server Error | Sistema | Sí |

---

## Detalle de Cada Escenario

### SUCCESS — Transacción registrada correctamente
- **Pv_ErrorCode:** `SUCCESS`
- **Pv_ErrorMessage:** `''` (string vacío)
- **Condición:** El monto es distinto de cero, el UUID existe en `ATB_UUID` con `codigo_estado = 1`, el INSERT en `ATB_TRANS_DIARIAS_CANAL_BANK` es exitoso, el COMMIT se aplica y `ACTUALIZAR_ESTADO_UUID` no retorna error.
- **HTTP:** `200 OK`

---

### ERROR — Monto cero
- **Pv_ErrorCode:** `ERROR`
- **Pv_ErrorMessage:** `El monto no puede ser cero.`
- **Condición:** `PN_MONTO = 0`. Primera validación del SP, retorna inmediatamente sin afectar la base de datos.
- **HTTP:** `400 Bad Request`
- **Nota:** La copia `lv_monto := PN_MONTO` es la que se evalúa, pero el INSERT utiliza `PN_MONTO` directamente (inconsistencia menor; ambos valores son idénticos en este punto).

---

### ERROR — UUID inexistente
- **Pv_ErrorCode:** `ERROR`
- **Pv_ErrorMessage:** `El codigo ingresado no existe, favor verificar`
- **Condición:** El SELECT sobre `ATB_UUID` no retorna filas (`WHEN NO_DATA_FOUND`).
- **HTTP:** `404 Not Found`

---

### ERROR — UUID en estado incorrecto
- **Pv_ErrorCode:** `ERROR`
- **Pv_ErrorMessage:** `El codigo ingresado tiene un estado diferente de REGISTRADO, favor verificar`
- **Condición:** El UUID existe en `ATB_UUID` pero `codigo_estado != 1`. El valor `1` corresponde al estado `REGISTRADO`.
- **HTTP:** `409 Conflict`
- **Nota:** El UUID puede estar en un estado posterior (procesado, anulado, etc.). No es un error de datos de entrada sino de estado del recurso.

---

### ERROR — Excepción no controlada (WHEN OTHERS)
- **Pv_ErrorCode:** `ERROR`
- **Pv_ErrorMessage:** Valor de `SQLERRM` en el momento de la excepción
- **Condición:** Cualquier excepción no prevista durante el bloque principal:
  - Fallo en el INSERT (violación de llave primaria/única, restricción NOT NULL, FK inválida, tablespace lleno)
  - Error de concurrencia o deadlock
  - Error de conexión a la base de datos
- **HTTP:** `500 Internal Server Error`
- **Retry:** Sí (errores transitorios de BD son candidatos a reintento)
- **Alerta:** El SP ejecuta `ROLLBACK` en este caso, deshaciendo el INSERT si fue parcial.

---

### ERROR — Fallo en ACTUALIZAR_ESTADO_UUID (post-COMMIT)
- **Pv_ErrorCode:** _(el que retorne `ACTUALIZAR_ESTADO_UUID`)_
- **Pv_ErrorMessage:** _(el que retorne `ACTUALIZAR_ESTADO_UUID`)_
- **Condición:** El COMMIT se ejecuta antes de llamar a `TRX_BATCH_CB.OSB_P_ATB_ACTUALIZAR_CB.ACTUALIZAR_ESTADO_UUID`. Si ese SP falla, el INSERT **ya fue persistido** y el `Pv_ErrorCode` queda con el error del SP interno en lugar de `SUCCESS`.
- **HTTP:** `500 Internal Server Error`
- **Advertencia crítica:** Al producirse un error aquí, la transacción quedó registrada en `ATB_TRANS_DIARIAS_CANAL_BANK` pero el estado del UUID en `ATB_UUID` no fue actualizado. Existe riesgo de reproceso o inconsistencia de datos.

---

## Orden de Validaciones en el SP

Las validaciones se ejecutan en este orden exacto; la primera que falla retorna inmediatamente:

1. `PN_MONTO != 0` → `400 Bad Request` si es cero
2. UUID existe en `ATB_UUID` → `404 Not Found` si no existe
3. `codigo_estado = 1` (REGISTRADO) → `409 Conflict` si estado diferente
4. INSERT en `ATB_TRANS_DIARIAS_CANAL_BANK` + COMMIT → `500` si falla (con rollback)
5. `ACTUALIZAR_ESTADO_UUID` → `500` si falla (sin rollback posible, COMMIT ya aplicado)

---

## Observaciones Técnicas del SP

| # | Observación | Impacto | Severidad |
|---|---|---|---|
| 1 | **COMMIT antes de `ACTUALIZAR_ESTADO_UUID`**: si el SP interno falla, el INSERT es permanente pero el UUID no queda actualizado | Inconsistencia de datos entre `ATB_TRANS_DIARIAS_CANAL_BANK` y `ATB_UUID` | Alta |
| 2 | **`lv_monto` vs `PN_MONTO`**: el monto se valida sobre la copia local `lv_monto` pero el INSERT utiliza `PN_MONTO` directamente | En este flujo no genera diferencias, pero es inconsistente y puede dificultar el mantenimiento | Baja |
| 3 | **Sin validación de nulos en campos clave**: `PV_UUID`, `PV_CORRESPONSAL`, `PV_CODIGO_CANAL`, `PV_MONEDA`, `PV_CODIGO_PAIS` no tienen verificación de nulidad explícita antes del INSERT | Un valor nulo en columna NOT NULL de la tabla dispara `WHEN OTHERS` con código `500` en lugar de un `400` descriptivo | Media |
| 4 | **`ACTUALIZAR_ESTADO_UUID` recibe estado `1` (REGISTRADO)**: si el SP fue llamado para marcar una transacción como procesada, pasar `1` mantendría el UUID en estado `REGISTRADO`, lo que podría no ser el comportamiento deseado | El UUID podría quedar disponible para ser reutilizado en otra transacción | Alta |
| 5 | **`WHEN OTHERS` sin log**: la excepción captura `SQLERRM` pero no registra trazabilidad adicional (stack trace, contexto de parámetros) | Dificulta la diagnosis de errores en producción | Media |

---

## Códigos de Error Técnicos de la Capa de Integración (OSB/JCA)

| Código | Descripción | Mapeo HTTP |
|---|---|---|
| `OSB-382033` | Schema validation failed | 400 |
| `OSB-382034` | XPath evaluation failed | 400 |
| `OSB-382500` | Service callout failed | 502 |
| `OSB-395026` | Authentication failed | 401 |
| `JCA-11001` | Database connection error | 500 |
| `JCA-11002` | Database timeout | 504 |
| `JCA-11003` | SQL execution error | 500 |

---

## Configuración de Retry por Tipo de Error

### Errores que Permiten Retry (Temporales)

| Código HTTP | Descripción | Max Intentos | Intervalo |
|---|---|---|---|
| **500** | Error de BD transitorio (deadlock, timeout de cursor) | 2 | 30 s |
| **504** | JCA Database timeout | 3 | 45 s |
| **502** | Service callout failed (OSB) | 3 | 30 s |

### Errores que NO Permiten Retry (Permanentes)

| Código HTTP | Descripción | Acción |
|---|---|---|
| **400** | Monto cero | Corregir el request |
| **404** | UUID inexistente | Verificar el UUID enviado |
| **409** | UUID en estado distinto a REGISTRADO | Validar el estado del UUID antes de llamar al SP |
| **500** | Error post-COMMIT en ACTUALIZAR_ESTADO_UUID | Investigar estado de `ATB_UUID` y `ATB_TRANS_DIARIAS_CANAL_BANK` antes de reintentar |
