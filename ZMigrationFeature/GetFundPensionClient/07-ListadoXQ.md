# Listado de XQueries — GetFundPensionClient

## Segmentación por País

### Honduras (HN01) — Única región detectada

Todas las XQueries aplican para HN01. Las XQueries `RegionalToVirtualBody11gHN` y `RegionalToVirtualHeader11gHN` tienen el sufijo `HN` indicando que son específicas de Honduras.

---

## 1. ConvertIdType.Xquery

**Ruta**: `SBRG_Pension_GetFundPensionClient/Transformations/ConvertIdType.Xquery`

**Propósito**: Convierte el código numérico de tipo de identificación (formato 11g) al código textual estándar regional. Usada exclusivamente en el flujo 11g.

**Entrada**: `$idType` — String (código numérico)

**Salida**: String (código textual)

### Tabla de Conversión

| Código Numérico (11g) | Código Textual (Regional) |
|-----------------------|---------------------------|
| `1` | `CC` (Cédula de Ciudadanía) |
| `9` | `NIT` (Número de Identificación Tributaria) |
| `4` | `PAS` (Pasaporte) |
| `2` | `CAR` (Carné) |
| Otro | Valor original sin cambio |

### Análisis

- Tabla de homologación hardcodeada en el XQuery (no en base de datos).
- Si el código no está en la tabla, retorna el valor original — no lanza error.

---

## 2. Virtual11gToRegional.Xquery

**Ruta**: `SBRG_Pension_GetFundPensionClient/Transformations/Virtual11gToRegional.Xquery`

**Propósito**: Transforma el request del formato legado 11g (`consultaFondosPensionesClienteRequest`) al formato regional estándar (`getFundPensionClient`).

**Entradas**:
- `$request11g` — Elemento `consultaFondosPensionesClienteRequest`
- `$sourceBank` — String
- `$destinationBank` — String
- `$userName` — String
- `$legalIdType` — String (resultado de ConvertIdType)

**Salida**: Elemento `getFundPensionClient`

### Transformación de Campos

| Campo Entrada | Transformación | Campo Salida |
|---------------|----------------|--------------|
| `$sourceBank` | Directo | `GeneralInfo/SourceBank` |
| `$destinationBank` | Directo | `GeneralInfo/DestinationBank` |
| `$userName` | Directo | `GeneralInfo/ApplicationId` |
| `$userName` | Directo | `GeneralInfo/ApplicationUser` |
| `$legalIdType` | Resultado de ConvertIdType | `IdentificationType` |
| `CUSTOMER_ID_VALUE` | Directo | `IdentificationNumber` |
| `CUSTOMER_CODE` | Directo | `Clientcode` |

### Análisis

- `GeneralInfo/GlobalId`, `Language`, `BranchId`, `TransactionDate` no se mapean desde 11g (quedan vacíos).
- El `ApplicationId` y `ApplicationUser` se asignan con el mismo valor `$userName`.

---

## 3. RegionalToVirtualBody11gHN.Xquery

**Ruta**: `SBRG_Pension_GetFundPensionClient/Transformations/RegionalToVirtualBody11gHN.Xquery`

**Propósito**: Transforma el body del response regional (`getFundPensionClientResponse`) al formato legado 11g (`consultaFondosPensionesClienteResponse`).

**Entrada**: `$responseRegional` — Elemento `getFundPensionClientResponse`

**Salida**: Elemento `consultaFondosPensionesClienteResponse`

### Transformación de Campos

| Campo Origen (Regional) | Transformación | Campo Destino (11g) |
|-------------------------|----------------|---------------------|
| `Data/Client/IdentificationType` | `fn:data()` | `CUSTOMER_ID_TYPE` |
| `Data/Client/IdentificationNumber` | `fn:data()` | `CUSTOMER_ID_VALUE` |
| `Data/Client/Clientcode` | `fn:data()` | `CUSTOMER_CODE` |
| `Data/Client/Accounts[]/AccountCode` | for-each | `ACCOUNT_INFO/ACCOUNT_ITEM/ACCOUNT_NUMBER` |
| `Data/Client/Accounts[]/CurrencyCode` | for-each | `ACCOUNT_INFO/ACCOUNT_ITEM/CURRENCY_CODE` |
| `Data/Client/Accounts[]/CurrencyName` | for-each | `ACCOUNT_INFO/ACCOUNT_ITEM/CURRENCY_NAME` |
| `Data/Client/Accounts[]/CodeProductLine` | for-each | `ACCOUNT_INFO/ACCOUNT_ITEM/PRODUCT_CODE` |
| `Data/Client/Accounts[]/ProductLineName` | for-each | `ACCOUNT_INFO/ACCOUNT_ITEM/PRODUCT_NAME` |
| `Data/Client/Accounts[]/ProductCode` | for-each | `ACCOUNT_INFO/ACCOUNT_ITEM/SUBPRODUCT_CODE` |
| `Data/Client/Accounts[]/ProductName` | for-each | `ACCOUNT_INFO/ACCOUNT_ITEM/SUBPRODUCT_NAME` |
| `Data/Client/Accounts[]/Alternative` | for-each | `ACCOUNT_INFO/ACCOUNT_ITEM/ACCOUNT_CODE` |

### Análisis

- Itera sobre todos los elementos `Accounts` del response regional.
- Los campos `OPENING_DATE` y `TOTAL_BALANCE` del schema 11g no se mapean (no existen en el response regional).

---

## 4. RegionalToVirtualHeader11gHN.Xquery

**Ruta**: `SBRG_Pension_GetFundPensionClient/Transformations/RegionalToVirtualHeader11gHN.Xquery`

**Propósito**: Transforma el header del response regional al formato de header 11g (`ResponseHeader`).

**Entrada**: `$responseRegional` — Elemento `getFundPensionClientResponse`

**Salida**: Elemento `ResponseHeader` (namespace `http://www.ficohsa.com.hn/middleware.services/autType`)

### Lógica de Transformación

| Condición | Campo Salida | Valor |
|-----------|-------------|-------|
| `Status != SUCCESS` | `messageId` | `ErrorInfo/Error` |
| `Status = SUCCESS` | `successIndicator` | `StatusInfo/Status` (tal cual) |
| `Status = ERROR` | `successIndicator` | `ERROR` (uppercase forzado) |
| Otro (ej: vacío) | `successIndicator` | `NO RECORDS` |
| `Status != SUCCESS` | `messages` | `ErrorInfo/Description` |

---

## 5. ErrorToGetFundPensionClient.Xquery

**Ruta**: `SBRG_Pension_GetFundPensionClient/Transformations/ErrorToGetFundPensionClient.Xquery`

**Propósito**: Construye la respuesta de error en formato regional a partir del resultado del mapeo de errores.

**Entradas**:
- `$responseError` — Elemento `errorMappingRegionalOutput`
- `$errorCode` — String
- `$errorMessage` — String
- `$targetSystem` — String (ej: 'OSB')
- `$status` — String (ej: 'Error')
- `$globalId` — String (UUID)

**Salida**: Elemento `getFundPensionClientResponse`

### Transformación de Campos

| Campo Entrada | Transformación | Campo Salida |
|---------------|----------------|--------------|
| `$status` | Directo | `StatusInfo/Status` |
| (generado) | `fn:substring(fn:string(fn:current-dateTime()),0,11)` | `StatusInfo/ValueDate` |
| (generado) | `fn:substring(fn:string(fn:current-dateTime()),0,20)` | `StatusInfo/DateTime` |
| `$globalId` | Directo | `StatusInfo/GlobalId` |
| `$responseError/code` | `fn:data()` | `ErrorInfo/Code` |
| `$responseError/error` | `fn:data()` | `ErrorInfo/Error` |
| `$responseError/description` | `fn:data()` | `ErrorInfo/Description` |
| `$responseError/shortDescription` | `fn:data()` | `ErrorInfo/ShortDescription` |
| (generado) | `fn:substring(fn:string(fn:current-dateTime()),0,20)` | `ErrorInfo/DateTime` |
| `$globalId` | Directo | `ErrorInfo/GlobalId` |
| `$targetSystem` | Directo | `ErrorInfo/Details/SystemId` |
| `$status` | Directo | `ErrorInfo/Details/SystemStatus` |
| `$errorCode` | Directo | `ErrorInfo/Details/MessageId` |
| `$errorMessage` | Directo | `ErrorInfo/Details/Messages` |
