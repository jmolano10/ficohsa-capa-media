# Mapeo de Errores - ReversarTransaccionID

## Tabla de mapeo de errores con homologación HTTP

| Código Error (ReversarTransaccionID) | Descripción Error (ReversarTransaccionID) | Código HTTP | Descripción Error HTTP |
|-------------------------------------|-------------------------------------------|-------------|------------------------|
| FICBCO0516-001 | No se pudo obtener el estado de la transaccion, verifique el ID | 404 | Not Found - Transacción no encontrada |
| FICBCO0516-002 | La transaccion no tiene el estado correcto, no se puede reversar | 409 | Conflict - Estado de transacción inválido |
| FICBCO0516-003 | La transaccion no se puede reversar porque aun no se ha aplicado en V+ | 412 | Precondition Failed - Transacción no aplicada |
| FICBCO0516-004 | Error en la consulta de ruta regional | 503 | Service Unavailable - Servicio de enrutamiento no disponible |
| FICBCO0516-005 | Tipo de transacción no válido | 400 | Bad Request - Tipo de transacción inválido |
| FICBCO0516-006 | Error en la conexión con T24 | 502 | Bad Gateway - Error de conectividad con T24 |
| FICBCO0516-007 | Credenciales de usuario no válidas | 401 | Unauthorized - Credenciales inválidas |
| FICBCO0516-008 | Usuario no autorizado para realizar reversiones | 403 | Forbidden - Usuario sin permisos |
| FICBCO0516-009 | Transacción ya fue reversada anteriormente | 409 | Conflict - Transacción ya procesada |
| FICBCO0516-010 | Error interno del sistema | 500 | Internal Server Error - Error interno |

## Errores específicos de la operación ReversionPagoTCTengo

### Errores de T24 (Core Bancario)

| Código Error T24 | Descripción Error T24 | Código HTTP | Descripción Error HTTP |
|------------------|----------------------|-------------|------------------------|
| T24-TFS-001 | Transaction not found in T24 | 404 | Not Found - Transacción no encontrada en T24 |
| T24-TFS-002 | Transaction already reversed | 409 | Conflict - Transacción ya reversada |
| T24-TFS-003 | Insufficient funds for reversal | 402 | Payment Required - Fondos insuficientes |
| T24-TFS-004 | Account blocked or closed | 423 | Locked - Cuenta bloqueada |
| T24-TFS-005 | Invalid transaction type for reversal | 400 | Bad Request - Tipo de transacción inválido |
| T24-TFS-006 | Transaction outside reversal time window | 410 | Gone - Fuera del tiempo permitido |
| T24-TFS-007 | System maintenance in progress | 503 | Service Unavailable - Mantenimiento del sistema |
| T24-TFS-008 | Credit card not found | 404 | Not Found - Tarjeta de crédito no encontrada |
| T24-TFS-009 | Credit card expired or inactive | 410 | Gone - Tarjeta expirada o inactiva |
| T24-TFS-010 | Reversal amount exceeds original transaction | 400 | Bad Request - Monto de reversión excede original |

### Errores de Base de Datos

| Código Error DB | Descripción Error DB | Código HTTP | Descripción Error HTTP |
|-----------------|---------------------|-------------|------------------------|
| DB-REV-001 | Connection timeout to database | 504 | Gateway Timeout - Timeout de conexión |
| DB-REV-002 | Transaction record not found | 404 | Not Found - Registro no encontrado |
| DB-REV-003 | Database constraint violation | 409 | Conflict - Violación de restricción |
| DB-REV-004 | Stored procedure execution failed | 500 | Internal Server Error - Error en SP |
| DB-REV-005 | Invalid transaction status | 400 | Bad Request - Estado de transacción inválido |
| DB-REV-006 | Concurrent modification detected | 409 | Conflict - Modificación concurrente |
| DB-REV-007 | Database connection pool exhausted | 503 | Service Unavailable - Pool de conexiones agotado |
| DB-REV-008 | Transaction log full | 507 | Insufficient Storage - Log de transacciones lleno |

### Errores de Validación de Negocio

| Código Error Negocio | Descripción Error Negocio | Código HTTP | Descripción Error HTTP |
|---------------------|---------------------------|-------------|------------------------|
| BIZ-REV-001 | Transaction ID format invalid | 400 | Bad Request - Formato de ID inválido |
| BIZ-REV-002 | Transaction type not supported for reversal | 405 | Method Not Allowed - Tipo no soportado |
| BIZ-REV-003 | Reversal not allowed for this region | 403 | Forbidden - No permitido en esta región |
| BIZ-REV-004 | Transaction amount below minimum threshold | 400 | Bad Request - Monto por debajo del mínimo |
| BIZ-REV-005 | Transaction amount above maximum threshold | 400 | Bad Request - Monto por encima del máximo |
| BIZ-REV-006 | Customer account suspended | 423 | Locked - Cuenta de cliente suspendida |
| BIZ-REV-007 | Merchant not authorized for reversals | 403 | Forbidden - Comercio no autorizado |
| BIZ-REV-008 | Transaction date outside allowed window | 410 | Gone - Fecha fuera del rango permitido |

### Errores de Seguridad

| Código Error Seguridad | Descripción Error Seguridad | Código HTTP | Descripción Error HTTP |
|------------------------|------------------------------|-------------|------------------------|
| SEC-REV-001 | Authentication failed | 401 | Unauthorized - Autenticación fallida |
| SEC-REV-002 | Session expired | 401 | Unauthorized - Sesión expirada |
| SEC-REV-003 | IP address not whitelisted | 403 | Forbidden - IP no autorizada |
| SEC-REV-004 | Too many failed attempts | 429 | Too Many Requests - Demasiados intentos |
| SEC-REV-005 | User account locked | 423 | Locked - Cuenta de usuario bloqueada |
| SEC-REV-006 | Invalid digital signature | 401 | Unauthorized - Firma digital inválida |
| SEC-REV-007 | Encryption/Decryption error | 400 | Bad Request - Error de cifrado |

### Errores de Comunicación

| Código Error Comunicación | Descripción Error Comunicación | Código HTTP | Descripción Error HTTP |
|---------------------------|--------------------------------|-------------|------------------------|
| COMM-REV-001 | Network timeout | 504 | Gateway Timeout - Timeout de red |
| COMM-REV-002 | Service unavailable | 503 | Service Unavailable - Servicio no disponible |
| COMM-REV-003 | Message format error | 400 | Bad Request - Formato de mensaje inválido |
| COMM-REV-004 | SSL/TLS handshake failed | 495 | SSL Certificate Error - Error de certificado |
| COMM-REV-005 | Connection refused | 502 | Bad Gateway - Conexión rechazada |
| COMM-REV-006 | DNS resolution failed | 502 | Bad Gateway - Error de resolución DNS |
| COMM-REV-007 | Circuit breaker open | 503 | Service Unavailable - Circuit breaker abierto |

## Mapeo de Errores por Componente

### 1. Errores del Proxy Service ReversarTransaccionID

```xml
<!-- Error Handler en el Proxy -->
<con1:pipeline type="error" name="_onErrorHandler">
  <con1:stage name="ManejoError">
    <con1:actions>
      <con3:wsCallout>
        <con3:service ref="Middleware/v2/ProxyServices/MapeoErrores"/>
        <con3:operation>mapeoErrores</con3:operation>
        <con3:request>
          <con3:body>
            <mapeoErroresRequest>
              <MENSAJE_ERROR>FICBCO0259$#${errorMessage}</MENSAJE_ERROR>
              <CODIGO_ERROR>{$errorCode}</CODIGO_ERROR>
            </mapeoErroresRequest>
          </con3:body>
        </con3:request>
      </con3:wsCallout>
    </con1:actions>
  </con1:stage>
</con1:pipeline>
```

### 2. Errores de la operación ReversionPagoTCTengo

Los errores de esta operación se mapean según el campo `Status/successIndicator`:

- **Success**: Operación exitosa (HTTP 200)
- **TWSError**: Error del Web Service (HTTP 502)
- **T24Error**: Error del core T24 (HTTP 500)
- **T24Override**: Requiere autorización adicional (HTTP 202)
- **T24Offline**: Sistema T24 no disponible (HTTP 503)

### 3. Transformación de Errores

```xquery
(: Mapeo de errores T24 a códigos HTTP :)
declare function mapT24ErrorToHTTP($t24Error as xs:string) as xs:string {
  switch($t24Error)
    case "Transaction not found" return "404"
    case "Transaction already reversed" return "409"
    case "Insufficient funds" return "402"
    case "Account blocked" return "423"
    case "System maintenance" return "503"
    default return "500"
};
```

## Ejemplos de Respuestas de Error

### Error de Transacción No Encontrada

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>ERROR</successIndicator>
         <messageId>FICBCO0516-001: No se pudo obtener el estado de la transaccion, verifique el ID</messageId>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <rev:reversarTransaccionIDResponse/>
   </soapenv:Body>
</soapenv:Envelope>
```

### Error de Estado Inválido

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>ERROR</successIndicator>
         <messageId>FICBCO0516-002: La transaccion no tiene el estado correcto, no se puede reversar</messageId>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <rev:reversarTransaccionIDResponse/>
   </soapenv:Body>
</soapenv:Envelope>
```

### Error de T24

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>ERROR</successIndicator>
         <messageId>T24-TFS-002: Transaction already reversed</messageId>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <rev:reversarTransaccionIDResponse/>
   </soapenv:Body>
</soapenv:Envelope>
```

---

## SP: OBTENER_TIPO_TRANSACCION

Homologación de los posibles resultados del stored procedure `OBTENER_TIPO_TRANSACCION`, que valida si un código de operación OSB existe en la tabla `TRX_BATCH_CB.ATB_CODIGOS_TRX_GEN_CB` para determinar si la transacción es de tipo genérico.

| `PV_ERROR_CODE` | `PV_MESSAGE` | `PV_TIPO_OPE` | Escenario | Código HTTP | Descripción HTTP |
|----------------|-------------|--------------|-----------|-------------|-----------------|
| **SUCCESS** | `GEN` | `1` | Código OSB encontrado en tabla de transacciones genéricas (`COUNT > 0`) | **200** | OK |
| **SUCCESS** | `NOGEN` | `0` | Código OSB **no** encontrado en la tabla (`COUNT = 0`) | **200** | OK |
| **SUCCESS** | `NOGEN` | `0` | `NO_DATA_FOUND` — `COUNT(*)` no devolvió filas (caso excepcional del motor) | **200** | OK |
| **ERROR** | *(vacío)* | — | `WHEN OTHERS` — error inesperado en base de datos (`SQLERRM || ' ERROR'`) | **500** | Internal Server Error |

> **Nota:** Tanto `GEN` como `NOGEN` se retornan con `SUCCESS`. La distinción es lógica de negocio (qué flujo de reversión aplicar), no un error técnico, por lo que ambos se mapean a **200 OK**. Solo `ERROR` representa un fallo real de procesamiento.

---

## SP: CONSULTAR_TRANSACCIONES

Homologación de los posibles resultados del stored procedure `CONSULTAR_TRANSACCIONES`. Según el parámetro `PN_TIPO_CONSULTA`, valida la existencia y el estado de una transacción para determinar si puede ser reversada.

### Tipo de Consulta 1 — Verificar reversabilidad (tabla `ATB_TRANS_DIARIAS_CANAL_BANK`)

Busca por UUID (si `PV_UUID` tiene 36 caracteres) o por `CLAVE_CORRESPONSAL`. Retorna si la transacción puede reversarse (estados `4` u `11`).

| `Pv_ErrorCode` | `Pv_Message` | `Pv_ErrorMessage` | Escenario | Código HTTP | Descripción HTTP |
|---------------|-------------|------------------|-----------|-------------|-----------------|
| **SUCCESS** | `TRUE` | *(vacío)* | Transacción encontrada con estado reversable (`4` o `11`) | **200** | OK |
| **SUCCESS** | `FALSE` | `LA TRANSACCION NO SE PUEDE REVERSAR PORQUE NO SE ENCUENTRA EN UN ESTADO CORRECTO.` | Transacción existe pero su estado no permite reversión | **409** | Conflict |
| **NO EXISTE REGISTRO PARA EL CODIGO SELECCIONADO** | `FALSE` | `SQLERRM` | `NO_DATA_FOUND` — UUID o clave de corresponsal no existe en la tabla | **404** | Not Found |
| **ERROR** | *(vacío)* | `SQLERRM` | `WHEN OTHERS` — error inesperado en base de datos | **500** | Internal Server Error |

### Tipo de Consulta 2 — Obtener código de estado UUID (tabla `ATB_UUID`)

Retorna el `CODIGO_ESTADO` asociado al UUID consultado.

| `Pv_ErrorCode` | `Pv_Message` | `Pv_ErrorMessage` | Escenario | Código HTTP | Descripción HTTP |
|---------------|-------------|------------------|-----------|-------------|-----------------|
| **SUCCESS** | *Valor de `CODIGO_ESTADO`* | *(vacío)* | UUID encontrado; `Pv_Message` contiene el código de estado | **200** | OK |
| **NO EXISTE REGISTRO PARA EL CODIGO SELECCIONADO** | `FALSE` | `SQLERRM` | `NO_DATA_FOUND` — UUID no existe en `ATB_UUID` | **404** | Not Found |
| **ERROR** | *(vacío)* | `SQLERRM` | `WHEN OTHERS` — error inesperado en base de datos | **500** | Internal Server Error |

### Tipo de Consulta 3 — Descripción de estado de transacción (tabla `ATB_TRANS_DIARIAS_CANAL_BANK`)

Retorna la descripción legible del estado de una transacción a partir de su UUID.

| `Pv_ErrorCode` | `Pv_Message` | `Pv_ErrorMessage` | Escenario | Código HTTP | Descripción HTTP |
|---------------|-------------|------------------|-----------|-------------|-----------------|
| **SUCCESS** | `PENDIENTE DE APLICAR` | *(vacío)* | Estado entre 7 y 8 (exclusive) | **200** | OK |
| **SUCCESS** | `TRANSACCION SERA APLICADA EN LA NOCHE` | *(vacío)* | Estado = `10` | **200** | OK |
| **SUCCESS** | `EXITOSA` | *(vacío)* | Estado = `11` | **200** | OK |
| **SUCCESS** | `FALLIDA` | *(vacío)* | Estado ≥ `12` | **200** | OK |
| **SUCCESS** | *Descripción de `ATB_ESTADOS_TRANSACCION`* | *(vacío)* | Cualquier otro estado; descripción resuelta desde tabla de estados | **200** | OK |
| **NO EXISTE REGISTRO PARA EL CODIGO SELECCIONADO** | `FALSE` | `SQLERRM` | `NO_DATA_FOUND` — UUID no existe o estado sin descripción en tabla | **404** | Not Found |
| **ERROR** | *(vacío)* | `SQLERRM` | `WHEN OTHERS` — error inesperado en base de datos | **500** | Internal Server Error |

### Tipo de Consulta 4 — Verificar reversabilidad genérica (tabla `atb_trans_genericas_cb_dia`)

Igual al tipo 1 pero sobre la tabla de transacciones genéricas. Solo el estado `4` habilita la reversión.

| `Pv_ErrorCode` | `Pv_Message` | `Pv_ErrorMessage` | Escenario | Código HTTP | Descripción HTTP |
|---------------|-------------|------------------|-----------|-------------|-----------------|
| **SUCCESS** | `TRUE` | *(vacío)* | Transacción genérica encontrada con estado reversable (`4`) | **200** | OK |
| **SUCCESS** | `FALSE` | `LA TRANSACCION NO SE PUEDE REVERSAR PORQUE NO SE ENCUENTRA EN UN ESTADO CORRECTO.` | Transacción genérica existe pero su estado no permite reversión | **409** | Conflict |
| **NO EXISTE REGISTRO PARA EL CODIGO SELECCIONADO** | `FALSE` | `SQLERRM` | `NO_DATA_FOUND` — UUID o clave de corresponsal no existe en la tabla genérica | **404** | Not Found |
| **ERROR** | *(vacío)* | `SQLERRM` | `WHEN OTHERS` — error inesperado en base de datos | **500** | Internal Server Error |

### Excepción externa — bloque `WHEN OTHERS` del SP

Aplica si ningún bloque interno captura el error.

| `Pv_ErrorCode` | `Pv_Message` | `Pv_ErrorMessage` | Escenario | Código HTTP | Descripción HTTP |
|---------------|-------------|------------------|-----------|-------------|-----------------|
| **ERROR** | *(vacío)* | `SQLERRM` | `WHEN OTHERS` externo — fallo no controlado a nivel de procedimiento | **500** | Internal Server Error |

> **Nota:** El SP retorna `SUCCESS` con `Pv_Message = 'FALSE'` cuando la transacción existe pero no cumple las condiciones de negocio para ser reversada. Se mapea a **409 Conflict** porque el estado actual del recurso impide la operación solicitada. Solo `'NO EXISTE REGISTRO...'` y `'ERROR'` son fallos técnicos reales (**404** y **500** respectivamente).

---

## SP: OSB_P_REGISTRA_REVERSION_TC_CB

Homologación de los posibles resultados del stored procedure `OSB_P_REGISTRA_REVERSION_TC_CB` (esquema `PAGOSWSTC`), que registra la reversión de un pago de tarjeta de crédito eliminando un registro previo de tipo `R` e insertando uno nuevo copiado del pago original de tipo `C`.

| `Pv_ErrorCode` | `Pv_ErrorMessage` | Escenario | Código HTTP | Descripción HTTP |
|---------------|------------------|-----------|-------------|-----------------|
| **SUCCESS** | *(vacío)* | `DELETE` e `INSERT` completados correctamente; la reversión quedó registrada en `TRC_PAGOS_HN` | **200** | OK |
| **ERROR** | `SQLERRM` | `NO_DATA_FOUND` en el `SELECT INTO` — no existe un pago original (`TIPO_OPERACION='C'`, `TIPO_TRANSACCION=1`, `APLICADO='S'`) para la `SECUENCIA_MOVIMIENTO` indicada; se ejecuta `ROLLBACK` | **404** | Not Found |
| **ERROR** | `SQLERRM` | `WHEN OTHERS` — cualquier otro error de base de datos (violación de constraint, fallo de `INSERT`, etc.); se ejecuta `ROLLBACK` | **500** | Internal Server Error |

> **Nota:** El SP no distingue entre `NO_DATA_FOUND` y otros errores en el handler: todos caen en `WHEN OTHERS` con `ROLLBACK`. El mapeo a **404** para el caso de registro no encontrado es una recomendación de la capa de integración basada en el `SQLERRM` recibido, ya que el SP no expone un código diferenciado para ese caso.

---

---

## Homologación Errores ReversionPagoTCTengo

Homologación de los valores posibles del campo `Status/successIndicator` retornados por la operación `ReversionPagoTCTengo` del Business Service `svcReversarTransaccionCB`, hacia códigos HTTP semánticos. El proxy captura este valor mediante `fn:upper-case(fn:string($RSPRevTC/Status/successIndicator/text()))` y lo evalúa para construir la respuesta final.

| `Status/successIndicator` | `Status/messages` | Escenario | Código HTTP | Descripción HTTP |
|--------------------------|-------------------|-----------|-------------|-----------------|
| **Success** | *(vacío)* | Reversión de pago TC procesada exitosamente en T24; el proxy continúa a registrar en Master Data (`conReversarPagoTCRG`) y retorna `T24_REFERENCE`, `TRANSACTION_ID` y `REFERENCE_CB` | **200** | OK |
| **TWSError** | Mensaje de error del Web Service | Error en la comunicación con el Web Service de T24; falla en la capa de transporte antes de llegar al core bancario | **502** | Bad Gateway |
| **T24Error** | Mensaje de error del core T24 | El core bancario T24 rechazó o no pudo procesar la reversión (p.ej. transacción no encontrada, ya reversada, fondos insuficientes) | **500** | Internal Server Error |
| **T24Override** | Mensaje descriptivo del override | T24 requiere una autorización adicional (override) para completar la reversión; la transacción queda en estado pendiente de aprobación | **202** | Accepted |
| **T24Offline** | Mensaje de sistema no disponible | T24 se encuentra fuera de línea o en mantenimiento; no es posible procesar la reversión en este momento | **503** | Service Unavailable |

> **Nota:** El proxy uppercasea el `successIndicator` antes de la comparación (`fn:upper-case`), por lo que `Success` del XSD se evalúa como `SUCCESS`. Solo el valor `SUCCESS` habilita el flujo exitoso; cualquier otro valor resulta en una respuesta SOAP con `successIndicator=ERROR` y el campo `messageId` poblado con el contenido de `Status/messages`. El mapeo HTTP es semántico — la capa SOAP retorna siempre HTTP 200 en el transporte; los códigos aquí representan la intención de negocio para la capa REST/API Gateway.

---

## SP: OSBRegistraReversaTC

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

---

---

## Homologación Errores ReversarTransaccionTENGOEEH Julian M

Homologación de los valores posibles del campo `Status/successIndicator` retornados por la operación `ReversarTransaccionTENGOEEH` del Business Service `svcGestionesTrxSEEHTENGO`. Esta operación se invoca cuando `$tipoTransaccion = 'PAGO_EEH'`. El proxy captura el resultado mediante `fn:upper-case(fn:string($RSPRevTransGenerica/Status/successIndicator/text()))` y lo almacena en `$successIndicator`; el mensaje de error se toma de `$RSPRevTransGenerica/Status/messages` hacia `$errorCode`.

| `Status/successIndicator` | `Status/messages` | Escenario | Código HTTP | Descripción HTTP |
|--------------------------|-------------------|-----------|-------------|-----------------|
| **Success** | *(vacío)* | Reversión de transacción SEEH/TENGO procesada exitosamente en T24; el proxy continúa al stage `ActualizarEstadoTransaccion` para actualizar el estado en base de datos y retorna `T24_REFERENCE`, `TRANSACTION_ID` y `REFERENCE_CB` | **200** | OK |
| **TWSError** | Mensaje de error del Web Service | Error en la comunicación con el Web Service de T24; falla en la capa de transporte antes de llegar al core bancario | **502** | Bad Gateway |
| **T24Error** | Mensaje de error del core T24 | El core bancario T24 rechazó o no pudo procesar la reversión de la transacción SEEH/TENGO (p.ej. transacción inválida, ya reversada, error de procesamiento) | **500** | Internal Server Error |
| **T24Override** | Mensaje descriptivo del override | T24 requiere una autorización adicional (override) para completar la reversión; la transacción queda pendiente de aprobación | **202** | Accepted |
| **T24Offline** | Mensaje de sistema no disponible | T24 se encuentra fuera de línea o en mantenimiento; no es posible procesar la reversión en este momento | **503** | Service Unavailable |

> **Nota:** A diferencia de `ReversionPagoTCTengo`, esta operación no tiene un paso intermedio de registro en una tabla de tarjetas de crédito antes de llamar a T24. El resultado de `ReversarTransaccionTENGOEEH` fluye directamente al stage `ActualizarEstadoTransaccion`, donde solo si `$successIndicator = 'SUCCESS'` se actualiza el estado de la transacción en base de datos. Cualquier valor distinto de `SUCCESS` resulta en una respuesta SOAP con `successIndicator=ERROR` y el campo `messageId` poblado con el contenido de `Status/messages`.

---

## Códigos de Estado HTTP Utilizados

- **200 OK**: Reversión exitosa
- **400 Bad Request**: Datos de entrada inválidos
- **401 Unauthorized**: Credenciales inválidas
- **403 Forbidden**: Usuario sin permisos
- **404 Not Found**: Transacción no encontrada
- **405 Method Not Allowed**: Operación no permitida
- **409 Conflict**: Estado de transacción conflictivo
- **410 Gone**: Transacción fuera del tiempo permitido
- **412 Precondition Failed**: Precondiciones no cumplidas
- **423 Locked**: Recurso bloqueado
- **429 Too Many Requests**: Demasiadas solicitudes
- **500 Internal Server Error**: Error interno del servidor
- **502 Bad Gateway**: Error de gateway
- **503 Service Unavailable**: Servicio no disponible
- **504 Gateway Timeout**: Timeout de gateway
- **507 Insufficient Storage**: Almacenamiento insuficiente