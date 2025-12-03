# Ejemplos de Request/Response y Mapeo de Datos - HN01 (Honduras)

## Request OSB (Ejemplo SOAP/XML)

### Estructura del Request Principal
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:rev="http://www.ficohsa.com.hn/middleware.services/reversarTransaccionTypes" 
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>USUARIO_CAJA</UserName>
            <Password>PASSWORD_ENCRYPTED</Password>
         </Authentication>
         <Region>
            <SourceBank>HN01</SourceBank>
            <Company>FICOHSA</Company>
            <Country>HN</Country>
         </Region>
         <messageId>UUID-12345-67890</messageId>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <rev:reversarTransaccion>
         <TRANSACTION_ID>FT2312150001</TRANSACTION_ID>
         <TRANSACTION_TYPE>CREDIT_CARD_PAYMENT</TRANSACTION_TYPE>
         <AUTHORIZER_USERNAME>SUPERVISOR01</AUTHORIZER_USERNAME>
         <AUTHORIZER_PASSWORD>AUTH_PASSWORD</AUTHORIZER_PASSWORD>
      </rev:reversarTransaccion>
   </soapenv:Body>
</soapenv:Envelope>
```

### Ejemplo Request para ReversarTransaccionID
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:rev="http://www.ficohsa.com.hn/middleware.services/reversarTransaccionIDTypes" 
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>USUARIO_SISTEMA</UserName>
            <Password>PASSWORD_ENCRYPTED</Password>
         </Authentication>
         <Region>
            <SourceBank>HN01</SourceBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <rev:reversarTransaccionID>
         <TRANSACTION_ID>TFS2312150001</TRANSACTION_ID>
         <TRANSACTION_TYPE>PAGO_TC</TRANSACTION_TYPE>
      </rev:reversarTransaccionID>
   </soapenv:Body>
</soapenv:Envelope>
```

## Response OSB (Ejemplo SOAP/XML)

### Response Exitoso
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:rev="http://www.ficohsa.com.hn/middleware.services/reversarTransaccionTypes" 
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>SUCCESS</successIndicator>
         <messageId>REV-12345-SUCCESS</messageId>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <rev:reversarTransaccionResponse/>
   </soapenv:Body>
</soapenv:Envelope>
```

### Response con Error
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:rev="http://www.ficohsa.com.hn/middleware.services/reversarTransaccionTypes" 
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>ERROR</successIndicator>
         <messages>TRANSACTION_ID MUST TO BEGIN WITH "FT" OR "TT"</messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <rev:reversarTransaccionResponse/>
   </soapenv:Body>
</soapenv:Envelope>
```

### Response ReversarTransaccionID Exitoso
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:rev="http://www.ficohsa.com.hn/middleware.services/reversarTransaccionIDTypes" 
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>SUCCESS</successIndicator>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <rev:reversarTransaccionIDResponse>
         <T24_REFERENCE>FT23121500012</T24_REFERENCE>
         <TRANSACTION_ID>TFS2312150001</TRANSACTION_ID>
         <REFERENCE_CB>CB-REV-001</REFERENCE_CB>
      </rev:reversarTransaccionIDResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

## Requests/Responses Internos a Servicios Dependientes

### 1. Validación Regional
**Request a ValidaServicioRegional:**
```xml
<val:ValidaServicioRegional>
   <val:PV_SERVICIO_ID>FICBCO0084</val:PV_SERVICIO_ID>
   <val:PV_PAIS>HN</val:PV_PAIS>
   <val:PV_EMPRESA>FICOHSA</val:PV_EMPRESA>
   <val:PV_BANCO>HN01</val:PV_BANCO>
</val:ValidaServicioRegional>
```

**Response de ValidaServicioRegional:**
```xml
<val:ValidaServicioRegionalResponse>
   <val:PV_CODIGO_ERROR>SUCCESS</val:PV_CODIGO_ERROR>
   <val:PV_MENSAJE_ERROR></val:PV_MENSAJE_ERROR>
</val:ValidaServicioRegionalResponse>
```

### 2. Reversión T24 - Pago TC
**Request a svcReversarTransaccionCB:**
```xml
<t24:ReversionPagoTCTengo>
   <t24:user>USUARIO_CAJA</t24:user>
   <t24:TFS>TFS2312150001</t24:TFS>
</t24:ReversionPagoTCTengo>
```

**Response de svcReversarTransaccionCB:**
```xml
<t24:ReversionPagoTCTengoResponse>
   <Status>
      <successIndicator>SUCCESS</successIndicator>
      <messages>Transaction reversed successfully</messages>
      <transactionId>FT23121500012</transactionId>
   </Status>
</t24:ReversionPagoTCTengoResponse>
```

### 3. Registro de Reversión CB
**Request a registrarReversionTCCB:**
```xml
<reg:registrarReversionTCCB>
   <reg:PV_TRANSACCION_ID>TFS2312150001</reg:PV_TRANSACCION_ID>
</reg:registrarReversionTCCB>
```

**Response de registrarReversionTCCB:**
```xml
<reg:registrarReversionTCCBResponse>
   <reg:PV_ERRORCODE>SUCCESS</reg:PV_ERRORCODE>
   <reg:PV_ERRORMESSAGE></reg:PV_ERRORMESSAGE>
</reg:registrarReversionTCCBResponse>
```

## Cadenas de Conexión y Credenciales

### Base de Datos
- **Nombre BD**: T24_CORE_BANKING_HN
- **Esquema**: FICOHSA_HN
- **Stored Procedures**:
  - `registrarReversionTCCB` - Registro de reversión TC
  - `validarEstadoTransaccion` - Validación de estado
  - `actualizarEstadoTransaccionUUID` - Actualización de estado
  - `ValidaServicioRegional` - Validación regional

### Servicios WSDL
- **Endpoint T24**: `http://t24server:port/T24WebServices`
- **Operaciones**:
  - `ReversionPagoTCTengo` - Reversión pago TC
  - `ReversionDepositoTengo` - Reversión depósito
  - `ReversarTransaccionTENGOEEH` - Reversión EEH

### Conexiones OSB
- **Business Service**: `svcReversarTransaccionCB`
- **Database Adapter**: `registrarReversionTCCB_db`
- **Validation Service**: `ValidaServicioRegional_db`

## Tablas de Mapeo de Entrada

### Mapeo OSB → T24 (Reversión Pago TC)
| Campo Origen (OSB) | Transformación/Script | Campo Destino (T24) |
|-------------------|----------------------|-------------------|
| `$header/aut:RequestHeader/Authentication/UserName` | `fn:string()` | `user` |
| `$body/rev:reversarTransaccion/TRANSACTION_ID` | `fn:string()` | `TFS` |
| `fn-bea:uuid()` | Generación UUID | `uuid` (interno) |

### Mapeo OSB → DB (Registro Reversión)
| Campo Origen (OSB) | Transformación/Script | Campo Destino (DB) |
|-------------------|----------------------|------------------|
| `$body/rev:reversarTransaccion/TRANSACTION_ID` | `fn:string()` | `PV_TRANSACCION_ID` |
| `'R'` | Constante | `PV_ESTADO` |
| `fn:current-dateTime()` | Timestamp actual | `PV_FECHA_REVERSION` |

### Mapeo OSB → Validación Regional
| Campo Origen (OSB) | Transformación/Script | Campo Destino (Validación) |
|-------------------|----------------------|---------------------------|
| `'FICBCO0084'` | Constante servicio | `PV_SERVICIO_ID` |
| `$header/aut:RequestHeader/Region/Country` | `fn:string()` | `PV_PAIS` |
| `$header/aut:RequestHeader/Region/Company` | `fn:string()` | `PV_EMPRESA` |
| `$header/aut:RequestHeader/Region/SourceBank` | `fn:string()` | `PV_BANCO` |

## Tablas de Mapeo de Salida

### Mapeo T24 → OSB (Response Reversión)
| Campo Origen (T24) | Transformación/Script | Campo Destino (OSB) |
|-------------------|----------------------|-------------------|
| `$RSPRevTC/Status/successIndicator` | `fn:upper-case()` | `$successIndicator` |
| `$RSPRevTC/Status/messages` | `fn:string()` | `$errorCode` |
| `$RSPRevTC/Status/transactionId` | `fn:string()` | `$statusT24` |

### Mapeo DB → OSB (Response Validación)
| Campo Origen (DB) | Transformación/Script | Campo Destino (OSB) |
|------------------|----------------------|-------------------|
| `$RSPValidarEstadoTRX/val:PV_ERRORCODE` | `fn:string()` | `$successIndicator` |
| `$RSPValidarEstadoTRX/val:PV_ERRORMESSAGE` | `fn:string()` | `$ErrorCode` |
| `$RSPValidarEstadoTRX/val:PV_FT` | `fn:string()` | `$refT24` |
| `$RSPValidarEstadoTRX/val:PV_MESSAGE` | `fn:string()` | `$dbmesage` |

### Mapeo Final OSB Response
| Campo Origen (Interno) | Transformación/Script | Campo Destino (Response) |
|-----------------------|----------------------|------------------------|
| `$successIndicator` | Condicional SUCCESS/ERROR | `aut:ResponseHeader/successIndicator` |
| `$errorCode` | `fn:string()` | `aut:ResponseHeader/messages` |
| `$statusT24` | `fn:upper-case()` | `rev:T24_REFERENCE` |
| `$uuiddb` | `fn:upper-case()` | `rev:TRANSACTION_ID` |
| `$refcb` | `fn:upper-case()` | `rev:REFERENCE_CB` |

## Reglas de Negocio Detectadas

### 1. Validación de Tipo de Transacción
**Ubicación**: `ReversarTransaccion.proxy` - Stage `stage1`
**Regla**: 
```xquery
if ($transactionType = "CHEQUE_PAYMENT" and fn:string($trxId) != "") then
    // Procesar reversión de cheque
else if ($transactionType = "CREDIT_CARD_PAYMENT" and fn:string($trxId) != "") then
    // Procesar reversión TC
```

### 2. Validación de ID de Transacción
**Ubicación**: `ReversarTransaccion.proxy` - Response pipeline
**Regla**:
```xquery
if (fn:string($tipoTrx) != "FT" and fn:string($tipoTrx) != "TT") then
    error("TRANSACTION_ID MUST TO BEGIN WITH 'FT' OR 'TT'")
```

### 3. Autorización Dual para TC
**Ubicación**: `ReversarTransaccion.proxy` - CREDIT_CARD_PAYMENT case
**Regla**:
```xquery
if (upper-case($statusReversion) = "SUCCESS") then
    // Llamar autorización adicional
    wsCallout("AutorizareversapagooretiroTC")
```

### 4. Validación de Estado de Transacción
**Ubicación**: `ReversarTransaccionID.proxy` - Stage `ValidarTransaccionDB`
**Regla**:
```xquery
if ($dbmesage = 'TRUE') then
    // Proceder con reversión
else
    error("La transaccion no tiene el estado correcto, no se puede reversar")
```

### 5. Manejo de Tipos de Pago (Recaudos)
**Ubicación**: `ReversarTransaccion.proxy` - Collection cases
**Regla**:
```xquery
if ($payMethod = "CASH") then
    // Reversión efectivo
else if ($payMethod = "DEB.TO.ACCT") then
    // Reversión débito a cuenta
else if ($payMethod = "FICO.CHEQUE") then
    // Reversión cheque FICO
```

### 6. Actualización de Estado Post-Reversión
**Ubicación**: `ReversarTransaccionID.proxy` - Stage `ActualizarEstadoTransaccion`
**Regla**:
```xquery
if ($successIndicator = 'SUCCESS') then
    if ($tipoTRX != 'GEN') then
        // Actualizar estado normal
        actualizarEstadoTransaccionUUID(estado='R')
    else
        // Actualizar transacción genérica
        actualizarTransaccionGenCB()
```