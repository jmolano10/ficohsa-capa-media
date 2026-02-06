xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns0:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/CNV/consultaContratosReferenciados/xsd/consultaContratoReferenciado_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaContratoReferenciado";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudo/xq/pagoCobranzasIn/";

declare function xf:pagoCobranzasIn($pagoRecaudo as element(ns0:pagoRecaudo))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:CODIGO_CONTRATO>{ data($pagoRecaudo/CONTRACT_ID) }</ns1:CODIGO_CONTRATO>
        </ns1:InputParameters>
};

declare variable $pagoRecaudo as element(ns0:pagoRecaudo) external;

xf:pagoCobranzasIn($pagoRecaudo)