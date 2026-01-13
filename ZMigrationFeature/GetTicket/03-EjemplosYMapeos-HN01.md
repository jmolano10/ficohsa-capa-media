# Ejemplos de Request/Response y Mapeo de Datos - HN01

## Request OSB (ejemplo SOAP/XML)

### SOAP Envelope Completo
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
               xmlns:ach="http://www.ficohsa.com.hn/middleware.services/achServicesPS"
               xmlns:com="http://www.ficohsa.com.hn/middleware.services/commonTypes">
    <soap:Header>
        <com:RequestHeader>
            <com:SourceBank>HN01</com:SourceBank>
            <com:DestinationBank>HN01</com:DestinationBank>
            <com:ApplicationId>MOBILE_APP</com:ApplicationId>
            <com:Language>es</com:Language>
        </com:RequestHeader>
    </soap:Header>
    <soap:Body>
        <ach:GetTicketRequest>
            <ach:originatorId>FICOHSA_HN</ach:originatorId>
            <ach:messageType>CREDIT</ach:messageType>
        </ach:GetTicketRequest>
    </soap:Body>
</soap:Envelope>
```

### Request Body Detallado
```xml
<ach:GetTicketRequest xmlns:ach="http://www.ficohsa.com.hn/middleware.services/achServicesPS">
    <ach:originatorId>FICOHSA_HN</ach:originatorId>
    <ach:messageType>CREDIT</ach:messageType>
</ach:GetTicketRequest>
```

## Response OSB (ejemplo SOAP/XML)

### SOAP Envelope de Respuesta Exitosa
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
               xmlns:ach="http://www.ficohsa.com.hn/middleware.services/achServicesPS"
               xmlns:com="http://www.ficohsa.com.hn/middleware.services/commonTypes">
    <soap:Header>
        <com:ResponseHeader>
            <com:TransactionId>TXN-20241201-001</com:TransactionId>
            <com:MessageId>MSG-20241201-001</com:MessageId>
            <com:SuccessIndicator>Success</com:SuccessIndicator>
            <com:Messages></com:Messages>
            <com:ValueDate>2024-12-01T10:30:00</com:ValueDate>
        </com:ResponseHeader>
    </soap:Header>
    <soap:Body>
        <ach:GetTicketResponse>
            <ach:ticket>eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJNT0JJTEVfQVBQIiwiaWF0IjoxNzMzMDU4NjAwLCJleHAiOjE3MzMwNjIyMDB9.abc123def456</ach:ticket>
        </ach:GetTicketResponse>
    </soap:Body>
</soap:Envelope>
```

### Response Body de Error
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
               xmlns:ach="http://www.ficohsa.com.hn/middleware.services/achServicesPS"
               xmlns:com="http://www.ficohsa.com.hn/middleware.services/commonTypes">
    <soap:Header>
        <com:ResponseHeader>
            <com:TransactionId>TXN-20241201-002</com:TransactionId>
            <com:MessageId>MSG-20241201-002</com:MessageId>
            <com:SuccessIndicator>Error</com:SuccessIndicator>
            <com:Messages>Error al generar ticket ACH</com:Messages>
            <com:ValueDate>2024-12-01T10:35:00</com:ValueDate>
        </com:ResponseHeader>
    </soap:Header>
    <soap:Body>
        <ach:GetReportTransactionResponse/>
    </soap:Body>
</soap:Envelope>
```

## Requests/Responses internos a servicios dependientes

### Request a ACHRest_BS (REST)
```xml
<ach:GetAchTicket_params xmlns:ach="http://xmlns.oracle.com/DynamoMigrate/Applications/ACHRest_BS">
    <ach:userName>MOBILE_APP</ach:userName>
</ach:GetAchTicket_params>
```

### Response de ACHRest_BS (JSON convertido a XML)
```xml
<ach:GetTicketResponse xmlns:ach="http://www.ficohsa.com/ach">
    <ach:ticket>eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJNT0JJTEVfQVBQIiwiaWF0IjoxNzMzMDU4NjAwLCJleHAiOjE3MzMwNjIyMDB9.abc123def456</ach:ticket>
    <ach:StatusCode></ach:StatusCode>
    <ach:Message></ach:Message>
</ach:GetTicketResponse>
```

### Response de ACHRest_BS con Error
```xml
<ach:GetTicketResponse xmlns:ach="http://www.ficohsa.com/ach">
    <ach:ticket></ach:ticket>
    <ach:StatusCode>500</ach:StatusCode>
    <ach:Message>Internal Server Error - Unable to generate ticket</ach:Message>
</ach:GetTicketResponse>
```

## Cadenas de conexión detectadas y credenciales

### Business Service ACHRest_BS
- **Endpoint**: `https://saliente-ach-dev2.gfficohsa.hn/api/Ach`
- **Operación REST**: `GetAchTicket`
- **Método HTTP**: POST
- **Autenticación**: HTTP Basic Authentication
- **Service Account**: `Applications/ProviderServices/SA/ACHRest_SA`
- **Timeout**: 65 segundos
- **Connection Timeout**: 60 segundos
- **Content-Type**: application/xml (SOAP over HTTP)

### Servicios de Logging
- **SetLogInfoService_BS**: 
  - Ubicación: `CommonResources/MiddlewareDB/ProviderServices/BusinessServices/SetLogInfoService/v1.0/SetLogInfoService_BS`
  - Operación: `SetLogInfoService_BS`
  - Propósito: Registro de logs de transacciones

- **GetErrorMessages_BS**:
  - Ubicación: `CommonResources/MiddlewareDB/ProviderServices/BusinessServices/GetErrorMessages/v1.0/GetErrorMessages_BS`
  - Operación: `GetErrorMessages_BS`
  - Propósito: Obtención de mensajes de error localizados

## Tablas de mapeo de entrada por cada llamada a servicio dependiente

### Mapeo OSB Request → ACHRest_BS Request

| Campo Origen (OSB) | Transformación/Script | Campo Destino (ACHRest_BS) |
|-------------------|----------------------|---------------------------|
| `$header/com:RequestHeader/com:ApplicationId` | `fn:data()` | `ach:userName` |
| N/A (hardcoded) | `'GetAchTicket'` | Operación REST |
| N/A (generado) | `fn-bea:uuid()` | Variable interna `$uuid` |
| N/A (generado) | `'5'` | Variable interna `$codigoServicio` |

### Mapeo para SetLogInfoService_BS (Request Log)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (SetLogInfoService) |
|-------------------|----------------------|----------------------------------|
| N/A (hardcoded) | `1` | `codigoAplicacion` |
| `$codigoServicio` | Directo | `codigoServicio` |
| N/A (hardcoded) | `''` | `codigoError` |
| `$bodyInput` | `fn-bea:serialize()` | `contenido` |
| N/A (hardcoded) | `''` | `estado` |
| N/A (hardcoded) | `1` | `codigoSistema` |
| `$uuid` | Directo | `uuid` |
| N/A (hardcoded) | `'GetTicket'` | `operacionServicio` |
| `$sourceBank` | Directo | `bancoOrigen` |
| `$destinationBank` | Directo | `bancoDestino` |
| N/A (función) | `fn:current-dateTime()` | `fechaHora` |
| N/A (hardcoded) | `'Request'` | `tipoMensaje` |

## Tablas de mapeo de salida por cada respuesta de servicio dependiente

### Mapeo ACHRest_BS Response → OSB Response Header

| Campo Origen (ACHRest_BS) | Transformación/Script | Campo Destino (OSB Header) |
|--------------------------|----------------------|---------------------------|
| `$getTicketResponse/ns2:StatusCode` | `if (fn:data() != '') then 'Error' else 'Success'` | `ns3:SuccessIndicator` |
| `$getTicketResponse/ns2:Message` | `if ($getTicketResponse/ns2:Message) then fn:data() else ()` | `ns3:Messages` |

### Mapeo ACHRest_BS Response → OSB Response Body

| Campo Origen (ACHRest_BS) | Transformación/Script | Campo Destino (OSB Body) |
|--------------------------|----------------------|-------------------------|
| `$getTicketResponse/ns1:ticket` | `if ($getTicketResponse/ns1:ticket) then fn:data() else ()` | `ns3:ticket` |

### Mapeo para SetLogInfoService_BS (Response Log)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (SetLogInfoService) |
|-------------------|----------------------|----------------------------------|
| `$finalResponse` | `fn-bea:serialize()` | `contenido` |
| N/A (hardcoded) | `'Response'` | `tipoMensaje` |
| N/A (hardcoded) | `''` | `codigoError` |
| N/A (hardcoded) | `''` | `estado` |

### Mapeo para GetErrorMessages_BS (Error Handling)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (GetErrorMessages) |
|-------------------|----------------------|----------------------------------|
| `$fault/ctx:errorCode` | `fn:data()` | `codigoErrorSistema` |
| `$codigoServicio` | Directo | `codigoServicio` |
| N/A (hardcoded) | `'1'` | `codigoSistema` |
| `$header/com:RequestHeader/com:Language` | `if (fn:data() != '') then fn:data() else 'es'` | `codigoLenguaje` |
| `$fault/ctx:reason` | `fn:data()` | `descripcionError` |

## Reglas de negocio detectadas

### Reglas de Validación
1. **Validación de StatusCode**: 
   - **Ubicación**: `GetTicketHeaderOut.xqy` línea 16-18
   - **Regla**: Si StatusCode no está vacío, se considera Error, caso contrario Success
   - **Código**: `if (fn:data($getTicketResponse/ns2:StatusCode) != '') then <ns3:SuccessIndicator>Error</ns3:SuccessIndicator> else <ns3:SuccessIndicator>Success</ns3:SuccessIndicator>`

2. **Validación de Mensaje**:
   - **Ubicación**: `GetTicketHeaderOut.xqy` línea 19-22
   - **Regla**: Solo incluir Messages si existe en la respuesta
   - **Código**: `if ($getTicketResponse/ns2:Message) then <ns3:Messages>{fn:data($getTicketResponse/ns2:Message)}</ns3:Messages> else ()`

3. **Validación de Ticket**:
   - **Ubicación**: `GetTicketOUT.xqy` línea 16-19
   - **Regla**: Solo incluir ticket si existe en la respuesta
   - **Código**: `if ($getTicketResponse/ns1:ticket) then <ns3:ticket>{fn:data($getTicketResponse/ns1:ticket)}</ns3:ticket> else ()`

### Reglas de Logging
4. **Logging de Request**:
   - **Ubicación**: Pipeline `GetTicket_PP.pipeline` stage "LogInitialRequest"
   - **Regla**: Registrar todos los requests con código de servicio '5'
   - **Parámetros**: codigoAplicacion=1, codigoServicio=5, tipoMensaje='Request'

5. **Logging de Response**:
   - **Ubicación**: Pipeline `GetTicket_PP.pipeline` stage "LogFinalResponse"
   - **Regla**: Registrar todas las respuestas exitosas
   - **Parámetros**: tipoMensaje='Response', estado=''

6. **Logging de Error**:
   - **Ubicación**: Pipeline `GetTicket_PP.pipeline` stage "LogErrorRequest"
   - **Regla**: Registrar todos los errores con estado='Error'
   - **Parámetros**: estado='Error', codigoError=$errorCode

### Reglas de Transformación
7. **Mapeo de ApplicationId**:
   - **Ubicación**: Pipeline `GetTicket_PP.pipeline` stage "GetTicketACHREQ"
   - **Regla**: El ApplicationId del header se convierte en userName para el servicio ACH
   - **Código**: `{fn:data($header/com:RequestHeader/com:ApplicationId)}`

8. **Generación de UUID**:
   - **Ubicación**: Pipeline `GetTicket_PP.pipeline` stage "CommonParams"
   - **Regla**: Generar UUID único para cada transacción
   - **Código**: `fn-bea:uuid()`

### Reglas de Manejo de Errores
9. **Manejo de Idioma**:
   - **Ubicación**: Pipeline error stage "GetErrors"
   - **Regla**: Si no se especifica idioma, usar 'es' por defecto
   - **Código**: `if (fn:data($header/com:RequestHeader/com:Language)!='') then fn:data($header/com:RequestHeader/com:Language) else 'es'`

10. **Transformación de Error Header**:
    - **Ubicación**: Pipeline error stage "TxErrorMessage"
    - **Regla**: Usar transformación estándar para headers de error
    - **Referencia**: `CommonResources/XQ/Tx_ErrorMap_To_ErrorHeaderRSP`