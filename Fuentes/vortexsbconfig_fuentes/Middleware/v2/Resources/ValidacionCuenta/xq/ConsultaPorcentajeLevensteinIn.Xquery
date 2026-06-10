<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns1:AutenticacionRequestHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/consultaPorcentajeLevenstein/xsd/CONS_PORC_LEVENSTEIN_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/CONS_PORC_LEVENSTEIN";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/validacionCuenta/ValidacionCuenta2.0/ConsultaPorcentajeLevensteinIn/";

declare function xf:ConsultaPorcentajeLevensteinIn($autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader))
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:VA_USUARIO>{ data($autenticacionRequestHeader1/UserName) }&lt;/ns0:VA_USUARIO>
        &lt;/ns0:InputParameters>
};

declare variable $autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader) external;

xf:ConsultaPorcentajeLevensteinIn($autenticacionRequestHeader1)</con:xquery>
    <con:dependency location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/Business_Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/consultaPorcentajeLevenstein/xsd/CONS_PORC_LEVENSTEIN_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/consultaPorcentajeLevenstein/xsd/CONS_PORC_LEVENSTEIN_sp"/>
    </con:dependency>
</con:xqueryEntry>