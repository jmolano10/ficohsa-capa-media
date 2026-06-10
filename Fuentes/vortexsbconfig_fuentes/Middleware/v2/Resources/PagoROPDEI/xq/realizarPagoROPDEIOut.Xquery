<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/DEI/pagoROP/realizarPagoROP/xsd/realizarPagoROP_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoROPResponse" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/realizarPagoROP";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoROPDEI/xq/realizarPagoROPDEIOut/";

declare function xf:realizarPagoROPDEIOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:pagoROPResponse) {
        &lt;ns1:pagoROPResponse>
            {
                for $PV_IDRECIBO in $outputParameters/ns0:PV_IDRECIBO
                return
                    &lt;BILL_NUMBER>{ data($PV_IDRECIBO) }&lt;/BILL_NUMBER>
            }
        &lt;/ns1:pagoROPResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:realizarPagoROPDEIOut($outputParameters)</con:xquery>
    <con:dependency location="../../../BusinessServices/DEI/pagoROP/realizarPagoROP/xsd/realizarPagoROP_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/DEI/pagoROP/realizarPagoROP/xsd/realizarPagoROP_sp"/>
    </con:dependency>
    <con:dependency location="../../TributosDEI/xsd/tributosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/TributosDEI/xsd/tributosTypes"/>
    </con:dependency>
</con:xqueryEntry>