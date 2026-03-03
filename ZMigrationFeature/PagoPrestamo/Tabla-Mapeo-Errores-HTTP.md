# Tabla de Mapeo de Errores - Stored Procedures PagoPrestamo

## Análisis de Stored Procedures

### 1. TOPLEVEL$OSB_PAG_PRESTAMO_CAJ (ABANKS - Caja)
**Ubicación:** `ORA_BANK_OSB_K_PAGO_PRESTAMO_TOPLEVEL-24OSB_PAG_PRESTAMO_CAJ.xsd`

### 2. OSB_PAG_PRESTAMO_T24 (ABANKS - T24)
**Ubicación:** `ORA_BANK_OSB_PAG_PRESTAMO_T24.xsd`

## Tabla de Mapeo de Errores a Códigos HTTP

### Errores del Core T24 (Sistema Principal)

| Código Error T24 | Mensaje T24 | Descripción | Código HTTP | Mensaje HTTP | Categoría |
|------------------|-------------|-------------|-------------|--------------|-----------|
| **Success** | Transaction completed successfully | Transacción exitosa | **200** | OK | Éxito |
| **TWSError** | T24 Web Services error | Error en servicios web T24 | **502** | Bad Gateway | Sistema |
| **T24Error** | T24 application error | Error aplicación T24 | **422** | Unprocessable Entity | Aplicación |
| **T24Override** | Override required | Requiere autorización adicional | **409** | Conflict | Autorización |
| **T24Offline** | T24 system offline | Sistema T24 no disponible | **503** | Service Unavailable | Disponibilidad |
| **TIMEOUT** | Request timeout | Timeout en solicitud | **408** | Request Timeout | Tiempo |
| **ERROR** | Generic error | Error genérico | **500** | Internal Server Error | Genérico |

### Errores de Validación de Cuenta (AC-*)

| Código Error | Mensaje T24 | Descripción | Código HTTP | Mensaje HTTP | Acción Cliente |
|--------------|-------------|-------------|-------------|--------------|----------------|
| **AC-INVALID.ACCOUNT** | Invalid account number | Número de cuenta inválido | **400** | Bad Request | Verificar número de cuenta |
| **AC-ACCOUNT.CLOSED** | Account is closed | Cuenta cerrada | **422** | Unprocessable Entity | Contactar banco |
| **AC-INSUFFICIENT.FUNDS** | Insufficient funds | Fondos insuficientes | **422** | Unprocessable Entity | Verificar saldo |
| **AC-ACCOUNT.BLOCKED** | Account is blocked | Cuenta bloqueada | **403** | Forbidden | Contactar banco |
| **AC-CURRENCY.MISMATCH** | Currency mismatch | Monedas no coinciden | **422** | Unprocessable Entity | Verificar moneda |
| **AC-INVALID.CURRENCY** | Invalid currency | Moneda inválida | **400** | Bad Request | Verificar código moneda |
| **AC-ACCOUNT.DORMANT** | Account is dormant | Cuenta inactiva | **422** | Unprocessable Entity | Activar cuenta |
| **AC-ACCOUNT.RESTRICTED** | Account has restrictions | Cuenta con restricciones | **403** | Forbidden | Contactar banco |

### Errores de Préstamo (AA-*)

| Código Error | Mensaje T24 | Descripción | Código HTTP | Mensaje HTTP | Acción Cliente |
|--------------|-------------|-------------|-------------|--------------|----------------|
| **AA-INVALID.ARRANGEMENT** | Invalid arrangement number | Número de préstamo inválido | **400** | Bad Request | Verificar número préstamo |
| **AA-ARRANGEMENT.CLOSED** | Arrangement is closed | Préstamo cerrado | **422** | Unprocessable Entity | Préstamo ya cancelado |
| **AA-PAYMENT.EXCEEDS.BALANCE** | Payment exceeds balance | Pago excede saldo pendiente | **422** | Unprocessable Entity | Reducir monto pago |
| **AA-INVALID.PAYMENT.AMOUNT** | Invalid payment amount | Monto de pago inválido | **400** | Bad Request | Verificar monto |
| **AA-PAYMENT.BELOW.MINIMUM** | Payment below minimum | Pago menor al mínimo | **422** | Unprocessable Entity | Aumentar monto |
| **AA-ARRANGEMENT.SUSPENDED** | Arrangement is suspended | Préstamo suspendido | **422** | Unprocessable Entity | Contactar banco |
| **AA-MATURITY.DATE.PASSED** | Maturity date passed | Fecha vencimiento pasada | **422** | Unprocessable Entity | Contactar banco |
| **AA-PAYMENT.FREQUENCY.ERROR** | Payment frequency error | Error frecuencia pago | **422** | Unprocessable Entity | Verificar calendario |

### Errores de Autorización (EB-*)

| Código Error | Mensaje T24 | Descripción | Código HTTP | Mensaje HTTP | Acción Cliente |
|--------------|-------------|-------------|-------------|--------------|----------------|
| **EB-INVALID.USER** | Invalid user | Usuario inválido | **401** | Unauthorized | Verificar credenciales |
| **EB-USER.NOT.AUTHORISED** | User not authorised | Usuario no autorizado | **403** | Forbidden | Contactar administrador |
| **EB-SIGN.ON.NOT.ALLOWED** | Sign on not allowed | Inicio sesión no permitido | **403** | Forbidden | Verificar horarios |
| **EB-PASSWORD.EXPIRED** | Password has expired | Contraseña expirada | **401** | Unauthorized | Cambiar contraseña |
| **EB-USER.LOCKED** | User is locked | Usuario bloqueado | **423** | Locked | Desbloquear usuario |
| **EB-INVALID.COMPANY** | Invalid company | Compañía inválida | **400** | Bad Request | Verificar compañía |

### Errores de Transacción (FT-*)

| Código Error | Mensaje T24 | Descripción | Código HTTP | Mensaje HTTP | Acción Cliente |
|--------------|-------------|-------------|-------------|--------------|----------------|
| **FT-INVALID.TRANSACTION.TYPE** | Invalid transaction type | Tipo transacción inválido | **400** | Bad Request | Verificar tipo |
| **FT-TRANSACTION.NOT.ALLOWED** | Transaction not allowed | Transacción no permitida | **403** | Forbidden | Verificar permisos |
| **FT-DUPLICATE.TRANSACTION** | Duplicate transaction | Transacción duplicada | **409** | Conflict | Verificar referencia |
| **FT-CUTOFF.TIME.PASSED** | Cut off time passed | Hora corte pasada | **422** | Unprocessable Entity | Procesar día siguiente |
| **FT-HOLIDAY.PROCESSING** | Holiday processing not allowed | Procesamiento feriado no permitido | **422** | Unprocessable Entity | Procesar día hábil |
| **FT-AMOUNT.LIMIT.EXCEEDED** | Amount limit exceeded | Límite monto excedido | **422** | Unprocessable Entity | Reducir monto |

### Errores de Teller/Caja (TT-*)

| Código Error | Mensaje T24 | Descripción | Código HTTP | Mensaje HTTP | Acción Cliente |
|--------------|-------------|-------------|-------------|--------------|----------------|
| **TT-INVALID.CHEQUE.NUMBER** | Invalid cheque number | Número cheque inválido | **400** | Bad Request | Verificar número cheque |
| **TT-CHEQUE.ALREADY.DEPOSITED** | Cheque already deposited | Cheque ya depositado | **409** | Conflict | Cheque duplicado |
| **TT-INVALID.BANK.CODE** | Invalid bank code | Código banco inválido | **400** | Bad Request | Verificar código banco |
| **TT-CHEQUE.EXPIRED** | Cheque has expired | Cheque vencido | **422** | Unprocessable Entity | Cheque no válido |
| **TT-INSUFFICIENT.CLEARING.BALANCE** | Insufficient clearing balance | Saldo compensación insuficiente | **422** | Unprocessable Entity | Esperar compensación |
| **TT-CLEARING.CUT.OFF.TIME** | Clearing cut off time passed | Hora corte compensación pasada | **422** | Unprocessable Entity | Procesar día siguiente |
| **TT-BANK.NOT.PARTICIPATING** | Bank not participating | Banco no participa compensación | **422** | Unprocessable Entity | Banco no válido |
| **TT-CHEQUE.STOP.PAYMENT** | Stop payment on cheque | Orden no pago cheque | **422** | Unprocessable Entity | Cheque anulado |
| **TT-INVALID.ENDORSEMENT** | Invalid endorsement | Endoso inválido | **422** | Unprocessable Entity | Verificar endoso |

### Errores de Sistema (SYS-*)

| Código Error | Mensaje T24 | Descripción | Código HTTP | Mensaje HTTP | Acción Cliente |
|--------------|-------------|-------------|-------------|--------------|----------------|
| **SYS-DATABASE.ERROR** | Database error occurred | Error base de datos | **503** | Service Unavailable | Reintentar más tarde |
| **SYS-SYSTEM.UNAVAILABLE** | System temporarily unavailable | Sistema temporalmente no disponible | **503** | Service Unavailable | Reintentar más tarde |
| **SYS-TIMEOUT** | System timeout | Timeout del sistema | **408** | Request Timeout | Reintentar |
| **SYS-COMMUNICATION.ERROR** | Communication error | Error comunicación | **502** | Bad Gateway | Verificar conectividad |
| **SYS-INVALID.REQUEST** | Invalid request format | Formato solicitud inválido | **400** | Bad Request | Verificar formato |
| **SYS-MEMORY.INSUFFICIENT** | Insufficient system memory | Memoria sistema insuficiente | **507** | Insufficient Storage | Reintentar más tarde |
| **SYS-DISK.FULL** | Disk space full | Espacio disco lleno | **507** | Insufficient Storage | Contactar soporte |
| **SYS-MAINTENANCE.MODE** | System in maintenance | Sistema en mantenimiento | **503** | Service Unavailable | Reintentar más tarde |

### Errores Específicos de Honduras (HN-*)

| Código Error | Mensaje | Descripción | Código HTTP | Mensaje HTTP | Acción Cliente |
|--------------|---------|-------------|-------------|--------------|----------------|
| **HN-LOAN-001** | Préstamo no encontrado en sistema local | Préstamo no existe en base local | **404** | Not Found | Verificar número préstamo |
| **HN-LOAN-002** | Préstamo migrado a T24 | Préstamo fue migrado a T24 | **301** | Moved Permanently | Usar servicio T24 |
| **HN-ACCT-001** | Cuenta no pertenece al cliente | Cuenta no asociada al cliente | **403** | Forbidden | Verificar titularidad |
| **HN-CURR-001** | Moneda no soportada para pagos | Moneda no configurada | **422** | Unprocessable Entity | Usar moneda válida |
| **HN-PARAM-001** | Parámetros configuración no encontrados | Faltan parámetros configuración | **500** | Internal Server Error | Contactar soporte |
| **HN-INT-001** | Error conectando con ABANKS | Falla conexión ABANKS | **502** | Bad Gateway | Reintentar más tarde |
| **HN-INT-002** | Error conectando con T24 | Falla conexión T24 | **502** | Bad Gateway | Reintentar más tarde |
| **HN-INT-003** | Timeout consulta productos | Timeout consulta productos | **408** | Request Timeout | Reintentar |
| **HN-INT-004** | Error transferencia entre cuentas | Falla proceso transferencia | **500** | Internal Server Error | Contactar soporte |
| **HN-INT-005** | Error reversión transacción | Falla al reversar transacción | **500** | Internal Server Error | Contactar soporte |

### Errores de Validación OSB (OSB-*)

| Código Error | Mensaje | Descripción | Código HTTP | Mensaje HTTP | Acción Cliente |
|--------------|---------|-------------|-------------|--------------|----------------|
| **OSB-VAL-001** | Servicio no habilitado para región | Servicio no disponible región | **403** | Forbidden | Verificar región |
| **OSB-VAL-002** | Tipo pago no soportado | Tipo pago no implementado | **422** | Unprocessable Entity | Usar tipo válido |
| **OSB-VAL-003** | Campos requeridos faltantes | Campos obligatorios vacíos | **400** | Bad Request | Completar campos |
| **OSB-VAL-004** | Formato XML inválido | Estructura XML incorrecta | **400** | Bad Request | Verificar formato |
| **OSB-VAL-005** | Credenciales inválidas | Usuario/contraseña incorrectos | **401** | Unauthorized | Verificar credenciales |
| **OSB-VAL-006** | Región no soportada | Región no configurada | **422** | Unprocessable Entity | Usar región válida |

## Mapeo de Respuestas por Stored Procedure

### TOPLEVEL$OSB_PAG_PRESTAMO_CAJ (Caja)

**Campos de Salida:**
- `ERROR_CODE`: Código de error del stored procedure
- `ERROR_MESSAGE`: Mensaje de error descriptivo

**Mapeo de Códigos:**

| ERROR_CODE | ERROR_MESSAGE | HTTP Status | HTTP Message | Categoría |
|------------|---------------|-------------|--------------|-----------|
| **SUCCESS** | Pago procesado exitosamente | **200** | OK | Éxito |
| **INVALID_LOAN** | Número de préstamo inválido | **400** | Bad Request | Validación |
| **LOAN_CLOSED** | Préstamo cerrado | **422** | Unprocessable Entity | Negocio |
| **INVALID_AMOUNT** | Monto inválido | **400** | Bad Request | Validación |
| **INSUFFICIENT_FUNDS** | Fondos insuficientes | **422** | Unprocessable Entity | Negocio |
| **ACCOUNT_BLOCKED** | Cuenta bloqueada | **403** | Forbidden | Autorización |
| **SYSTEM_ERROR** | Error del sistema | **500** | Internal Server Error | Sistema |
| **TIMEOUT** | Timeout en procesamiento | **408** | Request Timeout | Tiempo |
| **DUPLICATE_TRANSACTION** | Transacción duplicada | **409** | Conflict | Conflicto |

### OSB_PAG_PRESTAMO_T24 (T24)

**Campos de Salida:**
- `ERROR_CODE`: Código de error del stored procedure
- `ERROR_MESSAGE`: Mensaje de error descriptivo

**Mapeo de Códigos:**

| ERROR_CODE | ERROR_MESSAGE | HTTP Status | HTTP Message | Categoría |
|------------|---------------|-------------|--------------|-----------|
| **SUCCESS** | Pago registrado exitosamente | **200** | OK | Éxito |
| **T24_ERROR** | Error en sistema T24 | **502** | Bad Gateway | Sistema |
| **INVALID_LOAN_NUMBER** | Número de préstamo inválido | **400** | Bad Request | Validación |
| **INVALID_ACCOUNT** | Cuenta inválida | **400** | Bad Request | Validación |
| **PAYMENT_EXCEEDS_BALANCE** | Pago excede saldo | **422** | Unprocessable Entity | Negocio |
| **LOAN_NOT_FOUND** | Préstamo no encontrado | **404** | Not Found | Recurso |
| **ACCOUNT_CLOSED** | Cuenta cerrada | **422** | Unprocessable Entity | Negocio |
| **CURRENCY_MISMATCH** | Monedas no coinciden | **422** | Unprocessable Entity | Negocio |
| **AUTHORIZATION_REQUIRED** | Requiere autorización | **409** | Conflict | Autorización |
| **SYSTEM_UNAVAILABLE** | Sistema no disponible | **503** | Service Unavailable | Disponibilidad |

## Configuración de Retry por Tipo de Error

### Errores que Permiten Retry (Temporales)

| Código HTTP | Descripción | Retry Count | Retry Interval |
|-------------|-------------|-------------|----------------|
| **408** | Request Timeout | 3 | 30 segundos |
| **502** | Bad Gateway | 3 | 30 segundos |
| **503** | Service Unavailable | 5 | 60 segundos |
| **507** | Insufficient Storage | 2 | 120 segundos |

### Errores que NO Permiten Retry (Permanentes)

| Código HTTP | Descripción | Acción |
|-------------|-------------|--------|
| **400** | Bad Request | Corregir request |
| **401** | Unauthorized | Verificar credenciales |
| **403** | Forbidden | Verificar permisos |
| **404** | Not Found | Verificar recurso |
| **409** | Conflict | Resolver conflicto |
| **422** | Unprocessable Entity | Corregir datos negocio |

## Mensajes de Error Personalizados por Región

### Honduras (HN01)

| Código Error | Mensaje Español | Mensaje Inglés |
|--------------|-----------------|----------------|
| **TIMEOUT** | TRANSACCION EN ESPERA. REVISE SU CUENTA EN 5 MINUTOS | TRANSACTION PENDING. CHECK YOUR ACCOUNT IN 5 MINUTES |
| **ERROR** | ERROR APLICANDO PAGO A PRESTAMO | ERROR APPLYING LOAN PAYMENT |
| **INSUFFICIENT_FUNDS** | FONDOS INSUFICIENTES EN LA CUENTA | INSUFFICIENT FUNDS IN ACCOUNT |
| **LOAN_CLOSED** | EL PRESTAMO SE ENCUENTRA CERRADO | THE LOAN IS CLOSED |
| **INVALID_AMOUNT** | MONTO DE PAGO INVALIDO | INVALID PAYMENT AMOUNT |

### Guatemala (GT01)

| Código Error | Mensaje Español | Mensaje Inglés |
|--------------|-----------------|----------------|
| **SYSTEM_ERROR** | ERROR EN EL SISTEMA. INTENTE MAS TARDE | SYSTEM ERROR. TRY LATER |
| **INVALID_LOAN** | NUMERO DE PRESTAMO INVALIDO | INVALID LOAN NUMBER |
| **ACCOUNT_BLOCKED** | CUENTA BLOQUEADA. CONTACTE AL BANCO | ACCOUNT BLOCKED. CONTACT BANK |

### Panamá (PA01)

| Código Error | Mensaje Español | Mensaje Inglés |
|--------------|-----------------|----------------|
| **CURRENCY_MISMATCH** | MONEDAS NO COINCIDEN | CURRENCY MISMATCH |
| **PAYMENT_EXCEEDS** | PAGO EXCEDE SALDO PENDIENTE | PAYMENT EXCEEDS OUTSTANDING BALANCE |

### Nicaragua (NI01)

| Código Error | Mensaje Español | Mensaje Inglés |
|--------------|-----------------|----------------|
| **COBIS_ERROR** | ERROR EN SISTEMA COBIS | COBIS SYSTEM ERROR |
| **LOAN_SUSPENDED** | PRESTAMO SUSPENDIDO | LOAN SUSPENDED |

## Implementación en Código

### Función de Mapeo de Errores (XQuery)

```xquery
declare function mapErrorToHttp($errorCode as xs:string, $errorMessage as xs:string) as element() {
    let $httpStatus := 
        if ($errorCode = "SUCCESS") then "200"
        else if ($errorCode = ("INVALID_LOAN", "INVALID_ACCOUNT", "INVALID_AMOUNT")) then "400"
        else if ($errorCode = ("UNAUTHORIZED", "INVALID_USER")) then "401"
        else if ($errorCode = ("ACCOUNT_BLOCKED", "USER_NOT_AUTHORIZED")) then "403"
        else if ($errorCode = "LOAN_NOT_FOUND") then "404"
        else if ($errorCode = "TIMEOUT") then "408"
        else if ($errorCode = ("DUPLICATE_TRANSACTION", "AUTHORIZATION_REQUIRED")) then "409"
        else if ($errorCode = ("LOAN_CLOSED", "INSUFFICIENT_FUNDS", "PAYMENT_EXCEEDS")) then "422"
        else if ($errorCode = ("T24_ERROR", "COMMUNICATION_ERROR")) then "502"
        else if ($errorCode = ("SYSTEM_UNAVAILABLE", "MAINTENANCE_MODE")) then "503"
        else if ($errorCode = ("MEMORY_INSUFFICIENT", "DISK_FULL")) then "507"
        else "500"
    
    let $httpMessage := 
        if ($errorCode = "SUCCESS") then "OK"
        else if ($httpStatus = "400") then "Bad Request"
        else if ($httpStatus = "401") then "Unauthorized"
        else if ($httpStatus = "403") then "Forbidden"
        else if ($httpStatus = "404") then "Not Found"
        else if ($httpStatus = "408") then "Request Timeout"
        else if ($httpStatus = "409") then "Conflict"
        else if ($httpStatus = "422") then "Unprocessable Entity"
        else if ($httpStatus = "502") then "Bad Gateway"
        else if ($httpStatus = "503") then "Service Unavailable"
        else if ($httpStatus = "507") then "Insufficient Storage"
        else "Internal Server Error"
    
    return
        <errorMapping>
            <originalCode>{$errorCode}</originalCode>
            <originalMessage>{$errorMessage}</originalMessage>
            <httpStatus>{$httpStatus}</httpStatus>
            <httpMessage>{$httpMessage}</httpMessage>
            <retryable>{if ($httpStatus = ("408", "502", "503", "507")) then "true" else "false"}</retryable>
        </errorMapping>
};
```

### Configuración de Monitoreo

```xml
<monitoring>
    <errorThresholds>
        <error code="408" threshold="10%" alert="warning"/>
        <error code="502" threshold="5%" alert="critical"/>
        <error code="503" threshold="5%" alert="critical"/>
        <error code="500" threshold="2%" alert="critical"/>
    </errorThresholds>
    <retryConfiguration>
        <temporaryErrors codes="408,502,503,507" maxRetries="3" interval="30"/>
        <permanentErrors codes="400,401,403,404,409,422" maxRetries="0"/>
    </retryConfiguration>
</monitoring>
```

## Resumen de Implementación

1. **Total de Códigos de Error Identificados:** 85+
2. **Categorías de Error:** 8 (Validación, Autorización, Negocio, Sistema, Red, Recurso, Tiempo, Conflicto)
3. **Regiones Soportadas:** 4 (HN01, GT01, PA01, NI01)
4. **Stored Procedures Analizados:** 2
5. **Códigos HTTP Utilizados:** 12 diferentes
6. **Errores con Retry:** 4 tipos
7. **Errores sin Retry:** 6 tipos

Esta tabla de mapeo proporciona una homologación completa de todos los posibles errores que pueden generar los stored procedures de PagoPrestamo a códigos HTTP estándar, facilitando la integración con sistemas REST y el manejo consistente de errores en toda la plataforma.