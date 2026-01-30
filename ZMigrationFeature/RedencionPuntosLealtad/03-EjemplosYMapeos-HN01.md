# Ejemplos y Mapeos - HN01 (Honduras)

## Request OSB (Ejemplo JSON/XML)

### Ejemplo 1: Redención por Efectivo con CARD_NUMBER

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:pro="http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>SALESFORCE</UserName>
            <Password>********</Password>
         </Authentication>
         <Region>
            <SourceBank>HN01</SourceBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pro:redencionPuntosLealtad>
         <CUSTOMER_ID_TYPE>CARD_NUMBER</CUSTOMER_ID_TYPE>
         <CUSTOMER_ID_VALUE>4567123456789012</CUSTOMER_ID_VALUE>
         <REDEMPTION_TYPE>CASH</REDEMPTION_TYPE>
         <REDEMPTION_AMOUNT>500.00</REDEMPTION_AMOUNT>
         <CASH_REDEMPTION>
            <CARD_NUMBER>4567123456789012</CARD_NUMBER>
            <MERCHANT_ID>123456789</MERCHANT_ID>
            <MERCHANT_TYPE>RETAIL</MERCHANT_TYPE>
            <TERMINAL_ID>TERM001</TERMINAL_ID>
         </CASH_REDEMPTION>
         <REDEMPTION_DETAILS>
            <REDEMPTION_METHOD>CASH</REDEMPTION_METHOD>
         </REDEMPTION_DETAILS>
         <PROGRAM_ID>2</PROGRAM_ID>
      </pro:redencionPuntosLealtad>
   </soapenv:Body>
</soapenv:Envelope>
```

## Response OSB (Ejemplo JSON/XML)

### Respuesta Exitosa

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
   <soapenv:Header>
      <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
         <successIndicator>Success</successIndicator>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pro:redencionPuntosLealtadResponse xmlns:pro="http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes">
         <LEGAL_ID>0801199012345</LEGAL_ID>
         <CUSTOMER_NAME>JUAN PEREZ LOPEZ</CUSTOMER_NAME>
         <POINTS_REDEEMED>5000</POINTS_REDEEMED>
         <REMAINING_BALANCE>15000</REMAINING_BALANCE>
         <REDEMPTION_ID>987654321</REDEMPTION_ID>
      </pro:redencionPuntosLealtadResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

## Cadenas de Conexión y Credenciales

### Base de Datos

| Servicio | Base de Datos | Esquema | SP/Operación | JCA |
|----------|---------------|---------|--------------|-----|
| canjearPuntosEfectivo_db | ABK_DB | ABK | canjearPuntosEfectivo | Middleware/v2/BusinessServices/ABK/canjearPuntosEfectivo/jca/canjearPuntosEfectivo_db.jca |
| conInfoLealtad_db | PROCESOS_HN_DB | PROCESOS_HN | conInfoLealtad | Middleware/v2/BusinessServices/ProcesosHN/conInfoLealtad/jca/conInfoLealtad_db.jca |
| conDatoCuenta_db | MASTERDATA_HN_DB | MASTERDATA_HN | conDatoCuenta | Middleware/v2/BusinessServices/MasterDataHN/conDatoCuenta/jca/conDatoCuenta_db.jca |
| INSTransaccionRedencion_db | MASTERDATA_DB | MASTERDATA | INSTransaccionRedencion | Middleware/v2/BusinessServices/MasterData/iNSTransaccionRedencion/jca/INSTransaccionRedencion_db.jca |

### Servicios WSDL

| Servicio | Endpoint WSDL | Operación |
|----------|---------------|-----------|
| RedemptionService | Mastercard Rewards Services | doItemRedemption |
| visionPlus | VisionPlus/FDCS | PointsRedeem, PointsAdjustmentInquiry |
| consultasClienteBS | T24 WebServices | Consultadecliente |
| tarjetasDebitoBS | T24 WebServices | ConsultaMaestraTarjetaDebito |
| transaccionesAlcance | Alcance WebServices | InformacionTarjeta |

## Tablas de Mapeo de Entrada

### Mapeo 1: Request OSB → conInfoLealtad

| Campo Origen (OSB) | Transformación/Script | Campo Destino (conInfoLealtad) |
|--------------------|----------------------|--------------------------------|
| CUSTOMER_ID_VALUE | fn:string() | PV_CARDNUMBER |
| RequestHeader/Region/SourceBank | convertirCodigoPais('OSB-ISO3') | PV_COUNTRY |

**XQuery**: `Middleware/v2/Resources/ProgramaLealtad/xq/conInfoLealtadHNIn.xq`

```xquery
<InputParameters>
    <PV_COUNTRY>{ $country }</PV_COUNTRY>
    <PV_CARDNUMBER>{ $cardNumber }</PV_CARDNUMBER>
</InputParameters>
```

### Mapeo 2: Request OSB → canjearPuntosEfectivo (si REDEMPTION_TYPE=CASH)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (canjearPuntosEfectivo) |
|--------------------|----------------------|---------------------------------------|
| REDEMPTION_AMOUNT | fn:string() | PN_MONTOCONVERSION |
| Variable $logo | fn:string() | PV_LOGO |
| Constante '2' | - | PN_TIPOCONVERSION |
| CASH_REDEMPTION/TERMINAL_ID | fn:string() | PV_TERMINALID |
| CASH_REDEMPTION/MERCHANT_TYPE | fn:string() | PV_MERCHANTTYPE |
| CASH_REDEMPTION/MERCHANT_ID | fn:string() | PV_MERCHANTNUMBER |

**XQuery**: `Middleware/v2/Resources/ProgramaLealtad/xq/canjearPuntosEfectivoHNIn.xq`

### Mapeo 3: Request OSB → doItemRedemption (Mastercard - Programa 1)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (doItemRedemption) |
|--------------------|----------------------|----------------------------------|
| Variable $totalPoints | xs:long() | redemptions/quantity |
| Variable $matrixId | fn:string() | redemptions/rewardMatrixItemId |
| Constante 'false' | - | confirmationEmailSw |
| Constante 'info@ficohsa.com' | - | confirmationEmailAddr |
| Constante 'true' | - | redemptions/newShippingAddressSw |
| Constante 'en_US' | - | language |

**Header MRSIdentity**:
| Campo Origen | Transformación/Script | Campo Destino |
|--------------|----------------------|---------------|
| Variable $institutionName | fn:string() | institutionName |
| Variable $legalId | fn:string() | appID |

**XQuery**: `Middleware/v2/Resources/RedencionPuntosLealtad/xq/doItemRedemptionIn.xq`

### Mapeo 4: Request OSB → INSTransaccionRedencion (Programa 2)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (INSTransaccionRedencion) |
|--------------------|----------------------|----------------------------------------|
| CUSTOMER_ID_VALUE | fn:string() | PV_CARDNUMBER |
| REDEMPTION_AMOUNT o $totalPoints | Condicional según REDEMPTION_TYPE | PN_AMOUNT |
| CASH_REDEMPTION/TERMINAL_ID | fn:string() | PV_MERCHANT |
| Constante 'DESC 35' | - | PV_DESCRIPTION |
| Constante '' | - | PV_SERVICEID |
| Constante '' | - | PV_CHANNELID |
| Variable $codigoPais | fn:string() | PV_COUNTRYCODE |

**XQuery**: `Middleware/v2/Resources/RedencionPuntosLealtad/xq/insTransaccionRedencionIn.xq`

### Mapeo 5: Request OSB → PointsRedeem (VisionPlus - Programa 2)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (PointsRedeem) |
|--------------------|----------------------|------------------------------|
| Variable $totalPoints | fn:string() | GPXAIO-POINTS-TO-REDEEM |
| Variable $rewardItem | fn:string() | GPXAIO-REWARD-ITEM |
| conDatoCuenta/ORG | fn:string() | GPXAIO-ORG |
| conDatoCuenta/LMS_SCHEME | fn:string() | GPXAIO-SCHEME |
| conDatoCuenta/LMS_ACC | fn:string() | GPXAIO-ACC |

**XQuery**: `Middleware/v2/Resources/RedencionPuntosLealtad/xq/pointsRedeemIn.xq`

## Tablas de Mapeo de Salida

### Mapeo 1: conInfoLealtad → Variables OSB

| Campo Origen (conInfoLealtad) | Transformación/Script | Campo Destino (Variable OSB) |
|-------------------------------|----------------------|------------------------------|
| RowSet/Row/Column[@name='legalId'] | fn-bea:trim(fn:string()) | $legalId |
| RowSet/Row/Column[@name='customerName'] | fn:string() | $customerName |
| RowSet/Row/Column[@name='cardType'] | fn:string() | $cardType |
| RowSet/Row/Column[@name='logo'] | fn:string() | $logo |
| CodigoError | fn:string() | $errorCode |
| MensajeError | fn:string() | $validationMessage |

### Mapeo 2: canjearPuntosEfectivo → Variables OSB

| Campo Origen (canjearPuntosEfectivo) | Transformación/Script | Campo Destino (Variable OSB) |
|--------------------------------------|----------------------|------------------------------|
| PN_VALORSALIDA | data() | $totalPoints |
| PV_CODIGOMENSAJE | fn:string() | $errorCode |
| PV_DESCRIPCIONMENSAJE | Condicional: si errorCode='SUCCESS' entonces '' | $validationMessage |

### Mapeo 3: doItemRedemption → Variables OSB

| Campo Origen (doItemRedemption) | Transformación/Script | Campo Destino (Variable OSB) |
|---------------------------------|----------------------|------------------------------|
| pointTotalRemaining | fn:string() | $pointTotalRemaining |
| redemptionResults[1]/redemptionId | fn:string() | $redemptionId |

### Mapeo 4: INSTransaccionRedencion → Variables OSB

| Campo Origen (INSTransaccionRedencion) | Transformación/Script | Campo Destino (Variable OSB) |
|----------------------------------------|----------------------|------------------------------|
| CodigoError | fn:string() | $errorCode |
| MensajeError | fn:string() | $validationMessage |
| IDTransaccion | fn:string() | $redemptionId |

### Mapeo 5: PointsRedeem → Variables OSB

| Campo Origen (PointsRedeem) | Transformación/Script | Campo Destino (Variable OSB) |
|-----------------------------|----------------------|------------------------------|
| SVC-RETURN | Condicional: si='P' entonces '' sino Desc | $validationMessage |
| ReturnCodes/RC[1]/Code | fn:string() | $errorCode |

### Mapeo 6: PointsAdjustmentInquiry → Variables OSB

| Campo Origen (PointsAdjustmentInquiry) | Transformación/Script | Campo Destino (Variable OSB) |
|----------------------------------------|----------------------|------------------------------|
| GPXAIO-OPEN-TO-RED-ON-SCR | fn-bea:trim(), dividir por 1000 | $pointTotalRemaining |

### Mapeo 7: Variables OSB → Response OSB

| Campo Origen (Variable OSB) | Transformación/Script | Campo Destino (Response OSB) |
|-----------------------------|----------------------|------------------------------|
| $legalId | fn:string() | LEGAL_ID |
| $customerName | fn:string() | CUSTOMER_NAME |
| $totalPoints | data() | POINTS_REDEEMED |
| $pointTotalRemaining | fn:string() | REMAINING_BALANCE |
| $redemptionId | fn:string() | REDEMPTION_ID |

**XQuery**: `Middleware/v2/Resources/RedencionPuntosLealtad/xq/redencionPuntosLealtadHNOut.xq`

## Reglas de Negocio Detectadas

### Regla 1: Validación de Método de Redención

**Ubicación**: `Middleware/v2/Resources/RedencionPuntosLealtad/xq/redencionPuntosLealtadValidate.xq`

```xquery
if ( not(fn:string($redencionPuntosLealtad/REDEMPTION_DETAILS/REDEMPTION_METHOD/text()) = ("CASH")) ) then (
    "Método de redención no permitido"
) else (
    ""
)
```

**Descripción**: Solo se permite el método de redención "CASH". Otros métodos (ACCOUNT_CREDIT, CREDIT_CARD_PAYMENT) son rechazados.

### Regla 2: Determinación de Programa de Lealtad

**Ubicación**: `RedencionPuntosLealtadHN.proxy` - Stage "ConsultaProgramaLealtad"

**Lógica**:
```
SI cardType = "DEBIT" ENTONCES
    programCode = '1'  (Mastercard)
    binNumber = substring(CUSTOMER_ID_VALUE, 1, 6)
SINO SI cardType = "CREDIT" Y logo != "" ENTONCES
    Invocar consultaProgramaLealtad(logo, codigoPais)
    programCode = PV_CODIGOLEALTAD
    SI logo = '625' Y existe PROGRAM_ID ENTONCES
        programCode = PROGRAM_ID  (Permite override para Infinite)
    FIN SI
SINO
    errorCode = "ERROR"
    validationMessage = "No se encontró logo para la tarjeta."
FIN SI
```

### Regla 3: Conversión de Puntos a Efectivo

**Ubicación**: `RedencionPuntosLealtadHN.proxy` - Stage "ObtenerPuntos"

**Lógica**:
```
SI validationMessage = "" Y REDEMPTION_TYPE = "CASH" ENTONCES
    Invocar canjearPuntosEfectivo(
        tipoConversion = '2',
        montoConversion = REDEMPTION_AMOUNT,
        logo = $logo,
        terminalId = CASH_REDEMPTION/TERMINAL_ID,
        merchantType = CASH_REDEMPTION/MERCHANT_TYPE,
        merchantNumber = CASH_REDEMPTION/MERCHANT_ID
    )
    totalPoints = PN_VALORSALIDA
SINO
    totalPoints = REDEMPTION_AMOUNT
FIN SI
```

### Regla 4: Selección de Backend de Redención

**Ubicación**: `RedencionPuntosLealtadHN.proxy` - Stage "Rendencion"

**Lógica**:
```
SI programCode = '1' Y matrixId != '' Y institutionName != '' ENTONCES
    // Programa Mastercard Rewards
    Invocar doItemRedemption(matrixId, totalPoints)
    redemptionId = redemptionResults[1]/redemptionId
    pointTotalRemaining = pointTotalRemaining
    
SINO SI programCode = '2' Y rewardItem != '' Y nRowsBase > 0 ENTONCES
    // Programa VisionPlus
    Invocar INSTransaccionRedencion(...)
    redemptionId = IDTransaccion
    
    SI validationMessage = '' ENTONCES
        Invocar PointsRedeem(...)
        
        SI validationMessage = '' ENTONCES
            Invocar PointsAdjustmentInquiry(accountNumber, org, scheme)
            pointTotalRemaining = GPXAIO-OPEN-TO-RED-ON-SCR / 1000
        FIN SI
    FIN SI
FIN SI
```

### Regla 5: Consulta de Información de Cliente por Tipo de ID

**Ubicación**: `RedencionPuntosLealtadHN.proxy` - Stage "ConsultaInformacionCliente"

**Lógica**:
```
SI customerIdType = "CUSTOMER_ID" ENTONCES
    Invocar T24.Consultadecliente(customerId)
    legalId = LEGALID
    customerName = SHORTNAME
    
SINO SI customerIdType = "CARD_NUMBER" ENTONCES
    Invocar sjConsultaTipoTarjeta(binNumber)
    cardType = CARD_TYPE
    
    SI cardType = "DEBIT" ENTONCES
        Invocar T24.ConsultaMaestraTarjetaDebito(cardNumber)
        legalId = CUSTOMERLEGALID
        customerName = NAMEONCARD
        
    SINO SI cardType = "CREDIT" ENTONCES
        Invocar Alcance.InformacionTarjeta(cardNumber)
        legalId = IdentificacionClienteCuenta
        customerName = NombreTarjetaHabiente
    FIN SI
    
SINO  // LEGAL_ID
    Invocar T24.Consultadecliente(legalId)
    legalId = LEGALID
    customerName = SHORTNAME
FIN SI
```

### Regla 6: Obtención de Parámetros de Configuración

**Ubicación**: `RedencionPuntosLealtadHN.proxy` - Stage "ObtenerParametrizacion"

**Parámetros**:
- `FICBCO0229.MRS.MATRIXID.HN01`: ID de matriz de recompensas Mastercard
- `FICBCO0229.MRS.INSTITUTION.NAME`: Nombre de institución para Mastercard
- `FICBCO0229.{USERNAME}.REWARDITEM`: Item de recompensa por canal (ej: 'CANJE POR SALESFORC')

**Lógica**:
```
SI programCode = '1' O programCode = '2' ENTONCES
    matrixIdParameter = 'FICBCO0229.MRS.MATRIXID.' + SourceBank
    institutionNameParameter = 'FICBCO0229.MRS.INSTITUTION.NAME'
    rewardItemParameter = 'FICBCO0229.' + upper-case(UserName) + '.REWARDITEM'
    
    Invocar ObtenerParametrizacion(matrixIdParameter || institutionNameParameter || rewardItemParameter)
    
    matrixId = CONFIGURACIONES_ITEM[NAME=matrixIdParameter]/VALUE
    institutionName = CONFIGURACIONES_ITEM[NAME=institutionNameParameter]/VALUE
    rewardItem = CONFIGURACIONES_ITEM[NAME=rewardItemParameter]/VALUE
    
    SI rewardItem = '' ENTONCES
        rewardItem = 'CANJE POR SALESFORC'  // Valor por defecto
    FIN SI
FIN SI
```

### Regla 7: Manejo de Errores y Mapeo

**Ubicación**: `RedencionPuntosLealtadHN.proxy` - Error Handler

**Lógica**:
```
SI programCode = '1' ENTONCES
    errorCode = fault/details/ReceivedFaultDetail/detail/ErrorResp/code
    validationMessage = fault/details/ReceivedFaultDetail/detail/ErrorResp/description
SINO
    errorCode = fault/errorCode
    validationMessage = fault/reason
FIN SI

Invocar MapeoErrores(errorCode, "FICBCO0229$#$" + validationMessage)
```

---

## Flujo Completo de Ejemplo

### Escenario: Redención de 500 Lempiras en Efectivo con Tarjeta de Crédito (Programa 2)

1. **Request OSB**: CARD_NUMBER=4567123456789012, REDEMPTION_TYPE=CASH, REDEMPTION_AMOUNT=500.00
2. **Validación XSD**: OK
3. **Validación Regional**: ValidaServicioRegional(FICBCO0229, HN01) → SUCCESS
4. **Consulta Info Cliente**: conInfoLealtad(HND, 4567123456789012) → legalId=0801199012345, customerName=JUAN PEREZ, cardType=CREDIT, logo=625
5. **Consulta Programa**: consultaProgramaLealtad(625, HN01) → programCode=2
6. **Conversión Puntos**: canjearPuntosEfectivo(2, 500.00, 625, TERM001, RETAIL, 123456789) → totalPoints=5000
7. **Obtener Parámetros**: ObtenerParametrizacion → rewardItem='CANJE POR SALESFORC'
8. **Consulta Datos Cuenta**: conDatoCuenta(4567123456789012, HND, '') → org=ALT, scheme=001, acc=1234567890
9. **Registro Transacción**: INSTransaccionRedencion(4567123456789012, 5000, TERM001, DESC 35, '', '', HND) → redemptionId=987654321
10. **Redención VisionPlus**: PointsRedeem(5000, CANJE POR SALESFORC, ALT, 001, 1234567890) → SVC-RETURN=P
11. **Consulta Saldo**: PointsAdjustmentInquiry(1234567890, ALT, 001) → GPXAIO-OPEN-TO-RED-ON-SCR=15000000 → pointTotalRemaining=15000
12. **Response OSB**: LEGAL_ID=0801199012345, CUSTOMER_NAME=JUAN PEREZ, POINTS_REDEEMED=5000, REMAINING_BALANCE=15000, REDEMPTION_ID=987654321

---

**Nota**: Este documento refleja la implementación AS-IS de la región HN01. Las transformaciones y reglas de negocio están extraídas directamente del código fuente OSB.
