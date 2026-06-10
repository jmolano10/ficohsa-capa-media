<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaRazonSocialIN" element="ns0:consultaRazonSocial" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/DEI/consultaRazonSocial/xsd/consultaRazonSocial_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRazonSocial";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRazonSocial/xq/ConsultaRazonSocialIN/";

declare function xf:ConsultaRazonSocialIN($consultaRazonSocialIN as element(ns0:consultaRazonSocial))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            &lt;ns1:PV_RTN>{ data($consultaRazonSocialIN/RTN) }&lt;/ns1:PV_RTN>
        &lt;/ns1:InputParameters>
};

declare variable $consultaRazonSocialIN as element(ns0:consultaRazonSocial) external;

xf:ConsultaRazonSocialIN($consultaRazonSocialIN)</con:xquery>
    <con:dependency location="../../TributosDEI/xsd/tributosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/TributosDEI/xsd/tributosTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/DEI/consultaRazonSocial/xsd/consultaRazonSocial_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/DEI/consultaRazonSocial/xsd/consultaRazonSocial_sp"/>
    </con:dependency>
</con:xqueryEntry>