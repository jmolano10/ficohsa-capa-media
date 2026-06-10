<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$eliminarDeudores1" element="ns0:eliminarDeudores" location="../../CobranzasElectronicas/xsd/cobranzasElectronicasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABK/eliminarDeudores/xsd/eliminarDeudores_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/cobranzasElectronicasTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/eliminarDeudores";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EliminarDeudores/xq/eliminarDeudoresHNIn/";

declare function xf:eliminarDeudoresHNIn($eliminarDeudores1 as element(ns0:eliminarDeudores))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CODIGOCLIENTE>{ data($eliminarDeudores1/CUSTOMER_ID) }</ns1:PV_CODIGOCLIENTE>
            <ns1:PV_NUMEROCONTRATO>{ data($eliminarDeudores1/CONTRACT_ID) }</ns1:PV_NUMEROCONTRATO>
            <ns1:PT_CODIGODEUDORES>
                {
                    for $DEBTOR in $eliminarDeudores1/DEBTORS/DEBTOR
                    return
                        <ns1:ITEM>{ data($DEBTOR/DEBTOR_CODE) }</ns1:ITEM>
                }
            </ns1:PT_CODIGODEUDORES>
        </ns1:InputParameters>
};

declare variable $eliminarDeudores1 as element(ns0:eliminarDeudores) external;

xf:eliminarDeudoresHNIn($eliminarDeudores1)]]></con:xquery>
    <con:dependency location="../../CobranzasElectronicas/xsd/cobranzasElectronicasTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/CobranzasElectronicas/xsd/cobranzasElectronicasTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABK/eliminarDeudores/xsd/eliminarDeudores_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABK/eliminarDeudores/xsd/eliminarDeudores_sp"/>
    </con:dependency>
</con:xqueryEntry>