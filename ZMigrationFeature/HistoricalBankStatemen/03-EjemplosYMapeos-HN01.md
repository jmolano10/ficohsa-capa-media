# Ejemplos y Mapeos: Honduras (HN01) - HistoricalBankStatemen

## Request OSB (ejemplo JSON)

```json
{
  "historicalBankStatement": {
    "GeneralInfo": {
      "SourceBank": "HN01",
      "DestinationBank": "HN01",
      "GlobalId": "TXN-12345-67890",
      "ApplicationId": "PENSION_APP",
      "ApplicationUser": "SYSTEM_USER",
      "Language": "ES"
    },
    "IdentificationType": "1",
    "IdentificationNumber": "0801199012345",
    "StartDate": "2024-01-01",
    "EndDate": "2024-06-30"
  }
}
```

## Response OSB (ejemplo JSON - Exitoso)

```json
{
  "historicalBankStatementResponse": {
    "StatusInfo": {
      "Status": "Success",
      "GlobalId": "TXN-12345-67890"
    },
    "Data": {
      "Message": "Consulta exitosa",
      "Data": {
        "StatusAccount": {
          "Date": "2024-06-30",
          "NameClient": "Juan Carlos Pérez García",
          "EmailClient": "juan.perez@email.com",
          "CustomerNumber": "CLI-001234",
          "Movements": [
            {
              "Currency": "HNL",
              "Account": "1234567890",
              "Yield": "5000.00",
              "TotalStaff": "25000.00",
              "TotalEmployee": "37500.00",
              "GrandTotal": "67500.00",
              "Transactions": [
                {
                  "Date": "2024-03-15",
                  "TypeMovement": "APORTE",
                  "DescriptionTransaction": "Aporte mensual marzo 2024",
                  "MovementStaff": "5000.00",
                  "EmployerMovement": "7500.00",
                  "TotalMovement": "12500.00"
                },
                {
                  "Date": "2024-04-15",
                  "TypeMovement": "APORTE",
                  "DescriptionTransaction": "Aporte mensual abril 2024",
                  "MovementStaff": "5000.00",
                  "EmployerMovement": "7500.00",
                  "TotalMovement": "12500.00"
                }
              ]
            }
          ]
        }
      }
    }
  }
}
```

## Request al Servicio Backend (CloudCode API)

**Endpoint**: `POST https://apidev.afpficohsa.com/api/v2/estados-cuentas/historicos`

**Headers**:
- `Authorization`: Bearer {token_cloudcode}
- `Content-Type`: application/json

**Body**:
```json
{
  "tipoIdentificacion": "CC",
  "numeroIdentificacion": "0801199012345",
  "fechaInicio": "2024-01-01",
  "fechaFinal": "2024-06-30"
}
```

## Response del Servicio Backend (CloudCode API)

```json
{
  "error": "false",
  "mensaje": "Consulta exitosa",
  "datos": {
    "estadoCuenta": {
      "fecha": "2024-06-30",
      "nombreCliente": "Juan Carlos Pérez García",
      "emailCliente": "juan.perez@email.com",
      "numeroCliente": "CLI-001234",
      "movimientos": [
        {
          "moneda": "HNL",
          "cuenta": "1234567890",
          "rendimiento": "5000.00",
          "totalPersonal": "25000.00",
          "totalPatronal": "37500.00",
          "granTotal": "67500.00",
          "transacciones": [
            {
              "fecha": "2024-03-15",
              "tipoMovimiento": "APORTE",
              "descripcionTransaccion": "Aporte mensual marzo 2024",
              "movimientoPersonal": "5000.00",
              "movimientoPatronal": "7500.00",
              "movimientoTotal": "12500.00"
            }
          ]
        }
      ]
    }
  }
}
```

## Cadenas de Conexión

| Servicio | Endpoint | Protocolo | Autenticación |
|----------|----------|-----------|---------------|
| CloudCodeRestBS | `https://apidev.afpficohsa.com/api/v2` | HTTPS/REST | Bearer Token |
| GetParametersRestBS | `https://mwservices.gfficohsa.hn:8020/regional/utility/constants/rest/GetCustomParameter/v2` | HTTPS/REST | Regional Auth |
| CloudCodeLoginPS | `SBHN_Pension_CloudCodeLogin/PS/CloudCodeLoginPS` | SOAP | Basic Auth |
| LoggingRegionalRestBS | `https://mwservices.gfficohsa.hn:8020/regional/utility/logging/rest/writeToFileSystem/v2` | HTTPS/REST | Regional Auth |
| GetCustomErrorByStackTraceRegionalRestBS | `https://mwservices.gfficohsa.hn:8020/regional/utility/constants/rest/GetCustomErrorByStackTrace/v2` | HTTPS/REST | Regional Auth |

## Tabla de Mapeo de Entrada (OSB → CloudCode)

**XQuery**: `HistoricalBankStatemenToCloudCode.xqy`

| Campo Origen (OSB) | Transformación/Script | Campo Destino (CloudCode) |
|---------------------|----------------------|---------------------------|
| `IdentificationType` | Homologación: 1→CC, 2→CAR, 4→PAS, 5→NIT. Si no hay equivalencia, usa valor original | `tipoIdentificacion` |
| `IdentificationNumber` | Directo | `numeroIdentificacion` |
| `StartDate` | Directo | `fechaInicio` |
| `EndDate` | Directo | `fechaFinal` |

## Tabla de Mapeo de Salida (CloudCode → OSB)

**XQuery**: `CloudCodeToHistoricalBankStatemen.xqy`

| Campo Origen (CloudCode) | Transformación/Script | Campo Destino (OSB) |
|--------------------------|----------------------|---------------------|
| `mensaje` | Directo | `Data/Message` |
| `datos/estadoCuenta/fecha` | Directo | `Data/Data/StatusAccount/Date` |
| `datos/estadoCuenta/nombreCliente` | Directo | `Data/Data/StatusAccount/NameClient` |
| `datos/estadoCuenta/emailCliente` | Directo | `Data/Data/StatusAccount/EmailClient` |
| `datos/estadoCuenta/numeroCliente` | Directo | `Data/Data/StatusAccount/CustomerNumber` |
| `datos/estadoCuenta/movimientos[]/moneda` | Directo (for loop) | `Movements[]/Currency` |
| `datos/estadoCuenta/movimientos[]/cuenta` | Directo (for loop) | `Movements[]/Account` |
| `datos/estadoCuenta/movimientos[]/rendimiento` | Directo (for loop) | `Movements[]/Yield` |
| `datos/estadoCuenta/movimientos[]/totalPersonal` | Directo (for loop) | `Movements[]/TotalStaff` |
| `datos/estadoCuenta/movimientos[]/totalPatronal` | Directo (for loop) | `Movements[]/TotalEmployee` |
| `datos/estadoCuenta/movimientos[]/granTotal` | Directo (for loop) | `Movements[]/GrandTotal` |
| `datos/estadoCuenta/movimientos[]/transacciones[]/fecha` | Directo (for loop anidado) | `Transactions[]/Date` |
| `datos/estadoCuenta/movimientos[]/transacciones[]/tipoMovimiento` | Directo (for loop anidado) | `Transactions[]/TypeMovement` |
| `datos/estadoCuenta/movimientos[]/transacciones[]/descripcionTransaccion` | Directo (for loop anidado) | `Transactions[]/DescriptionTransaction` |
| `datos/estadoCuenta/movimientos[]/transacciones[]/movimientoPersonal` | Directo (for loop anidado) | `Transactions[]/MovementStaff` |
| `datos/estadoCuenta/movimientos[]/transacciones[]/movimientoPatronal` | Directo (for loop anidado) | `Transactions[]/EmployerMovement` |
| `datos/estadoCuenta/movimientos[]/transacciones[]/movimientoTotal` | Directo (for loop anidado) | `Transactions[]/TotalMovement` |

**Parámetros adicionales en respuesta**:
- `StatusService`: "Success" si `error = "false"`, sino "Error"
- `GlobalId`: Propagado desde el request original

## Reglas de Negocio

| Regla | Ubicación | Descripción |
|-------|-----------|-------------|
| Homologación Tipo ID | `HistoricalBankStatemenToCloudCode.xqy` | Convierte código numérico a código alfanumérico Ficopen (1→CC, 2→CAR, 4→PAS, 5→NIT) |
| Re-autenticación 401 | Pipeline `InvokeCountry` | Si CloudCode retorna 401, se invoca CloudCodeLoginPS con `forceLogin=true` y se reintenta la operación |
| Evaluación de éxito | `CloudCodeToHistoricalBankStatemen.xqy` | Si `error = "false"` → StatusService = "Success"; sino → StatusService = valor del campo error |
| Iteración múltiple | `CloudCodeToHistoricalBankStatemen.xqy` | Soporta múltiples datos, múltiples movimientos y múltiples transacciones mediante for loops anidados |
