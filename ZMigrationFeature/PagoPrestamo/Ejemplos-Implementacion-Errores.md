# Ejemplos de Implementación - Mapeo de Errores PagoPrestamo

## Casos de Uso Específicos por Stored Procedure

### 1. TOPLEVEL$OSB_PAG_PRESTAMO_CAJ - Casos de Error

#### Caso 1: Préstamo Inválido
```xml
<!-- Request -->
<pagoPrestamo>
    <LOAN_NUMBER>9999999999</LOAN_NUMBER>
    <PAYMENT_AMOUNT>1000.00</PAYMENT_AMOUNT>
    <PAYMENT_TYPE>CASH</PAYMENT_TYPE>
</pagoPrestamo>

<!-- Response del SP -->
<OutputParameters>
    <ERROR_CODE>INVALID_LOAN</ERROR_CODE>
    <ERROR_MESSAGE>Número de préstamo no existe en el sistema</ERROR_MESSAGE>
</OutputParameters>

<!-- Response HTTP Mapeado -->
HTTP/1.1 400 Bad Request
Content-Type: application/json
{
    "error": {
        "code": "INVALID_LOAN",
        "message": "Número de préstamo no existe en el sistema",
        "httpStatus": 400,
        "httpMessage": "Bad Request",
        "retryable": false,
        "timestamp": "2024-01-15T10:30:00Z"
    }
}
```

#### Caso 2: Fondos Insuficientes
```xml
<!-- Request -->
<pagoPrestamo>
    <LOAN_NUMBER>1234567890</LOAN_NUMBER>
    <PAYMENT_AMOUNT>50000.00</PAYMENT_AMOUNT>
    <PAYMENT_TYPE>ACCOUNT_DEBIT</PAYMENT_TYPE>
    <DEBIT_ACCOUNT>1001234567</DEBIT_ACCOUNT>
</pagoPrestamo>

<!-- Response del SP -->
<OutputParameters>
    <ERROR_CODE>INSUFFICIENT_FUNDS</ERROR_CODE>
    <ERROR_MESSAGE>Saldo insuficiente en cuenta de débito</ERROR_MESSAGE>
</OutputParameters>

<!-- Response HTTP Mapeado -->
HTTP/1.1 422 Unprocessable Entity
Content-Type: application/json
{
    "error": {
        "code": "INSUFFICIENT_FUNDS",
        "message": "Saldo insuficiente en cuenta de débito",
        "httpStatus": 422,
        "httpMessage": "Unprocessable Entity",
        "retryable": false,
        "details": {
            "account": "1001234567",
            "requestedAmount": "50000.00",
            "availableBalance": "25000.00"
        }
    }
}
```

#### Caso 3: Timeout del Sistema
```xml
<!-- Request -->
<pagoPrestamo>
    <LOAN_NUMBER>1234567890</LOAN_NUMBER>
    <PAYMENT_AMOUNT>1000.00</PAYMENT_AMOUNT>
    <PAYMENT_TYPE>CASH</PAYMENT_TYPE>
</pagoPrestamo>

<!-- Response del SP -->
<OutputParameters>
    <ERROR_CODE>TIMEOUT</ERROR_CODE>
    <ERROR_MESSAGE>Timeout en procesamiento de pago</ERROR_MESSAGE>
</OutputParameters>

<!-- Response HTTP Mapeado -->
HTTP/1.1 408 Request Timeout
Content-Type: application/json
{
    "error": {
        "code": "TIMEOUT",
        "message": "TRANSACCION EN ESPERA. REVISE SU CUENTA EN 5 MINUTOS",
        "httpStatus": 408,
        "httpMessage": "Request Timeout",
        "retryable": true,
        "retryAfter": 300,
        "maxRetries": 3
    }
}
```

### 2. OSB_PAG_PRESTAMO_T24 - Casos de Error

#### Caso 1: Error de Conexión T24
```xml
<!-- Request -->
<pagoPrestamo>
    <LOAN_NUMBER>AA24001234</LOAN_NUMBER>
    <PAYMENT_AMOUNT>2500.00</PAYMENT_AMOUNT>
    <PAYMENT_TYPE>ACCOUNT_DEBIT</PAYMENT_TYPE>
    <DEBIT_ACCOUNT>2001234567</DEBIT_ACCOUNT>
</pagoPrestamo>

<!-- Response del SP -->
<OutputParameters>
    <ERROR_CODE>T24_ERROR</ERROR_CODE>
    <ERROR_MESSAGE>SYS-COMMUNICATION.ERROR - Error de comunicación con T24</ERROR_MESSAGE>
</OutputParameters>

<!-- Response HTTP Mapeado -->
HTTP/1.1 502 Bad Gateway
Content-Type: application/json
{
    "error": {
        "code": "T24_ERROR",
        "message": "Error de comunicación con T24",
        "httpStatus": 502,
        "httpMessage": "Bad Gateway",
        "retryable": true,
        "retryAfter": 30,
        "systemStatus": "T24_UNAVAILABLE"
    }
}
```

#### Caso 2: Pago Excede Saldo
```xml
<!-- Request -->
<pagoPrestamo>
    <LOAN_NUMBER>AA24001234</LOAN_NUMBER>
    <PAYMENT_AMOUNT>100000.00</PAYMENT_AMOUNT>
    <PAYMENT_TYPE>ACCOUNT_DEBIT</PAYMENT_TYPE>
    <DEBIT_ACCOUNT>2001234567</DEBIT_ACCOUNT>
</pagoPrestamo>

<!-- Response del SP -->
<OutputParameters>
    <ERROR_CODE>PAYMENT_EXCEEDS_BALANCE</ERROR_CODE>
    <ERROR_MESSAGE>AA-PAYMENT.EXCEEDS.BALANCE - Pago excede saldo pendiente del préstamo</ERROR_MESSAGE>
</OutputParameters>

<!-- Response HTTP Mapeado -->
HTTP/1.1 422 Unprocessable Entity
Content-Type: application/json
{
    "error": {
        "code": "PAYMENT_EXCEEDS_BALANCE",
        "message": "Pago excede saldo pendiente del préstamo",
        "httpStatus": 422,
        "httpMessage": "Unprocessable Entity",
        "retryable": false,
        "details": {
            "loanNumber": "AA24001234",
            "requestedPayment": "100000.00",
            "outstandingBalance": "75000.00",
            "maxPaymentAllowed": "75000.00"
        }
    }
}
```

## Implementación de Middleware de Mapeo

### Función JavaScript para Mapeo de Errores

```javascript
class ErrorMapper {
    constructor() {
        this.errorMappings = {
            // Errores de Validación (4xx)
            'INVALID_LOAN': { status: 400, message: 'Bad Request', retryable: false },
            'INVALID_ACCOUNT': { status: 400, message: 'Bad Request', retryable: false },
            'INVALID_AMOUNT': { status: 400, message: 'Bad Request', retryable: false },
            
            // Errores de Autorización (4xx)
            'UNAUTHORIZED': { status: 401, message: 'Unauthorized', retryable: false },
            'ACCOUNT_BLOCKED': { status: 403, message: 'Forbidden', retryable: false },
            'USER_NOT_AUTHORIZED': { status: 403, message: 'Forbidden', retryable: false },
            
            // Errores de Recurso (4xx)
            'LOAN_NOT_FOUND': { status: 404, message: 'Not Found', retryable: false },
            
            // Errores de Tiempo (4xx)
            'TIMEOUT': { status: 408, message: 'Request Timeout', retryable: true },
            
            // Errores de Conflicto (4xx)
            'DUPLICATE_TRANSACTION': { status: 409, message: 'Conflict', retryable: false },
            'AUTHORIZATION_REQUIRED': { status: 409, message: 'Conflict', retryable: false },
            
            // Errores de Negocio (4xx)
            'LOAN_CLOSED': { status: 422, message: 'Unprocessable Entity', retryable: false },
            'INSUFFICIENT_FUNDS': { status: 422, message: 'Unprocessable Entity', retryable: false },
            'PAYMENT_EXCEEDS_BALANCE': { status: 422, message: 'Unprocessable Entity', retryable: false },
            'CURRENCY_MISMATCH': { status: 422, message: 'Unprocessable Entity', retryable: false },
            
            // Errores de Sistema (5xx)
            'SYSTEM_ERROR': { status: 500, message: 'Internal Server Error', retryable: false },
            'T24_ERROR': { status: 502, message: 'Bad Gateway', retryable: true },
            'COMMUNICATION_ERROR': { status: 502, message: 'Bad Gateway', retryable: true },
            'SYSTEM_UNAVAILABLE': { status: 503, message: 'Service Unavailable', retryable: true },
            'MAINTENANCE_MODE': { status: 503, message: 'Service Unavailable', retryable: true },
            'MEMORY_INSUFFICIENT': { status: 507, message: 'Insufficient Storage', retryable: true },
            'DISK_FULL': { status: 507, message: 'Insufficient Storage', retryable: true }
        };
        
        this.retryConfig = {
            408: { maxRetries: 3, interval: 30000 },  // 30 segundos
            502: { maxRetries: 3, interval: 30000 },  // 30 segundos
            503: { maxRetries: 5, interval: 60000 },  // 60 segundos
            507: { maxRetries: 2, interval: 120000 }  // 120 segundos
        };
    }
    
    mapError(errorCode, errorMessage, region = 'HN01') {
        const mapping = this.errorMappings[errorCode] || {
            status: 500,
            message: 'Internal Server Error',
            retryable: false
        };
        
        return {
            error: {
                code: errorCode,
                message: this.getLocalizedMessage(errorCode, errorMessage, region),
                httpStatus: mapping.status,
                httpMessage: mapping.message,
                retryable: mapping.retryable,
                timestamp: new Date().toISOString(),
                region: region,
                ...(mapping.retryable && this.retryConfig[mapping.status] && {
                    retryConfig: this.retryConfig[mapping.status]
                })
            }
        };
    }
    
    getLocalizedMessage(errorCode, originalMessage, region) {
        const messages = {
            'HN01': {
                'TIMEOUT': 'TRANSACCION EN ESPERA. REVISE SU CUENTA EN 5 MINUTOS',
                'INSUFFICIENT_FUNDS': 'FONDOS INSUFICIENTES EN LA CUENTA',
                'LOAN_CLOSED': 'EL PRESTAMO SE ENCUENTRA CERRADO',
                'INVALID_AMOUNT': 'MONTO DE PAGO INVALIDO',
                'SYSTEM_ERROR': 'ERROR EN EL SISTEMA. INTENTE MAS TARDE'
            },
            'GT01': {
                'SYSTEM_ERROR': 'ERROR EN EL SISTEMA. INTENTE MAS TARDE',
                'INVALID_LOAN': 'NUMERO DE PRESTAMO INVALIDO',
                'ACCOUNT_BLOCKED': 'CUENTA BLOQUEADA. CONTACTE AL BANCO'
            },
            'PA01': {
                'CURRENCY_MISMATCH': 'MONEDAS NO COINCIDEN',
                'PAYMENT_EXCEEDS_BALANCE': 'PAGO EXCEDE SALDO PENDIENTE'
            },
            'NI01': {
                'SYSTEM_ERROR': 'ERROR EN SISTEMA COBIS',
                'LOAN_CLOSED': 'PRESTAMO SUSPENDIDO'
            }
        };
        
        return messages[region]?.[errorCode] || originalMessage;
    }
    
    shouldRetry(httpStatus, attemptCount = 0) {
        const config = this.retryConfig[httpStatus];
        return config && attemptCount < config.maxRetries;
    }
    
    getRetryDelay(httpStatus) {
        return this.retryConfig[httpStatus]?.interval || 0;
    }
}

// Uso del mapper
const errorMapper = new ErrorMapper();

// Ejemplo de uso
const spResponse = {
    ERROR_CODE: 'TIMEOUT',
    ERROR_MESSAGE: 'Timeout en procesamiento de pago'
};

const httpResponse = errorMapper.mapError(
    spResponse.ERROR_CODE,
    spResponse.ERROR_MESSAGE,
    'HN01'
);

console.log(JSON.stringify(httpResponse, null, 2));
```

### Implementación en XQuery para OSB

```xquery
(: Función de mapeo de errores para OSB :)
declare function local:mapStoredProcedureError(
    $errorCode as xs:string,
    $errorMessage as xs:string,
    $region as xs:string
) as element() {
    
    let $httpStatus := 
        if ($errorCode = "SUCCESS") then "200"
        else if ($errorCode = ("INVALID_LOAN", "INVALID_ACCOUNT", "INVALID_AMOUNT", "INVALID_CHEQUE_NUMBER", "INVALID_BANK_CODE")) then "400"
        else if ($errorCode = ("UNAUTHORIZED", "INVALID_USER", "PASSWORD_EXPIRED")) then "401"
        else if ($errorCode = ("ACCOUNT_BLOCKED", "USER_NOT_AUTHORIZED", "ACCOUNT_RESTRICTED")) then "403"
        else if ($errorCode = ("LOAN_NOT_FOUND", "ACCOUNT_NOT_FOUND")) then "404"
        else if ($errorCode = ("TIMEOUT", "SYSTEM_TIMEOUT", "REQUEST_TIMEOUT")) then "408"
        else if ($errorCode = ("DUPLICATE_TRANSACTION", "AUTHORIZATION_REQUIRED", "CHEQUE_ALREADY_DEPOSITED")) then "409"
        else if ($errorCode = ("LOAN_CLOSED", "INSUFFICIENT_FUNDS", "PAYMENT_EXCEEDS_BALANCE", "CURRENCY_MISMATCH", "CHEQUE_EXPIRED")) then "422"
        else if ($errorCode = ("T24_ERROR", "COMMUNICATION_ERROR", "ABANKS_ERROR")) then "502"
        else if ($errorCode = ("SYSTEM_UNAVAILABLE", "T24_OFFLINE", "MAINTENANCE_MODE", "CLEARING_HOUSE_CLOSED")) then "503"
        else if ($errorCode = ("MEMORY_INSUFFICIENT", "DISK_FULL")) then "507"
        else "500"
    
    let $httpMessage := 
        if ($httpStatus = "200") then "OK"
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
    
    let $localizedMessage := 
        if ($region = "HN01") then (
            if ($errorCode = "TIMEOUT") then "TRANSACCION EN ESPERA. REVISE SU CUENTA EN 5 MINUTOS"
            else if ($errorCode = "INSUFFICIENT_FUNDS") then "FONDOS INSUFICIENTES EN LA CUENTA"
            else if ($errorCode = "LOAN_CLOSED") then "EL PRESTAMO SE ENCUENTRA CERRADO"
            else if ($errorCode = "INVALID_AMOUNT") then "MONTO DE PAGO INVALIDO"
            else if ($errorCode = "SYSTEM_ERROR") then "ERROR EN EL SISTEMA. INTENTE MAS TARDE"
            else $errorMessage
        ) else if ($region = "GT01") then (
            if ($errorCode = "SYSTEM_ERROR") then "ERROR EN EL SISTEMA. INTENTE MAS TARDE"
            else if ($errorCode = "INVALID_LOAN") then "NUMERO DE PRESTAMO INVALIDO"
            else if ($errorCode = "ACCOUNT_BLOCKED") then "CUENTA BLOQUEADA. CONTACTE AL BANCO"
            else $errorMessage
        ) else if ($region = "PA01") then (
            if ($errorCode = "CURRENCY_MISMATCH") then "MONEDAS NO COINCIDEN"
            else if ($errorCode = "PAYMENT_EXCEEDS_BALANCE") then "PAGO EXCEDE SALDO PENDIENTE"
            else $errorMessage
        ) else if ($region = "NI01") then (
            if ($errorCode = "SYSTEM_ERROR") then "ERROR EN SISTEMA COBIS"
            else if ($errorCode = "LOAN_CLOSED") then "PRESTAMO SUSPENDIDO"
            else $errorMessage
        ) else $errorMessage
    
    let $retryable := 
        if ($httpStatus = ("408", "502", "503", "507")) then "true" else "false"
    
    return
        <errorResponse>
            <httpStatus>{$httpStatus}</httpStatus>
            <httpMessage>{$httpMessage}</httpMessage>
            <error>
                <code>{$errorCode}</code>
                <message>{$localizedMessage}</message>
                <originalMessage>{$errorMessage}</originalMessage>
                <retryable>{$retryable}</retryable>
                <timestamp>{fn:current-dateTime()}</timestamp>
                <region>{$region}</region>
            </error>
        </errorResponse>
};

(: Ejemplo de uso en pipeline OSB :)
let $spErrorCode := $pagoPrestamoResponse/ERROR_CODE
let $spErrorMessage := $pagoPrestamoResponse/ERROR_MESSAGE
let $region := $requestHeader/Region/SourceBank

return 
    if ($spErrorCode = "SUCCESS") then (
        <ns0:ResponseHeader>
            <successIndicator>SUCCESS</successIndicator>
            <messages>Pago procesado exitosamente</messages>
        </ns0:ResponseHeader>
    ) else (
        let $errorMapping := local:mapStoredProcedureError($spErrorCode, $spErrorMessage, $region)
        return
            <ns0:ResponseHeader>
                <successIndicator>ERROR</successIndicator>
                <messages>{$errorMapping/error/message}</messages>
                <errorCode>{$errorMapping/error/code}</errorCode>
                <httpStatus>{$errorMapping/httpStatus}</httpStatus>
                <retryable>{$errorMapping/error/retryable}</retryable>
            </ns0:ResponseHeader>
    )
```

## Configuración de Monitoreo y Alertas

### Dashboard de Métricas de Error

```json
{
    "dashboard": {
        "name": "PagoPrestamo Error Monitoring",
        "widgets": [
            {
                "type": "errorRate",
                "title": "Error Rate by HTTP Status",
                "metrics": [
                    "http_4xx_rate",
                    "http_5xx_rate",
                    "timeout_rate"
                ],
                "thresholds": {
                    "warning": 5,
                    "critical": 10
                }
            },
            {
                "type": "errorDistribution",
                "title": "Top Error Codes",
                "metrics": [
                    "INSUFFICIENT_FUNDS",
                    "TIMEOUT",
                    "T24_ERROR",
                    "INVALID_LOAN"
                ]
            },
            {
                "type": "systemHealth",
                "title": "System Availability",
                "metrics": [
                    "t24_availability",
                    "abanks_availability",
                    "osb_availability"
                ]
            }
        ]
    }
}
```

### Configuración de Alertas

```yaml
alerts:
  - name: "High Error Rate"
    condition: "error_rate > 10%"
    severity: "critical"
    notification: ["email", "slack"]
    
  - name: "T24 System Down"
    condition: "t24_error_rate > 50%"
    severity: "critical"
    notification: ["email", "slack", "pagerduty"]
    
  - name: "High Timeout Rate"
    condition: "timeout_rate > 15%"
    severity: "warning"
    notification: ["email"]
    
  - name: "Insufficient Funds Spike"
    condition: "insufficient_funds_rate > 25%"
    severity: "info"
    notification: ["slack"]
```

## Casos de Prueba para Validación

### Test Suite para Mapeo de Errores

```javascript
describe('Error Mapping Tests', () => {
    const errorMapper = new ErrorMapper();
    
    test('should map TIMEOUT to 408', () => {
        const result = errorMapper.mapError('TIMEOUT', 'System timeout', 'HN01');
        expect(result.error.httpStatus).toBe(408);
        expect(result.error.retryable).toBe(true);
        expect(result.error.message).toBe('TRANSACCION EN ESPERA. REVISE SU CUENTA EN 5 MINUTOS');
    });
    
    test('should map INSUFFICIENT_FUNDS to 422', () => {
        const result = errorMapper.mapError('INSUFFICIENT_FUNDS', 'Not enough funds', 'HN01');
        expect(result.error.httpStatus).toBe(422);
        expect(result.error.retryable).toBe(false);
    });
    
    test('should map T24_ERROR to 502 with retry', () => {
        const result = errorMapper.mapError('T24_ERROR', 'T24 communication error', 'HN01');
        expect(result.error.httpStatus).toBe(502);
        expect(result.error.retryable).toBe(true);
        expect(result.error.retryConfig.maxRetries).toBe(3);
    });
    
    test('should handle unknown error codes', () => {
        const result = errorMapper.mapError('UNKNOWN_ERROR', 'Unknown error', 'HN01');
        expect(result.error.httpStatus).toBe(500);
        expect(result.error.retryable).toBe(false);
    });
});
```

Este archivo complementa la tabla de mapeo principal con ejemplos prácticos de implementación, casos de uso específicos y herramientas de monitoreo para asegurar una correcta homologación de errores de los stored procedures a códigos HTTP estándar.