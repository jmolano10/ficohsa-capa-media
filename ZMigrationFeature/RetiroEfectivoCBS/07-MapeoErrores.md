# Mapeo de Errores - RetiroEfectivoCBS

## Tabla de Mapeo de Errores

| Código Error (RetiroEfectivoCBS) | Descripción Error (RetiroEfectivoCBS) | Código HTTP | Descripción Error |
|----------------------------------|---------------------------------------|-------------|-------------------|
| SUCCESS | Transacción procesada exitosamente | 200 | OK |
| ERROR | Error general de validación | 400 | Bad Request |
| MW-0001 | SERVICE QUOTA EXCEEDED | 429 | Too Many Requests |
| R03 | Número de Cuenta Inexistente | 404 | Not Found |
| R01 | Fondos Insuficientes | 402 | Payment Required |
| FICBCO0218 | Error específico del servicio RetiroEfectivoCBS | 500 | Internal Server Error |
| VALIDACION_REGIONAL_FALLIDA | Región no válida para el servicio | 400 | Bad Request |
| ERROR_OBTENIENDO_PARAMETRIZACION | Error consultando parámetros del corresponsal | 500 | Internal Server Error |
| MONEDA_INVALIDA_PARA_TRANSACCION | Moneda no permitida para el corresponsal | 400 | Bad Request |
| ERROR_OBTENIENDO_COMISION | Error calculando comisión de la transacción | 500 | Internal Server Error |
| ERROR_CONSULTANDO_CUENTA | Error consultando información de la cuenta | 500 | Internal Server Error |
| ERROR_SALDO_INSUFICIENTE | Saldo insuficiente para la transacción | 402 | Payment Required |
| ERROR_AL_REALIZAR_TRANSFERENCIA | Error ejecutando transferencia en T24 | 500 | Internal Server Error |
| ERROR_COBRANDO_COMISION | Error cobrando comisión de la transacción | 500 | Internal Server Error |
| ERROR_AL_REVERSAR_LA_TRANSACCION | Error reversando transacción principal | 500 | Internal Server Error |
| REVERSADA | Transacción reversada exitosamente | 200 | OK |

## Códigos de Error por Categoría

### Errores de Validación de Entrada (4xx)
- **ERROR**: Error general de validación de datos de entrada
- **VALIDACION_REGIONAL_FALLIDA**: La región especificada no es válida para el servicio
- **MONEDA_INVALIDA_PARA_TRANSACCION**: La moneda no está permitida para el corresponsal
- **R03**: El número de cuenta proporcionado no existe
- **R01**: Fondos insuficientes en la cuenta para completar la transacción

### Errores de Límites y Cuotas (4xx)
- **MW-0001**: Se ha excedido la cuota de uso del servicio

### Errores de Sistema (5xx)
- **FICBCO0218**: Error interno específico del servicio RetiroEfectivoCBS
- **ERROR_OBTENIENDO_PARAMETRIZACION**: Error consultando configuración del corresponsal
- **ERROR_OBTENIENDO_COMISION**: Error en el cálculo de comisiones
- **ERROR_CONSULTANDO_CUENTA**: Error consultando información de la cuenta
- **ERROR_AL_REALIZAR_TRANSFERENCIA**: Error en la transferencia principal con T24
- **ERROR_COBRANDO_COMISION**: Error cobrando la comisión de la transacción
- **ERROR_AL_REVERSAR_LA_TRANSACCION**: Error reversando la transacción

### Estados Exitosos (2xx)
- **SUCCESS**: Transacción completada exitosamente
- **REVERSADA**: Transacción reversada correctamente

## SP REGISTRA_TRANSACCION_CANAL — Homologación de Errores

El SP expone dos parámetros de salida: `Pv_ErrorCode` y `Pv_ErrorMessage`. Los posibles escenarios son:

### Tabla de Homologación

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

### Notas de Implementación

- El bloque `WHEN OTHERS` ejecuta `ROLLBACK` antes de retornar, garantizando que ningún registro quede pendiente de commit ante cualquier falla.
- El `Pv_ErrorCode` solo toma dos valores posibles (`SUCCESS` / `ERROR`); la distinción entre tipos de error debe hacerse inspeccionando el contenido de `Pv_ErrorMessage`.
- Los errores `ORA-00001` y `ORA-02291` indican un problema en los datos enviados por el canal, por lo que corresponden a respuestas 4xx.
- Los errores de conectividad (`ORA-12541`, `ORA-12170`) deben mapearse a **503** con cabecera `Retry-After` para permitir reintentos automáticos por parte del cliente.

---

## SP `get_corban_commission` — Homologación de Errores

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

---

## Mapeo de Errores de Servicios Dependientes

### Errores de T24 (svcRegistraTransaccionTengo)
| Error T24 | Código Mapeado | Descripción |
|-----------|----------------|-------------|
| Connection Timeout | ERROR_AL_REALIZAR_TRANSFERENCIA | Error de conectividad con T24 |
| Invalid Account | R03 | Cuenta inválida en T24 |
| Insufficient Funds | R01 | Fondos insuficientes reportado por T24 |
| Transaction Failed | ERROR_AL_REALIZAR_TRANSFERENCIA | Fallo general en T24 |

### Errores de Base de Datos (consultaComisionesCB)
| Error BD | Código Mapeado | Descripción |
|----------|----------------|-------------|
| Connection Error | ERROR_OBTENIENDO_COMISION | Error de conexión a base de datos |
| SP Execution Error | ERROR_OBTENIENDO_COMISION | Error ejecutando stored procedure |
| Invalid Parameters | ERROR_OBTENIENDO_COMISION | Parámetros inválidos para SP |

### Errores de Consulta de Cuentas
| Error Consulta | Código Mapeado | Descripción |
|----------------|----------------|-------------|
| Account Not Found | R03 | Cuenta no encontrada |
| Service Unavailable | ERROR_CONSULTANDO_CUENTA | Servicio de consulta no disponible |
| Invalid Response | ERROR_CONSULTANDO_CUENTA | Respuesta inválida del servicio |

### Errores de Transferencias
| Error Transferencia | Código Mapeado | Descripción |
|---------------------|----------------|-------------|
| Commission Transfer Failed | ERROR_COBRANDO_COMISION | Fallo cobrando comisión |
| Reversal Failed | ERROR_AL_REVERSAR_LA_TRANSACCION | Fallo en reversión |
| Invalid Amount | ERROR_COBRANDO_COMISION | Monto inválido para comisión |

## Manejo de Errores por Pipeline

### Pipeline de Validaciones
- **Validación de Esquema**: Genera SOAP Fault automáticamente
- **Validación Regional**: Retorna ERROR con mensaje específico
- **Validación de Corresponsal**: Retorna código específico del corresponsal
- **Validación de Uso**: Retorna MW-0001 si excede cuota

### Pipeline HN01
- **Consulta de Comisión**: Mapea errores de BD a ERROR_OBTENIENDO_COMISION
- **Consulta de Cuenta**: Mapea count=0 a R03, otros errores a ERROR_CONSULTANDO_CUENTA
- **Validación de Fondos**: Genera R01 si fondos insuficientes
- **Transferencia T24**: Mapea errores de T24 a ERROR_AL_REALIZAR_TRANSFERENCIA
- **Cobro de Comisión**: Mapea errores a ERROR_COBRANDO_COMISION
- **Reversión**: Mapea errores a ERROR_AL_REVERSAR_LA_TRANSACCION

### Error Handler Global
- **Captura**: Todos los errores no manejados específicamente
- **Mapeo**: Utiliza servicio MapeoErrores con código FICBCO0218
- **Logging**: Registra error con código MW-0265
- **Actualización**: Actualiza estado de transacción a error
- **Respuesta**: Retorna error mapeado al cliente

## Configuración de Mapeo de Errores

### Servicio MapeoErrores
- **Entrada**: Código de error y mensaje
- **Procesamiento**: Mapea según configuración específica del servicio FICBCO0218
- **Salida**: Código y mensaje mapeados para el cliente

### Formato de Error en Response
```xml
<aut:ResponseHeader>
    <successIndicator>ERROR_CODE</successIndicator>
    <messages>Mensaje descriptivo del error</messages>
</aut:ResponseHeader>
```

## Trazabilidad de Errores

### Estados de Transacción en Error
- **ERROR_OBTENIENDO_PARAMETRIZACION**: Durante consulta de corresponsal
- **VALIDACION_REGIONAL_FALLIDA**: Durante validación regional
- **ERROR_DE_MONEDA_INVALIDA**: Durante validación de moneda
- **ERROR_OBTENIENDO_COMISION**: Durante cálculo de comisión
- **ERROR_CONSULTANDO_CUENTA**: Durante consulta de saldo
- **ERROR_SALDO_INSUFICIENTE**: Durante validación de fondos
- **ERROR_AL_REALIZAR_TRANSFERENCIA**: Durante transferencia T24
- **ERROR_COBRANDO_COMISION**: Durante cobro de comisión
- **ERROR_AL_REVERSAR_LA_TRANSACCION**: Durante reversión

### Logging de Errores
- **Nivel**: Debug habilitado para trazabilidad completa
- **Contexto**: Incluye identificadores de transacción
- **Detalle**: Código de error, mensaje y contexto de ejecución

## Recomendaciones para Manejo de Errores

### Códigos HTTP Sugeridos
1. **200 OK**: Para SUCCESS y REVERSADA
2. **400 Bad Request**: Para errores de validación de entrada
3. **402 Payment Required**: Para errores relacionados con fondos
4. **404 Not Found**: Para cuentas inexistentes
5. **429 Too Many Requests**: Para límites de cuota excedidos
6. **500 Internal Server Error**: Para errores de sistema

### Mejores Prácticas
1. **Consistencia**: Mantener códigos consistentes entre regiones
2. **Trazabilidad**: Incluir identificadores únicos en mensajes de error
3. **Seguridad**: No exponer detalles internos en mensajes de error
4. **Localización**: Considerar mensajes en idioma local por región