# Ejemplos y Mapeos — Región HN01 — GetFundPensionClient

## Request OSB (JSON — REST)

```json
{
  "GeneralInfo": {
    "SourceBank": "HN01",
    "DestinationBank": "HN01",
    "GlobalId": "550e8400-e29b-41d4-a716-446655440000",
    "Language": "ES",
    "ApplicationId": "CANAL_APP"
  },
  "IdentificationType": "CC",
  "IdentificationNumber": "0801199900001",
  "Clientcode": "12345"
}
```

## Response OSB — Caso Exitoso (JSON)

```json
{
  "StatusInfo": {
    "Status": "Success",
    "TransactionId": "",
    "ValueDate": "2024-01-15",
    "DateTime": "2024-01-15T10:30:00",
    "GlobalId": "550e8400-e29b-41d4-a716-446655440000"
  },
  "Data": {
    "Client": {
      "IdentificationType": "CC",
      "IdentificationNumber": "0801199900001",
      "Clientcode": "12345",
      "Accounts": [
        {
          "AccountCode": "001-123456-001",
          "CurrencyCode": "HNL",
          "CurrencyName": "Lempira",
          "CodeProductLine": "FPC",
          "ProductLineName": "Fondo de Pensiones",
          "ProductCode": "FPC-001",
          "ProductName": "Pensión Obligatoria",
          "Alternative": "ALT-001"
        }
      ]
    }
  }
}
```

## Response OSB — Caso Error (JSON)

```json
{
  "StatusInfo": {
    "Status": "Error",
    "TransactionId": "",
    "ValueDate": "2024-01-15",
    "DateTime": "2024-01-15T10:30:00",
    "GlobalId": "550e8400-e29b-41d4-a716-446655440000"
  },
  "ErrorInfo": {
    "Code": "ERR-001",
    "Error": "Cliente no encontrado",
    "Description": "No se encontraron fondos de pensión para el cliente",
    "ShortDescription": "Sin fondos",
    "DateTime": "2024-01-15T10:30:00",
    "GlobalId": "550e8400-e29b-41d4-a716-446655440000",
    "Details": {
      "SystemId": "OSB",
      "SystemStatus": "Error",
      "MessageId": "MW-0001",
      "Messages": "No se encontraron fondos de pensión"
    }
  }
}
```

---

## Request SOAP 11g (Formato legado)

```xml
<con:consultaFondosPensionesClienteRequest xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaFondosPensionesClienteTypes">
  <con:CUSTOMER_ID_TYPE>1</con:CUSTOMER_ID_TYPE>
  <con:CUSTOMER_ID_VALUE>0801199900001</con:CUSTOMER_ID_VALUE>
  <con:CUSTOMER_CODE>12345</con:CUSTOMER_CODE>
</con:consultaFondosPensionesClienteRequest>
```

## Response SOAP 11g (Formato legado)

```xml
<con:consultaFondosPensionesClienteResponse xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaFondosPensionesClienteTypes">
  <con:CUSTOMER_ID_TYPE>CC</con:CUSTOMER_ID_TYPE>
  <con:CUSTOMER_ID_VALUE>0801199900001</con:CUSTOMER_ID_VALUE>
  <con:CUSTOMER_CODE>12345</con:CUSTOMER_CODE>
  <con:ACCOUNT_INFO>
    <con:ACCOUNT_ITEM>
      <con:ACCOUNT_NUMBER>001-123456-001</con:ACCOUNT_NUMBER>
      <con:CURRENCY_CODE>HNL</con:CURRENCY_CODE>
      <con:CURRENCY_NAME>Lempira</con:CURRENCY_NAME>
      <con:PRODUCT_CODE>FPC</con:PRODUCT_CODE>
      <con:PRODUCT_NAME>Fondo de Pensiones</con:PRODUCT_NAME>
      <con:SUBPRODUCT_CODE>FPC-001</con:SUBPRODUCT_CODE>
      <con:SUBPRODUCT_NAME>Pensión Obligatoria</con:SUBPRODUCT_NAME>
      <con:ACCOUNT_CODE>ALT-001</con:ACCOUNT_CODE>
    </con:ACCOUNT_ITEM>
  </con:ACCOUNT_INFO>
</con:consultaFondosPensionesClienteResponse>
```

---

## Cadenas de Conexión

| Servicio | Tipo | Endpoint/Referencia | Operación |
|----------|------|---------------------|-----------|
| GetFundPensionClientRestBS | REST API | `https://mwservices.gfficohsa.hn:8020/country/pension/rest/getFundPensionClient/v1` | POST `/` |
| GetFundPensionClient12BS | SOAP | `https://mwservices.gfficohsa.hn:8020/regional/pension/soap/getFundPensionClient/v1` | `getFundPensionClient` |
| GetCountryURLByNameRestBS | REST interno | `SBRG_Pension_Commons/BS/GetCountryURLByNameRestBS` | `GetCountryURLByName` |
| LoggingRegionalRestBS | REST interno | `SBRG_Pension_Commons/BS/LoggingRegionalRestBS` | `SaveLogInFileSystem` |
| GetCustomErrorByStackTraceRegionalRestBS | REST interno | `SBRG_Pension_Commons/BS/GetCustomErrorByStackTraceRegionalRestBS` | `process` |

---

## Tablas de Mapeo de Entrada — Request Regional → Backend REST

El pipeline **no aplica transformación XQuery** al request. El body se pasa directamente:

```xquery
$body/pen:getFundPensionClient
```

| Campo Origen (OSB) | Transformación | Campo Destino (Backend) |
|--------------------|----------------|-------------------------|
| `getFundPensionClient/GeneralInfo` | Directo | `GeneralInfo` |
| `getFundPensionClient/IdentificationType` | Directo | `IdentificationType` |
| `getFundPensionClient/IdentificationNumber` | Directo | `IdentificationNumber` |
| `getFundPensionClient/Clientcode` | Directo | `Clientcode` |

## Tablas de Mapeo de Salida — Backend REST → Response Regional

El pipeline **no aplica transformación XQuery** al response. Se retorna directamente:

```xquery
$responseService
```

El backend retorna directamente el formato `getFundPensionClientResponse` con `StatusInfo`, `ErrorInfo` y `Data`.

---

## Mapeo 11g → Regional (Virtual11gToRegional.Xquery)

| Campo Origen (11g) | Transformación | Campo Destino (Regional) |
|--------------------|----------------|--------------------------|
| `$sourceBank` | Directo | `GeneralInfo/SourceBank` |
| `$destinationBank` | Directo | `GeneralInfo/DestinationBank` |
| `$userName` | Directo | `GeneralInfo/ApplicationId` y `GeneralInfo/ApplicationUser` |
| `$legalIdType` (resultado de ConvertIdType) | Conversión numérico→texto | `IdentificationType` |
| `CUSTOMER_ID_VALUE` | Directo | `IdentificationNumber` |
| `CUSTOMER_CODE` | Directo | `Clientcode` |

## Mapeo Regional → 11g Body (RegionalToVirtualBody11gHN.Xquery)

| Campo Origen (Regional) | Transformación | Campo Destino (11g) |
|-------------------------|----------------|---------------------|
| `Data/Client/IdentificationType` | Directo | `CUSTOMER_ID_TYPE` |
| `Data/Client/IdentificationNumber` | Directo | `CUSTOMER_ID_VALUE` |
| `Data/Client/Clientcode` | Directo | `CUSTOMER_CODE` |
| `Data/Client/Accounts[]/AccountCode` | for-each | `ACCOUNT_INFO/ACCOUNT_ITEM/ACCOUNT_NUMBER` |
| `Data/Client/Accounts[]/CurrencyCode` | for-each | `ACCOUNT_INFO/ACCOUNT_ITEM/CURRENCY_CODE` |
| `Data/Client/Accounts[]/CurrencyName` | for-each | `ACCOUNT_INFO/ACCOUNT_ITEM/CURRENCY_NAME` |
| `Data/Client/Accounts[]/CodeProductLine` | for-each | `ACCOUNT_INFO/ACCOUNT_ITEM/PRODUCT_CODE` |
| `Data/Client/Accounts[]/ProductLineName` | for-each | `ACCOUNT_INFO/ACCOUNT_ITEM/PRODUCT_NAME` |
| `Data/Client/Accounts[]/ProductCode` | for-each | `ACCOUNT_INFO/ACCOUNT_ITEM/SUBPRODUCT_CODE` |
| `Data/Client/Accounts[]/ProductName` | for-each | `ACCOUNT_INFO/ACCOUNT_ITEM/SUBPRODUCT_NAME` |
| `Data/Client/Accounts[]/Alternative` | for-each | `ACCOUNT_INFO/ACCOUNT_ITEM/ACCOUNT_CODE` |

## Mapeo Regional → 11g Header (RegionalToVirtualHeader11gHN.Xquery)

| Condición | Campo Destino (11g Header) | Valor |
|-----------|---------------------------|-------|
| `Status != SUCCESS` | `ResponseHeader/messageId` | `ErrorInfo/Error` |
| `Status = SUCCESS` | `ResponseHeader/successIndicator` | `StatusInfo/Status` |
| `Status = ERROR` | `ResponseHeader/successIndicator` | `ERROR` (uppercase) |
| Otro | `ResponseHeader/successIndicator` | `NO RECORDS` |
| `Status != SUCCESS` | `ResponseHeader/messages` | `ErrorInfo/Description` |

---

## Reglas de Negocio Detectadas

### 1. Conversión de tipo de identificación (11g)

**Ubicación**: `ConvertIdType.Xquery`

```xquery
1 → CC
9 → NIT
4 → PAS
2 → CAR
(otro) → valor original sin cambio
```

### 2. Regionalización dinámica

**Ubicación**: Template `PensionRegionalTemplateFicohsa` — Stage `StageRegionalitation`

Si `GetCountryURLByNameRestBS` retorna `"N/A"` → error `MW-0008: SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY`.

### 3. Inyección de código HTTP en error REST

**Ubicación**: Template — Stage `StageReplaceCodeError`

Si `method='REST'` y `StatusInfo/Status != 'SUCCESS'` → inyecta `ErrorInfo/Code` como código HTTP de respuesta.

### 4. Determinación del método (REST vs SOAP)

**Ubicación**: Pipeline `GetFundPensionClientPP` — override `method`

```xquery
if(fn:matches($inbound/ctx:transport/ctx:uri/text(), '/rest/')) then 'REST'
else 'SOAP'
```

### 5. Determinación del usuario

**Ubicación**: Pipeline `GetFundPensionClientPP` — override `user`

```xquery
if($userContext = "" and $headerAuthorization != "") then $applicationId
else $userContext
```
