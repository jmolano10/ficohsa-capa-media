(:: pragma bea:global-element-parameter parameter="$pagoGOP" element="ns0:pagoGOP" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/DEI/pagoGOP/validarPagoGOP/xsd/validarPagoGOP_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validarPagoGOP";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoGOPDEI/xq/PagoGOPDEIIn/";

declare function xf:PagoGOPDEIIn($pagoGOP as element(ns0:pagoGOP))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_RTN>{ data($pagoGOP/RTN) }</ns1:PV_RTN>
            <ns1:PV_NUMEROCONTRATO>{ data($pagoGOP/CONTRACT_ID) }</ns1:PV_NUMEROCONTRATO>
            <ns1:PV_CODIGOMONEDA>{ data($pagoGOP/CURRENCY) }</ns1:PV_CODIGOMONEDA>
        </ns1:InputParameters>
};

declare variable $pagoGOP as element(ns0:pagoGOP) external;

xf:PagoGOPDEIIn($pagoGOP)