# Listado de XQueries — FPCWithdrawalConsultation

## Segmentación por País

### Honduras (HN01) — Única región

Todas las XQueries aplican exclusivamente para HN01.

---

## 1. FPCWithdrawalConsultationToCloudCodeRestBS.Xquery

**Ruta**: `SBHN_Pension_FPCWithdrawalConsultation/Transformations/FPCWithdrawalConsultationToCloudCodeRestBS.Xquery`

**Propósito**: Transforma el request regional (formato Ficohsa) al formato esperado por la API de CloudCode (AFP Ficohsa).

**Entrada**: Elemento `ns1:FPCWithdrawalConsultation` (schema: FPCWithdrawalConsultationTypes.xsd, APIFPCTypes.xsd)

**Salida**: Elemento `ns1:CloudCode`

### Transformación de Campos

| Campo Entrada | Transformación | Campo Salida |
|---------------|----------------|--------------|
| `FPCWithdrawalConsultation/RequestNumber` | `fn:data()` — extracción directa | `CloudCode/numeroSolicitud` |
| `FPCWithdrawalConsultation/ClientId` | `fn:data()` — extracción directa | `CloudCode/numeroIdentificacion` |

### Análisis

- Transformación simple 1:1 sin lógica de negocio adicional.
- Los campos `GeneralInfo` del request original no se mapean al backend (solo se usan para logging y trazabilidad).

---

## 2. CloudCodeRestToFPCWithdrawalConsultation.Xquery

**Ruta**: `SBHN_Pension_FPCWithdrawalConsultation/Transformations/CloudCodeRestToFPCWithdrawalConsultation.Xquery`

**Propósito**: Transforma la respuesta exitosa de CloudCode al formato de respuesta regional estándar.

**Entrada**: 
- `$CloudCodeRestResponse` — Elemento `pen:CloudCodeResponse`
- `$StatusService` — String (valor: 'Success')
- `$GlobalId` — String (UUID de trazabilidad)

**Salida**: Elemento `pen:FPCWithdrawalConsultationResponse`

### Transformación de Campos

| Campo Entrada | Transformación | Campo Salida |
|---------------|----------------|--------------|
| `$StatusService` | Directo | `StatusInfo/Status` |
| (generado) | `fn:substring(fn:string(fn:current-dateTime()),0,20)` | `StatusInfo/ValueDate` |
| (generado) | `fn:substring(fn:string(fn:current-dateTime()),0,11)` | `StatusInfo/DateTime` |
| `$GlobalId` | Directo | `StatusInfo/GlobalId` |
| `CloudCodeResponse/datos/retiros/cuenta` | `fn:data()` | `Account` |
| `CloudCodeResponse/datos/retiros/nombreCliente` | `fn:data()` | `ClientName` |
| `CloudCodeResponse/datos/retiros/numeroIdentificacion` | `fn:data()` | `IdNumber` |
| `CloudCodeResponse/datos/retiros/formaPago` | `fn:data()` | `PaymentMethod` |
| `CloudCodeResponse/datos/retiros/moneda` | `fn:data()` | `Currency` |
| `CloudCodeResponse/datos/retiros/monto` | `fn:data()` | `Amount` |
| `CloudCodeResponse/datos/retiros/tipoRetiro` | `fn:data()` | `WithdrawalType` |
| `CloudCodeResponse/datos/retiros/cuentaBancaria` | `fn:data()` | `BankingAccount` |

### Análisis

- `StatusInfo/TransactionId` se deja vacío (no proporcionado por CloudCode).
- `ValueDate` usa formato datetime (19 chars: `2024-01-15T10:30:00`).
- `DateTime` usa formato date (10 chars: `2024-01-15`).
- Mapeo directo sin transformaciones de negocio.

---

## 3. ErrorMapeoRegionalToFPCWithdrawalConsultation.Xquery

**Ruta**: `SBHN_Pension_FPCWithdrawalConsultation/Transformations/ErrorMapeoRegionalToFPCWithdrawalConsultation.Xquery`

**Propósito**: Construye la respuesta de error en formato regional a partir del resultado del mapeo de errores.

**Entrada**:
- `$ErrorMapeoRegionalOutput` — Elemento `ns1:errorMappingRegionalOutput` (schema: ErrorMappingRegional.xsd)
- `$errorCode` — String (código de error del sistema origen)
- `$errorMessage` — String (mensaje de error original)
- `$targuetSystem` — String (sistema que generó el error: 'APIFPC' u 'OSB')
- `$StatusService` — String ('Error' o 'ERROR')
- `$GlobalId` — String (UUID de trazabilidad)

**Salida**: Elemento `ns2:FPCWithdrawalConsultationResponse`

### Transformación de Campos

| Campo Entrada | Transformación | Campo Salida |
|---------------|----------------|--------------|
| `$StatusService` | Directo | `StatusInfo/Status` |
| (generado) | `fn:substring(fn:string(fn:current-dateTime()),0,11)` | `StatusInfo/ValueDate` |
| (generado) | `fn:substring(fn:string(fn:current-dateTime()),0,20)` | `StatusInfo/DateTime` |
| `$GlobalId` | Directo | `StatusInfo/GlobalId` |
| `$ErrorMapeoRegionalOutput/code` | `fn:data()` | `ErrorInfo/Code` |
| `$ErrorMapeoRegionalOutput/error` | `fn:data()` | `ErrorInfo/Error` |
| `$ErrorMapeoRegionalOutput/description` | `fn:data()` | `ErrorInfo/Description` |
| `$ErrorMapeoRegionalOutput/shortDescription` | `fn:data()` | `ErrorInfo/ShortDescription` |
| (generado) | `fn:substring(fn:string(fn:current-dateTime()),0,20)` | `ErrorInfo/DateTime` |
| `$GlobalId` | Directo | `ErrorInfo/GlobalId` |
| `$targuetSystem` | Directo | `ErrorInfo/Details/SystemId` |
| `$StatusService` | Directo | `ErrorInfo/Details/SystemStatus` |
| `$errorCode` | Directo | `ErrorInfo/Details/MessageId` |
| `$errorMessage` | Directo | `ErrorInfo/Details/Messages` |

### Análisis

- Se usa tanto para errores del backend (APIFPC) como para errores internos de OSB.
- `StatusInfo/TransactionId` se deja vacío.
- Los campos de negocio (Account, ClientName, etc.) no se incluyen en la respuesta de error.
- Nota: el parámetro se llama `$targuetSystem` (typo en el código fuente, debería ser `targetSystem`).

---

## 4. ExtractCredentialsAPIFPC.Xquery (Commons)

**Ruta**: `SBHN_Pension_Commons/Transformations/ExtractCredentialsAPIFPC.Xquery`

**Propósito**: Extrae usuario y contraseña del OSB Security Store para la cuenta de servicio indicada.

**Entrada**: `$account` — Elemento `ns1:serviceAccount` con `accountName`

**Salida**: Elemento `ns1:credentials` con `userName` y `userPassword`

### Lógica

```xquery
fn-bea:lookupBasicCredentials(concat("SB_Security/Common/", upper-case($LDAPId)))
```

- Busca en el Security Store de OSB la entrada `SB_Security/Common/{ACCOUNT_NAME_UPPERCASE}`.
- Usa `fn-bea:fail-over()` para retornar el nombre de cuenta como fallback si no se encuentran credenciales.

---

## 5. ServiceToCloudCodeLogin.Xquery (Commons)

**Ruta**: `SBHN_Pension_Commons/Transformations/ServiceToCloudCodeLogin.Xquery`

**Propósito**: Construye el request de login para CloudCode.

**Entrada**:
- `$credentials` — Elemento con `userName` y `userPassword`
- `$forceLogin` — Boolean

**Salida**: Elemento `ns1:cloudCodeLoginRequest`

### Transformación de Campos

| Campo Entrada | Transformación | Campo Salida |
|---------------|----------------|--------------|
| `credentials/userName` | `fn:data()` | `userName` |
| `credentials/userPassword` | `fn:data()` | `password` |
| (generado) | `fn-bea:dateTime-from-string-with-format("yyyy-MM-dd'T'HH:mm:ss", current-dateTime())` | `timestamp` |
| `$forceLogin` | `fn:data()` | `forceLogin` |
