# Tabla de Errores T24 y Homologación a Códigos HTTP

## Errores Definidos en el Esquema T24

Según el esquema XSD `ReversarTransacciones.xsd`, el campo `successIndicator` es un tipo enumerado con los siguientes valores posibles:

```xml
<xs:simpleType name="successIndicator">
  <xs:restriction base="xs:string">
    <xs:enumeration value="Success"/>
    <xs:enumeration value="TWSError"/>
    <xs:enumeration value="T24Error"/>
    <xs:enumeration value="T24Override"/>
    <xs:enumeration value="T24Offline"/>
  </xs:restriction>
</xs:simpleType>
```

---

## Tabla de Homologación: Errores T24 → Códigos HTTP

| Código T24 | Descripción | Código HTTP Sugerido | Razón HTTP | Categoría | Acción Recomendada |
|------------|-------------|---------------------|------------|-----------|-------------------|
| **Success** | Operación exitosa | **200 OK** | La reversión se completó exitosamente | Éxito | Ninguna - Operación completada |
| **TWSError** | Error en T24 Web Services (capa de integración) | **502 Bad Gateway** | Error en el servicio intermediario (T24 Web Services) | Error de Integración | Reintentar después de verificar conectividad con T24 |
| **T24Error** | Error de negocio en T24 Core Banking | **422 Unprocessable Entity** | La solicitud es válida pero T24 no puede procesarla por reglas de negocio | Error de Negocio | Revisar mensaje de error específico y corregir datos |
| **T24Override** | Requiere autorización manual (override) | **409 Conflict** | La operación requiere aprobación adicional o resolución de conflicto | Requiere Acción | Solicitar autorización manual en T24 |
| **T24Offline** | T24 no disponible | **503 Service Unavailable** | El servicio backend (T24) está temporalmente fuera de servicio | Error de Disponibilidad | Reintentar después de un tiempo (implementar backoff exponencial) |

---

## Tabla Detallada de Escenarios de Error

### 1. Success (200 OK)

| Aspecto | Detalle |
|---------|---------|
| **Código T24** | Success |
| **Código HTTP** | 200 OK |
| **Descripción** | La transacción fue reversada exitosamente en T24 |
| **Campo Status/messages** | "Transaction reversed successfully" (ejemplo) |
| **Response OSB** | StatusInfo con Status="Success", sin ErrorInfo |
| **Retry** | No aplica |
| **Logging** | INFO level |
| **Ejemplo Mensaje** | "Reversión de boletín fiscal FT24001123456 completada exitosamente" |

---

### 2. TWSError (502 Bad Gateway)

| Aspecto | Detalle |
|---------|---------|
| **Código T24** | TWSError |
| **Código HTTP** | 502 Bad Gateway |
| **Descripción** | Error en la capa de T24 Web Services (middleware) |
| **Causas Posibles** | - Error de serialización/deserialización XML<br/>- Timeout en T24 Web Services<br/>- Error de configuración en TWS<br/>- Problema de red entre OSB y TWS |
| **Campo Status/messages** | Mensaje técnico del error TWS |
| **Response OSB** | ErrorInfo con Code mapeado, SystemId="T24", SystemStatus="TWSError" |
| **Retry** | Sí, con backoff exponencial (3 intentos) |
| **Logging** | ERROR level con stack trace |
| **Ejemplo Mensaje** | "Error de comunicación con T24 Web Services: Connection timeout" |
| **Acción Usuario** | Contactar soporte técnico si persiste |

---

### 3. T24Error (422 Unprocessable Entity)

| Aspecto | Detalle |
|---------|---------|
| **Código T24** | T24Error |
| **Código HTTP** | 422 Unprocessable Entity |
| **Descripción** | Error de validación o regla de negocio en T24 Core Banking |
| **Causas Posibles** | - Transacción no encontrada<br/>- Transacción ya reversada<br/>- Transacción en estado no reversible<br/>- Fecha de reversión fuera de ventana permitida<br/>- Cuenta bloqueada o cerrada<br/>- Fondos insuficientes para reversar cargos<br/>- Usuario sin permisos para reversar |
| **Campo Status/messages** | Mensaje de negocio específico de T24 |
| **Response OSB** | ErrorInfo con Code mapeado, Description detallada, SystemId="T24", SystemStatus="T24Error" |
| **Retry** | No (error de negocio, no transitorio) |
| **Logging** | WARN level |
| **Ejemplos Mensajes** | - "Transaction FT24001123456 not found"<br/>- "Transaction already reversed"<br/>- "Transaction status does not allow reversal"<br/>- "Reversal window expired (max 24 hours)"<br/>- "Account 1234567890 is closed" |
| **Acción Usuario** | Revisar datos de entrada y estado de la transacción original |

---

### 4. T24Override (409 Conflict)

| Aspecto | Detalle |
|---------|---------|
| **Código T24** | T24Override |
| **Código HTTP** | 409 Conflict |
| **Descripción** | La operación requiere autorización manual (override) en T24 |
| **Causas Posibles** | - Monto de reversión excede límite automático<br/>- Reversión fuera de horario operativo<br/>- Transacción marcada para revisión<br/>- Requiere aprobación de supervisor<br/>- Cuenta con alertas de fraude |
| **Campo Status/messages** | Mensaje indicando override requerido y razón |
| **Response OSB** | ErrorInfo con Code específico de override, Description con instrucciones |
| **Retry** | No (requiere intervención manual) |
| **Logging** | WARN level |
| **Ejemplos Mensajes** | - "Override required: Amount exceeds automatic reversal limit"<br/>- "Override required: Transaction outside business hours"<br/>- "Supervisor approval required for this reversal" |
| **Acción Usuario** | Solicitar autorización manual en T24 o contactar supervisor |

---

### 5. T24Offline (503 Service Unavailable)

| Aspecto | Detalle |
|---------|---------|
| **Código T24** | T24Offline |
| **Código HTTP** | 503 Service Unavailable |
| **Descripción** | T24 Core Banking no está disponible |
| **Causas Posibles** | - T24 en mantenimiento programado<br/>- T24 en proceso de cierre de día (EOD)<br/>- Falla en servidor T24<br/>- Red entre TWS y T24 caída<br/>- Base de datos T24 no disponible |
| **Campo Status/messages** | "T24 system is currently offline" o similar |
| **Response OSB** | ErrorInfo con Code de servicio no disponible, Header "Retry-After" sugerido |
| **Retry** | Sí, con backoff exponencial (máximo 5 intentos, espera creciente) |
| **Logging** | ERROR level |
| **Ejemplo Mensaje** | "T24 Core Banking is temporarily unavailable. Please try again later." |
| **Acción Usuario** | Reintentar después de 5-10 minutos |
| **Header HTTP** | `Retry-After: 300` (5 minutos) |

---

## Tabla de Errores Adicionales (Nivel OSB/Pipeline)

Además de los errores de T24, el OSB puede generar sus propios errores:

| Escenario de Error | Código HTTP | Descripción | Origen |
|-------------------|-------------|-------------|--------|
| **Validación de Esquema XML** | 400 Bad Request | Request no cumple con el esquema XSD | OSB Proxy |
| **Autenticación Fallida** | 401 Unauthorized | Credenciales HTTP Basic Auth inválidas | OWSM Policy |
| **Credenciales LDAP No Encontradas** | 500 Internal Server Error | No se encontraron credenciales en LDAP para ApplicationId | ExtractCredentials.xqy |
| **TransactionId Vacío** | 400 Bad Request | Campo TransactionId es obligatorio | OSB Pipeline |
| **Timeout de Conexión a T24** | 504 Gateway Timeout | No se recibió respuesta de T24 en tiempo esperado | ReversarTransaccionSoapT24BS |
| **Error de Transformación XQuery** | 500 Internal Server Error | Error al ejecutar transformación XQuery | Pipeline Stage |
| **Error de Mapeo de Errores** | 500 Internal Server Error | Fallo al invocar GetCustomErrorByStackTraceRegionalRestBS | Pipeline Error Handler |
| **Error de Logging** | N/A (no afecta respuesta) | Fallo al registrar log (operación continúa) | LoggingRegionalRestBS |

---

## Mapeo de Códigos de Error Regionales

El servicio `GetCustomErrorByStackTraceRegionalRestBS` traduce los errores de T24 a códigos regionales. Ejemplos de mapeo:

| Error T24 | Código Regional | Descripción Regional (ES) | Descripción Regional (EN) |
|-----------|----------------|---------------------------|---------------------------|
| T24Error: Transaction not found | TRF-404 | La transacción no fue encontrada | Transaction not found |
| T24Error: Already reversed | TRF-409 | La transacción ya fue reversada | Transaction already reversed |
| T24Error: Invalid status | TRF-422 | Estado de transacción no permite reversión | Transaction status does not allow reversal |
| T24Override: Amount limit | TRF-409-OVR | Monto excede límite, requiere autorización | Amount exceeds limit, authorization required |
| T24Offline | TRF-503 | Sistema core bancario no disponible | Core banking system unavailable |
| TWSError | TRF-502 | Error de comunicación con sistema bancario | Communication error with banking system |

---

## Recomendaciones de Implementación

### 1. Headers HTTP Sugeridos

```http
HTTP/1.1 422 Unprocessable Entity
Content-Type: application/json
X-Transaction-Id: FT24001123456
X-Global-Id: 550e8400-e29b-41d4-a716-446655440000
X-Error-Code: TRF-404
X-Error-Source: T24
```

### 2. Estructura de Response de Error (JSON)

```json
{
  "status": "error",
  "httpCode": 422,
  "errorCode": "TRF-404",
  "errorType": "TRANSACTION_NOT_FOUND",
  "message": "La transacción no fue encontrada o ya fue reversada",
  "details": {
    "systemId": "T24",
    "systemStatus": "T24Error",
    "systemMessage": "Transaction not found or already reversed",
    "transactionId": "FT24001123456",
    "globalId": "550e8400-e29b-41d4-a716-446655440000",
    "timestamp": "2024-01-15T10:30:45Z"
  },
  "retryable": false,
  "suggestedAction": "Verifique el ID de transacción y su estado actual"
}
```

### 3. Estrategia de Retry

| Error | Retryable | Max Intentos | Backoff | Ejemplo Espera |
|-------|-----------|--------------|---------|----------------|
| TWSError | Sí | 3 | Exponencial | 1s, 2s, 4s |
| T24Offline | Sí | 5 | Exponencial | 5s, 10s, 20s, 40s, 80s |
| T24Error | No | 0 | N/A | N/A |
| T24Override | No | 0 | N/A | N/A |
| Timeout | Sí | 2 | Lineal | 30s, 30s |

### 4. Circuit Breaker

Implementar circuit breaker para T24Offline:
- **Threshold**: 5 errores consecutivos
- **Timeout**: 60 segundos
- **Estado Half-Open**: Permitir 1 request de prueba
- **Reset**: Después de 3 requests exitosos

---

## Notas Importantes

1. **No se encontraron mensajes de error específicos en el código fuente**: Los mensajes mostrados son ejemplos basados en patrones comunes de T24

2. **El mapeo de errores es dinámico**: El servicio `GetCustomErrorByStackTraceRegionalRestBS` realiza el mapeo en tiempo de ejecución basándose en configuración externa

3. **Idioma**: El mapeo de errores considera el campo `Language` del request (ES/EN) para retornar mensajes localizados

4. **Logging**: Todos los errores se registran con el GlobalId para trazabilidad end-to-end

5. **Sin timeout configurado**: Actualmente el Business Service tiene timeout en 0, lo que puede causar esperas indefinidas. Se recomienda configurar timeout de 30-60 segundos

6. **Monitoreo**: Se recomienda implementar alertas para:
   - Tasa de T24Offline > 10%
   - Tasa de TWSError > 5%
   - Latencia promedio > 5 segundos
   - Errores consecutivos > 3
