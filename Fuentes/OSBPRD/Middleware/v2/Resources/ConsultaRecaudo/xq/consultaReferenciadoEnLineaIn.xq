(:: pragma bea:global-element-parameter parameter="$consultaRecaudo" element="ns0:consultaRecaudo" location="../../../../Business_Resources/recaudos/consultaRecaudo/consultaRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/consultarRecaudoReferenciadoEnLinea/xsd/FLINK_OSB_K_RECAUDOS_REF_ONLINE_OSB_CONSULTAR_REF_ONLINE.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_K_RECAUDOS_REF_ONLINE/OSB_CONSULTAR_REF_ONLINE/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRecaudo/xq/consultaReferenciadoEnLineaIn/";

declare function xf:consultaRecaudoConsultaReferenciadoEnLineaIn($consultaRecaudo as element(ns0:consultaRecaudo))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:CODIGO_CONTRATO>{ data($consultaRecaudo/CONTRACT_ID) }</ns1:CODIGO_CONTRATO>
        </ns1:InputParameters>
};

declare variable $consultaRecaudo as element(ns0:consultaRecaudo) external;

xf:consultaRecaudoConsultaReferenciadoEnLineaIn($consultaRecaudo)