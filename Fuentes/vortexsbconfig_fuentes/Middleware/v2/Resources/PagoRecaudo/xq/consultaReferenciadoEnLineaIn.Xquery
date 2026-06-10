<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns0:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/consultarRecaudoReferenciadoEnLinea/xsd/FLINK_OSB_K_RECAUDOS_REF_ONLINE_OSB_CONSULTAR_REF_ONLINE.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_K_RECAUDOS_REF_ONLINE/OSB_CONSULTAR_REF_ONLINE/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudo/xq/consultaReferenciadoEnLineaIn/";

declare function xf:consultaReferenciadoEnLineaIn($pagoRecaudo as element(ns0:pagoRecaudo))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            &lt;ns1:CODIGO_CONTRATO>{ data($pagoRecaudo/CONTRACT_ID) }&lt;/ns1:CODIGO_CONTRATO>
        &lt;/ns1:InputParameters>
};

declare variable $pagoRecaudo as element(ns0:pagoRecaudo) external;

xf:consultaReferenciadoEnLineaIn($pagoRecaudo)</con:xquery>
    <con:dependency location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/consultarRecaudoReferenciadoEnLinea/xsd/FLINK_OSB_K_RECAUDOS_REF_ONLINE_OSB_CONSULTAR_REF_ONLINE.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/consultarRecaudoReferenciadoEnLinea/xsd/FLINK_OSB_K_RECAUDOS_REF_ONLINE_OSB_CONSULTAR_REF_ONLINE"/>
    </con:dependency>
</con:xqueryEntry>