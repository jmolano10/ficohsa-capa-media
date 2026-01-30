# Ejemplos y Mapeos - NI01 (Nicaragua)

## Request OSB

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:pro="http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication><UserName>SALESFORCE</UserName><Password>********</Password></Authentication>
         <Region><SourceBank>NI01</SourceBank></Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pro:redencionPuntosLealtad>
         <CUSTOMER_ID_TYPE>CARD_NUMBER</CUSTOMER_ID_TYPE>
         <CUSTOMER_ID_VALUE>6011123456789012</CUSTOMER_ID_VALUE>
         <REDEMPTION_TYPE>CASH</REDEMPTION_TYPE>
         <REDEMPTION_AMOUNT>100.00</REDEMPTION_AMOUNT>
         <CASH_REDEMPTION>
            <CARD_NUMBER>6011123456789012</CARD_NUMBER>
            <MERCHANT_ID>111222333</MERCHANT_ID>
            <MERCHANT_TYPE>RETAIL</MERCHANT_TYPE>
            <TERMINAL_ID>TERM004</TERMINAL_ID>
         </CASH_REDEMPTION>
         <REDEMPTION_DETAILS><REDEMPTION_METHOD>CASH</REDEMPTION_METHOD></REDEMPTION_DETAILS>
      </pro:redencionPuntosLealtad>
   </soapenv:Body>
</soapenv:Envelope>
```

## Response OSB

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
   <soapenv:Header>
      <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
         <successIndicator>Success</successIndicator>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pro:redencionPuntosLealtadResponse xmlns:pro="http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes">
         <LEGAL_ID>001-010180-0001A</LEGAL_ID>
         <CUSTOMER_NAME>ANA MARTINEZ LOPEZ</CUSTOMER_NAME>
         <POINTS_REDEEMED>1000</POINTS_REDEEMED>
         <REMAINING_BALANCE>8500</REMAINING_BALANCE>
         <REDEMPTION_ID>20240115143530456</REDEMPTION_ID>
      </pro:redencionPuntosLealtadResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

## Cadenas de Conexión

| Servicio | Base de Datos | Esquema | SP | JCA |
|----------|---------------|---------|----|----|
| canjearPuntosEfectivo_db | PXYNIC_DB | PXYNIC | canjearPuntosEfectivo | Middleware/v2/BusinessServices/PXYNIC/canjearPuntosEfectivo/jca/canjearPuntosEfectivo_db.jca |
| sjConsultaTipoTarjetaNI | SJS_DB | SJS | ConsultaTipoTarjeta | Middleware/v2/BusinessServices/SJS/consultaTipoTarjetaNI/jca/sjConsultaTipoTarjetaNI.jca |
| consultaProgramaLealtad_db | INTFC_DB | INTFC | consultaProgramaLealtad | Middleware/v2/BusinessServices/INTFC/consultaProgramaLealtad/jca/consultaProgramaLealtad_db.jca |
| obtenerTipoProgramaLealtad_db | INTFC_DB | INTFC | obtenerTipoProgramaLealtad | Middleware/v2/BusinessServices/INTFC/obtenerTipoProgramaLealtad/jca/obtenerTipoProgramaLealtad_db.jca |

## Mapeos de Entrada

### Request OSB → sjConsultaTipoTarjeta

| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| CUSTOMER_ID_VALUE | xs:integer(fn:string()) | CARD_NUMBER |
| Variable $operation | fn:string() | OPERATION |

**XQuery**: `Middleware/v2/Resources/ProgramaLealtad/xq/consultaTipoTarjetaNIIn.xq`

### Request OSB → obtenerTipoProgramaLealtad (si DEBIT)

| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| Constante 'TD0000' | - | PV_PRODUCTO |
| Constante '000' | - | PV_GRUPOAFINIDAD |
| CUSTOMER_ID_VALUE | fn:substring(1, 6) | PV_BIN |

**XQuery**: `Middleware/v2/Resources/Genericos/obtenerTipoProgramaLealtadIn.xq`

### Request OSB → canjearPuntosEfectivo

| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| REDEMPTION_AMOUNT | fn:string() | PN_MONTOCONVERSION |
| Variable $logo o $binNumber | if logo='' then binNumber else logo | PV_LOGO |
| Constante '2' | - | PN_TIPOCONVERSION |
| CASH_REDEMPTION/TERMINAL_ID | fn:string() | PV_TERMINALID |
| CASH_REDEMPTION/MERCHANT_TYPE | fn:string() | PV_MERCHANTTYPE |
| CASH_REDEMPTION/MERCHANT_ID | fn:string() | PV_MERCHANTNUMBER |

**XQuery**: `Middleware/v2/Resources/ProgramaLealtad/xq/conversionPuntosNIIn.xq`

### Request OSB → doItemRedemption (Programa 1)

| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| Variable $totalPoints | xs:long() | redemptions/quantity |
| Variable $matrixId | fn:string() | redemptions/rewardMatrixItemId |
| Variable $customerId | fn-bea:pad-left(19, '0') | MRSIdentity/appID |

**XQuery**: `Middleware/v2/Resources/RedencionPuntosLealtad/xq/doItemRedemptionIn.xq`

### Request OSB → PointsRedeem (Programa 2)

| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| Variable $totalPoints | fn:string() | GPXAIO-POINTS-TO-REDEEM |
| Variable $rewardItem | fn:string() | GPXAIO-REWARD-ITEM |
| sjConsultaTipoTarjeta/ORG | fn:string() | GPXAIO-ORG |
| sjConsultaTipoTarjeta/SCHEME | fn:string() | GPXAIO-SCHEME |
| sjConsultaTipoTarjeta/ACC | fn:string() | GPXAIO-ACC |

**XQuery**: `Middleware/v2/Resources/RedencionPuntosLealtad/xq/pointsRedeemNIIn.xq`

## Mapeos de Salida

### sjConsultaTipoTarjeta → Variables OSB

| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| SUCCESS_INDICATOR | fn:string() | $errorCode |
| ERROR_MESSAGE | fn:string() | $validationMessage |
| LOGO | fn:string() | $logo |
| CUSTOMER_ID | fn:string() | $customerId |
| CUSTOMER_NAME | fn:string() | $customerName |
| LEGAL_ID | fn:string() | $legalId |
| CARD_TYPE | fn:string() | $cardType |
| CARD_STATUS | fn:string() | $cardStatus |

### obtenerTipoProgramaLealtad → Variables OSB

| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| PV_CODIGO_ERROR | fn:upper-case(fn:string()) | $errorCode |
| PV_MENSAJE_ERROR | if errorCode='SUCCESS' then '' else mensaje | $validationMessage |
| PN_PROGRAMA_LEALTAD | fn:string() | $programCode |

### Variables OSB → Response OSB

| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| $legalId | fn:string() | LEGAL_ID |
| $customerName | fn:string() | CUSTOMER_NAME |
| $totalPoints | fn:string() | POINTS_REDEEMED |
| $pointTotalRemaining o '' | fn:string() | REMAINING_BALANCE |
| $redemptionId | fn:string() | REDEMPTION_ID |

**XQuery**: `Middleware/v2/Resources/RedencionPuntosLealtad/xq/redencionPuntosLealtadNIOut.xq`

## Reglas de Negocio

### Validación de Estado de Tarjeta
```
SI cardStatus != 'ACTIVE' ENTONCES
    errorCode = "ERROR"
    validationMessage = "La tarjeta de debito no se encuentra activa"
    DETENER
FIN SI
```

### Determinación de Programa para Tarjetas Débito
```
SI cardType = "DEBIT" Y cardStatus = "ACTIVE" ENTONCES
    binNumber = fn:substring(CUSTOMER_ID_VALUE, 1, 6)
    Invocar obtenerTipoProgramaLealtad('TD0000', '000', binNumber)
    programCode = PN_PROGRAMA_LEALTAD
FIN SI
```

### Determinación de Programa para Tarjetas Crédito
```
SI cardType = "CREDIT" Y logo != "" ENTONCES
    Invocar consultaProgramaLealtad(logo, NI01)
    programCode = PV_CODIGOLEALTAD
FIN SI
```

### Redención Programa 1 (Mastercard)
```
SI programCode = '1' Y matrixId != '' Y institutionName != '' ENTONCES
    customerId_padded = fn-bea:pad-left($customerId, 19, '0')
    Invocar doItemRedemption(matrixId, totalPoints, customerId_padded)
    redemptionId = redemptionResults[1]/redemptionId
    pointTotalRemaining = pointTotalRemaining
FIN SI
```

### Redención Programa 2 (VisionPlus)
```
SI programCode = '2' Y rewardItem != '' ENTONCES
    Invocar PointsRedeem(...)
    redemptionId = fn-bea:dateTime-to-string-with-format('yyyyMMddHHmmssSSS')
FIN SI
```

**Diferencias clave**: 
- NI01 es la única región que valida estado de tarjeta (ACTIVE)
- Usa `obtenerTipoProgramaLealtad` para tarjetas débito
- Padding de customerId a 19 caracteres para Mastercard
- Genera redemptionId con timestamp para Programa 2
