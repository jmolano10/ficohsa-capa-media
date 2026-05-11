# 03 - Ejemplos y Mapeos: Región HN01

## Mapeo de Entrada (registrarTransaccionCupon.xq)

Transforma el mensaje ISO8583 a los parámetros del SP `MW_P_REGISTRAR_BILLETERA_CUPON`:

| Campo Destino (SP) | Campo Origen (ISO8583) | Transformación |
|--------------------|----------------------|----------------|
| PV_RETRIEVAL_REF | RetrievalReferenceNumber_037 | Directo |
| PV_TERMINAR_REFERENCE | SystemTraceAuditNumber_011 | Directo |
| PV_TERMINAL_ID | CardAcceptorTerminalIdentification_041 | Directo |
| PV_CUPON_ID | AdditionalDataPrivate_048 | Directo |
| PV_AMOUNT | AmountTransaction_004 | Directo (sin dividir entre 100) |
| PV_CURRENCY | CurrencyCodeTransaction_049 | Directo |

## Mapeo de Entrada al Proxy RetiroATMConCupon (retiroATMConCuponIn.xq)

| Campo Destino | Campo Origen (ISO8583) | Transformación |
|---------------|----------------------|----------------|
| AMOUNT | AmountTransaction_004 | `div 100` (centavos a unidades) |
| COUPON_ID | AdditionalDataPrivate_048 | Directo |
| TERMINAL_ID | CardAcceptorTerminalIdentification_041 | `fn-bea:trim()` |
| CHANNEL | — | Constante: "ATM" |
| CURRENCY | CurrencyCodeTransaction_049 | 340→"HNL", 840→"USD" |
| TERMINAL_REFERENCE | SystemTraceAuditNumber_011 | Directo |
| RETRIEVAL_REF_NUMBER | RetrievalReferenceNumber_037 | Directo |

## Mapeo de Salida (retiroATMConCuponOut.xq)

Transforma la respuesta del proxy hijo + body original a respuesta ISO8583:

| Campo Destino (ISO8583) | Origen | Transformación |
|-------------------------|--------|----------------|
| MTI | — | Constante: "0210" |
| ResponseCode_039 | successIndicator | SUCCESS→"00", ERROR→"80", otro→literal |
| TransmissionDateTime_007 | — | `current-dateTime()` formato MMddHHmmss |
| AmountTransaction_004 | Original / 100 | División entre 100 |
| AmountSettlement_005 | Original / 100 | División entre 100 |
| AmountCardholderBilling_006 | Original / 100 | División entre 100 |
| ReservedForPrivateUse_121 | retiroATMConCuponResponse | Solo si SUCCESS: voucher con datos concatenados |
| Demás campos | Body original | Pass-through directo |

### Formato del Voucher (Campo 121 - Éxito):
```
Ficohsa;{CardAcceptorNameLocation_043};{TRANSACTION_DATE yyyy-MM-dd HH:mm};{SystemTraceAuditNumber_011};{AUTORIZATION_NUMBER};RETIRO CUPON;{AmountTransaction_004/100}; Comprometidos a ser los mejores "GRACIAS POR USAR NUESTROS CAJEROS"
```

## Ejemplo Request ISO8583 (Retiro MTI 0200)

```xml
<proc:procesaMensajeGenericoSwitchFacadeRequest>
  <ISO8583>
    <ISO8583_HEADER/>
    <ISO8583_XML_CONTENT>
      <MTI>0200</MTI>
      <PrimaryAccountNumber_002>4000123456789012</PrimaryAccountNumber_002>
      <ProcessingCode_003>012000</ProcessingCode_003>
      <AmountTransaction_004>50000</AmountTransaction_004>
      <SystemTraceAuditNumber_011>123456</SystemTraceAuditNumber_011>
      <RetrievalReferenceNumber_037>REF123456789</RetrievalReferenceNumber_037>
      <CardAcceptorTerminalIdentification_041>ATM00001</CardAcceptorTerminalIdentification_041>
      <AdditionalDataPrivate_048>CUPON-ABC-123</AdditionalDataPrivate_048>
      <CurrencyCodeTransaction_049>340</CurrencyCodeTransaction_049>
    </ISO8583_XML_CONTENT>
  </ISO8583>
</proc:procesaMensajeGenericoSwitchFacadeRequest>
```

## Ejemplo Invocación SP registraTrxCuponTengoATM

```xml
<ns1:InputParameters>
  <ns1:PV_RETRIEVAL_REF>REF123456789</ns1:PV_RETRIEVAL_REF>
  <ns1:PV_TERMINAR_REFERENCE>123456</ns1:PV_TERMINAR_REFERENCE>
  <ns1:PV_TERMINAL_ID>ATM00001</ns1:PV_TERMINAL_ID>
  <ns1:PV_CUPON_ID>CUPON-ABC-123</ns1:PV_CUPON_ID>
  <ns1:PV_AMOUNT>50000</ns1:PV_AMOUNT>
  <ns1:PV_CURRENCY>340</ns1:PV_CURRENCY>
</ns1:InputParameters>
```

## Ejemplo Response SP

```xml
<ns1:OutputParameters>
  <ns1:PV_CODIGO_ERROR/>
  <ns1:PV_MENSAJE_ERROR/>
</ns1:OutputParameters>
```
