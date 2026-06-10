<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaRecaudo" element="ns0:consultaRecaudo" location="../../../../Business_Resources/recaudos/consultaRecaudo/consultaRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/consultarRecaudoReferenciadoEnLinea/xsd/FLINK_OSB_K_RECAUDOS_REF_ONLINE_OSB_CONSULTAR_REF_ONLINE.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_K_RECAUDOS_REF_ONLINE/OSB_CONSULTAR_REF_ONLINE/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRecaudo/xq/consultaReferenciadoEnLineaIn/";

declare function xf:consultaRecaudoConsultaReferenciadoEnLineaIn($consultaRecaudo as element(ns0:consultaRecaudo))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            &lt;ns1:CODIGO_CONTRATO>{ data($consultaRecaudo/CONTRACT_ID) }&lt;/ns1:CODIGO_CONTRATO>
        &lt;/ns1:InputParameters>
};

declare variable $consultaRecaudo as element(ns0:consultaRecaudo) external;

xf:consultaRecaudoConsultaReferenciadoEnLineaIn($consultaRecaudo)</con:xquery>
    <con:dependency location="../../../../Business_Resources/recaudos/consultaRecaudo/consultaRecaudoTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/recaudos/consultaRecaudo/consultaRecaudoTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/consultarRecaudoReferenciadoEnLinea/xsd/FLINK_OSB_K_RECAUDOS_REF_ONLINE_OSB_CONSULTAR_REF_ONLINE.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/consultarRecaudoReferenciadoEnLinea/xsd/FLINK_OSB_K_RECAUDOS_REF_ONLINE_OSB_CONSULTAR_REF_ONLINE"/>
    </con:dependency>
</con:xqueryEntry>