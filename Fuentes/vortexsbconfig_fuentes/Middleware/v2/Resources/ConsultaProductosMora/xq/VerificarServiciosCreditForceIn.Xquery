<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:Status" location="../../../BusinessServices/CREDITFORCE/ficohsaServices/xsd/creditForce.xsd" ::)

declare namespace ns0 = "http://www.creditforce.com/SOA";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProductosMora/xq/VerificarServiciosCreditForceIn/";

declare function xf:VerificarServiciosCreditForceIn($token as xs:string)
    as element(ns0:Status) {
        &lt;ns0:Status>
            &lt;ns0:apikey>{ $token }&lt;/ns0:apikey>
        &lt;/ns0:Status>
};

declare variable $token as xs:string external;

xf:VerificarServiciosCreditForceIn($token)</con:xquery>
    <con:dependency location="../../../BusinessServices/CREDITFORCE/ficohsaServices/xsd/creditForce.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/CREDITFORCE/ficohsaServices/xsd/creditForce"/>
    </con:dependency>
</con:xqueryEntry>