# Ejemplos de Request/Response y Mapeo de Datos - Honduras (HN)

## 1. Request OSB (Ejemplo SOAP)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:card="https://www.ficohsa.com/regional/card"
                  xmlns:com="https://www.ficohsa.com/regional/common/commonTypes">
   <soapenv:Header/>
   <soapenv:Body>
      <card:getStatusTicket>
         <GeneralInfo>
            <SourceBank>HN01</SourceBank>
            <DestinationBank>HN01</DestinationBank>
            <GlobalId>550e8400-e29b-41d4-a716-446655440000</GlobalId>
            <ApplicationId>MOBILE_BANKING</ApplicationId>
            <ApplicationUser>user123</ApplicationUser>
            <BranchId>001</BranchId>
            <TransactionDate>2024-01-15</TransactionDate>
            <Language>ES</Language>
         </GeneralInfo>
         <Ticket>TKT20240115001234</Ticket>
         <TransactionType>PURCHASE_REVERSAL</TransactionType>
      </card:getStatusTicket>
   </soapenv:Body>
</soapenv:Envelope>
```

## 2. Request OSB (Ejemplo REST/JSON)

```json
{
  "getStatusTicket": {
    "GeneralInfo": {
      "SourceBank": "HN01",
      "DestinationBank": "HN01",
      "GlobalId": "550e8400-e29b-41d4-a716-446655440000",
      "ApplicationId": "MOBILE_BANKING",
      "ApplicationUser": "user123",
      "BranchId": "001",
      "TransactionDate": "2024-01-15",
      "Language": "ES"
    },
    "Ticket": "TKT20240115001234",
    "TransactionType": "PURCHASE_REVERSAL"
  }
}
```

---

## 3. Response OSB Exitoso (Ejemplo SOAP)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:card="https://www.ficohsa.com/regional/card">
   <soapenv:Header/>
   <soapenv:Body>
      <card:getStatusTicketResponse>
         <StatusInfo>
            <Status>SUCCESS</Status>
            <TransactionId></TransactionId>
            <ValueDate>2024-01-15</ValueDate>
            <DateTime>2024-01-15T10:30:45</DateTime>
            <GlobalId>550e8400-e29b-41d4-a716-446655440000</GlobalId>
         </StatusInfo>
         <ErrorInfo>
            <Code></Code>
            <Error></Error>
            <Description></Description>
            <ShortDescription></ShortDescription>
            <DateTime></DateTime>
            <GlobalId></GlobalId>
            <Details>
               <SystemId></SystemId>
               <MessageId></MessageId>
               <Messages></Messages>
            </Details>
         </ErrorInfo>
         <Status>R</Status>
         <OriginalAgency>100</OriginalAgency>
         <MerchantNumber>123456</MerchantNumber>
         <CreditCard>************1234</CreditCard>
         <OperationType>PURCHASE</OperationType>
         <BalanceCurrency>1</BalanceCurrency>
         <Organizations>1</Organizations>
         <TransactionCurrency>HNL</TransactionCurrency>
         <ExchangeRate>1.00</ExchangeRate>
         <TransactionType>1</TransactionType>
         <User>ATX</User>
         <MovementSequence>000123</MovementSequence>
         <OriginalSequence>000122</OriginalSequence>
         <PaymentAmount>1500.00</PaymentAmount>
         <CheckValue>0.00</CheckValue>
         <DocumentNumber>0</DocumentNumber>
         <CardExpirationDate>2512</CardExpirationDate>
         <CheckType>0</CheckType>
         <OriginalBank>FICOHSA</OriginalBank>
         <DestinationBank>FICOHSA</DestinationBank>
         <Description>Reversa de compra</Description>
         <Channel>MOBILE</Channel>
         <AutorizationNumber>AUTH123456</AutorizationNumber>
         <Applied>Y</Applied>
         <AppliedOnLine>Y</AppliedOnLine>
      </card:getStatusTicketResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

---

## 4. Response OSB con Error (Ejemplo SOAP)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:card="https://www.ficohsa.com/regional/card">
   <soapenv:Header/>
   <soapenv:Body>
      <card:getStatusTicketResponse>
         <StatusInfo>
            <Status>ERROR</Status>
            <TransactionId></TransactionId>
            <ValueDate>2024-01-15</ValueDate>
            <DateTime>2024-01-15T10:30:45</DateTime>
            <GlobalId>550e8400-e29b-41d4-a716-446655440000</GlobalId>
         </StatusInfo>
         <ErrorInfo>
            <Code>CARD-RB-001</Code>
            <Error>TICKET_NOT_FOUND</Error>
            <Description>El ticket especificado no existe en el sistema</Description>
            <ShortDescription>Ticket no encontrado</ShortDescription>
            <DateTime>2024-01-15T10:30:45</DateTime>
            <GlobalId>550e8400-e29b-41d4-a716-446655440000</GlobalId>
            <Details>
               <SystemId>PAGOSWSTC</SystemId>
               <MessageId></MessageId>
               <Messages>Ticket TKT20240115001234 no existe</Messages>
            </Details>
         </ErrorInfo>
      </card:getStatusTicketResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

---

## 5. Cadenas de Conexión y Credenciales

### Base de Datos - PagosWSTC

**Conexión:**
```
JNDI Name: jca://eis/DB/ConnectionPagosWSTC
Tipo: Oracle Database Adapter (JCA)
Schema: PAGOSWSTC
Package: OSB_K_RECAUDO_BROKER_HN
```

**Stored Procedure 1: Consulta de Ticket**
```sql
-- Nombre: OSB_CONS_BROKER_RECAUDO_TICKET
-- Schema: PAGOSWSTC
-- Package: OSB_K_RECAUDO_BROKER_HN

CALL PAGOSWSTC.OSB_K_RECAUDO_BROKER_HN.OSB_CONS_BROKER_RECAUDO_TICKET(
    PV_TICKET => 'TKT20240115001234',
    -- Parámetros OUT (29 campos)
    PV_ESTADO_TICKET => ?,
    PN_AGENCIAORIGEN => ?,
    PV_MERCHANTNUMBER => ?,
    PV_NUMEROTARJETA => ?,
    -- ... (resto de parámetros OUT)
    PV_SUCCESSINDICATOR => ?,
    PV_MESSAGES => ?
);
```

**Stored Procedure 2: Actualización de Ticket**
```sql
-- Nombre: OSB_ACT_BROKER_RECAUDO_TICKET
-- Schema: PAGOSWSTC
-- Package: OSB_K_RECAUDO_BROKER_HN

CALL PAGOSWSTC.OSB_K_RECAUDO_BROKER_HN.OSB_ACT_BROKER_RECAUDO_TICKET(
    PV_TICKET => 'TKT20240115001234',
    PV_ESTADO_TICKET => 'R',
    -- Parámetros OUT
    PV_SUCCESSINDICATOR => ?,
    PV_MESSAGES => ?
);
```

### Servicio SOAP - Vision+ OnlineTransactions

**Endpoint:**
```
URL: http://172.28.1.145:7802/OTWS/v4
WSDL: OnlineTransactions_v4.wsdl
Operación: OnlineUpdateCard
Namespace: http://www.procesa.com/fdcs/ot/v4
```

**Request a Vision+ (OnlineUpdateCard):**
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:ot="http://www.procesa.com/fdcs/ot">
   <soapenv:Header/>
   <soapenv:Body>
      <ot:OnlinePaymentV4Request>
         <POSUserData>ATX</POSUserData>
         <RRN37>4015103012000123</RRN37>
         <NumberOfInstallments>00</NumberOfInstallments>
         <MCCType>6010</MCCType>
         <RequestType>R</RequestType>
         <CardNumber>4111111111111234</CardNumber>
         <OrgId>1</OrgId>
         <MerchantNumber>123456</MerchantNumber>
         <CardExpirationDate>2512</CardExpirationDate>
         <TotalSalesAmount>1500.00</TotalSalesAmount>
         <Track2Length>0000</Track2Length>
         <Track2Data>0000</Track2Data>
         <CardValidationValue>000</CardValidationValue>
      </ot:OnlinePaymentV4Request>
   </soapenv:Body>
</soapenv:Envelope>
```

**Response de Vision+ (OnlineUpdateCard):**
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:ot="http://www.procesa.com/fdcs/ot">
   <soapenv:Header/>
   <soapenv:Body>
      <ot:OnlinePaymentV4Response>
         <POSUserData>ATX</POSUserData>
         <RRN37>4015103012000123</RRN37>
         <VPrespCode>00</VPrespCode>
         <SystemAction>APPROVE</SystemAction>
         <ReasonActionCode>0</ReasonActionCode>
         <ActionDescription>APPROVED</ActionDescription>
         <CardValidationResult>PASS</CardValidationResult>
         <AuthorizationCode>AUTH123456</AuthorizationCode>
      </ot:OnlinePaymentV4Response>
   </soapenv:Body>
</soapenv:Envelope>
```

---

## 6. Tablas de Mapeo de Entrada

### 6.1. Mapeo OSB → Consulta de Ticket (DBGetStatusTicketAdapter)

**Transformación:** `RollbackPurchaseToPagosWS.xqy`

| Campo Origen (OSB) | Transformación/Script | Campo Destino (BD) |
|-------------------|----------------------|-------------------|
| Ticket | `fn:data($Rollback/Ticket)` | PV_TICKET |

**Regla de Negocio:**
- Extracción directa del campo Ticket del request OSB
- No hay transformaciones adicionales
- Ubicación: `SBHN_Card_RollbackPurchase/Transformations/RollbackPurchaseToPagosWS.xqy`

---

### 6.2. Mapeo Ticket BD → Vision+ OnlineUpdateCard

**Transformación:** `RollbackPurchaseToOnlinePayment.xqy`

| Campo Origen (BD Response) | Transformación/Script | Campo Destino (Vision+) |
|---------------------------|----------------------|------------------------|
| - | Constante: `'ATX'` | POSUserData |
| PV_SECUENCIAMOVIMIENTO | Generación dinámica RRN37 (ver regla) | RRN37 |
| - | Constante: `'00'` | NumberOfInstallments |
| - | Constante: `'6010'` | MCCType |
| - | Parámetro: `'R'` (Reversal) | RequestType |
| PV_NUMEROTARJETA | `fn:data($creditCard)` | CardNumber |
| PN_ORGANIZACION | `fn:data($org)` | OrgId |
| PV_MERCHANTNUMBER | `fn:data($merchant)` | MerchantNumber |
| PV_FECHAEXPTC | `fn:data($expiration)` | CardExpirationDate |
| PN_VALOREFECTIVO | `fn:data($payment)` | TotalSalesAmount |
| - | Constante: `'0000'` | Track2Length |
| - | Constante: `'0000'` | Track2Data |
| - | Constante: `'000'` | CardValidationValue |

**Regla de Negocio - Generación RRN37:**
```xquery
let $currentDate := (current-date())
let $currentTime := (current-time())
let $lastYearDigit := substring(fn-bea:date-to-string-with-format('YY', $currentDate), 2)
let $yearDays := fn-bea:pad-left(fn-bea:date-to-string-with-format('D', $currentDate), 3, '0')
let $hours := fn-bea:pad-left(xs:string(hours-from-time($currentTime)), 2, '0')
let $minutes := fn-bea:pad-left(xs:string(minutes-from-time($currentTime)), 2, '0')
return concat($lastYearDigit, $yearDays, $hours, $minutes, $sequence)

-- Formato: YYDDDHHMMssssss
-- Ejemplo: 4015103012000123
--   4 = Año 2024 (último dígito)
--   015 = Día 15 del año
--   10 = Hora 10
--   30 = Minutos 30
--   12000123 = Secuencia del movimiento
```

**Ubicación:** `SBHN_Card_RollbackPurchase/Transformations/RollbackPurchaseToOnlinePayment.xqy`

---

### 6.3. Mapeo OSB → Actualización de Ticket (DBActTicketAdapter)

**Transformación:** `RollbackPurchaseToActTicket.xqy`

| Campo Origen (OSB) | Transformación/Script | Campo Destino (BD) |
|-------------------|----------------------|-------------------|
| Ticket | `fn:data($RollbackPurchase/Ticket)` | PV_TICKET |
| - | Parámetro: `'R'` (Reversado) | PV_ESTADO_TICKET |

**Regla de Negocio:**
- El estado del ticket se establece en 'R' para indicar que fue reversado
- Solo se ejecuta si Vision+ retorna ActionDescription = 'APPROVED'
- Ubicación: `SBHN_Card_RollbackPurchase/Transformations/RollbackPurchaseToActTicket.xqy`

---

## 7. Tablas de Mapeo de Salida

### 7.1. Mapeo Consulta Ticket BD → Variables Pipeline

**Transformación:** Inline en pipeline (responseTransform)

| Campo Origen (BD) | Transformación/Script | Variable Destino |
|------------------|----------------------|-----------------|
| PV_SUCCESSINDICATOR | `fn:string($responseService/PV_SUCCESSINDICATOR/text())` | codeErrorGetTicket |
| PV_SUCCESSINDICATOR | `fn:string($responseService/PV_SUCCESSINDICATOR/text())` | statusService |
| PV_MESSAGES | `fn:string($responseService/PV_MESSAGES/text())` | messageErrorService |

**Regla de Negocio:**
- Si `codeErrorGetTicket = 'SUCCESS' AND messageErrorService = ''` → Continuar con reversión
- Si no → Retornar error sin invocar Vision+
- Ubicación: `SBHN_Card_RollbackPurchase/PP/RollbackPurchasePP.pipeline` (líneas de responseTransform)

---

### 7.2. Mapeo Vision+ Response → Variables Pipeline

**Transformación:** Inline en pipeline (responseTransform)

| Campo Origen (Vision+) | Transformación/Script | Variable Destino |
|------------------------|----------------------|-----------------|
| ActionDescription | `fn:string($responseOnlinePayment/ActionDescription/text())` | ActionDescription |
| ActionDescription | `fn:string($responseOnlinePayment/ActionDescription/text())` | messaggeOnlinePayment |

**Regla de Negocio:**
- Si `fn-bea:trim($ActionDescription) = 'APPROVED'` → Actualizar estado del ticket
- Si no → Retornar error sin actualizar ticket
- Ubicación: `SBHN_Card_RollbackPurchase/PP/RollbackPurchasePP.pipeline`

---

### 7.3. Mapeo Actualización Ticket BD → Variables Pipeline

**Transformación:** Inline en pipeline (responseTransform)

| Campo Origen (BD) | Transformación/Script | Variable Destino |
|------------------|----------------------|-----------------|
| PV_SUCCESSINDICATOR | `fn:string($responseActTicket/PV_SUCCESSINDICATOR/text())` | codeErrorService |
| PV_SUCCESSINDICATOR | `fn:string($responseActTicket/PV_SUCCESSINDICATOR/text())` | statusService |
| PV_MESSAGES | `fn:string($responseActTicket/PV_MESSAGES /text())` | messageErrorService |

**Regla de Negocio:**
- Si `codeErrorService = 'SUCCESS'` → Construir respuesta exitosa
- Si no → Construir respuesta de error
- Ubicación: `SBHN_Card_RollbackPurchase/PP/RollbackPurchasePP.pipeline`

---

### 7.4. Mapeo BD Response → OSB Response (Caso Exitoso)

**Transformación:** `PagosWSToRollbackPurchase.xqy`

| Campo Origen (BD) | Transformación/Script | Campo Destino (OSB) |
|------------------|----------------------|-------------------|
| PV_SUCCESSINDICATOR | `fn:data($PagosWS/PV_SUCCESSINDICATOR)` | StatusInfo/Status |
| - | `fn:substring(fn:string(fn:current-dateTime()),0,11)` | StatusInfo/ValueDate |
| - | `fn:substring(fn:string(fn:current-dateTime()),0,20)` | StatusInfo/DateTime |
| $globalId (parámetro) | `fn:data($globalId)` | StatusInfo/GlobalId |

**Regla de Negocio:**
- Solo se ejecuta cuando `codeErrorService = 'SUCCESS'`
- Genera timestamps dinámicamente
- Ubicación: `SBHN_Card_RollbackPurchase/Transformations/PagosWSToRollbackPurchase.xqy`

---

### 7.5. Mapeo Error → OSB Response (Caso Error)

**Transformación:** `ErrorToRollbackPurchase.xqy`

| Campo Origen | Transformación/Script | Campo Destino (OSB) |
|-------------|----------------------|-------------------|
| $status (parámetro) | `fn:data($status)` | StatusInfo/Status |
| - | `fn:substring(fn:string(fn:current-dateTime()),0,11)` | StatusInfo/ValueDate |
| - | `fn:substring(fn:string(fn:current-dateTime()),0,20)` | StatusInfo/DateTime |
| $globalId (parámetro) | `fn:data($globalId)` | StatusInfo/GlobalId |
| $ErrorToRollback/ns1:code | `fn:data($ErrorToRollback/ns1:code)` | ErrorInfo/Code |
| $ErrorToRollback/ns1:error | `fn:data($ErrorToRollback/ns1:error)` | ErrorInfo/Error |
| $ErrorToRollback/ns1:description | `fn:data($ErrorToRollback/ns1:description)` | ErrorInfo/Description |
| $ErrorToRollback/ns1:shortDescription | `fn:data($ErrorToRollback/ns1:shortDescription)` | ErrorInfo/ShortDescription |
| - | `fn:substring(fn:string(fn:current-dateTime()),0,20)` | ErrorInfo/DateTime |
| $globalId (parámetro) | `fn:data($globalId)` | ErrorInfo/GlobalId |
| $targetSystem (parámetro) | `fn:data($targetSystem)` | ErrorInfo/Details/SystemId |
| $messaggeOnlinePayment o $messageError | Condicional (ver regla) | ErrorInfo/Details/Messages |

**Regla de Negocio - Selección de Mensaje:**
```xquery
if ($messaggeOnlinePayment != '')
then <Messages>{fn:data($messaggeOnlinePayment)}</Messages>
else <Messages>{fn:data($messageError)}</Messages>
```
- Prioriza mensaje de Vision+ si existe
- Si no, usa mensaje de error genérico
- Ubicación: `SBHN_Card_RollbackPurchase/Transformations/ErrorToRollbackPurchase.xqy`

---

## 8. Reglas de Negocio Detectadas

### Regla 1: Validación de Ticket Existente
**Ubicación:** `RollbackPurchasePP.pipeline` - Stage "StageInvokeVision+"
```xquery
$codeErrorGetTicket = 'SUCCESS' and $messageErrorService = ''
```
**Descripción:** Antes de intentar la reversión en Vision+, se valida que el ticket exista y no tenga errores en la base de datos.

---

### Regla 2: Validación de Aprobación de Reversión
**Ubicación:** `RollbackPurchasePP.pipeline` - Stage "StageInvokeVision+"
```xquery
fn-bea:trim($ActionDescription) = 'APPROVED'
```
**Descripción:** Solo se actualiza el estado del ticket a 'R' si Vision+ aprueba la reversión. Se usa trim para eliminar espacios.

---

### Regla 3: Generación de RRN37 (Número de Referencia)
**Ubicación:** `RollbackPurchaseToOnlinePayment.xqy`
```xquery
concat($lastYearDigit, $yearDays, $hours, $minutes, $sequence)
```
**Descripción:** Se genera un número de referencia único basado en fecha/hora actual y la secuencia del movimiento.
**Formato:** YYDDDHHMMssssss (16 caracteres)

---

### Regla 4: Asignación de Variables de Template
**Ubicación:** `RollbackPurchasePP.pipeline` - Stage "StageAssigment"
```xquery
$service = "Card/RollbackPurchase"
$version = "v1"
$key = 'Ticket'
$value = data($body/card:getStatusTicket/Ticket)
$method = "SOAP"
$operationTargetSystem = "ReversaPagoTarjeta"
$targetSystem = "Vision+"
```
**Descripción:** Variables utilizadas para logging y trazabilidad de la transacción.

---

### Regla 5: Priorización de Mensajes de Error
**Ubicación:** `ErrorToRollbackPurchase.xqy`
```xquery
if ($messaggeOnlinePayment != '')
then <Messages>{fn:data($messaggeOnlinePayment)}</Messages>
else <Messages>{fn:data($messageError)}</Messages>
```
**Descripción:** Si Vision+ retorna un mensaje de error, se prioriza sobre el mensaje genérico del sistema.

---

### Regla 6: Estado de Reversión
**Ubicación:** `RollbackPurchaseToActTicket.xqy`
```xquery
$statusTicket = 'R'
```
**Descripción:** El estado 'R' indica que el ticket ha sido reversado exitosamente.

---

### Regla 7: Valores Constantes para Vision+
**Ubicación:** `RollbackPurchaseToOnlinePayment.xqy`
```xquery
POSUserData = 'ATX'
NumberOfInstallments = '00'
MCCType = '6010'
RequestType = 'R'
Track2Length = '0000'
Track2Data = '0000'
CardValidationValue = '000'
```
**Descripción:** Valores fijos requeridos por Vision+ para operaciones de reversión.

---

## 9. Flujo de Datos Completo

```
[Cliente] 
   ↓ (SOAP/REST Request)
[OSB Proxy: RollbackPurchaseRestPS/SoapPS]
   ↓
[Pipeline: RollbackPurchasePP]
   ↓ (Transformación: RollbackPurchaseToPagosWS.xqy)
[BD: OSB_CONS_BROKER_RECAUDO_TICKET]
   ↓ (Validación: SUCCESS + sin mensajes)
   ↓ (Transformación: RollbackPurchaseToOnlinePayment.xqy)
[Vision+: OnlineUpdateCard]
   ↓ (Validación: APPROVED)
   ↓ (Transformación: RollbackPurchaseToActTicket.xqy)
[BD: OSB_ACT_BROKER_RECAUDO_TICKET]
   ↓ (Transformación: PagosWSToRollbackPurchase.xqy)
[OSB Response]
   ↓
[Cliente]
```

---

**Nota:** Todos los ejemplos están basados en el análisis del código fuente real de la funcionalidad SBHN_Card_RollbackPurchase para la región de Honduras.
