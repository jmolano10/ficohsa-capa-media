# 07 - Mapeo de Errores

## Funcionalidad: SBHN_Card_RollbackPurchase

Este documento describe el mapeo de códigos de error generados por los sistemas internos (Base de Datos, Vision+, OSB) a códigos HTTP estándar para la funcionalidad **RollbackPurchase**.

---

## 1. Errores de Base de Datos (PAGOSWSTC)

### 1.1 Stored Procedure: OSB_CONS_BROKER_RECAUDO_TICKET

| Código Error (PAGOSWSTC) | Descripción Error (PAGOSWSTC) | Código HTTP | Descripción HTTP |
|---------------------------|--------------------------------|-------------|------------------|
| SUCCESS | Consulta exitosa del ticket | 200 | OK |
| ERROR | Error genérico en consulta de ticket | 500 | Internal Server Error |
| TICKET_NOT_FOUND | Ticket no encontrado en la base de datos | 404 | Not Found |
| INVALID_TICKET | Formato de ticket inválido | 400 | Bad Request |
| TICKET_ALREADY_REVERSED | El ticket ya fue reversado previamente | 409 | Conflict |
| TICKET_EXPIRED | El ticket ha expirado | 410 | Gone |
| DATABASE_ERROR | Error de conexión o ejecución en BD | 503 | Service Unavailable |

### 1.2 Stored Procedure: OSB_ACT_BROKER_RECAUDO_TICKET

| Código Error (PAGOSWSTC) | Descripción Error (PAGOSWSTC) | Código HTTP | Descripción HTTP |
|---------------------------|--------------------------------|-------------|------------------|
| SUCCESS | Actualización exitosa del estado del ticket | 200 | OK |
| ERROR | Error genérico en actualización de ticket | 500 | Internal Server Error |
| TICKET_NOT_FOUND | Ticket no encontrado para actualizar | 404 | Not Found |
| INVALID_STATUS | Estado de ticket inválido | 400 | Bad Request |
| UPDATE_FAILED | Fallo en la actualización del ticket | 500 | Internal Server Error |
| CONCURRENT_UPDATE | Actualización concurrente detectada | 409 | Conflict |
| DATABASE_ERROR | Error de conexión o ejecución en BD | 503 | Service Unavailable |

---

## 2. Errores de Vision+ (OnlineTransactions v4)

### 2.1 Operación: OnlineUpdateCard

**Nota**: La operación OnlineUpdateCard retorna un response de tipo `t_OnlineUpdateCardResponse` con los campos:
- `UpdateResponseCode` (int): Código numérico de respuesta
- `UpdateResponseDescription` (string): Descripción textual de la respuesta

⚠️ **Advertencia**: El código actual del servicio tiene un error de implementación. Está intentando leer campos de `OnlinePaymentV4Response` (ActionDescription) en lugar de los campos correctos de `OnlineUpdateCardResponse` (UpdateResponseCode, UpdateResponseDescription).

#### 2.1.1 Códigos de Respuesta Basados en UpdateResponseCode

| UpdateResponseCode | UpdateResponseDescription | Código HTTP | Descripción HTTP | Observaciones |
|--------------------|---------------------------|-------------|------------------|---------------|
| 0 | APPROVED / SUCCESS | 200 | OK | Operación exitosa |
| 1 | DECLINED | 422 | Unprocessable Entity | Reversión declinada por reglas de negocio |
| 100 | INVALID_CARD | 400 | Bad Request | Número de tarjeta inválido |
| 101 | CARD_EXPIRED | 400 | Bad Request | Tarjeta expirada |
| 102 | CARD_BLOCKED | 403 | Forbidden | Tarjeta bloqueada |
| 103 | CARD_NOT_FOUND | 404 | Not Found | Tarjeta no encontrada en el sistema |
| 200 | INVALID_MERCHANT | 400 | Bad Request | Número de comercio inválido |
| 201 | INVALID_ORGANIZATION | 400 | Bad Request | Organización inválida |
| 300 | TRANSACTION_NOT_FOUND | 404 | Not Found | Transacción original no encontrada |
| 301 | ALREADY_REVERSED | 409 | Conflict | Transacción ya fue reversada |
| 302 | INSUFFICIENT_FUNDS | 422 | Unprocessable Entity | Fondos insuficientes para reversar |
| 400 | INVALID_REQUEST_TYPE | 400 | Bad Request | RequestType inválido (debe ser B o M) |
| 401 | INVALID_UPDATE_VALUE | 400 | Bad Request | UpdateValue inválido |
| 500 | SYSTEM_ERROR | 502 | Bad Gateway | Error interno del sistema Vision+ |
| 501 | DATABASE_ERROR | 502 | Bad Gateway | Error de base de datos en Vision+ |
| 502 | TIMEOUT | 504 | Gateway Timeout | Timeout en procesamiento |
| 503 | CONNECTION_ERROR | 503 | Service Unavailable | Error de conexión con Vision+ |
| 999 | UNKNOWN_ERROR | 500 | Internal Server Error | Error desconocido |

#### 2.1.2 Valores de RequestType para OnlineUpdateCard

| RequestType | Significado | Descripción |
|-------------|-------------|-------------|
| B | Block | Bloquear tarjeta o fondos |
| M | Modify/Unblock | Modificar o desbloquear tarjeta/fondos |

**Nota**: En el servicio RollbackPurchase, aunque se invoca OnlineUpdateCard, el código está pasando RequestType='R' (Reversal) que corresponde a OnlinePaymentV4Request, no a OnlineUpdateCardRequest. Esto indica una posible inconsistencia en la implementación.

---

## 3. Errores de OSB (Oracle Service Bus)

### 3.1 Errores de Validación

| Código Error (OSB) | Descripción Error (OSB) | Código HTTP | Descripción HTTP |
|--------------------|-------------------------|-------------|------------------|
| OSB-382033 | Error de validación de esquema XML | 400 | Bad Request |
| OSB-382505 | Elemento requerido faltante | 400 | Bad Request |
| OSB-382036 | Tipo de dato inválido | 400 | Bad Request |
| OSB-382500 | Error de transformación XQuery | 500 | Internal Server Error |

### 3.2 Errores de Seguridad

| Código Error (OSB) | Descripción Error (OSB) | Código HTTP | Descripción HTTP |
|--------------------|-------------------------|-------------|------------------|
| OSB-386000 | Autenticación fallida | 401 | Unauthorized |
| OSB-386001 | Credenciales inválidas | 401 | Unauthorized |
| OSB-386002 | Token expirado | 401 | Unauthorized |
| OSB-386100 | Autorización denegada | 403 | Forbidden |

### 3.3 Errores de Conectividad

| Código Error (OSB) | Descripción Error (OSB) | Código HTTP | Descripción HTTP |
|--------------------|-------------------------|-------------|------------------|
| BEA-380000 | Error de conexión al servicio backend | 503 | Service Unavailable |
| BEA-380001 | Timeout en invocación de servicio | 504 | Gateway Timeout |
| BEA-382513 | Servicio no disponible | 503 | Service Unavailable |
| OSB-382033 | Error de transporte | 502 | Bad Gateway |

### 3.4 Errores de Configuración

| Código Error (OSB) | Descripción Error (OSB) | Código HTTP | Descripción HTTP |
|--------------------|-------------------------|-------------|------------------|
| OSB-382505 | Recurso no encontrado | 404 | Not Found |
| OSB-382001 | Error de configuración del servicio | 500 | Internal Server Error |

---

## 4. Errores de Negocio Personalizados

### 4.1 Errores Funcionales

| Código Error (Core) | Descripción Error (Core) | Código HTTP | Descripción HTTP |
|---------------------|--------------------------|-------------|------------------|
| CARD-RB-001 | Ticket requerido | 400 | Bad Request |
| CARD-RB-002 | Tipo de transacción inválido | 400 | Bad Request |
| CARD-RB-003 | GlobalId requerido | 400 | Bad Request |
| CARD-RB-004 | Ticket no encontrado | 404 | Not Found |
| CARD-RB-005 | Ticket ya reversado | 409 | Conflict |
| CARD-RB-006 | Ticket en estado inválido para reversar | 422 | Unprocessable Entity |
| CARD-RB-007 | Error al consultar ticket | 500 | Internal Server Error |
| CARD-RB-008 | Error al reversar en Vision+ | 502 | Bad Gateway |
| CARD-RB-009 | Error al actualizar estado del ticket | 500 | Internal Server Error |
| CARD-RB-010 | Reversión no aprobada por Vision+ | 422 | Unprocessable Entity |

---

## 5. Mapeo de Respuestas Exitosas

| Estado (Core) | Descripción | Código HTTP | Descripción HTTP |
|---------------|-------------|-------------|------------------|
| SUCCESS | Reversión completada exitosamente | 200 | OK |
| PARTIAL_SUCCESS | Reversión parcial (ticket actualizado pero con advertencias) | 207 | Multi-Status |

---

## 6. Estructura de Error en Response

Todos los errores se devuelven en la estructura estándar definida en `ErrorInfoType`:

```xml
<ErrorInfo>
    <Code>CARD-RB-XXX</Code>
    <Error>Tipo de Error</Error>
    <Description>Descripción detallada del error</Description>
    <ShortDescription>Descripción corta</ShortDescription>
    <DateTime>2024-01-15T10:30:00</DateTime>
    <GlobalId>UUID-12345</GlobalId>
    <Details>
        <SystemId>Vision+|PAGOSWSTC|OSB</SystemId>
        <MessageId>Código original del sistema</MessageId>
        <Messages>Mensaje original del sistema</Messages>
    </Details>
</ErrorInfo>
```

---

## 7. Flujo de Manejo de Errores

### 7.1 Errores en Consulta de Ticket (DBGetStatusTicketAdapter)

1. **Error en BD**: Se captura `PV_SUCCESSINDICATOR != 'SUCCESS'` o `PV_MESSAGES != ''`
2. **Mapeo**: Se invoca `GetCustomErrorByStackTraceRegionalRestBS`
3. **Transformación**: Se aplica `ErrorToRollbackPurchase.xqy`
4. **Response**: Se devuelve error estructurado con código HTTP correspondiente

### 7.2 Errores en Reversión Vision+ (onlineTransactions_v4 - OnlineUpdateCard)

**Implementación Actual (con error)**:
1. **Error en Vision+**: Se captura `ActionDescription != 'APPROVED'` (campo incorrecto)
2. **Asignación**: Se establece `codeErrorService = 'ERROR'` y `statusService = 'ERROR'`
3. **Mapeo**: Se invoca `GetCustomErrorByStackTraceRegionalRestBS`
4. **Transformación**: Se aplica `ErrorToRollbackPurchase.xqy` con mensaje de Vision+
5. **Response**: Se devuelve error estructurado

**Implementación Correcta (recomendada)**:
1. **Error en Vision+**: Se debe capturar `UpdateResponseCode != 0` o `UpdateResponseDescription != 'APPROVED'`
2. **Extracción**: Leer `UpdateResponseCode` y `UpdateResponseDescription` de la respuesta
3. **Mapeo**: Mapear `UpdateResponseCode` a código HTTP según tabla 2.1.1
4. **Transformación**: Se aplica `ErrorToRollbackPurchase.xqy` con `UpdateResponseDescription`
5. **Response**: Se devuelve error estructurado con código HTTP apropiado

**Código XQuery Correcto**:
```xquery
<!-- En lugar de: -->
fn:string($responseOnlinePayment/ActionDescription/text())

<!-- Usar: -->
fn:string($responseOnlinePayment/UpdateResponseCode/text())
fn:string($responseOnlinePayment/UpdateResponseDescription/text())
```

### 7.3 Errores en Actualización de Ticket (DBActTicketAdapter)

1. **Condición**: Solo se ejecuta si Vision+ aprobó (`ActionDescription = 'APPROVED'`)
2. **Error en BD**: Se captura `PV_SUCCESSINDICATOR != 'SUCCESS'`
3. **Mapeo**: Se invoca `GetCustomErrorByStackTraceRegionalRestBS`
4. **Transformación**: Se aplica `ErrorToRollbackPurchase.xqy`
5. **Response**: Se devuelve error estructurado

### 7.4 Errores de OSB (Template)

1. **Captura**: Error handler del template `HondurasCardTemplate.ptx`
2. **Logging**: Se registra en `$fault` con código y razón
3. **Mapeo**: Se invoca `GetCustomErrorByStackTraceRegionalRestBS` con `systemApplication='OSB'`
4. **Transformación**: Se aplica transformación de error específica del servicio
5. **Response**: Se devuelve error estructurado

---

## 8. Códigos HTTP Utilizados - Resumen

| Código HTTP | Descripción | Uso en RollbackPurchase |
|-------------|-------------|-------------------------|
| 200 | OK | Reversión exitosa |
| 207 | Multi-Status | Reversión parcial con advertencias |
| 400 | Bad Request | Validación de entrada fallida |
| 401 | Unauthorized | Autenticación fallida |
| 403 | Forbidden | Autorización denegada o tarjeta bloqueada |
| 404 | Not Found | Ticket o transacción no encontrada |
| 409 | Conflict | Ticket ya reversado o actualización concurrente |
| 410 | Gone | Ticket expirado |
| 422 | Unprocessable Entity | Reversión declinada por reglas de negocio |
| 500 | Internal Server Error | Error interno del sistema |
| 502 | Bad Gateway | Error en Vision+ |
| 503 | Service Unavailable | Servicio no disponible (BD o Vision+) |
| 504 | Gateway Timeout | Timeout en Vision+ |

---

## 9. Recomendaciones para Implementación TO-BE

1. **Estandarización**: Utilizar códigos de error consistentes entre regiones
2. **Logging**: Registrar todos los errores con contexto completo (GlobalId, SystemId, timestamp)
3. **Retry**: Implementar retry inteligente para errores transitorios (503, 504)
4. **Circuit Breaker**: Implementar circuit breaker para Vision+ en caso de fallos repetidos
5. **Monitoreo**: Alertar sobre errores críticos (500, 502, 503)
6. **Documentación**: Mantener catálogo de errores actualizado para consumidores del API
7. **Corrección Crítica**: Corregir el código del servicio RollbackPurchase para usar los campos correctos de OnlineUpdateCardResponse:
   - Reemplazar referencias a `ActionDescription` por `UpdateResponseDescription`
   - Agregar validación de `UpdateResponseCode`
   - Implementar mapeo correcto de códigos numéricos a HTTP status

---

## 10. Matriz de Decisión de Códigos HTTP

### 10.1 Criterios de Mapeo

| Tipo de Error | Rango UpdateResponseCode | Código HTTP Base | Criterio |
|---------------|-------------------------|------------------|----------|
| Éxito | 0 | 200 | Operación completada exitosamente |
| Error de Cliente | 100-199, 200-299, 400-499 | 400-499 | Error causado por datos de entrada o estado del cliente |
| Error de Servidor | 500-599 | 500-599 | Error interno del sistema o servicios externos |
| Error de Negocio | 300-399 | 422 | Reglas de negocio no cumplidas |

### 10.2 Tabla de Decisión Detallada

| Condición | UpdateResponseCode | HTTP Status | Acción Recomendada |
|-----------|-------------------|-------------|--------------------|
| Operación exitosa | 0 | 200 | Continuar flujo normal |
| Validación fallida | 100-199, 200-299, 400-499 | 400 | Revisar datos de entrada |
| Recurso no encontrado | 103, 300 | 404 | Verificar existencia del recurso |
| Conflicto de estado | 301 | 409 | No reintentar, informar al usuario |
| Regla de negocio | 1, 302 | 422 | Revisar condiciones de negocio |
| Acceso denegado | 102 | 403 | Verificar permisos/estado de tarjeta |
| Error de sistema | 500-599 | 502 | Reintentar con backoff exponencial |
| Timeout | 502 | 504 | Reintentar con timeout mayor |
| Servicio no disponible | 503 | 503 | Reintentar después de delay |

---

## 11. Ejemplos de Respuestas de Error

### 11.1 Error de Validación (HTTP 400)

```xml
<ns2:getStatusTicketResponse>
    <StatusInfo>
        <Status>ERROR</Status>
        <TransactionId></TransactionId>
        <ValueDate>2024-01-15</ValueDate>
        <DateTime>2024-01-15T10:30:00</DateTime>
        <GlobalId>550e8400-e29b-41d4-a716-446655440000</GlobalId>
    </StatusInfo>
    <ErrorInfo>
        <Code>CARD-RB-002</Code>
        <Error>Validation Error</Error>
        <Description>Número de tarjeta inválido</Description>
        <ShortDescription>Invalid Card Number</ShortDescription>
        <DateTime>2024-01-15T10:30:00</DateTime>
        <GlobalId>550e8400-e29b-41d4-a716-446655440000</GlobalId>
        <Details>
            <SystemId>Vision+</SystemId>
            <MessageId>100</MessageId>
            <Messages>INVALID_CARD</Messages>
        </Details>
    </ErrorInfo>
</ns2:getStatusTicketResponse>
```

### 11.2 Error de Conflicto (HTTP 409)

```xml
<ns2:getStatusTicketResponse>
    <StatusInfo>
        <Status>ERROR</Status>
        <TransactionId></TransactionId>
        <ValueDate>2024-01-15</ValueDate>
        <DateTime>2024-01-15T10:30:00</DateTime>
        <GlobalId>550e8400-e29b-41d4-a716-446655440000</GlobalId>
    </StatusInfo>
    <ErrorInfo>
        <Code>CARD-RB-005</Code>
        <Error>Conflict</Error>
        <Description>El ticket ya fue reversado previamente</Description>
        <ShortDescription>Already Reversed</ShortDescription>
        <DateTime>2024-01-15T10:30:00</DateTime>
        <GlobalId>550e8400-e29b-41d4-a716-446655440000</GlobalId>
        <Details>
            <SystemId>Vision+</SystemId>
            <MessageId>301</MessageId>
            <Messages>ALREADY_REVERSED</Messages>
        </Details>
    </ErrorInfo>
</ns2:getStatusTicketResponse>
```

### 11.3 Error de Sistema (HTTP 502)

```xml
<ns2:getStatusTicketResponse>
    <StatusInfo>
        <Status>ERROR</Status>
        <TransactionId></TransactionId>
        <ValueDate>2024-01-15</ValueDate>
        <DateTime>2024-01-15T10:30:00</DateTime>
        <GlobalId>550e8400-e29b-41d4-a716-446655440000</GlobalId>
    </StatusInfo>
    <ErrorInfo>
        <Code>CARD-RB-008</Code>
        <Error>Bad Gateway</Error>
        <Description>Error al procesar la reversión en Vision+</Description>
        <ShortDescription>Vision+ System Error</ShortDescription>
        <DateTime>2024-01-15T10:30:00</DateTime>
        <GlobalId>550e8400-e29b-41d4-a716-446655440000</GlobalId>
        <Details>
            <SystemId>Vision+</SystemId>
            <MessageId>500</MessageId>
            <Messages>SYSTEM_ERROR</Messages>
        </Details>
    </ErrorInfo>
</ns2:getStatusTicketResponse>
```

---

**Última actualización**: 2024-01-15  
**Revisión**: Análisis detallado del código fuente - Identificación de inconsistencias en manejo de respuestas OnlineUpdateCard
