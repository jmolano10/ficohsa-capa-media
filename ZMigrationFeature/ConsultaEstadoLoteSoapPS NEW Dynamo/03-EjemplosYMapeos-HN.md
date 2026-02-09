# Ejemplos de Request/Response y Mapeo de Datos - Honduras (HN01)

## 1. Request OSB Virtual 11g (Entrada del Cliente)

### 1.1. Ejemplo Request SOAP Completo

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType"
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>usuario_honduras</UserName>
            <Password>password123</Password>
         </Authentication>
         <Region>
            <SourceBank>HN01</SourceBank>
            <DestinationBank>HN01</DestinationBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:consultaEstadoLote>
         <CUSTOMER_ID>12345</CUSTOMER_ID>
         <BANK_BATCH_ID>98765</BANK_BATCH_ID>
         <UPLOAD_DATE>2024-01-15</UPLOAD_DATE>
      </pag:consultaEstadoLote>
   </soapenv:Body>
</soapenv:Envelope>
```

**Endpoint:** `https://mwservices.gfficohsa.hn:8020/regional/massivePayment/soap/getBatchStatus/v11g`

**Método:** POST

**Content-Type:** text/xml; charset=utf-8

**Seguridad:** WSS (WS-Security) - Username Token

---

## 2. Request OSB Regional v2 (Transformado)

### 2.1. Ejemplo Request SOAP a Regional v2

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:mas="https://www.ficohsa.com/regional/massivePayment">
   <soapenv:Body>
      <mas:getBatchStatus>
         <GeneralInfo>
            <SourceBank>HN01</SourceBank>
            <DestinationBank>HN01</DestinationBank>
            <GlobalId>550e8400-e29b-41d4-a716-446655440000</GlobalId>
            <ApplicationId>usuario_honduras</ApplicationId>
            <ApplicationUser></ApplicationUser>
            <BranchId></BranchId>
            <TransactionDate></TransactionDate>
            <Language>es</Language>
         </GeneralInfo>
         <CustomerId>12345</CustomerId>
         <QueryType>BANK_BATCH_ID</QueryType>
         <QueryValue>98765</QueryValue>
      </mas:getBatchStatus>
   </soapenv:Body>
</soapenv:Envelope>
```

**Endpoint:** `https://mwservices.gfficohsa.hn:8020/regional/massivePayment/soap/getBatchStatus/v2`

**Método:** POST

**Seguridad:** Basic Auth over SSL

**Headers:**
- `Authorization: Basic <base64(username:password)>`
- `Accept: text/xml`

---

## 3. Request a Servicio Country v2 (REST)

### 3.1. Ejemplo Request REST a Country

```json
{
  "GeneralInfo": {
    "SourceBank": "HN01",
    "DestinationBank": "HN01",
    "GlobalId": "550e8400-e29b-41d4-a716-446655440000",
    "ApplicationId": "usuario_honduras",
    "ApplicationUser": "",
    "BranchId": "",
    "TransactionDate": "",
    "Language": "es"
  },
  "CustomerId": "12345",
  "QueryType": "BANK_BATCH_ID",
  "QueryValue": "98765"
}
```

**Endpoint:** `https://mwservices.gfficohsa.hn:8020/country/massivePayment/rest/getBatchStatus/v2` (URL dinámica obtenida de servicio de regionalización)

**Método:** POST

**Content-Type:** application/json

**Seguridad:** Basic Auth over SSL

---

## 4. Response de Servicio Country v2 (REST)

### 4.1. Ejemplo Response REST de Country

```json
{
  "StatusInfo": {
    "Status": "Success",
    "Code": "0000",
    "Description": "Operación exitosa"
  },
  "Ticket": "",
  "CustomerBatchId": "",
  "BankBatchId": 98765,
  "CustomerId": "12345",
  "CustomerName": "Empresa XYZ Honduras S.A.",
  "Status": "PROCESSED",
  "StatusDescription": "Procesado correctamente",
  "Optimistic": true,
  "Accounts": [
    {
      "DebitAccount": "1234567890",
      "Amount": 50000.00,
      "Currency": "HNL"
    }
  ],
  "Payments": [
    {
      "Currency": "HNL",
      "TotalAmount": 50000.00,
      "ExchangeRate": 1.00
    }
  ],
  "TotalAmount": 50000.00,
  "TotalAmountSuccess": 49500.00,
  "TotalAmountError": 500.00,
  "NumberOfTransactions": 100,
  "NumberOfTransactionsSuccess": 98,
  "NumberOfTransactionsError": 2,
  "ApplicationDate": "2024-01-15T10:30:00",
  "ProcessInfo": "Lote procesado correctamente en Honduras",
  "ErrorInfo": {
    "Error": "",
    "Code": "",
    "Description": ""
  }
}
```

---

## 5. Response OSB Regional v2 (SOAP)

### 5.1. Ejemplo Response SOAP de Regional v2

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:mas="https://www.ficohsa.com/regional/massivePayment">
   <soapenv:Body>
      <mas:getBatchStatusResponse>
         <StatusInfo>
            <Status>Success</Status>
            <Code>0000</Code>
            <Description>Operación exitosa</Description>
         </StatusInfo>
         <Ticket></Ticket>
         <CustomerBatchId></CustomerBatchId>
         <BankBatchId>98765</BankBatchId>
         <CustomerId>12345</CustomerId>
         <CustomerName>Empresa XYZ Honduras S.A.</CustomerName>
         <Status>PROCESSED</Status>
         <StatusDescription>Procesado correctamente</StatusDescription>
         <Optimistic>true</Optimistic>
         <Accounts>
            <DebitAccount>1234567890</DebitAccount>
            <Amount>50000.00</Amount>
            <Currency>HNL</Currency>
         </Accounts>
         <Payments>
            <Currency>HNL</Currency>
            <TotalAmount>50000.00</TotalAmount>
            <ExchangeRate>1.00</ExchangeRate>
         </Payments>
         <TotalAmount>50000.00</TotalAmount>
         <TotalAmountSuccess>49500.00</TotalAmountSuccess>
         <TotalAmountError>500.00</TotalAmountError>
         <NumberOfTransactions>100</NumberOfTransactions>
         <NumberOfTransactionsSuccess>98</NumberOfTransactionsSuccess>
         <NumberOfTransactionsError>2</NumberOfTransactionsError>
         <ApplicationDate>2024-01-15T10:30:00</ApplicationDate>
         <ProcessInfo>Lote procesado correctamente en Honduras</ProcessInfo>
         <ErrorInfo>
            <Error></Error>
            <Code></Code>
            <Description></Description>
         </ErrorInfo>
      </mas:getBatchStatusResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

---

## 6. Response OSB Virtual 11g (Salida al Cliente)

### 6.1. Ejemplo Response SOAP Completo

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType"
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>SUCCESS</successIndicator>
         <messageId></messageId>
         <messages></messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:consultaEstadoLoteResponse>
         <BANK_BATCH_ID>98765</BANK_BATCH_ID>
         <CUSTOMER_ID>12345</CUSTOMER_ID>
         <CUSTOMER_NAME>Empresa XYZ Honduras S.A.</CUSTOMER_NAME>
         <STATUS>PROCESSED</STATUS>
         <STATUS_DESC>Procesado correctamente</STATUS_DESC>
         <OPTIMISTIC>YES</OPTIMISTIC>
         <ACCOUNTS>
            <ACCOUNT>
               <DEBIT_ACCOUNT>1234567890</DEBIT_ACCOUNT>
               <AMOUNT>50000.00</AMOUNT>
               <CURRENCY>HNL</CURRENCY>
            </ACCOUNT>
         </ACCOUNTS>
         <PAYMENTS>
            <PAYMENT>
               <CURRENCY>HNL</CURRENCY>
               <TOTAL_AMOUNT>50000.00</TOTAL_AMOUNT>
               <EXCHANGE_RATE>1.00</EXCHANGE_RATE>
            </PAYMENT>
         </PAYMENTS>
         <TOTAL_AMOUNT>50000.00</TOTAL_AMOUNT>
         <TOTAL_AMOUNT_ERROR>500.00</TOTAL_AMOUNT_ERROR>
         <NUMBER_OF_TRANSACTIONS>100</NUMBER_OF_TRANSACTIONS>
         <NUMBER_OF_TRANSACTIONS_SUCCESS>98</NUMBER_OF_TRANSACTIONS_SUCCESS>
         <NUMBER_OF_TRANSACTIONS_ERROR>2</NUMBER_OF_TRANSACTIONS_ERROR>
         <APPLICATION_DATE>2024-01-15T10:30:00</APPLICATION_DATE>
         <PROCESS_INFO>Lote procesado correctamente en Honduras</PROCESS_INFO>
      </pag:consultaEstadoLoteResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

---

## 7. Mapeo de Entrada - Virtual 11g a Regional v2

### 7.1. Tabla de Mapeo Request (Virtual 11g → Regional v2)

**Transformación:** `Virtual11gToGetBatchStatus.xqy`

| Campo Origen (Virtual 11g) | Transformación/Script | Campo Destino (Regional v2) |
|----------------------------|----------------------|----------------------------|
| `$header//Region/SourceBank` | `fn:data($SourceBank)` | `GeneralInfo/SourceBank` |
| `$header//Region/DestinationBank` | `fn:data($DestinationBank)` | `GeneralInfo/DestinationBank` |
| N/A (generado) | `fn-bea:uuid()` o valor del header si existe | `GeneralInfo/GlobalId` |
| `$inbound/ctx:security/ctx:transportClient/ctx:username` | `data(...)` | `GeneralInfo/ApplicationId` |
| N/A | Vacío | `GeneralInfo/ApplicationUser` |
| N/A | Vacío | `GeneralInfo/BranchId` |
| N/A | Vacío | `GeneralInfo/TransactionDate` |
| `$body//GeneralInfo/Language` o default | `if exists then data(...) else 'es'` | `GeneralInfo/Language` |
| `$body/pag:consultaEstadoLote/CUSTOMER_ID` | `fn:data($consultaEstadoLote/CUSTOMER_ID)` | `CustomerId` |
| Constante | `'BANK_BATCH_ID'` | `QueryType` |
| `$body/pag:consultaEstadoLote/BANK_BATCH_ID` | `fn:data($consultaEstadoLote/BANK_BATCH_ID)` | `QueryValue` |

**Fragmento de Código XQuery:**
```xquery
<ns2:getBatchStatus>
    <GeneralInfo>
        <SourceBank>{fn:data($SourceBank)}</SourceBank>
        <DestinationBank>{fn:data($DestinationBank)}</DestinationBank>
    </GeneralInfo>
    <CustomerId>{fn:data($consultaEstadoLote/CUSTOMER_ID)}</CustomerId>
    <QueryType>BANK_BATCH_ID</QueryType>
    <QueryValue>{fn:data($consultaEstadoLote/BANK_BATCH_ID)}</QueryValue>
</ns2:getBatchStatus>
```

**Ubicación:** `SBRG_MassivePayment_Commons_Virtual/Transformations/PagosMasivos/GetBatchStatus/Virtual11gToGetBatchStatus.xqy`

---

## 8. Mapeo de Salida - Regional v2 a Virtual 11g

### 8.1. Tabla de Mapeo Response Header (Regional v2 → Virtual 11g)

**Transformación:** `GetBatchStatusToVirtual11gHeaderHN.xqy`

| Campo Origen (Regional v2) | Transformación/Script | Campo Destino (Virtual 11g) |
|----------------------------|----------------------|----------------------------|
| `$responseService/ErrorInfo/Error` | `if exists then fn:data(...) else ()` | `ResponseHeader/messageId` |
| `$responseService/StatusInfo/Status` | `if data(...)='Error' then 'ERROR' else fn:data(...)` | `ResponseHeader/successIndicator` |
| `$responseService/ErrorInfo/Description` | `if exists then fn:data(...) else ()` | `ResponseHeader/messages` |

**Fragmento de Código XQuery:**
```xquery
<ns2:ResponseHeader>
    {
        if ($responseService/ErrorInfo/Error)
        then <messageId>{fn:data($responseService/ErrorInfo/Error)}</messageId>
        else ()
    }
    {
        if ($responseService/StatusInfo/Status) then
            if (fn:data($responseService/StatusInfo/Status) = 'Error') then 
                <successIndicator>ERROR</successIndicator>
            else 
                <successIndicator>{fn:data($responseService/StatusInfo/Status)}</successIndicator>
        else ()
    }
    {
        if ($responseService/ErrorInfo/Description)
        then  <messages>{fn:data($responseService/ErrorInfo/Description)}</messages>
        else ()
    }
</ns2:ResponseHeader>
```

**Ubicación:** `SBRG_MassivePayment_Commons_Virtual/Transformations/PagosMasivos/GetBatchStatus/GetBatchStatusToVirtual11gHeaderHN.xqy`

### 8.2. Tabla de Mapeo Response Body (Regional v2 → Virtual 11g)

**Transformación:** `GetBatchStatusToVirtual11gBodyHN.xqy`

| Campo Origen (Regional v2) | Transformación/Script | Campo Destino (Virtual 11g) |
|----------------------------|----------------------|----------------------------|
| `$responseService/BankBatchId` | `if exists then fn:data(...) else ()` | `BANK_BATCH_ID` |
| `$responseService/CustomerId` | `if exists then fn:data(...) else ()` | `CUSTOMER_ID` |
| `$responseService/CustomerName` | `if exists then fn:data(...) else ()` | `CUSTOMER_NAME` |
| `$responseService/Status` | `if exists then fn:data(...) else ()` | `STATUS` |
| `$responseService/StatusDescription` | `if exists then fn:data(...) else ()` | `STATUS_DESC` |
| `$responseService/Optimistic` | `if 'true' then 'YES' else if 'false' then 'NO' else ()` | `OPTIMISTIC` |
| `$responseService/Accounts/DebitAccount` | `for each Account: if exists then fn:data(...) else ()` | `ACCOUNTS/ACCOUNT/DEBIT_ACCOUNT` |
| `$responseService/Accounts/Amount` | `for each Account: if exists then fn:data(...) else ()` | `ACCOUNTS/ACCOUNT/AMOUNT` |
| `$responseService/Accounts/Currency` | `for each Account: if exists then fn:data(...) else ()` | `ACCOUNTS/ACCOUNT/CURRENCY` |
| `$responseService/Payments/Currency` | `for each Payment: if exists then fn:data(...) else ()` | `PAYMENTS/PAYMENT/CURRENCY` |
| `$responseService/Payments/TotalAmount` | `for each Payment: if exists then fn:data(...) else ()` | `PAYMENTS/PAYMENT/TOTAL_AMOUNT` |
| `$responseService/Payments/ExchangeRate` | `for each Payment: if exists then fn:data(...) else ()` | `PAYMENTS/PAYMENT/EXCHANGE_RATE` |
| `$responseService/TotalAmount` | `if exists then fn:data(...) else ()` | `TOTAL_AMOUNT` |
| `$responseService/TotalAmountError` | `if exists then fn:data(...) else ()` | `TOTAL_AMOUNT_ERROR` |
| `$responseService/NumberOfTransactions` | `if exists then fn:data(...) else ()` | `NUMBER_OF_TRANSACTIONS` |
| `$responseService/NumberOfTransactionsSuccess` | `if exists then fn:data(...) else ()` | `NUMBER_OF_TRANSACTIONS_SUCCESS` |
| `$responseService/NumberOfTransactionsError` | `if exists then fn:data(...) else ()` | `NUMBER_OF_TRANSACTIONS_ERROR` |
| `$responseService/ApplicationDate` | `if exists then fn:data(...) else ()` | `APPLICATION_DATE` |
| `$responseService/ProcessInfo` | `if exists then fn:data(...) else ()` | `PROCESS_INFO` |

**Fragmento de Código XQuery (Conversión Optimistic):**
```xquery
{
    if ($responseService/Optimistic) then
        if (fn:string(fn:data($responseService/Optimistic)) = 'true') then
            <OPTIMISTIC>YES</OPTIMISTIC>
        else if (fn:string(fn:data($responseService/Optimistic)) = 'false') then
            <OPTIMISTIC>NO</OPTIMISTIC>
        else ()
    else ()
}
```

**Ubicación:** `SBRG_MassivePayment_Commons_Virtual/Transformations/PagosMasivos/GetBatchStatus/GetBatchStatusToVirtual11gBodyHN.xqy`

---

## 9. Cadenas de Conexión y Credenciales

### 9.1. Conexión Virtual 11g → Regional v2

**Business Service:** `GetBatchStatusSoapBS.bix`

**Configuración:**
- **URL:** `https://mwservices.gfficohsa.hn:8020/regional/massivePayment/soap/getBatchStatus/v1`
- **Protocolo:** HTTPS
- **Método:** POST
- **Timeout:** 40 segundos
- **Connection Timeout:** 35 segundos
- **Retry Count:** 0
- **Autenticación:** Incluida en headers (Authorization: Basic)
- **Headers Enviados:**
  - `Authorization: Basic <base64(username:password)>` (generado desde WSS)
  - `Accept: text/xml`

**Ubicación:** `SBRG_MassivePayment_Commons_Virtual/BS/PagosMasivos/GetBatchStatusSoapBS.bix`

### 9.2. Conexión Regional v2 → Country v2

**Business Service:** `GetBatchStatusCountryGenericRestBS.bix`

**Configuración:**
- **URL Base:** `https://mwservices.gfficohsa.hn:8020/country/massivePayment/rest/getBatchStatus/v2`
- **URL Dinámica:** Obtenida de `GetCountryURLByNameRegionalRestBS`
- **Protocolo:** HTTPS (REST)
- **Método:** POST
- **Content-Type:** application/json
- **Timeout:** 70 segundos
- **Connection Timeout:** 65 segundos
- **Retry Count:** 0
- **Retry Interval:** 30 segundos
- **Autenticación:** Basic Auth over SSL
- **Policy:** `oracle/http_basic_auth_over_ssl_client_policy`

**Ubicación:** `SBRG_MassivePayment_GetBatchStatus/BS/v2/GetBatchStatusCountryGenericRestBS.bix`

### 9.3. Servicio de Regionalización

**Business Service:** `GetCountryURLByNameRegionalRestBS`

**Operación:** `GetCountryURLByName`

**Request:**
```json
{
  "destinationBank": "HN01",
  "service": "MassivePayment/GetBatchStatus",
  "user": "usuario_honduras",
  "operation": "",
  "version": "v2",
  "sourceBank": "HN01"
}
```

**Response:**
```
https://mwservices.gfficohsa.hn:8020/country/massivePayment/rest/getBatchStatus/v2
```

**Nota:** Si retorna "N/A", se genera error: "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"

---

## 10. Reglas de Negocio Detectadas

### 10.1. Validación de Región

**Ubicación:** `MassivePaymentRegional11gFicohsaTemplatePG16857.ptx` - Stage "Definitions"

**Regla:**
```xquery
let $sourceBank := if (($header//Region/SourceBank/text()) != "") then
                      $header//Region/SourceBank/text()
                   else 
                      "HN01"
```

**Descripción:** Si no se especifica `SourceBank`, se asume Honduras (HN01) como región por defecto.

### 10.2. Enrutamiento por Región

**Ubicación:** `MassivePaymentRegional11gFicohsaTemplatePG16857.ptx` - Stage "StageTransformOutput"

**Regla:**
```xquery
if (fn:contains($sourceBank, "HN")) then
    // Aplicar transformaciones específicas de Honduras
else if (fn:contains($sourceBank, "GT")) then
    // Error: INVALID REGION REQUEST
else if (fn:contains($sourceBank, "NI")) then
    // Error: INVALID REGION REQUEST
else if (fn:contains($sourceBank, "PA")) then
    // Error: INVALID REGION REQUEST
else
    // Error: INVALID REGION REQUEST
```

**Descripción:** Solo Honduras tiene transformaciones específicas en el código analizado. Otras regiones generan error en caso de no tener transformaciones configuradas.

### 10.3. Conversión de Tipo Optimistic

**Ubicación:** `GetBatchStatusToVirtual11gBodyHN.xqy`

**Regla:**
```xquery
if ($responseService/Optimistic) then
    if (fn:string(fn:data($responseService/Optimistic)) = 'true') then
        <OPTIMISTIC>YES</OPTIMISTIC>
    else if (fn:string(fn:data($responseService/Optimistic)) = 'false') then
        <OPTIMISTIC>NO</OPTIMISTIC>
    else ()
else ()
```

**Descripción:** Convierte el booleano `Optimistic` (true/false) del servicio Regional v2 a string (YES/NO) para el servicio Virtual 11g.

### 10.4. Generación de GlobalId (UUID)

**Ubicación:** `MassivePaymentRegionalFicohsaTemplatePG16857.ptx` - Stage "Definitions"

**Regla:**
```xquery
let $uuid := if(($body//GeneralInfo/GlobalId) and (data($body//GeneralInfo/GlobalId) != '')) then
                data($body//GeneralInfo/GlobalId)
             else
                fn-bea:uuid()
```

**Descripción:** Si el request no incluye un `GlobalId`, se genera automáticamente un UUID para trazabilidad.

### 10.5. Idioma por Defecto

**Ubicación:** `MassivePaymentRegionalFicohsaTemplatePG16857.ptx` - Stage "Definitions"

**Regla:**
```xquery
let $language := if(($body//GeneralInfo/Language) and (data($body//GeneralInfo/Language) != '')) then
                    data($body//GeneralInfo/Language)
                 else
                    'es'
```

**Descripción:** Si no se especifica idioma, se asume español ('es') por defecto.

### 10.6. Validación de Esquema

**Ubicación:** `GetBatchStatusPP.pipeline` - Stage "Validate"

**Regla:**
```xml
<con1:validate>
    <con1:schema ref="SBRG_MassivePayment_GetBatchStatus/Schemas/GetBatchStatusTypes"/>
    <con1:schemaElement xmlns:mas="https://www.ficohsa.com/regional/massivePayment">mas:getBatchStatus</con1:schemaElement>
    <con1:varName>body</con1:varName>
    <con1:location>
        <con2:xpathText>$body/mas:getBatchStatus</con2:xpathText>
    </con1:location>
</con1:validate>
```

**Descripción:** Se valida el esquema XSD del request en la capa Regional v2 antes de invocar al servicio Country.

### 10.7. Manejo de Errores HTTP en REST

**Ubicación:** `MassivePaymentRegionalFicohsaTemplatePG16857.ptx` - Stage "Stage1" (Response)

**Regla:**
```xquery
if (($method='REST') and (fn:upper-case($state)!='SUCCESS')) then
    <http:http-response-code>{$codeError}</http:http-response-code>
```

**Descripción:** Si el método es REST y el estado no es SUCCESS, se inserta el código de error HTTP en la respuesta.

### 10.8. Logging de Transacciones

**Ubicación:** `MassivePaymentRegionalFicohsaTemplatePG16857.ptx` - Stages "StageLoggingInput", "StageLoggingOutput", "StageLoggingOutputError"

**Regla:** Se registran logs en filesystem para:
- Request de entrada (antes de validación)
- Response de salida (después de recibir respuesta de Country)
- Errores (en pipeline de error)

**Campos Loggeados:**
- GlobalId, SourceBank, DestinationBank
- User, Channel, Service, Operation, Version
- State, CodeError, MessageError
- Body completo (Request/Response)
- ErrorDetails (Stack trace en caso de error)

**Servicio:** `LoggingRegionalRestBS` - Operación: `SaveLogInFileSystem`

---

## 11. Casos de Error Específicos de Honduras

### 11.1. Error: Región No Válida

**Condición:** `SourceBank` no contiene "HN", "GT", "NI" o "PA"

**Response Header:**
```xml
<aut:ResponseHeader>
    <successIndicator>ERROR</successIndicator>
    <messageId>INVALID REGION REQUEST</messageId>
</aut:ResponseHeader>
```

**Response Body:**
```xml
<pag:consultaEstadoLoteResponse/>
```

### 11.2. Error: Servicio No Implementado para País

**Condición:** Servicio de regionalización retorna "N/A"

**Error Code:** `MW-0008`

**Error Message:** `SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY`

### 11.3. Error: Timeout

**Condición:** El servicio Country no responde en 70 segundos

**Response:** Error de timeout del OSB

### 11.4. Error: Validación de Esquema

**Condición:** El request no cumple con el esquema XSD

**Response:** Error de validación con detalles del campo inválido

---

## 12. Notas Adicionales para Honduras

1. **Moneda Principal:** HNL (Lempira Hondureño)
2. **Formato de Cuenta:** No se especifica en el código, depende de la implementación del servicio Country
3. **Zona Horaria:** No se especifica en el código, se asume UTC o zona horaria del servidor
4. **Optimistic Flag:** Indica si el lote se procesó de forma optimista (sin validar saldos en tiempo real)
5. **Process Info:** Campo de texto libre con información adicional del procesamiento
