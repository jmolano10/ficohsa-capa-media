<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaContratoGOP" element="ns1:consultaContratoGOP" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/DEI/consultaContratoGOP/xsd/ConsultaContratoGOP_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaContratoGOP";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaContratoGOP/xq/ConsultaContratoGOPIn/";

declare function xf:ConsultaContratoGOPIn($consultaContratoGOP as element(ns1:consultaContratoGOP))
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:PV_RTN>{ data($consultaContratoGOP/RTN) }&lt;/ns0:PV_RTN>
        &lt;/ns0:InputParameters>
};

declare variable $consultaContratoGOP as element(ns1:consultaContratoGOP) external;

xf:ConsultaContratoGOPIn($consultaContratoGOP)</con:xquery>
    <con:dependency location="../../TributosDEI/xsd/tributosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/TributosDEI/xsd/tributosTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/DEI/consultaContratoGOP/xsd/ConsultaContratoGOP_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/DEI/consultaContratoGOP/xsd/ConsultaContratoGOP_sp"/>
    </con:dependency>
</con:xqueryEntry>