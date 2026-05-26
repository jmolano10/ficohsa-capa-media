# Listado de XQueries: HistoricalBankStatemen

## Honduras (HN01)

### 1. HistoricalBankStatemenToCloudCode.xqy

**Ruta**: `SBHN_Pension_HistoricalBankStatemen/Transformation/HistoricalBankStatemenToCloudCode.xqy`

**Propósito**: Convertir el request regional al formato CloudCode API para la operación estadoCuentasHistoricos.

**Etapa**: StageTransformationsRequest

**Análisis detallado**:
- Recibe los campos del request regional (IdentificationType, IdentificationNumber, StartDate, EndDate)
- Aplica homologación del tipo de identificación:
  - `1` → `CC` (Cédula de Ciudadanía)
  - `2` → `CAR` (Carnet)
  - `4` → `PAS` (Pasaporte)
  - `5` → `NIT` (Número de Identificación Tributaria)
  - Si no hay equivalencia → usa el valor original
- Construye el body JSON para CloudCode

**Campos de entrada**:

| Campo Entrada | Campo Salida |
|---------------|--------------|
| `IdentificationType` | `tipoIdentificacion` (homologado) |
| `IdentificationNumber` | `numeroIdentificacion` |
| `StartDate` | `fechaInicio` |
| `EndDate` | `fechaFinal` |

---

### 2. CloudCodeToHistoricalBankStatemen.xqy

**Ruta**: `SBHN_Pension_HistoricalBankStatemen/Transformation/CloudCodeToHistoricalBankStatemen.xqy`

**Propósito**: Convertir la respuesta de CloudCode al formato regional estándar.

**Etapa**: StageTargetSystemToRegional

**Análisis detallado**:
- Evalúa el campo `error` del response: si es `"false"` → StatusService = "Success", sino → StatusService = valor del campo
- Mapea el campo `mensaje` a `Data/Message`
- Itera sobre `datos/estadoCuenta` (for loop principal)
- Dentro de cada estadoCuenta, itera sobre `movimientos[]` (for loop anidado)
- Dentro de cada movimiento, itera sobre `transacciones[]` (for loop doblemente anidado)
- Propaga el `GlobalId` desde el request original

**Campos de entrada → salida**:

| Campo CloudCode | Campo Regional |
|-----------------|----------------|
| `mensaje` | `Data/Message` |
| `datos/estadoCuenta/fecha` | `Data/Data/StatusAccount/Date` |
| `datos/estadoCuenta/nombreCliente` | `Data/Data/StatusAccount/NameClient` |
| `datos/estadoCuenta/emailCliente` | `Data/Data/StatusAccount/EmailClient` |
| `datos/estadoCuenta/numeroCliente` | `Data/Data/StatusAccount/CustomerNumber` |
| `movimientos[]/moneda` | `Movements[]/Currency` |
| `movimientos[]/cuenta` | `Movements[]/Account` |
| `movimientos[]/rendimiento` | `Movements[]/Yield` |
| `movimientos[]/totalPersonal` | `Movements[]/TotalStaff` |
| `movimientos[]/totalPatronal` | `Movements[]/TotalEmployee` |
| `movimientos[]/granTotal` | `Movements[]/GrandTotal` |
| `transacciones[]/fecha` | `Transactions[]/Date` |
| `transacciones[]/tipoMovimiento` | `Transactions[]/TypeMovement` |
| `transacciones[]/descripcionTransaccion` | `Transactions[]/DescriptionTransaction` |
| `transacciones[]/movimientoPersonal` | `Transactions[]/MovementStaff` |
| `transacciones[]/movimientoPatronal` | `Transactions[]/EmployerMovement` |
| `transacciones[]/movimientoTotal` | `Transactions[]/TotalMovement` |

---

### 3. ErrorToHistoricalBankStatemen.xqy

**Ruta**: `SBHN_Pension_HistoricalBankStatemen/Transformation/ErrorToHistoricalBankStatemen.xqy`

**Propósito**: Mapear errores de CloudCode al formato regional estándar.

**Etapa**: StageTargetSystemToRegional (caso de error) / ErrorToRespuesta

**Análisis detallado**:
- Recibe la respuesta del servicio de mapeo de errores (GetCustomErrorByStackTrace)
- Construye la respuesta de error con los campos: errorCode, errorMessage, targetSystem, status, globalId
- Establece StatusService = "Error"

**Parámetros**:

| Parámetro | Descripción |
|-----------|-------------|
| `responseError` | Respuesta del servicio de mapeo de errores |
| `errorCode` | Código de error original |
| `errorMessage` | Mensaje de error original |
| `targetSystem` | Sistema origen del error |
| `status` | "Error" |
| `globalId` | Identificador global para trazabilidad |

---

## XQueries Comunes (SBHN_Pension_Commons)

### 4. ExtractCredentialsAPIFPC.xqy

**Ruta**: `SBHN_Pension_Commons/Transformations/ExtractCredentialsAPIFPC.xqy`

**Propósito**: Extraer y desencriptar credenciales para autenticación en CloudCode.

**Entrada**: serviceAccount con accountName (obtenido de GetParametersRestBS)
**Salida**: Credenciales desencriptadas para CloudCodeLoginPS

---

### 5. ServiceToCloudCodeLogin.xqy

**Ruta**: `SBHN_Pension_Commons/Transformations/ServiceToCloudCodeLogin.xqy`

**Propósito**: Preparar el request para CloudCodeLoginPS.

**Parámetros de salida**:
- `forceLogin`: "false" (normal) / "true" (re-autenticación tras 401)
- `credentials`: Credenciales encriptadas

---

### 6. ServiceToParameters.xqy

**Ruta**: `SBHN_Pension_Commons/Transformations/ServiceToParameters.xqy`

**Propósito**: Preparar el request para GetParametersRestBS.

**Parámetro de salida**: `parameterName` = "PG13516.SERVICE.ACCOUNT.APIFPC"

---

### 7. ServicesToError.xqy

**Ruta**: `SBHN_Pension_Commons/Transformations/ServicesToError.xqy`

**Propósito**: Preparar el request para GetCustomErrorByStackTraceRegionalRestBS.

**Parámetros de salida**:
- `systemApplication`: Sistema origen
- `service`: Nombre del servicio
- `errorMessage`: Mensaje de error
- `errorCode`: Código de error
- `language`: Idioma de respuesta
