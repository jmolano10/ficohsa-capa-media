<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaRazonSocialResponse" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRazonSocial/xq/consultaRazonSocialOUT/";

declare function xf:consultaRazonSocialOUT($RazonSocial as xs:string)
    as element(ns0:consultaRazonSocialResponse) {
        &lt;ns0:consultaRazonSocialResponse>
            &lt;BUSINESS_NAME>{ $RazonSocial }&lt;/BUSINESS_NAME>
        &lt;/ns0:consultaRazonSocialResponse>
};

declare variable $RazonSocial as xs:string external;

xf:consultaRazonSocialOUT($RazonSocial)</con:xquery>
    <con:dependency location="../../TributosDEI/xsd/tributosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/TributosDEI/xsd/tributosTypes"/>
    </con:dependency>
</con:xqueryEntry>