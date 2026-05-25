# Ejemplos y Mapeos — Región HN01 — FPCWithdrawalConsultation

## Request OSB (JSON)

```json
{
  "GeneralInfo": {
    "SourceBank": "HN01",
    "DestinationBank": "HN01",
    "GlobalId": "550e8400-e29b-41d4-a716-446655440000",
    "Language": "ES",
    "ApplicationId": "CANAL_APP"
  },
  "RequestNumber": "12345",
  "ClientId": "0801199900001"
}
```

## Response OSB — Caso Exitoso (JSON)

```json
{
  "StatusInfo": {
    "Status": "Success",
    "TransactionId": "",
    "ValueDate": "2024-01-15T10:30:00",
    "DateTime": "2024-01-15",
    "GlobalId": "550e8400-e29b-41d4-a716-446655440000"
  },
  "Account": "001-123456-001",
  "ClientName": "Juan Pérez",
  "IdNumber": "0801199900001",
  "PaymentMethod": "Transferencia",
  "Currency": "LPS",
  "Amount": 50000.00,
  "WithdrawalType": "Parcial",
  "BankingAccount": "200-456789-002"
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
    "Error": "Error de consulta",
    "Description": "No se encontraron retiros para el cliente",
    "ShortDescription": "Sin retiros",
    "DateTime": "2024-01-15T10:30:00",
    "GlobalId": "550e8400-e29b-41d4-a716-446655440000",
    "Details": {
      "SystemId": "APIFPC",
      "SystemStatus": "Error",
      "MessageId": "404",
      "Messages": "No se encontraron retiros"
    }
  }
}
```

---

## Requests/Responses Internos a Servicios Dependientes

### 1. GetParametersRestBS — Obtener Cuenta de Servicio

**Request** (construido por XQuery `ServiceToParameters`):

```xml
<parameters xmlns="https://www.ficohsa.com/regional/utility/constants">
  <parameterName>PG13516.SERVICE.ACCOUNT.APIFPC</parameterName>
</parameters>
```

**Response**:

```xml
<parametersResponse xmlns="https://www.ficohsa.com/regional/utility/constants">
  <errorCode>SUCCESS</errorCode>
  <message></message>
  <parameters>
    <parameter>
      <value>APIFPC_SERVICE_USER</value>
    </parameter>
  </parameters>
</parametersResponse>
```

### 2. CloudCodeLoginPS — Autenticación

**Request** (construido por XQuery `ServiceToCloudCodeLogin`):

```xml
<cloudCodeLoginRequest xmlns="https://www.ficohsa.com/honduras/pension/getEncryptCredentialsTypes">
  <userName>APIFPC_SERVICE_USER</userName>
  <password>****</password>
  <timestamp>2024-01-15T10:30:00</timestamp>
  <forceLogin>false</forceLogin>
</cloudCodeLoginRequest>
```

**Response**:

```xml
<cloudCodeLoginResponse xmlns="https://www.ficohsa.com/honduras/pension/getEncryptCredentialsTypes">
  <successIndicator>SUCCESS</successIndicator>
  <message>Login exitoso</message>
  <response>
    <datos xmlns="http://www.ficohsa.com.hn/honduras/cloudCodeLoginTypes">
      <token>Bearer eyJhbGciOiJIUzI1NiIs...</token>
    </datos>
  </response>
</cloudCodeLoginResponse>
```

### 3. CloudCodeRestBS — Consulta de Retiros (Servicio Backend)

**Request HTTP**:

```
GET https://apiqa.afpficohsa.com/api/v2/retiros?numeroSolicitud=12345&numeroIdentificacion=0801199900001
Authorization: Bearer eyJhbGciOiJIUzI1NiIs...
```

**Response (JSON)**:

```json
{
  "error": "false",
  "mensaje": "",
  "datos": {
    "retiros": {
      "id": "RET-001",
      "cuenta": "001-123456-001",
      "numeroIdentificacion": "0801199900001",
      "nombreCliente": "Juan Pérez",
      "formaPago": "Transferencia",
      "moneda": "LPS",
      "monto": 50000.00,
      "tipoRetiro": "Parcial",
      "cuentaBancaria": "200-456789-002"
    }
  }
}
```

### 4. GetCustomErrorByStackTraceRegionalRestBS — Mapeo de Errores

**Request** (construido por XQuery `ServicesToError`):

```xml
<errorRequest>
  <systemApplication>APIFPC</systemApplication>
  <service>Pension/FPCWithdrawalConsultation</service>
  <errorMessage>No se encontraron retiros</errorMessage>
  <errorCode>404</errorCode>
  <language>ES</language>
</errorRequest>
```

**Response**:

```xml
<errorMappingRegionalOutput xmlns="https://www.ficohsa.com/regional/constants">
  <code>ERR-001</code>
  <error>Error de consulta</error>
  <description>No se encontraron retiros para el cliente</description>
  <shortDescription>Sin retiros</shortDescription>
</errorMappingRegionalOutput>
```

---

## Cadenas de Conexión

| Servicio | Tipo | Endpoint/Referencia | Operación |
|----------|------|---------------------|-----------|
| CloudCodeRestBS | REST API | `https://apiqa.afpficohsa.com/api/v2` | GET `/retiros` |
| CloudCodeLoginPS | Proxy OSB interno | `SBHN_Pension_CloudCodeLogin/PS/CloudCodeLoginPS` | `cloudCodeLogin` |
| GetParametersRestBS | BS REST interno | `SBHN_Pension_Commons/BS/GetParametersRestBS` | `GetParameters` |
| LoggingRegionalRestBS | BS REST interno | `SBHN_Pension_Commons/BS/LoggingRegionalRestBS` | `SaveLogInFileSystem` |
| GetCustomErrorByStackTraceRegionalRestBS | BS REST interno | `SBHN_Pension_Commons/BS/GetCustomErrorByStackTraceRegionalRestBS` | `process` |
| Credenciales OSB | Security Store | `SB_Security/Common/{ACCOUNT_NAME}` | lookupBasicCredentials |

---

## Tablas de Mapeo de Entrada — Request Regional → CloudCode

### XQuery: `FPCWithdrawalConsultationToCloudCodeRestBS.Xquery`

| Campo Origen (OSB) | Transformación | Campo Destino (CloudCode) |
|---------------------|----------------|---------------------------|
| `$FPCWithdrawalConsultation/RequestNumber` | fn:data() | `numeroSolicitud` |
| `$FPCWithdrawalConsultation/ClientId` | fn:data() | `numeroIdentificacion` |

> Nota: El BS CloudCodeRestBS usa WADL que mapea estos campos como query parameters en la URL: `GET /retiros?numeroSolicitud={}&numeroIdentificacion={}`

---

## Tablas de Mapeo de Salida — CloudCode → Response Regional

### XQuery: `CloudCodeRestToFPCWithdrawalConsultation.Xquery`

| Campo Origen (CloudCode) | Transformación | Campo Destino (OSB) |
|--------------------------|----------------|---------------------|
| `$StatusService` | fn:data() | `StatusInfo/Status` |
| (generado) | `fn:substring(fn:string(fn:current-dateTime()),0,20)` | `StatusInfo/ValueDate` |
| (generado) | `fn:substring(fn:string(fn:current-dateTime()),0,11)` | `StatusInfo/DateTime` |
| `$GlobalId` | fn:data() | `StatusInfo/GlobalId` |
| `$CloudCodeRestResponse/datos/retiros/cuenta` | fn:data() | `Account` |
| `$CloudCodeRestResponse/datos/retiros/nombreCliente` | fn:data() | `ClientName` |
| `$CloudCodeRestResponse/datos/retiros/numeroIdentificacion` | fn:data() | `IdNumber` |
| `$CloudCodeRestResponse/datos/retiros/formaPago` | fn:data() | `PaymentMethod` |
| `$CloudCodeRestResponse/datos/retiros/moneda` | fn:data() | `Currency` |
| `$CloudCodeRestResponse/datos/retiros/monto` | fn:data() | `Amount` |
| `$CloudCodeRestResponse/datos/retiros/tipoRetiro` | fn:data() | `WithdrawalType` |
| `$CloudCodeRestResponse/datos/retiros/cuentaBancaria` | fn:data() | `BankingAccount` |

---

## Tablas de Mapeo de Error — Error → Response Regional

### XQuery: `ErrorMapeoRegionalToFPCWithdrawalConsultation.Xquery`

| Campo Origen | Transformación | Campo Destino (OSB) |
|--------------|----------------|---------------------|
| `$StatusService` | fn:data() | `StatusInfo/Status` |
| (generado) | `fn:substring(fn:string(fn:current-dateTime()),0,11)` | `StatusInfo/ValueDate` |
| (generado) | `fn:substring(fn:string(fn:current-dateTime()),0,20)` | `StatusInfo/DateTime` |
| `$GlobalId` | fn:data() | `StatusInfo/GlobalId` |
| `$ErrorMapeoRegionalOutput/code` | fn:data() | `ErrorInfo/Code` |
| `$ErrorMapeoRegionalOutput/error` | fn:data() | `ErrorInfo/Error` |
| `$ErrorMapeoRegionalOutput/description` | fn:data() | `ErrorInfo/Description` |
| `$ErrorMapeoRegionalOutput/shortDescription` | fn:data() | `ErrorInfo/ShortDescription` |
| (generado) | `fn:substring(fn:string(fn:current-dateTime()),0,20)` | `ErrorInfo/DateTime` |
| `$GlobalId` | fn:data() | `ErrorInfo/GlobalId` |
| `$targuetSystem` | fn:data() | `ErrorInfo/Details/SystemId` |
| `$StatusService` | fn:data() | `ErrorInfo/Details/SystemStatus` |
| `$errorCode` | fn:data() | `ErrorInfo/Details/MessageId` |
| `$errorMessage` | fn:data() | `ErrorInfo/Details/Messages` |

---

## Reglas de Negocio Detectadas

### 1. Determinación de éxito/error del servicio backend

**Ubicación**: Pipeline `FPCWithdrawalConsultationPP.Pipeline` — Stage `InvokeCountry` — responseTransform

```xquery
let $successIndicator := $responseService/error/text()
return 
if($successIndicator = 'false') then (
  'Success'
) else $successIndicator
```

**Regla**: Si el campo `error` del response de CloudCode es `"false"`, se considera éxito (`Success`). Cualquier otro valor se trata como código de error.

### 2. Extracción de mensaje de error

**Ubicación**: Pipeline `FPCWithdrawalConsultationPP.Pipeline` — Stage `InvokeCountry` — responseTransform

```xquery
if(fn:not(fn:upper-case($codeErrorService) = 'SUCCESS')) then (
  $responseService/mensaje/text()
) else ('')
```

**Regla**: Solo se extrae el mensaje de error si el status no es SUCCESS.

### 3. Retry por HTTP 401

**Ubicación**: Pipeline — Error Handler `ErrorHandlerInvokeCountry`

**Regla**: Si la invocación al BS retorna HTTP 401:
1. Se re-extraen credenciales de la cuenta de servicio
2. Se hace login forzado (`forceLogin=true`)
3. Se reintenta la invocación con el nuevo token

### 4. Extracción de mensaje de error desde fault detail (caso no-401)

**Ubicación**: Error Handler `ErrorHandlerInvokeCountry` — default branch

```xquery
if(fn:exists($fault/ctx:details/con:ReceivedFaultDetail/con:detail/err:PayloadDetail/err:text)) then (
  let $message := fn:data($fault/ctx:details/con:ReceivedFaultDetail/con:detail/err:PayloadDetail/err:text)
  return
  fn:substring-before(fn:substring-after($message, '"mensaje":"'), '"}')
) else (fn:data($fault/ctx:reason))
```

**Regla**: Intenta extraer el campo `mensaje` del JSON embebido en el payload del fault. Si no existe, usa el reason del fault.
