xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/DEI/pagoROP/realizarPagoROP/xsd/realizarPagoROP_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoROPResponse" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/realizarPagoROP";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoROPDEI/xq/realizarPagoROPDEIOut/";

declare function xf:realizarPagoROPDEIOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:pagoROPResponse) {
        <ns1:pagoROPResponse>
            {
                for $PV_IDRECIBO in $outputParameters/ns0:PV_IDRECIBO
                return
                    <BILL_NUMBER>{ data($PV_IDRECIBO) }</BILL_NUMBER>
            }
        </ns1:pagoROPResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:realizarPagoROPDEIOut($outputParameters)