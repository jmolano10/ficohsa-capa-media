<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaBloqueoTcSalesForceRequest" location="../../ConsultaBloqueoTcSalesForce/xsd/consultaBloqueoTcSalesForceTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaBloqueoTcSalesForceTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPuntosLealtad/xq/consultaBloqueSFIn/";

declare function xf:consultaBloqueSFIn($string as xs:string)
    as element(ns0:consultaBloqueoTcSalesForceRequest) {
        &lt;ns0:consultaBloqueoTcSalesForceRequest>
            &lt;LEGAL_ID>{ $string }&lt;/LEGAL_ID>
        &lt;/ns0:consultaBloqueoTcSalesForceRequest>
};

declare variable $string as xs:string external;

xf:consultaBloqueSFIn($string)</con:xquery>
    <con:dependency location="../../ConsultaBloqueoTcSalesForce/xsd/consultaBloqueoTcSalesForceTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaBloqueoTcSalesForce/xsd/consultaBloqueoTcSalesForceTypes"/>
    </con:dependency>
</con:xqueryEntry>