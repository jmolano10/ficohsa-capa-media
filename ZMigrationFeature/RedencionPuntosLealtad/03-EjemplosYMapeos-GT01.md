# Ejemplos y Mapeos - GT01 (Guatemala)

## Request OSB

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:pro="http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication><UserName>SALESFORCE</UserName><Password>********</Password></Authentication>
         <Region><SourceBank>GT01</SourceBank></Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pro:redencionPuntosLealtad>
         <CUSTOMER_ID_TYPE>CARD_NUMBER</CUSTOMER_ID_TYPE>
         <CUSTOMER_ID_VALUE>5412345678901234</CUSTOMER_ID_VALUE>
         <REDEMPTION_TYPE>CASH</REDEMPTION_TYPE>
         <REDEMPTION_AMOUNT>250.00</REDEMPTION_AMOUNT>
         <CASH_REDEMPTION>
            <CARD_NUMBER>5412345678901234</CARD_NUMBER>
            <MERCHANT_ID>987654321</MERCHANT_ID>
            <MERCHANT_TYPE>RETAIL</MERCHANT_TYPE>
            <TERMINAL_ID>TERM002</TERMINAL_ID>
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
         <LEGAL_ID>1234567890101</LEGAL_ID>
         <CUSTOMER_NAME>MARIA LOPEZ GARCIA</CUSTOMER_NAME>
         <POINTS_REDEEMED>2500</POINTS_REDEEMED>
         <REMAINING_BALANCE></REMAINING_BALANCE>
         <REDEMPTION_ID>123456789</REDEMPTION_ID>
      </pro:redencionPuntosLealtadResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

## Cadenas de Conexión

| Servicio | Base de Datos | Esquema | SP | JCA |
|----------|---------------|---------|----|----|
| canjearPuntosEfectivo_db | ABKGT_DB | ABKGT | canjearPuntosEfectivo | Middleware/v2/BusinessServices/ABKGT/canjearPuntosEfectivo/jca/canjearPuntosEfectivo_db.jca |
| conDatoCuenta_db | MASTERDATA_GT_DB | MASTERDATA_GT | conDatoCuenta | Middleware/v2/BusinessServices/MasterDataGT/conDatoCuenta/jca/conDatoCuenta_db.jca |
| consultaProgramaLealtad_db | INTFC_DB | INTFC | consultaProgramaLealtad | Middleware/v2/BusinessServices/INTFC/consultaProgramaLealtad/jca/consultaProgramaLealtad_db.jca |
| INSTransaccionRedencion_db | MASTERDATA_DB | MASTERDATA | INSTransaccionRedencion | Middleware/v2/BusinessServices/MasterData/iNSTransaccionRedencion/jca/INSTransaccionRedencion_db.jca |

## Mapeos de Entrada

### Request OSB → conDatoCuenta

| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| CUSTOMER_ID_VALUE | fn:string() | PV_ACCOUNTNUMBER |
| RequestHeader/Region/SourceBank | convertirCodigoPais('OSB-ISO3') | PV_COUNTRYCODE |
| Constante '' | - | PV_ORG |

**XQuery**: `Middleware/v2/Resources/MasterDataGT/xq/conDatoCuentaGTIn.xq`

### Request OSB → canjearPuntosEfectivo

| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| REDEMPTION_AMOUNT | fn:string() | PN_MONTOCONVERSION |
| Variable $logo | fn:string() | PV_LOGO |
| Constante '2' | - | PN_TIPOCONVERSION |
| CASH_REDEMPTION/TERMINAL_ID | fn:string() | PV_TERMINALID |
| CASH_REDEMPTION/MERCHANT_TYPE | fn:string() | PV_MERCHANTTYPE |
| CASH_REDEMPTION/MERCHANT_ID | fn:string() | PV_MERCHANTNUMBER |

**XQuery**: `Middleware/v2/Resources/ProgramaLealtad/xq/canjearPuntosEfectivoGTIn.xq`

### Request OSB → INSTransaccionRedencion

| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| CUSTOMER_ID_VALUE | fn:string() | PV_CARDNUMBER |
| REDEMPTION_AMOUNT | fn:string() | PN_AMOUNT |
| CASH_REDEMPTION/TERMINAL_ID | fn:string() | PV_MERCHANT |

**XQuery**: `Middleware/v2/Resources/RedencionPuntosLealtad/xq/insTransaccionRedencion.xq`

### Request OSB → PointsRedeem

| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| Variable $totalPoints | fn:string() | GPXAIO-POINTS-TO-REDEEM |
| Variable $rewardItem | fn:string() | GPXAIO-REWARD-ITEM |
| conDatoCuenta/ORG | fn:string() | GPXAIO-ORG |
| conDatoCuenta/LMS_SCHEME | fn:string() | GPXAIO-SCHEME |
| conDatoCuenta/LMS_ACC | fn:string() | GPXAIO-ACC |

**XQuery**: `Middleware/v2/Resources/RedencionPuntosLealtad/xq/pointsRedeemGTIn.xq`

## Mapeos de Salida

### conDatoCuenta → Variables OSB

| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| RowSet[1]/Row[TipoOrg='BASE']/Column[@name='logo'] | fn:string() | $logo |
| RowSet[1]/Row[TipoOrg='BASE']/Column[@name='CUST_NBR'] | fn:string() | $customerId |
| RowSet[1]/Row[TipoOrg='BASE']/Column[@name='nombre_cliente'] | fn:string() | $customerName |
| RowSet[1]/Row[TipoOrg='BASE']/Column[@name='legal_id'] | fn:string() | $legalId |
| CodigoError | fn:string() | $errorCode |
| MensajeError | if errorCode != '-1' then MensajeError else '' | $validationMessage |

### Variables OSB → Response OSB

| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| $legalId | fn:string() | LEGAL_ID |
| $customerName | fn:string() | CUSTOMER_NAME |
| $totalPoints | fn:string() | POINTS_REDEEMED |
| Constante '' | - | REMAINING_BALANCE |
| $redemptionId | fn:string() | REDEMPTION_ID |

**XQuery**: `Middleware/v2/Resources/RedencionPuntosLealtad/xq/redencionPuntosLealtadGTOut.xq`

## Reglas de Negocio

### Validación de Entrada
```
SI CUSTOMER_ID_TYPE != 'CARD_NUMBER' ENTONCES
    validationMessage = 'CUSTOMER_ID_TYPE no soportado'
FIN SI
```

### Determinación de Programa
```
SI logo != "" ENTONCES
    Invocar consultaProgramaLealtad(logo, GT01)
    programCode = PV_CODIGOLEALTAD
SINO
    errorCode = "ERROR"
    validationMessage = "No se encontró logo para la tarjeta."
FIN SI
```

### Redención Programa 2
```
SI programCode = '2' Y rewardItem != '' Y nRowsBase > 0 ENTONCES
    Invocar INSTransaccionRedencion(...)
    redemptionId = IDTransaccion
    
    SI validationMessage = '' ENTONCES
        Invocar PointsRedeem(...)
    FIN SI
FIN SI
```
