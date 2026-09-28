(:: pragma bea:global-element-parameter parameter="$consultaRecaudo" element="ns0:consultaRecaudo" location="../../ConsultaRecaudo/xsd/consultaRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/TercerosNI/consultaConvenio/xsd/ConsultaConvenio_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaRecaudoNI";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRecaudoNI/xq/ArmarConsultaRecaudoNIIn/";

declare function xf:ArmarConsultaRecaudoNIIn($consultaRecaudo as element(ns0:consultaRecaudo))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_IDCONVENIO>{ data($consultaRecaudo/CONTRACT_ID) }</ns1:PV_IDCONVENIO>
        </ns1:InputParameters>
};

declare variable $consultaRecaudo as element(ns0:consultaRecaudo) external;
declare variable $username as xs:string external;
declare variable $session as xs:string external;

xf:ArmarConsultaRecaudoNIIn($consultaRecaudo)