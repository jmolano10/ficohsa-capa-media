# Ejemplos y Mapeos - HN01 (Honduras)

## 1. Request OSB (ejemplo XML)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
    xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaOfertaCreditoConsumoTypes"
    xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
  <soapenv:Header>
    <aut:RequestHeader>
      <SourceBank>HN01</SourceBank>
      <Channel>DIGITAL</Channel>
      <User>USR_APP</User>
    </aut:RequestHeader>
  </soapenv:Header>
  <soapenv:Body>
    <con:consultaOfertaCreditoConsumoRequest>
      <CASE_ID>CASO-2024-001</CASE_ID>
      <PRODUCT_NATURE>CONSUMO</PRODUCT_NATURE>
      <CUSTOMER_INFO>
        <ID>0801199900001</ID>
        <TYPE>ASALARIADO</TYPE>
        <TOTAL_SALARY>45000.00</TOTAL_SALARY>
        <NET_SALARY>38000.00</NET_SALARY>
        <PAYROLL_SALARY>45000.00</PAYROLL_SALARY>
        <GENDER>M</GENDER>
        <TARGET>PREMIUM</TARGET>
        <JOB_TYPE>DEPENDIENTE</JOB_TYPE>
      </CUSTOMER_INFO>
      <EXTERNAL_SCORE>720.0</EXTERNAL_SCORE>
      <SCORE_INFO>
        <QUALIFICATION>A</QUALIFICATION>
        <RISK_LEVEL>BAJO</RISK_LEVEL>
        <SCORE_CALCULATION>750.0</SCORE_CALCULATION>
      </SCORE_INFO>
      <LIABILITIES>
        <CREDIT_CARDS_INFO>
          <CREDIT_CARD>
            <ACCOUNT>4000123456789012</ACCOUNT>
            <PRODUCT>VISA_ORO</PRODUCT>
            <STATUS>VIGENTE</STATUS>
            <CURRENT_LIMIT>50000.00</CURRENT_LIMIT>
            <CURRENT_BALANCE>12000.00</CURRENT_BALANCE>
            <BEHAVIOR_SCORE>680.0</BEHAVIOR_SCORE>
          </CREDIT_CARD>
        </CREDIT_CARDS_INFO>
      </LIABILITIES>
      <REFERENCES_DETAILS>
        <ACTIVE_REFERENCES>
          <REFERENCE>
            <CREDITOR>BANCO FICOHSA</CREDITOR>
            <REFERENCE_NUMBER>REF-001</REFERENCE_NUMBER>
            <TYPE>DIRECTA</TYPE>
            <STATUS>VIGENTE</STATUS>
            <BALANCE>150000.00</BALANCE>
            <INSTALLMENT>5200.00</INSTALLMENT>
            <CURRENCY>LPS</CURRENCY>
            <TERM>60.0</TERM>
          </REFERENCE>
        </ACTIVE_REFERENCES>
      </REFERENCES_DETAILS>
    </con:consultaOfertaCreditoConsumoRequest>
  </soapenv:Body>
</soapenv:Envelope>
```

## 2. Response OSB (ejemplo XML – caso exitoso)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
    xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaOfertaCreditoConsumoTypes"
    xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
  <soapenv:Header>
    <aut:ResponseHeader>
      <successIndicator>Success</successIndicator>
    </aut:ResponseHeader>
  </soapenv:Header>
  <soapenv:Body>
    <con:consultaOfertaCreditoConsumoResponse>
      <CASE_ID>CASO-2024-001</CASE_ID>
      <GENERAL_RCI>0.35</GENERAL_RCI>
      <GENERAL_RCI_MAX>0.50</GENERAL_RCI_MAX>
      <GENERAL_CURRENT_NDE>0.28</GENERAL_CURRENT_NDE>
      <GENERAL_FINAL_NDE>0.42</GENERAL_FINAL_NDE>
      <CREDIT_CARD_SCORE>680</CREDIT_CARD_SCORE>
      <INTERNAL_SCORE>750.0</INTERNAL_SCORE>
      <CREDIT_CARD_RISK_LEVEL>MEDIO</CREDIT_CARD_RISK_LEVEL>
      <INTERNAL_RISK_LEVEL>BAJO</INTERNAL_RISK_LEVEL>
      <EXTERNAL_RISK_LEVEL>A</EXTERNAL_RISK_LEVEL>
      <CUSTOMER_SEGMENT>PREMIUM</CUSTOMER_SEGMENT>
      <CUSTOMER_SUBSEGMENT>PREMIUM_ALTO</CUSTOMER_SUBSEGMENT>
      <CURRENT_EXPOSURE>162000.0</CURRENT_EXPOSURE>
      <GLOBAL_EXPOSURE_LOCAL_CCY>162000.0</GLOBAL_EXPOSURE_LOCAL_CCY>
      <GLOBAL_EXPOSURE_FOREIGN_CCY>6600.0</GLOBAL_EXPOSURE_FOREIGN_CCY>
      <CREDIT_CARD_OVERDRAFT>0.0</CREDIT_CARD_OVERDRAFT>
      <CREDIT_REFERENCES>3</CREDIT_REFERENCES>
      <INTERNAL_LOAN_REFERENCES>1</INTERNAL_LOAN_REFERENCES>
      <REWRITE_REFERENCES>0</REWRITE_REFERENCES>
      <TOTAL_EXTRA>0</TOTAL_EXTRA>
      <TOTAL_RISK>162000.0</TOTAL_RISK>
      <CURRENT_ARREAR>0</CURRENT_ARREAR>
      <CURRENT_ARREAR_BALANCE>0.0</CURRENT_ARREAR_BALANCE>
      <CREDIT_EXPERIENCE>5</CREDIT_EXPERIENCE>
      <ARREAR_ON_60DAYS_FOR_6MONTHS>0</ARREAR_ON_60DAYS_FOR_6MONTHS>
      <ARREAR_ON_60DAYS_FOR_12MONTHS>0</ARREAR_ON_60DAYS_FOR_12MONTHS>
      <ARREAR_ON_90DAYS_FOR_12MONTHS>0</ARREAR_ON_90DAYS_FOR_12MONTHS>
      <RESOLUTIONS>
        <RESOLUTION>
          <RESOLUTION_ID>APROBADO</RESOLUTION_ID>
          <RESOLUTION_DESCRIPTION>Crédito aprobado</RESOLUTION_DESCRIPTION>
        </RESOLUTION>
      </RESOLUTIONS>
      <RESOLUTION_OFFERS>
        <OFFER>
          <PRODUCT_CODE>CONSUMO_01</PRODUCT_CODE>
          <RATE>18.5</RATE>
          <INSTALLMENT>8500.0</INSTALLMENT>
          <FOR_12_MONTHS>95000.0</FOR_12_MONTHS>
          <FOR_24_MONTHS>175000.0</FOR_24_MONTHS>
          <FOR_36_MONTHS>240000.0</FOR_36_MONTHS>
          <FOR_48_MONTHS>300000.0</FOR_48_MONTHS>
          <FOR_60_MONTHS>350000.0</FOR_60_MONTHS>
          <FOR_MAX_AMOUNT>350000.0</FOR_MAX_AMOUNT>
          <MAX_OFFER>350000.0</MAX_OFFER>
          <RCI>0.35</RCI>
          <TIMESINCOME>8</TIMESINCOME>
        </OFFER>
      </RESOLUTION_OFFERS>
    </con:consultaOfertaCreditoConsumoResponse>
  </soapenv:Body>
</soapenv:Envelope>
```

---

## 3. Requests/Responses Internos a Servicios Dependientes

### 3.1. ConsultaConsolidadaRiesgoClienteHN

**Request interno** (generado por `consultaConsolidadoRiesgoClienteIn.xqy`):

```xml
<ns0:consultaConsolidadaRiesgoCliente xmlns:ns0="http://www.ficohsa.com.hn/middleware.services/consultaConsolidadaRiesgoClienteTypes">
  <CUSTOMER_LEGAL_ID>0801199900001</CUSTOMER_LEGAL_ID>
</ns0:consultaConsolidadaRiesgoCliente>
```

**Response interno**: Variable `$RESConsultaConsRiesgoCliente` – contiene la respuesta completa del servicio de riesgo consolidado.

---

### 3.2. TokenizacionProcesamientoBlazeProxyService

**Request interno**: Se envía el body completo del request (wrapped=false) y header.

**Response interno**: Variable `$RSPTokenizacion` – se extrae `$tokenApi = data($RSPTokenizacion)` (string del token).

---

### 3.3. blazeCloudApiRestBS (FICO Blaze Cloud)

**Request interno** (generado por `consultaOfertaCreditoConsumoCloudIn.xqy`):

```xml
<ns3:epOriginacionesHonduras xmlns:ns3="http://fico.com/blaze/advisor/rma/">
  <arg0>
    <accion>...</accion>
    <activos>...</activos>
    <antiguedadLaboral>...</antiguedadLaboral>
    <canalDeVenta>...</canalDeVenta>
    <edad>...</edad>
    <estadoCivil>...</estadoCivil>
    <identidad>0801199900001</identidad>
    <prestamos>
      <transaccionesPrestamo>...</transaccionesPrestamo>
      <valorCuota>5200.0</valorCuota>
    </prestamos>
    <referencias>
      <acreedor>BANCO FICOHSA</acreedor>
      <cuota>5200.0</cuota>
      <estado>VIGENTE</estado>
      <moneda>LPS</moneda>
      <saldoActual>150000.0</saldoActual>
      <tipoReferencia>DIRECTA</tipoReferencia>
    </referencias>
    <salarioBruto>45000.0</salarioBruto>
    <salarioNeto>38000.0</salarioNeto>
    <salarioPlanilla>45000.0</salarioPlanilla>
    <score>
      <calificacionScore>A</calificacionScore>
      <nivelRiesgo>BAJO</nivelRiesgo>
      <score>750.0</score>
    </score>
    <scoreBuro>720.0</scoreBuro>
    <segmentoCliente>PREMIUM</segmentoCliente>
    <sexo>M</sexo>
    <tarjetas>
      <behaviorScore>680.0</behaviorScore>
      <estado>VIGENTE</estado>
      <limiteActual>50000.0</limiteActual>
      <numeroCuenta>4000123456789012</numeroCuenta>
      <producto>VISA_ORO</producto>
      <saldoActual>12000.0</saldoActual>
    </tarjetas>
    <tasaConvenio>...</tasaConvenio>
    <tipoCliente>ASALARIADO</tipoCliente>
    <tipoTrabajo>DEPENDIENTE</tipoTrabajo>
  </arg0>
</ns3:epOriginacionesHonduras>
```

**Header HTTP enviado**:
```
Authorization: Bearer <tokenApi>
```

**Response interno** (`$RSPBlazeCloudApi`):

```xml
<ns1:epOriginacionesHondurasResponse xmlns:ns1="http://fico.com/blaze/advisor/rma/">
  <return>
    <numeroSolicitud>CASO-2024-001</numeroSolicitud>
    <RCI>0.35</RCI>
    <RCIMax>0.50</RCIMax>
    <NDEActual>0.28</NDEActual>
    <NDEFinal>0.42</NDEFinal>
    <behaviorScoreTC>680</behaviorScoreTC>
    <score>
      <score>750.0</score>
      <nivelRiesgo>BAJO</nivelRiesgo>
    </score>
    <nivelRiesgoTC>MEDIO</nivelRiesgoTC>
    <calificacionBuro>A</calificacionBuro>
    <segmentoCliente>PREMIUM</segmentoCliente>
    <subSegmentoCliente>PREMIUM_ALTO</subSegmentoCliente>
    <exposicionActual>162000.0</exposicionActual>
    <exposicionGlobal>162000.0</exposicionGlobal>
    <exposicionGlobalUSD>6600.0</exposicionGlobalUSD>
    <noSobregiroTC>0.0</noSobregiroTC>
    <noReferenciasCrediticias>3</noReferenciasCrediticias>
    <noReferenciasPtmo>1</noReferenciasPtmo>
    <noReferenciasSR>0</noReferenciasSR>
    <totalExtrafinanciamientos>0</totalExtrafinanciamientos>
    <riesgoTotal>162000.0</riesgoTotal>
    <moraActualInterna>0</moraActualInterna>
    <saldoMoraActualInterna>0.0</saldoMoraActualInterna>
    <expCrediticia>5</expCrediticia>
    <vecesMora60_6m>0</vecesMora60_6m>
    <vecesMora60_12m>0</vecesMora60_12m>
    <vecesMora90_12m>0</vecesMora90_12m>
    <oferta>
      <arrayResolucion>
        <codResolucion>APROBADO</codResolucion>
        <descripcionResolucion>Crédito aprobado</descripcionResolucion>
      </arrayResolucion>
      <codProducto>CONSUMO_01</codProducto>
      <tasa>18.5</tasa>
      <cuota>8500.0</cuota>
      <monto12>95000.0</monto12>
      <monto24>175000.0</monto24>
      <monto36>240000.0</monto36>
      <monto48>300000.0</monto48>
      <monto60>350000.0</monto60>
      <montoMax>350000.0</montoMax>
      <ofertaMax>350000.0</ofertaMax>
      <RCI>0.35</RCI>
      <timesIncome>8</timesIncome>
    </oferta>
    <tarjetas>...</tarjetas>
  </return>
</ns1:epOriginacionesHondurasResponse>
```

---

### 3.4. AlmacenaInformacionOfertaHonduras_db (publish/fire-and-forget)

**Request interno** (generado por `almacenaInformacionHondurasIN.xqy`):

```xml
<ns1:InputParameters xmlns:ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/AlmacenaInformacionOfertaHonduras">
  <ns1:IDENTIDAD>0801199900001</ns1:IDENTIDAD>
  <ns1:XML>&lt;ns1:epOriginacionesHondurasResponse...&gt;...&lt;/ns1:epOriginacionesHondurasResponse&gt;</ns1:XML>
</ns1:InputParameters>
```

---

## 4. Cadenas de Conexión y Credenciales

| Servicio | Tipo | Endpoint / Conexión | Detalle |
|----------|------|---------------------|---------|
| blazeCloudApiRestBS | REST API | `https://app.dms.uset2.ficoanalyticcloud.com/34ahtjvkip/A5JJwBSiBLVtg1DwTkNlOAeKKbL/RmaDynamicWebService/solutionid/34ahtjvkip` | Operación: `epOriginacionesHonduras`, Auth: Bearer Token |
| AlmacenaInformacionOfertaHonduras_db | JCA/DB | `jca://eis/DB/ConnectionCustomerCreditRisk` | Schema: `CREDITOS_RIESGOS`, Package: `HN_ONBASE`, SP: `AlmacenaInformacionOfertaHonduras` |
| ConsultaConsolidadaRiesgoClienteHN | Proxy OSB | `Middleware/v2/ProxyServices/ConsultaConsolidadaRiesgoClienteHN` | Operación: `consultaConsolidadaRiesgoCliente` |
| TokenizacionProcesamientoBlazeProxyService | Proxy OSB | `Middleware/v2/ProxyServices/TokenizacionProcesamientoBlazeProxyService` | Operación: `tokenizacionProcesamientoBlaze` |

---

## 5. Tablas de Mapeo de Entrada – Llamada a blazeCloudApiRestBS

**XQuery**: `consultaOfertaCreditoConsumoCloudIn.xqy`

| Campo Origen (OSB) | Transformación/Script | Campo Destino (Blaze API) |
|--------------------|-----------------------|---------------------------|
| `CUSTOMER_INFO/ID` | directo | `identidad` |
| `CUSTOMER_INFO/TYPE` | directo | `tipoCliente` |
| `CUSTOMER_INFO/TOTAL_SALARY` | `xs:float()` | `salarioBruto` |
| `CUSTOMER_INFO/NET_SALARY` | `xs:float()` | `salarioNeto` |
| `CUSTOMER_INFO/PAYROLL_SALARY` | `xs:float()` | `salarioPlanilla` |
| `CUSTOMER_INFO/GENDER` | directo | `sexo` |
| `CUSTOMER_INFO/TARGET` | directo | `segmentoCliente` |
| `CUSTOMER_INFO/JOB_TYPE` | for-each | `tipoTrabajo` |
| `EXTERNAL_SCORE` | `xs:float()` | `scoreBuro` |
| `SCORE_INFO/QUALIFICATION` | for-each | `score/calificacionScore` |
| `SCORE_INFO/RISK_LEVEL` | for-each | `score/nivelRiesgo` |
| `SCORE_INFO/SCORE_CALCULATION` | `xs:float()` | `score/score` |
| `AGREEMENT/RATE` | `xs:float()` | `tasaConvenio` |
| `LIABILITIES/CREDIT_CARDS_INFO/CREDIT_CARD` | for-each | `tarjetas` (array) |
| `CREDIT_CARD/ACCOUNT` | directo | `tarjetas/numeroCuenta` |
| `CREDIT_CARD/PRODUCT` | for-each | `tarjetas/producto` |
| `CREDIT_CARD/STATUS` | directo | `tarjetas/estado` |
| `CREDIT_CARD/CURRENT_LIMIT` | `xs:float()` | `tarjetas/limiteActual` |
| `CREDIT_CARD/CURRENT_BALANCE` | `xs:float()` | `tarjetas/saldoActual` |
| `CREDIT_CARD/BEHAVIOR_SCORE` | `xs:float()` | `tarjetas/behaviorScore` |
| `CREDIT_CARD/CLOSING_BALANCE` | `xs:float()` | `tarjetas/saldoCorte` |
| `CREDIT_CARD/EXTRA_BALANCE` | `xs:float()` | `tarjetas/saldoExtra` |
| `CREDIT_CARD/INTRA_BALANCE` | `xs:float()` | `tarjetas/saldoIntra` |
| `CREDIT_CARD/CLEARING_MODEL` | directo | `tarjetas/modeloLiquidacion` |
| `CREDIT_CARD/CURRENT_DUE` | `xs:int()` | `tarjetas/moraActual` |
| `CREDIT_CARD/OPENING_DATE` | `xs:date()` | `tarjetas/fechaApertura` |
| `CREDIT_CARD/CANCELATION_DATE` | `xs:date()` | `tarjetas/fechaCancelacion` |
| `CREDIT_CARD/CASH_DISCOUNT_DATE` | `xs:date()` | `tarjetas/fechaDescuentoContado` |
| `CREDIT_CARD/LAST_EXTRA_DATE` | `xs:date()` | `tarjetas/fechaUltimoExtra` |
| `CREDIT_CARD/ACTIVE_EXTRA_INSTALLMENTS` | `xs:float()` | `tarjetas/cuotasExtraVigentes` |
| `CREDIT_CARD/TRANSACTION/EXTRA_FEE` | for-each | `tarjetas/transaccionesTarjeta/cuota_extra` |
| `CREDIT_CARD/TRANSACTION/INTRA_FEE` | for-each | `tarjetas/transaccionesTarjeta/cuota_intra` |
| `CREDIT_CARD/TRANSACTION/EXTRA_BALANCE` | for-each | `tarjetas/transaccionesTarjeta/saldo_extra` |
| `CREDIT_CARD/TRANSACTION/INTRA_BALANCE` | for-each | `tarjetas/transaccionesTarjeta/saldo_intra` |
| `REFERENCES_DETAILS/ACTIVE_REFERENCES/REFERENCE` | for-each | `referencias` (array) |
| `REFERENCE/CREDITOR` | condicional (string-length > 0) | `referencias/acreedor` |
| `REFERENCE/HISTORICAL_COUNT_DOL` | directo | `referencias/conteoHistoricoDol` |
| `REFERENCE/HISTORICAL_COUNT_LOC` | directo | `referencias/conteoHistoricoLoc` |
| `REFERENCE/INSTALLMENT` | `xs:float()` | `referencias/cuota` |
| `REFERENCE/STATUS` | directo | `referencias/estado` |
| `REFERENCE/EXCHANGE_FACTOR` | `xs:float()` | `referencias/factorCambio` |
| `REFERENCE/OPENING_DATE` | `xs:date()` | `referencias/fechaApertura` |
| `REFERENCE/CANCELATION_DATE` | `xs:date()` | `referencias/fechaCancelacion` |
| `REFERENCE/EXPIRATION_DATE` | `xs:date()` | `referencias/fechaVencimiento` |
| `REFERENCE/LIMIT` | `xs:float()` | `referencias/limiteMonto` |
| `REFERENCE/CURRENCY` | directo | `referencias/moneda` |
| `REFERENCE/HISTORICAL_ARREAR` | directo | `referencias/moraHistorica` |
| `REFERENCE/ARREAR_LEVEL` | directo | `referencias/nivelMora` |
| `REFERENCE/REFERENCE_NUMBER` | directo | `referencias/noReferencia` |
| `REFERENCE/PERIOD` | directo | `referencias/periodoInfo` |
| `REFERENCE/TERM` | `xs:float()` | `referencias/plazo` |
| `REFERENCE/BALANCE` | `xs:float()` | `referencias/saldoActual` |
| `REFERENCE/PUNISHED_BALANCE` | `xs:float()` | `referencias/saldoCastigado` |
| `REFERENCE/DUE_BALANCE` | `xs:float()` | `referencias/saldoCobroJudicial` |
| `REFERENCE/ARREAR_BALANCE` | `xs:float()` | `referencias/saldoMora` |
| `REFERENCE/GUARANTEE_TYPE` | directo | `referencias/tipoGarantia` |
| `REFERENCE/OBLIGATION_TYPE` | directo | `referencias/tipoObligacion` |
| `REFERENCE/CREDIT_TYPE` | directo | `referencias/tipoPrestamo` |
| `REFERENCE/TYPE` | directo | `referencias/tipoReferencia` |
| `REFERENCES_DETAILS/HISTORICAL_REFERENCES/REFERENCE` | for-each (mismo mapeo que activas) | `referencias` (array) |

> **Nota**: También se mapean las referencias históricas con exactamente la misma estructura que las activas.

---

## 6. Tablas de Mapeo de Salida – Respuesta de blazeCloudApiRestBS

**XQuery**: `consultaOfertaCreditoConsumoCloudOut.xqy`

| Campo Origen (Blaze API) | Transformación/Script | Campo Destino (OSB) |
|--------------------------|----------------------|---------------------|
| `return/numeroSolicitud` | directo | `CASE_ID` |
| `return/RCI` | `xs:float()` | `GENERAL_RCI` |
| `return/RCIMax` | `xs:float()` | `GENERAL_RCI_MAX` |
| `return/NDEActual` | `xs:float()` | `GENERAL_CURRENT_NDE` |
| `return/NDEFinal` | `xs:float()` | `GENERAL_FINAL_NDE` |
| `return/behaviorScoreTC` | `xs:int()` | `CREDIT_CARD_SCORE` |
| `return/score/score` | `xs:float()` | `INTERNAL_SCORE` |
| `return/nivelRiesgoTC` | `xs:string()` | `CREDIT_CARD_RISK_LEVEL` |
| `return/score/nivelRiesgo` | `xs:string()` | `INTERNAL_RISK_LEVEL` |
| `return/calificacionBuro` | `xs:string()` | `EXTERNAL_RISK_LEVEL` |
| `return/segmentoCliente` | `xs:string()` | `CUSTOMER_SEGMENT` |
| `return/subSegmentoCliente` | `xs:string()` | `CUSTOMER_SUBSEGMENT` |
| `return/exposicionActual` | `xs:float()` | `CURRENT_EXPOSURE` |
| `return/exposicionGlobal` | `xs:float()` | `GLOBAL_EXPOSURE_LOCAL_CCY` |
| `return/exposicionGlobalUSD` | `xs:float()` | `GLOBAL_EXPOSURE_FOREIGN_CCY` |
| `return/noSobregiroTC` | `xs:float()` | `CREDIT_CARD_OVERDRAFT` |
| `return/noReferenciasCrediticias` | `xs:int()` | `CREDIT_REFERENCES` |
| `return/noReferenciasPtmo` | `xs:int()` | `INTERNAL_LOAN_REFERENCES` |
| `return/noReferenciasSR` | `xs:int()` | `REWRITE_REFERENCES` |
| `return/totalExtrafinanciamientos` | `xs:int()` | `TOTAL_EXTRA` |
| `return/riesgoTotal` | `xs:float()` | `TOTAL_RISK` |
| `return/moraActualInterna` | `xs:int()` | `CURRENT_ARREAR` |
| `return/saldoMoraActualInterna` | `xs:float()` | `CURRENT_ARREAR_BALANCE` |
| `return/expCrediticia` | `xs:int()` | `CREDIT_EXPERIENCE` |
| `return/vecesMora60_6m` | `xs:int()` | `ARREAR_ON_60DAYS_FOR_6MONTHS` |
| `return/vecesMora60_12m` | `xs:int()` | `ARREAR_ON_60DAYS_FOR_12MONTHS` |
| `return/vecesMora90_12m` | `xs:int()` | `ARREAR_ON_90DAYS_FOR_12MONTHS` |
| `return/oferta/arrayResolucion/codResolucion` | for-each, `xs:string()` | `RESOLUTIONS/RESOLUTION/RESOLUTION_ID` |
| `return/oferta/arrayResolucion/descripcionResolucion` | for-each, `xs:string()` | `RESOLUTIONS/RESOLUTION/RESOLUTION_DESCRIPTION` |
| `return/oferta/codProducto` | for-each, `xs:string()` | `RESOLUTION_OFFERS/OFFER/PRODUCT_CODE` |
| `return/oferta/tasa` | `xs:float()` | `RESOLUTION_OFFERS/OFFER/RATE` |
| `return/oferta/cuota` | `xs:float()` | `RESOLUTION_OFFERS/OFFER/INSTALLMENT` |
| `return/oferta/cuotaNDE` | `xs:float()` | `RESOLUTION_OFFERS/OFFER/INSTALLMENT_NDE` |
| `return/oferta/cuotaRCI_NONP2C` | `xs:float()` | `RESOLUTION_OFFERS/OFFER/INSTALLMENT_RCI_NONP2C` |
| `return/oferta/cuotaRCI_P2C` | `xs:float()` | `RESOLUTION_OFFERS/OFFER/INSTALLMENT_RCI_P2C` |
| `return/oferta/monto12` | `xs:float()` | `RESOLUTION_OFFERS/OFFER/FOR_12_MONTHS` |
| `return/oferta/monto18` | `xs:float()` | `RESOLUTION_OFFERS/OFFER/FOR_18_MONTHS` |
| `return/oferta/monto24` | `xs:float()` | `RESOLUTION_OFFERS/OFFER/FOR_24_MONTHS` |
| `return/oferta/monto36` | `xs:float()` | `RESOLUTION_OFFERS/OFFER/FOR_36_MONTHS` |
| `return/oferta/monto48` | `xs:float()` | `RESOLUTION_OFFERS/OFFER/FOR_48_MONTHS` |
| `return/oferta/monto60` | `xs:float()` | `RESOLUTION_OFFERS/OFFER/FOR_60_MONTHS` |
| `return/oferta/monto72` | `xs:float()` | `RESOLUTION_OFFERS/OFFER/FOR_72_MONTHS` |
| `return/oferta/monto84` | `xs:float()` | `RESOLUTION_OFFERS/OFFER/FOR_84_MONTHS` |
| `return/oferta/monto96` | `xs:float()` | `RESOLUTION_OFFERS/OFFER/FOR_96_MONTHS` |
| `return/oferta/monto108` | `xs:float()` | `RESOLUTION_OFFERS/OFFER/FOR_108_MONTHS` |
| `return/oferta/monto120` | `xs:float()` | `RESOLUTION_OFFERS/OFFER/FOR_120_MONTHS` |
| `return/oferta/montoMax` | `xs:float()` | `RESOLUTION_OFFERS/OFFER/FOR_MAX_AMOUNT` |
| `return/oferta/ofertaMEG` | `xs:float()` | `RESOLUTION_OFFERS/OFFER/MEG_OFFER` |
| `return/oferta/ofertaMax` | `xs:float()` | `RESOLUTION_OFFERS/OFFER/MAX_OFFER` |
| `return/oferta/ofertaNDE` | `xs:float()` | `RESOLUTION_OFFERS/OFFER/NDE_OFFER` |
| `return/oferta/ofertaNonP2c` | `xs:float()` | `RESOLUTION_OFFERS/OFFER/NONP2C_OFFER` |
| `return/oferta/ofertaP2C` | `xs:float()` | `RESOLUTION_OFFERS/OFFER/P2C_OFFER` |
| `return/oferta/ofertaRCI` | `xs:float()` | `RESOLUTION_OFFERS/OFFER/RCI_OFFER` |
| `return/oferta/ofertaTimesIncome` | `xs:float()` | `RESOLUTION_OFFERS/OFFER/TIMESINCOME_OFFER` |
| `return/oferta/RCI` | `xs:float()` | `RESOLUTION_OFFERS/OFFER/RCI` |
| `return/oferta/timesIncome` | `xs:int()` | `RESOLUTION_OFFERS/OFFER/TIMESINCOME` |
| `return/tarjetas` | for-each | `CREDIT_CARD` (array) |
| `return/tarjetas/codbloqueo1` | for-each | `CREDIT_CARD/LOCKCODE1` |
| `return/tarjetas/codbloqueo2` | for-each | `CREDIT_CARD/LOCKCODE2` |
| `return/tarjetas/grupoAfinidad` | for-each | `CREDIT_CARD/LOGO` |
| `return/tarjetas/cash_diponible` | for-each | `CREDIT_CARD/AVAILABLE_CASH` |
| `return/tarjetas/fechabloqueo1` | for-each | `CREDIT_CARD/LOCK_DATE1` |
| `return/tarjetas/fechabloqueo2` | for-each | `CREDIT_CARD/LOCK_DATE2` |
| `return/tarjetas/transaccionesTarjeta` | for-each | `CREDIT_CARD/TRANSACTION_CREDIT_CARD_TYPE/TRANSACTION` |

---

## 7. Reglas de Negocio Detectadas

| # | Regla | Ubicación | Fragmento |
|---|-------|-----------|-----------|
| 1 | Si el token está vacío, asignar ErrorCode='Error' y no llamar al API | `ConsultaOfertaCreditoConsumoHN.pipeline` – Stage ProcesamientoEntradaCloud | `if ($tokenApi != '') then wsCallout... else assign ErrorCode='Error'` |
| 2 | Manejo de códigos HTTP específicos del API | `ConsultaOfertaCreditoConsumoHN.pipeline` – Response Stage | 401='Token inválido o vencido', 503='Servicio o Api no disponible', 'Error'='No se obtuvo token de entrada', otros='Error general [Código HTTP: X]' |
| 3 | Error handler captura HTTP response code y hace resume | `error-N3f57fef6...` – Stage StageErrorHandlerApiEtapa | `$fault/ctx:details/ctx1:ErrorResponseDetail/ctx1:http-response-code` → `$ErrorCode` → `resume` |
| 4 | Almacenamiento fire-and-forget de la oferta serializada | `ConsultaOfertaCreditoConsumoHN.pipeline` – Stage Almacenar Oferta | `publish` a `AlmacenaInformacionOfertaHonduras_db` con XML serializado vía `fn-bea:serialize($xmlSalida)` |
| 5 | Extracción de identidad para almacenamiento | `ConsultaOfertaCreditoConsumoHN.pipeline` – Stage 1 | `$identidad = $body/.../CUSTOMER_INFO/ID` |
| 6 | Campos condicionales (solo si existen/string-length>0) | `consultaOfertaCreditoConsumoCloudIn.xqy` | `if (exists($X)) then... else ()` para campos opcionales como salarios, fechas, montos |
