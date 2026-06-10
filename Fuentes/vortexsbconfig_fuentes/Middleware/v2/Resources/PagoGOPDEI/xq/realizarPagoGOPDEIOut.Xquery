<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/DEI/pagoGOP/realizarPagoGOP/xsd/realizarPagoGOP_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:pagoGOPResponse" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/realizarPagoGOP";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoGOPDEI/xq/realizarPagoGOPDEIOut/";

declare function xf:realizarPagoGOPDEIOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:pagoGOPResponse) {
        <ns0:pagoGOPResponse>
            <BILL_NUMBER>{ data($outputParameters/ns1:PN_IDRECIBOGOP) }</BILL_NUMBER>
            {
                for $PV_REFERENCIAFENIX in $outputParameters/ns1:PV_REFERENCIAFENIX
                return
                    <EXTERNAL_REFERENCE>{ data($PV_REFERENCIAFENIX) }</EXTERNAL_REFERENCE>
            }
        </ns0:pagoGOPResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:realizarPagoGOPDEIOut($outputParameters)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/DEI/pagoGOP/realizarPagoGOP/xsd/realizarPagoGOP_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/DEI/pagoGOP/realizarPagoGOP/xsd/realizarPagoGOP_sp"/>
    </con:dependency>
    <con:dependency location="../../TributosDEI/xsd/tributosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/TributosDEI/xsd/tributosTypes"/>
    </con:dependency>
</con:xqueryEntry>