# Ejemplos y Mapeos - PA01 (Panamá)

## Request OSB

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:pro="http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication><UserName>SALESFORCE</UserName><Password>********</Password></Authentication>
         <Region><SourceBank>PA01</SourceBank></Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pro:redencionPuntosLealtad>
         <CUSTOMER_ID_TYPE>CARD_NUMBER</CUSTOMER_ID_TYPE>
         <CUSTOMER_ID_VALUE>4111111111111111</CUSTOMER_ID_VALUE>
         <REDEMPTION_TYPE>POINTS</REDEMPTION_TYPE>
         <REDEMPTION_AMOUNT>1000</REDEMPTION_AMOUNT>
         <CASH_REDEMPTION>
            <CARD_NUMBER>4111111111111111</CARD_NUMBER>
            <MERCHANT_ID>555555555</MERCHANT_ID>
            <MERCHANT_TYPE>ONLINE</MERCHANT_TYPE>
            <TERMINAL_ID>TERM003</TERMINAL_ID>
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
         <LEGAL_ID>8-123-4567</LEGAL_ID>
         <CUSTOMER_NAME>CARLOS RODRIGUEZ SANCHEZ</CUSTOMER_NAME>
         <POINTS_REDEEMED>1000</POINTS_REDEEMED>
         <REMAINING_BALANCE></REMAINING_BALANCE>
         <REDEMPTION_ID>20240115143025123</REDEMPTION_ID>
      </pro:redencionPuntosLealtadResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

## Cadenas de Conexión

| Servicio | Base de Datos | Esquema | SP | JCA |
|----------|---------------|---------|----|----|
| canjearPuntosEfectivo_db | PXYNIC_DB | PXYNIC | canjearPuntosEfectivo | Middleware/v2/BusinessServices/PXYNIC/canjearPuntosEfectivo/jca/canjearPuntosEfectivo_db.jca |
| conDatoCuenta_db | MASTERDATA_PA_DB | MASTERDATA_PA | conDatoCuenta | Middleware/v2/BusinessServices/MasterDataPA/conDatoCuenta/jca/conDatoCuenta_db.jca |
| consultaProgramaLealtad_db | INTFC_DB | INTFC | consultaProgramaLealtad | Middleware/v2/BusinessServices/INTFC/consultaProgramaLealtad/jca/consultaProgramaLealtad_db.jca |

## Mapeos de Entrada

### Request OSB → conDatoCuenta

| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| CUSTOMER_ID_VALUE | fn:string() | PV_ACCOUNTNUMBER |
| RequestHeader/Region/SourceBank | convertirCodigoPais('OSB-ISO3') | PV_COUNTRYCODE |
| Constante '' | - | PV_ORG |

**XQuery**: `Middleware/v2/Resources/MasterDataPA/xq/conDatoCuentaPAIn.xq`

### Request OSB → canjearPuntosEfectivo

| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| REDEMPTION_AMOUNT | fn:string() | PN_MONTOCONVERSION |
| Variable $logo | fn:string() | PV_LOGO |
| Constante '2' | - | PN_TIPOCONVERSION |
| CASH_REDEMPTION/TERMINAL_ID | fn:string() | PV_TERMINALID |
| CASH_REDEMPTION/MERCHANT_TYPE | fn:string() | PV_MERCHANTTYPE |
| CASH_REDEMPTION/MERCHANT_ID | fn:string() | PV_MERCHANTNUMBER |

**XQuery**: `Middleware/v2/Resources/ProgramaLealtad/xq/conversionPuntosNIIn.xq`

### Request OSB → PointsRedeem

| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| Variable $totalPoints | fn:string() | GPXAIO-POINTS-TO-REDEEM |
| Variable $rewardItem | fn:string() | GPXAIO-REWARD-ITEM |
| conDatoCuenta/ORG | fn:string() | GPXAIO-ORG |
| conDatoCuenta/LMS_SCHEME | fn:string() | GPXAIO-SCHEME |
| conDatoCuenta/LMS_ACC | fn:string() | GPXAIO-ACC |

**XQuery**: `Middleware/v2/Resources/RedencionPuntosLealtad/xq/pointsRedeemIn.xq`

## Mapeos de Salida

### conDatoCuenta → Variables OSB

| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| RowSet[1]/Row[1]/Column[@name='logo'] | fn:string() | $logo |
| RowSet[1]/Row[1]/Column[@name='CUST_NBR'] | fn:string() | $customerId |
| RowSet[1]/Row[1]/Column[@name='nombre_cliente'] | fn:string() | $customerName |
| RowSet[1]/Row[1]/Column[@name='legal_id'] | fn:string() | $legalId |
| CodigoError | fn:string() | $errorCode |

### Variables OSB → Response OSB

| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| $legalId | fn:string() | LEGAL_ID |
| $customerName | fn:string() | CUSTOMER_NAME |
| $totalPoints | fn:string() | POINTS_REDEEMED |
| Constante '' | - | REMAINING_BALANCE |
| $redemptionId | fn-bea:dateTime-to-string-with-format('yyyyMMddHHmmssSSS') | REDEMPTION_ID |

**XQuery**: `Middleware/v2/Resources/RedencionPuntosLealtad/xq/redencionPuntosLealtadNIOut.xq`

## Reglas de Negocio

### Generación de Redemption ID
```
redemptionId = fn-bea:dateTime-to-string-with-format('yyyyMMddHHmmssSSS', 
                adjust-dateTime-to-timezone(fn:current-dateTime(), ()))
```

### Redención Programa 2
```
SI programCode = '2' Y rewardItem != '' ENTONCES
    Invocar PointsRedeem(...)
    redemptionId = timestamp generado
FIN SI
```

**Diferencia clave**: PA01 no registra transacción en base de datos, genera ID con timestamp.
