# Ejemplos y Mapeos - GT01 (Guatemala)

## 1. Request OSB (ejemplo XML)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
    xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaOfertaCreditoConsumoTypes"
    xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
  <soapenv:Header>
    <aut:RequestHeader>
      <SourceBank>GT01</SourceBank>
      <Channel>DIGITAL</Channel>
      <User>USR_APP_GT</User>
    </aut:RequestHeader>
  </soapenv:Header>
  <soapenv:Body>
    <con:consultaOfertaCreditoConsumoRequest>
      <CASE_ID>CASO-GT-2024-001</CASE_ID>
      <PRODUCT_NATURE>CONSUMO</PRODUCT_NATURE>
      <CUSTOMER_INFO>
        <ID>1234567890101</ID>
        <TYPE>ASALARIADO</TYPE>
        <TOTAL_SALARY>25000.00</TOTAL_SALARY>
        <NET_SALARY>20000.00</NET_SALARY>
        <GENDER>F</GENDER>
        <TARGET>MASIVO</TARGET>
        <JOB_TYPE>DEPENDIENTE</JOB_TYPE>
        <SIB_REFERENCE>REF-SIB-001</SIB_REFERENCE>
        <VIP_CLIENT>NO</VIP_CLIENT>
        <SALES_ORIGIN>SUCURSAL</SALES_ORIGIN>
      </CUSTOMER_INFO>
      <EXTERNAL_SCORE>650.0</EXTERNAL_SCORE>
      <SCORE_INFO>
        <QUALIFICATION>B</QUALIFICATION>
        <RISK_LEVEL>MEDIO</RISK_LEVEL>
        <SCORE_CALCULATION>680.0</SCORE_CALCULATION>
      </SCORE_INFO>
      <REFERENCES_DETAILS>
        <QUERIES>
          <QUERY_ITEM>
            <ID>Q001</ID>
            <DATE>2024-01-15</DATE>
            <ENTITY>BANCO_X</ENTITY>
            <TYPE>CONSULTA</TYPE>
            <MOTIVE>CREDITO</MOTIVE>
          </QUERY_ITEM>
        </QUERIES>
        <ACTIVE_REFERENCES>
          <REFERENCE>
            <CREDITOR>BANCO GT</CREDITOR>
            <REFERENCE_NUMBER>REF-GT-001</REFERENCE_NUMBER>
            <TYPE>DIRECTA</TYPE>
            <STATUS>VIGENTE</STATUS>
            <BALANCE>80000.00</BALANCE>
            <INSTALLMENT>3500.00</INSTALLMENT>
            <CURRENCY>GTQ</CURRENCY>
            <TERM>48.0</TERM>
          </REFERENCE>
        </ACTIVE_REFERENCES>
        <REFERENCE_BUREAU_TUCA>
          <REFERENCE>
            <QUERY_ID>Q001</QUERY_ID>
            <TYPE>DIRECTA</TYPE>
            <CREDITOR>BANCO_X</CREDITOR>
            <STATUS>VIGENTE</STATUS>
            <BALANCE>50000</BALANCE>
          </REFERENCE>
        </REFERENCE_BUREAU_TUCA>
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
      <CASE_ID>CASO-GT-2024-001</CASE_ID>
      <GENERAL_RCI>0.40</GENERAL_RCI>
      <GENERAL_RCI_MAX>0.55</GENERAL_RCI_MAX>
      <GENERAL_CURRENT_NDE>0.32</GENERAL_CURRENT_NDE>
      <GENERAL_FINAL_NDE>0.45</GENERAL_FINAL_NDE>
      <CREDIT_CARD_SCORE>620</CREDIT_CARD_SCORE>
      <CREDIT_CARD_RISK_LEVEL>MEDIO</CREDIT_CARD_RISK_LEVEL>
      <EXTERNAL_RISK_LEVEL>B</EXTERNAL_RISK_LEVEL>
      <CUSTOMER_SEGMENT>MASIVO</CUSTOMER_SEGMENT>
      <CUSTOMER_SUBSEGMENT>MASIVO_MEDIO</CUSTOMER_SUBSEGMENT>
      <CURRENT_EXPOSURE>80000.0</CURRENT_EXPOSURE>
      <GLOBAL_EXPOSURE_LOCAL_CCY>80000.0</GLOBAL_EXPOSURE_LOCAL_CCY>
      <GLOBAL_EXPOSURE_FOREIGN_CCY>10300.0</GLOBAL_EXPOSURE_FOREIGN_CCY>
      <RESOLUTION_OFFERS>
        <OFFER>
          <PRODUCT_CODE>CONSUMO_GT_01</PRODUCT_CODE>
          <RATE>22.0</RATE>
          <INSTALLMENT>4500.0</INSTALLMENT>
          <FOR_12_MONTHS>50000.0</FOR_12_MONTHS>
          <FOR_24_MONTHS>90000.0</FOR_24_MONTHS>
          <FOR_36_MONTHS>120000.0</FOR_36_MONTHS>
          <FOR_MAX_AMOUNT>120000.0</FOR_MAX_AMOUNT>
          <MAX_OFFER>120000.0</MAX_OFFER>
        </OFFER>
      </RESOLUTION_OFFERS>
    </con:consultaOfertaCreditoConsumoResponse>
  </soapenv:Body>
</soapenv:Envelope>
```

---

## 3. Requests/Responses Internos a Servicios Dependientes

### 3.1. TokenizacionProcesamientoBlaze

**Request interno**: Se envía header OSB original y body. Se obtiene token de la respuesta.

**Response interno**: 
- Header: `aut:ResponseHeader/successIndicator` → se verifica si es `SUCCESS`
- Body: `$RSPtokenizacionProcesamientoBlaze/TOKEN` → se extrae el token

---

### 3.2. originacionesGT (OIC – processWithDecisionFlow2)

**Request interno** (generado por `processWithDecisionFlow2In.xqy`):

```xml
<ns1:processWithDecisionFlow2 xmlns:ns1="http://fico.com/blaze/advisor/rma/">
  <arg0>
    <token>eyJhbGciOiJIUz...</token>
    <accion>
      <referenciaSIB>REF-SIB-001</referenciaSIB>
    </accion>
    <antiguedadExtrafinanciamiento>0</antiguedadExtrafinanciamiento>
    <antiguedadLaboral>0</antiguedadLaboral>
    <antiguedadPrestamo>0</antiguedadPrestamo>
    <antiguedadPrestamoExterno>0</antiguedadPrestamoExterno>
    <antiguedadPrestamoFiduciario>0</antiguedadPrestamoFiduciario>
    <antiguedadTarjeta>0</antiguedadTarjeta>
    <antiguedadTarjetaCancelada>0</antiguedadTarjetaCancelada>
    <canalDeVenta>SUCURSAL</canalDeVenta>
    <clienteCastigado>0</clienteCastigado>
    <clienteCobroJudicial>0</clienteCobroJudicial>
    <clienteCuentaCancelada>0</clienteCuentaCancelada>
    <clientePignorado>0</clientePignorado>
    <clienteRPDA>0</clienteRPDA>
    <clienteSaldoRestructurado>0</clienteSaldoRestructurado>
    <clienteUniversitario>0</clienteUniversitario>
    <clienteVIP>NO</clienteVIP>
    <codigoTipoCliente>0</codigoTipoCliente>
    <consultaTuca>
      <entidad>BANCO_X</entidad>
      <fechaConsulta>2024-01-15T00:00:00</fechaConsulta>
      <motivo>CREDITO</motivo>
      <tipo>CONSULTA</tipo>
    </consultaTuca>
    <referencias>
      <acreedor>BANCO GT</acreedor>
      <cuota>3500.0</cuota>
      <estado>VIGENTE</estado>
      <moneda>GTQ</moneda>
      <noReferencia>REF-GT-001</noReferencia>
      <plazo>48.0</plazo>
      <saldoActual>80000.0</saldoActual>
      <tipoReferencia>DIRECTA</tipoReferencia>
    </referencias>
    <salarioBruto>25000.0</salarioBruto>
    <salarioNeto>20000.0</salarioNeto>
    <score>
      <calificacionScore>B</calificacionScore>
      <nivelRiesgo>MEDIO</nivelRiesgo>
      <score>680.0</score>
    </score>
    <scoreBuro>650.0</scoreBuro>
    <segmentoCliente>MASIVO</segmentoCliente>
    <sexo>F</sexo>
    <tipoCliente>ASALARIADO</tipoCliente>
    <tipoTrabajo>DEPENDIENTE</tipoTrabajo>
  </arg0>
</ns1:processWithDecisionFlow2>
```

**Response interno** (`$RSPprocessWithDecisionFlow2`):

```xml
<ns1:processWithDecisionFlow2Response xmlns:ns1="http://fico.com/blaze/advisor/rma/">
  <return>
    <noSolicitud>CASO-GT-2024-001</noSolicitud>
    <accion>
      <rciFinal>0.40</rciFinal>
      <rciMax>0.55</rciMax>
      <nivelEndeudamientoActual>0.32</nivelEndeudamientoActual>
      <nivelEndeudamientoFinal>0.45</nivelEndeudamientoFinal>
      <scoreTarjetaCredito>620</scoreTarjetaCredito>
      <nivelRiesgoTarjetaCredito>MEDIO</nivelRiesgoTarjetaCredito>
      <nivelRiesgoExterno>B</nivelRiesgoExterno>
      <segmentoCliente>MASIVO</segmentoCliente>
      <subSegmentoCliente>MASIVO_MEDIO</subSegmentoCliente>
      <exposicionGlobal>80000.0</exposicionGlobal>
      <exposicionActualLOC>80000.0</exposicionActualLOC>
      <exposicionActualUSD>10300.0</exposicionActualUSD>
    </accion>
    <oferta>
      <codProducto>CONSUMO_GT_01</codProducto>
      <tasa>22.0</tasa>
      <cuota>4500.0</cuota>
      <monto12>50000.0</monto12>
      <monto24>90000.0</monto24>
      <monto36>120000.0</monto36>
      <montoMax>120000.0</montoMax>
      <ofertaMax>120000.0</ofertaMax>
    </oferta>
    <audit>
      <auditSteps>
        <type>INFO</type>
        <stepMessage>Evaluación completada</stepMessage>
      </auditSteps>
    </audit>
  </return>
</ns1:processWithDecisionFlow2Response>
```

---

## 4. Cadenas de Conexión y Credenciales

| Servicio | Tipo | Endpoint / Conexión | Detalle |
|----------|------|---------------------|---------|
| originacionesGT | SOAP/OIC | `https://oic.ocservices.ficohsa.com/ic/ws/integration/v1/flows/soap/EPORIGINACIONESG_SOAP/1.0/` | Operación: `processWithDecisionFlow2`, Auth: HTTP Basic (Service Account `Middleware/Security/DEVCLOUD`) |
| TokenizacionProcesamientoBlaze | Proxy OSB | `Middleware/v2/ProxyServices/TokenizacionProcesamientoBlaze` | Operación: `tokenizacionProcesamientoBlaze` |

---

## 5. Tablas de Mapeo de Entrada – Llamada a originacionesGT

**XQuery**: `processWithDecisionFlow2In.xqy`

| Campo Origen (OSB) | Transformación/Script | Campo Destino (OIC) |
|--------------------|-----------------------|---------------------|
| `$token` (variable) | directo | `arg0/token` |
| `CUSTOMER_INFO/SIB_REFERENCE` | for-each | `arg0/accion/referenciaSIB` |
| `CUSTOMER_INFO/SALES_ORIGIN` | for-each | `arg0/canalDeVenta` |
| `CUSTOMER_INFO/VIP_CLIENT` | for-each | `arg0/clienteVIP` |
| (constante) | `0` | `arg0/antiguedadExtrafinanciamiento`, `antiguedadLaboral`, `antiguedadPrestamo`, etc. |
| (constante) | `0` | `arg0/clienteCastigado`, `clienteCobroJudicial`, `clientePignorado`, etc. |
| (constante) | `0` | `arg0/codigoTipoCliente` |
| `REFERENCES_DETAILS/QUERIES/QUERY_ITEM` | for-each | `arg0/consultaTuca` |
| `QUERY_ITEM/ENTITY` | for-each | `consultaTuca/entidad` |
| `QUERY_ITEM/DATE` | conversión con formato dd/MM/yyyy o yyyy-MM-dd | `consultaTuca/fechaConsulta` |
| `QUERY_ITEM/MOTIVE` | for-each | `consultaTuca/motivo` |
| `QUERY_ITEM/TYPE` | for-each | `consultaTuca/tipo` |
| `REFERENCES_DETAILS/ACTIVE_REFERENCES/REFERENCE` | for-each | `arg0/referencias` (array) |
| (mismo mapeo que HN para campos de referencia) | | |
| `CUSTOMER_INFO/TOTAL_SALARY` | `xs:float()` | `arg0/salarioBruto` |
| `CUSTOMER_INFO/NET_SALARY` | `xs:float()` | `arg0/salarioNeto` |
| `CUSTOMER_INFO/PAYROLL_SALARY` | `xs:float()` | `arg0/salarioPlanilla` |
| `SCORE_INFO/QUALIFICATION` | for-each | `arg0/score/calificacionScore` |
| `SCORE_INFO/RISK_LEVEL` | for-each | `arg0/score/nivelRiesgo` |
| `SCORE_INFO/SCORE_CALCULATION` | `xs:float()` | `arg0/score/score` |
| `EXTERNAL_SCORE` | `xs:float()` | `arg0/scoreBuro` |
| `CUSTOMER_INFO/TARGET` | directo | `arg0/segmentoCliente` |
| `CUSTOMER_INFO/GENDER` | directo | `arg0/sexo` |
| `LIABILITIES/CREDIT_CARDS_INFO/CREDIT_CARD` | for-each | `arg0/tarjetas` (array) |
| `AGREEMENT/RATE` | `xs:float()` | `arg0/tasaConvenio` |
| `CUSTOMER_INFO/TYPE` | directo | `arg0/tipoCliente` |
| `CUSTOMER_INFO/JOB_TYPE` | for-each | `arg0/tipoTrabajo` |

**Diferencias con HN en el mapeo de entrada:**
- GT envía `token` como campo dentro del payload
- GT envía `referenciaSIB` del CUSTOMER_INFO
- GT envía `canalDeVenta` (SALES_ORIGIN), `clienteVIP` (VIP_CLIENT)
- GT envía `consultaTuca` con consultas del buró (QUERIES)
- GT inicializa múltiples campos de antigüedad con valor `0` (constantes)
- GT NO recibe respuesta de ConsultaConsolidadaRiesgoCliente (no la usa como input)

---

## 6. Tablas de Mapeo de Salida – Respuesta de originacionesGT

**XQuery**: `consultaOfertaCreditoConsumoGTOut.xqy`

| Campo Origen (OIC) | Transformación/Script | Campo Destino (OSB) |
|--------------------|----------------------|---------------------|
| `return/noSolicitud` | for-each | `CASE_ID` |
| `return/accion/rciFinal` | for-each | `GENERAL_RCI` |
| `return/accion/rciMax` | for-each | `GENERAL_RCI_MAX` |
| `return/accion/nivelEndeudamientoActual` | for-each | `GENERAL_CURRENT_NDE` |
| `return/accion/nivelEndeudamientoFinal` | for-each | `GENERAL_FINAL_NDE` |
| `return/accion/scoreTarjetaCredito` | for-each | `CREDIT_CARD_SCORE` |
| `return/accion/nivelRiesgoTarjetaCredito` | for-each | `CREDIT_CARD_RISK_LEVEL` |
| `return/accion/nivelRiesgoExterno` | for-each | `EXTERNAL_RISK_LEVEL` |
| `return/accion/segmentoCliente` | for-each | `CUSTOMER_SEGMENT` |
| `return/accion/subSegmentoCliente` | for-each | `CUSTOMER_SUBSEGMENT` |
| `return/accion/exposicionGlobal` | for-each | `CURRENT_EXPOSURE` |
| `return/accion/exposicionActualLOC` | for-each | `GLOBAL_EXPOSURE_LOCAL_CCY` |
| `return/accion/exposicionActualUSD` | for-each | `GLOBAL_EXPOSURE_FOREIGN_CCY` |
| `return/accion/sobreGiroTarjetaCredito` | for-each | `CREDIT_CARD_OVERDRAFT` |
| `return/oferta/codProducto` | for-each | `RESOLUTION_OFFERS/OFFER/PRODUCT_CODE` |
| `return/oferta/tasa` | for-each | `RESOLUTION_OFFERS/OFFER/RATE` |
| `return/oferta/cuota` | for-each | `RESOLUTION_OFFERS/OFFER/INSTALLMENT` |
| `return/oferta/monto12..monto120` | for-each | `RESOLUTION_OFFERS/OFFER/FOR_12_MONTHS..FOR_120_MONTHS` |
| `return/oferta/montoMax` | for-each | `RESOLUTION_OFFERS/OFFER/FOR_MAX_AMOUNT` |
| `return/oferta/ofertaMax` | for-each | `RESOLUTION_OFFERS/OFFER/MAX_OFFER` |

---

## 7. Reglas de Negocio Detectadas

| # | Regla | Ubicación | Fragmento |
|---|-------|-----------|-----------|
| 1 | Si el token falla (successIndicator != SUCCESS), no se llama al motor de decisión | `ConsultaOfertaCreditoConsumoGT.pipeline` – Stage ObtenerToken → OriginacionesGT | `if ($validationMessage = "") then wsCallout...` |
| 2 | Validación de error por auditSteps | `ConsultaOfertaCreditoConsumoGT.pipeline` – Response Stage | `if (not(exists($RSPprocessWithDecisionFlow2/return/audit/auditSteps[type = 'ERROR'])))` → Success, else → ERROR con stepMessages |
| 3 | Conversión de fechas de buró TUCA | `processWithDecisionFlow2In.xqy` – consultaTuca/fechaConsulta | Si formato `dd/MM/yyyy` → convertir a `yyyy-MM-ddTHH:mm:ss`; si otro formato, usar directo con `fn-bea:date-from-string-with-format` |
| 4 | Campos de antigüedad con valor por defecto 0 | `processWithDecisionFlow2In.xqy` | `antiguedadExtrafinanciamiento=0`, `antiguedadLaboral=0`, `antiguedadPrestamo=0`, `antiguedadPrestamoExterno=0`, `antiguedadPrestamoFiduciario=0`, `antiguedadTarjeta=0`, `antiguedadTarjetaCancelada=0` |
| 5 | Campos de estado de cliente con valor por defecto 0 | `processWithDecisionFlow2In.xqy` | `clienteCastigado=0`, `clienteCobroJudicial=0`, `clienteCuentaCancelada=0`, `clientePignorado=0`, `clienteRPDA=0`, `clienteSaldoRestructurado=0`, `clienteUniversitario=0` |
| 6 | Token enviado dentro del payload (no como header) | `processWithDecisionFlow2In.xqy` | `<token>{ $token }</token>` dentro de `<arg0>` |
