xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns0:pagoRecaudo" location="../../PagoRecaudo/xsd/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/TercerosNI/consultaConvenio/xsd/ConsultaConvenio_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaRecaudoNI";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudoNI/xq/consultaRecaudoIn/";

declare function xf:consultaRecaudoIn($pagoRecaudo as element(ns0:pagoRecaudo))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_IDCONVENIO>{ data($pagoRecaudo/CONTRACT_ID) }</ns1:PV_IDCONVENIO>
        </ns1:InputParameters>
};

declare variable $pagoRecaudo as element(ns0:pagoRecaudo) external;

xf:consultaRecaudoIn($pagoRecaudo)