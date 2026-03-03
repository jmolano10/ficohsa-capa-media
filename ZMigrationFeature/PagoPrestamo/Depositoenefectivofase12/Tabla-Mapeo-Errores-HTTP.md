# Tabla de Mapeo de Errores HTTP - Depositoenefectivofase12

## Homologación de Errores T24 a Códigos HTTP

### Errores T24 Core - Operación Depositoefecenmonedaextranjera

| Error T24 | Mensaje T24 Original | Código HTTP | Mensaje HTTP Homologado | Acción Correctiva |
|-----------|---------------------|-------------|------------------------|-------------------|
| EB-UNKNOWN.VARIABLE | Unknown variable | 400 | Bad Request: Variable desconocida | Verificar estructura del request |
| EB-TELLER.ID | Invalid teller id | 401 | Unauthorized: ID de cajero inválido | Verificar credenciales de cajero |
| EB-ACCOUNT.MISSING | Account number missing | 400 | Bad Request: Número de cuenta faltante | Proporcionar número de cuenta |
| EB-INVALID.ACCOUNT | Invalid account number | 404 | Not Found: Cuenta no encontrada | Verificar número de cuenta |
| EB-ACCOUNT.CLOSED | Account is closed | 409 | Conflict: Cuenta cerrada | Usar cuenta activa |
| EB-CURRENCY.NOT.ALLOWED | Currency not allowed | 400 | Bad Request: Moneda no permitida | Usar moneda USD |
| EB-AMOUNT.REQUIRED | Amount is required | 400 | Bad Request: Monto requerido | Proporcionar monto válido |
| EB-INVALID.AMOUNT | Invalid amount | 400 | Bad Request: Monto inválido | Verificar formato del monto |
| EB-AMOUNT.EXCEEDS.LIMIT | Amount exceeds limit | 400 | Bad Request: Monto excede límite | Reducir monto de transacción |
| EB-INSUFFICIENT.FUNDS | Insufficient funds | 409 | Conflict: Fondos insuficientes | Verificar saldo disponible |
| EB-NARRATIVE.REQUIRED | Narrative is required | 400 | Bad Request: Narrativa requerida | Proporcionar descripción |
| EB-INVALID.VALUE.DATE | Invalid value date | 400 | Bad Request: Fecha valor inválida | Verificar fecha de transacción |
| EB-SYSTEM.DATE.ERROR | System date error | 500 | Internal Server Error: Error fecha sistema | Verificar configuración fecha T24 |
| EB-TRANSACTION.NOT.ALLOWED | Transaction not allowed | 403 | Forbidden: Transacción no permitida | Verificar permisos de usuario |
| EB-DAILY.LIMIT.EXCEEDED | Daily limit exceeded | 429 | Too Many Requests: Límite diario excedido | Esperar siguiente día hábil |
| EB-BRANCH.CLOSED | Branch is closed | 503 | Service Unavailable: Sucursal cerrada | Usar sucursal activa |
| EB-EOD.IN.PROGRESS | End of day in progress | 503 | Service Unavailable: Cierre en proceso | Esperar finalización EOD |
| EB-SYSTEM.UNAVAILABLE | System unavailable | 503 | Service Unavailable: Sistema no disponible | Verificar estado T24 |
| EB-DATABASE.ERROR | Database error | 500 | Internal Server Error: Error base datos | Verificar conectividad BD T24 |
| EB-TIMEOUT | Transaction timeout | 504 | Gateway Timeout: Tiempo agotado | Reintentar transacción |

### Errores T24 Específicos - TELLERFICOHNANYCASHINFCYType

| Error T24 | Mensaje T24 Original | Código HTTP | Mensaje HTTP Homologado | Acción Correctiva |
|-----------|---------------------|-------------|------------------------|-------------------|
| TT-INVALID.TXN.CODE | Invalid transaction code | 400 | Bad Request: Código transacción inválido | Verificar tipo de transacción |
| TT-CREDIT.ACCOUNT.INVALID | Credit account invalid | 400 | Bad Request: Cuenta crédito inválida | Verificar cuenta destino |
| TT-FCY.CASH.CURRENCY.INVALID | FCY cash currency invalid | 400 | Bad Request: Moneda extranjera inválida | Usar USD válido |
| TT-EXCHANGE.RATE.NOT.FOUND | Exchange rate not found | 500 | Internal Server Error: Tasa cambio no encontrada | Configurar tasa USD/HNL |
| TT-FCY.POSITION.LIMIT.EXCEEDED | FCY position limit exceeded | 400 | Bad Request: Límite posición FCY excedido | Verificar límites divisas |
| TT-CURRENCY.POSITION.ERROR | Currency position error | 500 | Internal Server Error: Error posición moneda | Verificar posición USD |
| TT-ACCOUNTING.ERROR | Accounting entries error | 500 | Internal Server Error: Error contabilización | Verificar configuración contable |
| TT-OVERRIDE.REQUIRED | Override required | 202 | Accepted: Autorización requerida | Obtener autorización supervisor |
| TT-DUPLICATE.REFERENCE | Duplicate reference number | 409 | Conflict: Referencia duplicada | Usar nueva referencia |
| TT-FCY.DAILY.LIMIT.EXCEEDED | FCY daily limit exceeded | 429 | Too Many Requests: Límite diario FCY excedido | Esperar siguiente día |

### Errores Regulatorios FCY

| Error T24 | Mensaje T24 Original | Código HTTP | Mensaje HTTP Homologado | Acción Correctiva |
|-----------|---------------------|-------------|------------------------|-------------------|
| REG-FCY.CUSTOMER.LIMIT | Customer FCY limit exceeded | 400 | Bad Request: Límite cliente FCY excedido | Verificar límites cliente |
| REG-FCY.BRANCH.LIMIT | Branch FCY limit exceeded | 400 | Bad Request: Límite sucursal FCY excedido | Verificar límites sucursal |
| REG-FCY.AUTHORIZATION.REQUIRED | FCY authorization required | 403 | Forbidden: Autorización FCY requerida | Obtener autorización BCH |
| REG-FCY.REPORTING.FAILED | FCY reporting failed | 500 | Internal Server Error: Reporte FCY falló | Verificar sistema reportes |

### Errores OSB y Configuración

| Error OSB | Mensaje OSB Original | Código HTTP | Mensaje HTTP Homologado | Acción Correctiva |
|-----------|---------------------|-------------|------------------------|-------------------|
| MW-0001 | INVALID REQUEST | 400 | Bad Request: Solicitud inválida | Verificar estructura request |
| MW-0002 | CURRENCY LOAN NOT SUPPORTED | 400 | Bad Request: Moneda préstamo no soportada | Usar préstamos USD |
| CFG-0001 | T24T044.USDCREDITAACCTNO not configured | 500 | Internal Server Error: Cuenta USD no configurada | Configurar parámetro |
| DB-0001 | Loan not found | 404 | Not Found: Préstamo no encontrado | Verificar número préstamo |

## Respuestas Exitosas T24

| Respuesta T24 | Código HTTP | Mensaje HTTP | Descripción |
|---------------|-------------|--------------|-------------|
| Success | 200 | OK | Transacción FCY procesada exitosamente |
| Accepted with Override | 202 | Accepted | Transacción FCY aceptada con autorización |

## Estructura de Mapeo Error T24 → HTTP

```xml
<!-- Respuesta T24 Original -->
<Status>
  <successIndicator>Failure</successIndicator>
  <messages>TT-FCY.POSITION.LIMIT.EXCEEDED - FCY position limit exceeded</messages>
  <transactionId></transactionId>
</Status>
```

```json
// Respuesta HTTP Homologada
{
  "error": {
    "code": 400,
    "message": "Bad Request: Límite posición FCY excedido",
    "t24Error": "TT-FCY.POSITION.LIMIT.EXCEEDED",
    "currency": "USD",
    "timestamp": "2024-01-15T10:30:00Z"
  }
}
```

### Códigos de Estado HTTP Utilizados

| Código | Descripción | Uso en Depositoenefectivofase12 |
|--------|-------------|--------------------------------|
| 200 | OK | Transacción FCY exitosa |
| 202 | Accepted | Requiere autorización FCY |
| 400 | Bad Request | Errores validación T24/OSB/FCY |
| 401 | Unauthorized | Credenciales inválidas |
| 403 | Forbidden | Transacción FCY no autorizada |
| 404 | Not Found | Cuenta/préstamo no encontrado |
| 409 | Conflict | Estado inconsistente |
| 429 | Too Many Requests | Límites FCY excedidos |
| 500 | Internal Server Error | Errores sistema T24/FCY |
| 503 | Service Unavailable | T24/FCY no disponible |
| 504 | Gateway Timeout | Timeout T24/FCY |