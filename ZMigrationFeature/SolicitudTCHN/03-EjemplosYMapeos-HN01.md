# Ejemplos y Mapeos — Región HN01

## 1. Request OSB (ejemplo XML)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType"
                  xmlns:ges="http://www.ficohsa.com.hn/middleware.services/gestionesTarjetasTypes">
   <soapenv:Header>
      <aut:RequestHeader>
         <Region>
            <SourceBank>HN01</SourceBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <ges:solicitudTC>
         <ACCOUNT_NUMBER>4999880012345678901</ACCOUNT_NUMBER>
         <CARD_NUMBER></CARD_NUMBER>
         <ORG></ORG>
         <CUSTOMER_ID>00012345</CUSTOMER_ID>
         <CARD_ACTION>NEW_CARD</CARD_ACTION>
         <EMBOSSED_NAME>JUAN PEREZ LOPEZ</EMBOSSED_NAME>
         <EXPIRATION_DATE>2712</EXPIRATION_DATE>
         <CARD_HOLDER_TYPE>PRINCIPAL</CARD_HOLDER_TYPE>
         <GENERATE_PIN>YES</GENERATE_PIN>
         <PROCESS_TYPE>NORMAL</PROCESS_TYPE>
         <TYPE_CARD></TYPE_CARD>
         <TYPE_CARD_MAILER></TYPE_CARD_MAILER>
         <EMBOSSED_NAME_2></EMBOSSED_NAME_2>
         <NAME_2></NAME_2>
         <BLOCK_CODE></BLOCK_CODE>
         <PRIORYTI_PASS></PRIORYTI_PASS>
         <EMBLEM_ID></EMBLEM_ID>
         <CARD_ACTION_REASON_CODE></CARD_ACTION_REASON_CODE>
         <SPENDING_LIMIT_INDICATOR></SPENDING_LIMIT_INDICATOR>
         <PERCENTAGE_LIMIT_OF_DAILY_PURCHASE></PERCENTAGE_LIMIT_OF_DAILY_PURCHASE>
         <PERCENTAGE_MONTHLY_PURCHASE_LIMIT></PERCENTAGE_MONTHLY_PURCHASE_LIMIT>
         <ANNUAL_PURCHASE_LIMIT_PERCENTAGE></ANNUAL_PURCHASE_LIMIT_PERCENTAGE>
         <DAILY_PURCHASE_LIMIT></DAILY_PURCHASE_LIMIT>
         <MONTHLY_PURCHASE_LIMIT></MONTHLY_PURCHASE_LIMIT>
         <ANNUAL_PURCHASE_LIMIT></ANNUAL_PURCHASE_LIMIT>
         <DAILY_WITHDRAWAL_LIMIT_PERCENTAGE></DAILY_WITHDRAWAL_LIMIT_PERCENTAGE>
         <MONTHLY_WITHDRAWAL_LIMIT_PERCENTAGE></MONTHLY_WITHDRAWAL_LIMIT_PERCENTAGE>
         <ANNUAL_RETIREMENT_LIMIT_PERCENTAGE></ANNUAL_RETIREMENT_LIMIT_PERCENTAGE>
         <DAILY_WITHDRAWAL_LIMIT></DAILY_WITHDRAWAL_LIMIT>
         <MONTHLY_WITHDRAWAL_LIMIT></MONTHLY_WITHDRAWAL_LIMIT>
         <ANNUAL_WITHDRAWAL_LIMIT></ANNUAL_WITHDRAWAL_LIMIT>
      </ges:solicitudTC>
   </soapenv:Body>
</soapenv:Envelope>
```

## 2. Response OSB (ejemplo XML — caso exitoso)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType"
                  xmlns:ges="http://www.ficohsa.com.hn/middleware.services/gestionesTarjetasTypes">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>Success</successIndicator>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <ges:solicitudTCResponse>
         <LCY_ORG>101</LCY_ORG>
         <FCY_ORG>0</FCY_ORG>
         <LOGO>501</LOGO>
         <ACCOUNT_NUMBER>4999880012345678901</ACCOUNT_NUMBER>
         <CARD_NUMBER>4999880012345678</CARD_NUMBER>
         <CARD_SEQUENCE>1</CARD_SEQUENCE>
         <CHIP_SEQUENCE>0</CHIP_SEQUENCE>
      </ges:solicitudTCResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

## 3. Response OSB (ejemplo XML — caso error)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType"
                  xmlns:ges="http://www.ficohsa.com.hn/middleware.services/gestionesTarjetasTypes">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>0001</successIndicator>
         <messages>Account not found</messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <ges:solicitudTCResponse/>
   </soapenv:Body>
</soapenv:Envelope>
```

---

## 4. Requests/Responses Internos a Servicios Dependientes

### 4.1 Business Service: conDatoCuenta_db (HN)

**Tipo**: JCA / Database Adapter  
**Conexión**: `jca://eis/DB/ConnectionTarjetasHN`  
**Package**: `dbo`  
**Stored Procedure**: `OSBConDatoCuenta`  
**Operación**: `conDatoCuenta`

#### Request (InputParameters)

```xml
<ns0:InputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoCuenta">
    <ns0:Pais>HND</ns0:Pais>
    <ns0:Org></ns0:Org>
    <ns0:NumCuenta>4999880012345678901</ns0:NumCuenta>
</ns0:InputParameters>
```

**Notas**:
- `Pais` se obtiene convirtiendo el `SourceBank` del header (`HN01`) a ISO3 (`HND`) mediante `convertirCodigoPais.xqy`
- `NumCuenta` se rellena con ceros a la izquierda hasta 19 caracteres (`fn-bea:pad-left`)
- `Org` solo se incluye si viene informado en el request original

#### Response (OutputParameters)

```xml
<ns0:OutputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoCuenta">
    <ns0:RowSet>
        <ns0:Row>
            <ns0:Column name="ORG" sqltype="VARCHAR">101</ns0:Column>
            <ns0:Column name="TIPOORG" sqltype="VARCHAR">BASE</ns0:Column>
        </ns0:Row>
        <ns0:Row>
            <ns0:Column name="ORG" sqltype="VARCHAR">102</ns0:Column>
            <ns0:Column name="TIPOORG" sqltype="VARCHAR">FOREIGN</ns0:Column>
        </ns0:Row>
    </ns0:RowSet>
    <ns0:CodigoError>-1</ns0:CodigoError>
    <ns0:MensajeError></ns0:MensajeError>
</ns0:OutputParameters>
```

**Lógica de extracción del ORG**:
```xquery
let $row := $RSPConDatoCuenta/con:RowSet/con:Row
   where $row/con:Column[upper-case(@name) = 'TIPOORG' and text() = 'BASE']
return
   data($row/con:Column[upper-case(@name) = 'ORG'])
```

Se selecciona la fila donde `TIPOORG = 'BASE'` y se extrae el valor de `ORG`.

---

### 4.2 Business Service: visionPlus (EmbosserAddL8VB)

**Tipo**: HTTP / SOAP  
**Endpoint**: `http://172.28.1.145:7802/VisionPlusService`  
**Operación**: `EmbosserAddL8VB`  
**WSDL Port**: `VisionPlusServiceSOAP`  
**Namespace**: `http://www.procesa.com/services/VisionPlus`  
**Timeout**: 5 seg (request + connection)

#### Request (EmbosserAddL8VBRequest)

```xml
<fdcs:EmbosserAddL8VBRequest xmlns:fdcs="http://www.procesa.com/fdcs">
    <AZXAPI-ORG>101</AZXAPI-ORG>
    <AZXAPI-POST-TO-ACCT>4999880012345678901</AZXAPI-POST-TO-ACCT>
    <AZXAPI-CARD-NBR></AZXAPI-CARD-NBR>
    <AZXAPI-CARD-SEQ>1</AZXAPI-CARD-SEQ>
    <AZXAPI-CARD-ACTION>1</AZXAPI-CARD-ACTION>
    <AZXAPI-NBR-RQTD>1</AZXAPI-NBR-RQTD>
    <AZXAPI-TYPE-OF-CARD>1</AZXAPI-TYPE-OF-CARD>
    <AZXAPI-RQTD-CARD-TYPE>01</AZXAPI-RQTD-CARD-TYPE>
    <AZXAPI-TYPE-CARD-MAILER>01</AZXAPI-TYPE-CARD-MAILER>
    <AZXAPI-PLASTIC-ID>0</AZXAPI-PLASTIC-ID>
    <AZXAPI-NAME1-TYPE-IND>0</AZXAPI-NAME1-TYPE-IND>
    <AZXAPI-NAME2-TYPE-IND>0</AZXAPI-NAME2-TYPE-IND>
    <AZXAPI-EMBOSSED-NAME-1>JUAN PEREZ LOPEZ</AZXAPI-EMBOSSED-NAME-1>
    <AZXAPI-EMBOSSED-NAME-2></AZXAPI-EMBOSSED-NAME-2>
    <AZXAPI-SECURECODE-ACTIVATE>0</AZXAPI-SECURECODE-ACTIVATE>
    <AZXAPI-VISA-PLUS-IND>0</AZXAPI-VISA-PLUS-IND>
    <AZXAPI-PIN-DELAY-DAYS>0</AZXAPI-PIN-DELAY-DAYS>
    <AZXAPI-DATE-EXPIRE>2712</AZXAPI-DATE-EXPIRE>
    <AZXAPI-CUSTOMER-NBR>00012345</AZXAPI-CUSTOMER-NBR>
    <AZXAPI-EMBR-NAME-1></AZXAPI-EMBR-NAME-1>
    <AZXAPI-EMBR-NAME-2></AZXAPI-EMBR-NAME-2>
    <AZXAPI-PIN-OFFSET>0</AZXAPI-PIN-OFFSET>
    <AZXAPI-POS-SERVICE-CODE>201</AZXAPI-POS-SERVICE-CODE>
    <AZXAPI-CARDHOLDER-FLAG>1</AZXAPI-CARDHOLDER-FLAG>
    <AZXAPI-ADDR-LINE-1></AZXAPI-ADDR-LINE-1>
    <AZXAPI-ADDR-LINE-2></AZXAPI-ADDR-LINE-2>
    <AZXAPI-CITY></AZXAPI-CITY>
    <AZXAPI-ST-PR></AZXAPI-ST-PR>
    <AZXAPI-PSTL-CD></AZXAPI-PSTL-CD>
    <AZXAPI-LANG-CODE></AZXAPI-LANG-CODE>
    <AZXAPI-VISA-MINI-IND>0</AZXAPI-VISA-MINI-IND>
    <AZXAPI-PIN-SUPPRESSION>0</AZXAPI-PIN-SUPPRESSION>
    <AZXAPI-BLOCK-CODE></AZXAPI-BLOCK-CODE>
    <AZXAPI-CURR-CRD-ACTN>Y</AZXAPI-CURR-CRD-ACTN>
    <AZXAPI-AUTH-ATM-OTC-RTL-FREQ>0</AZXAPI-AUTH-ATM-OTC-RTL-FREQ>
    <AZXAPI-AUTH-ATM-CASH-AMT>0</AZXAPI-AUTH-ATM-CASH-AMT>
    <AZXAPI-AUTH-ATM-CASH-NBR>0</AZXAPI-AUTH-ATM-CASH-NBR>
    <AZXAPI-AUTH-ATM-CASH-SNGL-TXN>0</AZXAPI-AUTH-ATM-CASH-SNGL-TXN>
    <AZXAPI-AUTH-OTC-CASH-AMT>0</AZXAPI-AUTH-OTC-CASH-AMT>
    <AZXAPI-AUTH-OTC-CASH-NBR>0</AZXAPI-AUTH-OTC-CASH-NBR>
    <AZXAPI-AUTH-OTC-CASH-SNGL-TXN>0</AZXAPI-AUTH-OTC-CASH-SNGL-TXN>
    <AZXAPI-AUTH-RTL-AMT>0</AZXAPI-AUTH-RTL-AMT>
    <AZXAPI-AUTH-RTL-NBR>0</AZXAPI-AUTH-RTL-NBR>
    <AZXAPI-AUTH-RTL-SNGL-TXN>0</AZXAPI-AUTH-RTL-SNGL-TXN>
    <AZXAPI-AUTH-INTRNT-AMT>0</AZXAPI-AUTH-INTRNT-AMT>
    <AZXAPI-AUTH-INTRNT-NBR>0</AZXAPI-AUTH-INTRNT-NBR>
    <AZXAPI-AUTH-INTRNT-SNGL-TXN>0</AZXAPI-AUTH-INTRNT-SNGL-TXN>
    <AZXAPI-USER-1></AZXAPI-USER-1>
    <AZXAPI-USER-2></AZXAPI-USER-2>
    <AZXAPI-USER-3></AZXAPI-USER-3>
    <AZXAPI-USER-4>0</AZXAPI-USER-4>
    <AZXAPI-USER-5></AZXAPI-USER-5>
    <AZXAPI-USER-6></AZXAPI-USER-6>
    <AZXAPI-USER-7></AZXAPI-USER-7>
    <AZXAPI-USER-8></AZXAPI-USER-8>
    <AZXAPI-USER-DATE-1>0</AZXAPI-USER-DATE-1>
    <AZXAPI-USER-DATE-2>0</AZXAPI-USER-DATE-2>
    <AZXAPI-ADMIN-BRANCH>0</AZXAPI-ADMIN-BRANCH>
    <AZXAPI-REISSUE-DELIV-OPTION>0</AZXAPI-REISSUE-DELIV-OPTION>
    <AZXAPI-DATE-NEXT-EXPR>0</AZXAPI-DATE-NEXT-EXPR>
    <AZXAPI-FIRST-ISS-BRANCH>0</AZXAPI-FIRST-ISS-BRANCH>
    <AZXAPI-ISSUE-DELIV-OPTION>0</AZXAPI-ISSUE-DELIV-OPTION>
    <AZXAPI-AUTH-CRITERIA-TBL></AZXAPI-AUTH-CRITERIA-TBL>
    <AZXAPI-CARD-DELAY-DAYS>0</AZXAPI-CARD-DELAY-DAYS>
    <AZXAPI-SPND-LIMIT-TBL></AZXAPI-SPND-LIMIT-TBL>
    <AZXAPI-SPND-ARRAY>
        <AZXAPI-SPND-ELEMENT>
            <AZXAPI-SPND-LIMIT>0</AZXAPI-SPND-LIMIT>
            <AZXAPI-SPND-TRANS>0</AZXAPI-SPND-TRANS>
            <AZXAPI-SPND-FREQ>0</AZXAPI-SPND-FREQ>
        </AZXAPI-SPND-ELEMENT>
    </AZXAPI-SPND-ARRAY>
    <AZXAPI-PROGRAM-ID>0</AZXAPI-PROGRAM-ID>
    <AZXAPI-DVC-IND></AZXAPI-DVC-IND>
    <AZXAPI-SDP-PROCESS-TYPE>0</AZXAPI-SDP-PROCESS-TYPE>
    <AZXAPI-EMBLM-ID>0</AZXAPI-EMBLM-ID>
    <AZXAPI-CARD-ACTION-REASON>1</AZXAPI-CARD-ACTION-REASON>
    <AZXAPI-VBV-STATUS></AZXAPI-VBV-STATUS>
    <AZXAPI-VBV-PAM></AZXAPI-VBV-PAM>
    <AZXAPI-FALC-MARK></AZXAPI-FALC-MARK>
    <AZXAPI-FALC-MARK-ST-DATE xsi:nil="true"/>
    <AZXAPI-FALC-MARK-END-DATE xsi:nil="true"/>
    <AZXAPI-SPEND-LIMITS-STATUS>0</AZXAPI-SPEND-LIMITS-STATUS>
    <AZXAPI-RETAIL-PERCENT-DAILY>0</AZXAPI-RETAIL-PERCENT-DAILY>
    <AZXAPI-RETAIL-PERCENT-MTD>0</AZXAPI-RETAIL-PERCENT-MTD>
    <AZXAPI-RETAIL-PERCENT-YTD>0</AZXAPI-RETAIL-PERCENT-YTD>
    <AZXAPI-RETAIL-AMOUNT-DAILY>0</AZXAPI-RETAIL-AMOUNT-DAILY>
    <AZXAPI-RETAIL-AMOUNT-MTD>0</AZXAPI-RETAIL-AMOUNT-MTD>
    <AZXAPI-RETAIL-AMOUNT-YTD>0</AZXAPI-RETAIL-AMOUNT-YTD>
    <AZXAPI-CASH-PERCENT-DAILY>0</AZXAPI-CASH-PERCENT-DAILY>
    <AZXAPI-CASH-PERCENT-MTD>0</AZXAPI-CASH-PERCENT-MTD>
    <AZXAPI-CASH-PERCENT-YTD>0</AZXAPI-CASH-PERCENT-YTD>
    <AZXAPI-CASH-AMOUNT-DAILY>0</AZXAPI-CASH-AMOUNT-DAILY>
    <AZXAPI-CASH-AMOUNT-MTD>0</AZXAPI-CASH-AMOUNT-MTD>
    <AZXAPI-CASH-AMOUNT-YTD>0</AZXAPI-CASH-AMOUNT-YTD>
</fdcs:EmbosserAddL8VBRequest>
```

#### Response (EmbosserAddL8VBResponse)

```xml
<fdcs:EmbosserAddL8VBResponse xmlns:fdcs="http://www.procesa.com/fdcs">
    <ServiceReturnCode>P</ServiceReturnCode>
    <ReturnCodeCount>0</ReturnCodeCount>
    <fdcs:ReturnCodes>
        <RC>
            <Code></Code>
            <Desc></Desc>
        </RC>
    </fdcs:ReturnCodes>
    <fdcs:ReasonCodes/>
    <AZXAPO-ORG>101</AZXAPO-ORG>
    <AZXAPO-FOREIGN-ORG>0</AZXAPO-FOREIGN-ORG>
    <AZXAPO-LOGO>501</AZXAPO-LOGO>
    <AZXAPO-ACCT>4999880012345678901</AZXAPO-ACCT>
    <AZXAPO-CARD-NBR>4999880012345678</AZXAPO-CARD-NBR>
    <AZXAPO-CARD-SEQ>1</AZXAPO-CARD-SEQ>
    <AZXAPO-CURR-CHIP-SEQ>0</AZXAPO-CURR-CHIP-SEQ>
</fdcs:EmbosserAddL8VBResponse>
```

---

## 5. Cadenas de Conexión

| Servicio | Tipo | Conexión/Endpoint | Operación |
|----------|------|-------------------|-----------|
| conDatoCuenta_db | JCA/Database Adapter | `jca://eis/DB/ConnectionTarjetasHN` | `conDatoCuenta` (SP: `dbo.OSBConDatoCuenta`) |
| visionPlus | HTTP/SOAP | `http://172.28.1.145:7802/VisionPlusService` | `EmbosserAddL8VB` |

---

## 6. Tabla de Mapeo de Entrada — conDatoCuenta_db

### Request OSB → conDatoCuenta SP (via `conDatoCuentaHNIn.xqy`)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (SP) |
|---------------------|----------------------|-------------------|
| `$header/aut:RequestHeader/Region/SourceBank` | `convertirCodigoPais($codigoPais, 'OSB-ISO3')` → HN01→HND | `ns0:Pais` |
| `$body/ges:solicitudTC/ORG` | Si no vacío, se pasa directo | `ns0:Org` |
| `$body/ges:solicitudTC/ACCOUNT_NUMBER` | `fn-bea:pad-left($accountNumber, 19, '0')` | `ns0:NumCuenta` |

### Response conDatoCuenta SP → Variables Pipeline

| Campo Origen (SP) | Transformación/Script | Campo Destino (Pipeline) |
|-------------------|----------------------|--------------------------|
| `$RSPConDatoCuenta/con:CodigoError` | Asignación directa | `$errorCode` |
| `$RSPConDatoCuenta/con:MensajeError` | Si `$errorCode != '-1'` → mensaje | `$validationMessage` |
| `$RSPConDatoCuenta/con:RowSet/con:Row` | Filtro: `TIPOORG = 'BASE'`, extrae columna `ORG` | `$org` |

---

## 7. Tabla de Mapeo de Entrada — VisionPlus EmbosserAddL8VB

### Request OSB → VisionPlus (via `embosserAddL8VBNIIn.xqy`)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (VisionPlus) |
|---------------------|----------------------|---------------------------|
| `$org` (variable pipeline) | Directo como integer | `AZXAPI-ORG` |
| `solicitudTC/ACCOUNT_NUMBER` | Directo | `AZXAPI-POST-TO-ACCT` |
| `solicitudTC/CARD_NUMBER` | Directo | `AZXAPI-CARD-NBR` |
| (constante) | `1` | `AZXAPI-CARD-SEQ` |
| `solicitudTC/CARD_ACTION` | `transformarCardAction()`: NEW_CARD→1, NORMAL_REPLACEMENT→3, EMERGENCY_REPLACEMENT→6, RENOVATION→7 | `AZXAPI-CARD-ACTION` |
| (constante) | `1` | `AZXAPI-NBR-RQTD` |
| (constante) | `1` | `AZXAPI-TYPE-OF-CARD` |
| `solicitudTC/TYPE_CARD` | Si TYPE_CARD no vacío → directo; si vacío: PRINCIPAL→'01', ADDITIONAL→'00' | `AZXAPI-RQTD-CARD-TYPE` |
| `solicitudTC/TYPE_CARD_MAILER` | Si TYPE_CARD_MAILER no vacío → directo; si vacío: PRINCIPAL→'01', ADDITIONAL→'00' | `AZXAPI-TYPE-CARD-MAILER` |
| (constante) | `0` | `AZXAPI-PLASTIC-ID` |
| (constante) | `0` | `AZXAPI-NAME1-TYPE-IND` |
| (constante) | `0` | `AZXAPI-NAME2-TYPE-IND` |
| `solicitudTC/EMBOSSED_NAME` | Directo | `AZXAPI-EMBOSSED-NAME-1` |
| `solicitudTC/EMBOSSED_NAME_2` | Directo | `AZXAPI-EMBOSSED-NAME-2` |
| (constante) | `0` | `AZXAPI-SECURECODE-ACTIVATE` |
| (constante) | `0` | `AZXAPI-VISA-PLUS-IND` |
| (constante) | `0` | `AZXAPI-PIN-DELAY-DAYS` |
| `solicitudTC/EXPIRATION_DATE` | Directo | `AZXAPI-DATE-EXPIRE` |
| `solicitudTC/CUSTOMER_ID` | Directo | `AZXAPI-CUSTOMER-NBR` |
| (constante) | `''` | `AZXAPI-EMBR-NAME-1` |
| `solicitudTC/NAME_2` | Directo | `AZXAPI-EMBR-NAME-2` |
| (constante) | `0` | `AZXAPI-PIN-OFFSET` |
| (constante) | `201` | `AZXAPI-POS-SERVICE-CODE` |
| `solicitudTC/CARD_HOLDER_TYPE` | PRINCIPAL→1, ADDITIONAL→0 | `AZXAPI-CARDHOLDER-FLAG` |
| (constante) | `''` | `AZXAPI-ADDR-LINE-1` a `AZXAPI-LANG-CODE` |
| (constante) | `0` | `AZXAPI-VISA-MINI-IND` |
| `solicitudTC/GENERATE_PIN` | YES→0, NO→1 | `AZXAPI-PIN-SUPPRESSION` |
| `solicitudTC/BLOCK_CODE` | Directo | `AZXAPI-BLOCK-CODE` |
| (constante) | `Y` | `AZXAPI-CURR-CRD-ACTN` |
| (constantes) | `0` | `AZXAPI-AUTH-*` (todos los campos de autorización) |
| `solicitudTC/PRIORYTI_PASS` | Directo | `AZXAPI-USER-1` |
| (constantes) | `''` o `0` | `AZXAPI-USER-2` a `AZXAPI-USER-DATE-2` |
| (constantes) | `0` | `AZXAPI-ADMIN-BRANCH` a `AZXAPI-CARD-DELAY-DAYS` |
| (constante) | `''` | `AZXAPI-SPND-LIMIT-TBL`, `AZXAPI-AUTH-CRITERIA-TBL` |
| (constantes) | `0` | `AZXAPI-SPND-ARRAY` (limit, trans, freq) |
| (constante) | `0` | `AZXAPI-PROGRAM-ID` |
| (constante) | `''` | `AZXAPI-DVC-IND` |
| `solicitudTC/PROCESS_TYPE` | EMERGENCY→1, NORMAL→0 | `AZXAPI-SDP-PROCESS-TYPE` |
| `solicitudTC/EMBLEM_ID` | Si no vacío → directo; si vacío → 0 | `AZXAPI-EMBLM-ID` |
| `solicitudTC/CARD_ACTION_REASON_CODE` | Si no vacío → directo; si vacío → 1 | `AZXAPI-CARD-ACTION-REASON` |
| (constantes) | `''` | `AZXAPI-VBV-STATUS`, `AZXAPI-VBV-PAM`, `AZXAPI-FALC-MARK` |
| (constantes) | `xsi:nil="true"` | `AZXAPI-FALC-MARK-ST-DATE`, `AZXAPI-FALC-MARK-END-DATE` |
| `solicitudTC/SPENDING_LIMIT_INDICATOR` | Si no vacío → directo; si vacío → 0 | `AZXAPI-SPEND-LIMITS-STATUS` |
| `solicitudTC/PERCENTAGE_LIMIT_OF_DAILY_PURCHASE` | Si no vacío → directo; si vacío → 0 | `AZXAPI-RETAIL-PERCENT-DAILY` |
| `solicitudTC/PERCENTAGE_MONTHLY_PURCHASE_LIMIT` | Si no vacío → directo; si vacío → 0 | `AZXAPI-RETAIL-PERCENT-MTD` |
| `solicitudTC/ANNUAL_PURCHASE_LIMIT_PERCENTAGE` | Si no vacío → directo; si vacío → 0 | `AZXAPI-RETAIL-PERCENT-YTD` |
| `solicitudTC/DAILY_PURCHASE_LIMIT` | Si no vacío → directo; si vacío → 0 | `AZXAPI-RETAIL-AMOUNT-DAILY` |
| `solicitudTC/MONTHLY_PURCHASE_LIMIT` | Si no vacío → directo; si vacío → 0 | `AZXAPI-RETAIL-AMOUNT-MTD` |
| `solicitudTC/ANNUAL_PURCHASE_LIMIT` | Si no vacío → directo; si vacío → 0 | `AZXAPI-RETAIL-AMOUNT-YTD` |
| `solicitudTC/DAILY_WITHDRAWAL_LIMIT_PERCENTAGE` | Si no vacío → directo; si vacío → 0 | `AZXAPI-CASH-PERCENT-DAILY` |
| `solicitudTC/MONTHLY_WITHDRAWAL_LIMIT_PERCENTAGE` | Si no vacío → directo; si vacío → 0 | `AZXAPI-CASH-PERCENT-MTD` |
| `solicitudTC/ANNUAL_RETIREMENT_LIMIT_PERCENTAGE` | Si no vacío → directo; si vacío → 0 | `AZXAPI-CASH-PERCENT-YTD` |
| `solicitudTC/DAILY_WITHDRAWAL_LIMIT` | Si no vacío → directo; si vacío → 0 | `AZXAPI-CASH-AMOUNT-DAILY` |
| `solicitudTC/MONTHLY_WITHDRAWAL_LIMIT` | Si no vacío → directo; si vacío → 0 | `AZXAPI-CASH-AMOUNT-MTD` |
| `solicitudTC/ANNUAL_WITHDRAWAL_LIMIT` | Si no vacío → directo; si vacío → 0 | `AZXAPI-CASH-AMOUNT-YTD` |

---

## 8. Tabla de Mapeo de Salida — VisionPlus → Response OSB

### Response VisionPlus → Response OSB (via `solicitudTCOut.xqy`)

| Campo Origen (VisionPlus) | Transformación/Script | Campo Destino (OSB) |
|---------------------------|----------------------|---------------------|
| `AZXAPO-ORG` | Directo | `LCY_ORG` |
| `AZXAPO-FOREIGN-ORG` | Directo | `FCY_ORG` |
| `AZXAPO-LOGO` | Directo | `LOGO` |
| `AZXAPO-ACCT` | Directo | `ACCOUNT_NUMBER` |
| `AZXAPO-CARD-NBR` | Directo | `CARD_NUMBER` |
| `AZXAPO-CARD-SEQ` | Directo | `CARD_SEQUENCE` |
| `AZXAPO-CURR-CHIP-SEQ` | Directo | `CHIP_SEQUENCE` |

### Validación de éxito/error VisionPlus

| Campo | Lógica |
|-------|--------|
| `$RSPEmbosserAddL8VB/fdcs:ReturnCodes/RC[1]/Code` | Se asigna a `$errorCode` (trim) |
| `$RSPEmbosserAddL8VB/ServiceReturnCode` | Si `!= 'P'` → se extrae `RC[1]/Desc` como `$validationMessage` |

---

## 9. Reglas de Negocio Detectadas

### RN-01: Resolución de ORG cuando viene vacío

**Ubicación**: Pipeline `HN01_SolicitudTC_request`, Stage `FlujoEntrada`, primer `ifThenElse`

```xquery
fn:string($body/ges:solicitudTC/ORG/text()) = ""
```

Si el campo `ORG` del request está vacío:
1. Convierte `SourceBank` (HN01) a ISO3 (HND) usando `convertirCodigoPais.xqy`
2. Invoca SP `dbo.OSBConDatoCuenta` con país, org vacío y número de cuenta (pad-left 19)
3. Del resultado filtra `TIPOORG = 'BASE'` y extrae el `ORG`

Si `ORG` viene informado, se usa directamente.

### RN-02: Validación de ORG antes de invocar VisionPlus

**Ubicación**: Pipeline `HN01_SolicitudTC_request`, Stage `FlujoEntrada`, segundo `ifThenElse`

```xquery
$org != ""
```

Solo si se obtuvo un ORG válido (no vacío) se procede a invocar VisionPlus. Si `$org` quedó vacío (SP no retornó resultados), no se invoca VP y el flujo continúa al response pipeline donde se evalúa `$validationMessage`.

### RN-03: Transformación de CARD_ACTION

**Ubicación**: `embosserAddL8VBNIIn.xqy`, función `transformarCardAction()`

| Valor Entrada | Valor VP |
|---------------|----------|
| NEW_CARD | 1 |
| NORMAL_REPLACEMENT | 3 |
| EMERGENCY_REPLACEMENT | 6 |
| RENOVATION | 7 |

### RN-04: Determinación de CARD_TYPE y CARD_MAILER por CARD_HOLDER_TYPE

**Ubicación**: `embosserAddL8VBNIIn.xqy`

Si `TYPE_CARD` o `TYPE_CARD_MAILER` vienen vacíos, se determina por `CARD_HOLDER_TYPE`:
- PRINCIPAL → `01`
- ADDITIONAL → `00`

### RN-05: PIN Suppression inversa

**Ubicación**: `embosserAddL8VBNIIn.xqy`

| GENERATE_PIN | AZXAPI-PIN-SUPPRESSION |
|--------------|------------------------|
| YES | 0 (no suprimir → generar PIN) |
| NO | 1 (suprimir → no generar PIN) |

### RN-06: Determinación de CARDHOLDER-FLAG

**Ubicación**: `embosserAddL8VBNIIn.xqy`

| CARD_HOLDER_TYPE | AZXAPI-CARDHOLDER-FLAG |
|------------------|------------------------|
| PRINCIPAL | 1 |
| ADDITIONAL | 0 |

### RN-07: Tipo de Proceso (SDP)

**Ubicación**: `embosserAddL8VBNIIn.xqy`

| PROCESS_TYPE | AZXAPI-SDP-PROCESS-TYPE |
|--------------|-------------------------|
| EMERGENCY | 1 |
| NORMAL | 0 |

### RN-08: Evaluación de respuesta exitosa

**Ubicación**: Pipeline `HN01_SolicitudTC_response`, Stage `FlujoSalida`

```xquery
$validationMessage = ""
```

- Si `$validationMessage` vacío → Respuesta exitosa con `successIndicator = "Success"` y body con datos de `solicitudTCOut.xqy`
- Si `$validationMessage` no vacío → Respuesta de error con `successIndicator = $errorCode` y `messages = $validationMessage`, body vacío (`<ges:solicitudTCResponse/>`)

### RN-09: Validación de éxito VisionPlus

**Ubicación**: Pipeline `HN01_SolicitudTC_request`, responseTransform del wsCallout VisionPlus

```xquery
let $svnReturn := $RSPEmbosserAddL8VB/ServiceReturnCode/text()
return if ($svnReturn != 'P') then(
    fn-bea:trim(xs:string($RSPEmbosserAddL8VB/fdcs:ReturnCodes/RC[1]/Desc/text()))
) else ("")
```

`ServiceReturnCode = 'P'` indica éxito. Cualquier otro valor se considera error.
