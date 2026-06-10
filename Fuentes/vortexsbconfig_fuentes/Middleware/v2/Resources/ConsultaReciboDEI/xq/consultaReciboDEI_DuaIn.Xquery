<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaRecibo" element="ns1:consultaRecibo" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/DEI/consultaReciboDUA/xsd/ConsultaReciboDua_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaReciboDua";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaReciboDEI/xq/consultaReciboDEI_DuaIn/";

declare function xf:consultaReciboDEI_DuaIn($consultaRecibo as element(ns1:consultaRecibo))
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:P_ID_LIQUIDACION>{ data($consultaRecibo/BILL_NUMBER) }&lt;/ns0:P_ID_LIQUIDACION>
        &lt;/ns0:InputParameters>
};

declare variable $consultaRecibo as element(ns1:consultaRecibo) external;

xf:consultaReciboDEI_DuaIn($consultaRecibo)</con:xquery>
    <con:dependency location="../../TributosDEI/xsd/tributosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/TributosDEI/xsd/tributosTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/DEI/consultaReciboDUA/xsd/ConsultaReciboDua_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/DEI/consultaReciboDUA/xsd/ConsultaReciboDua_sp"/>
    </con:dependency>
</con:xqueryEntry>