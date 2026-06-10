<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKPA/consultaBuroInterno/xsd/ConsultaBuroInterno_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaBuroInternoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaBuroInterno";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaBuroInterno/xq/consultaBuroInternoPAIn/";

declare function xf:consultaBuroInternoPAIn($customerId as xs:string)
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            &lt;ns1:PV_CODIGO_CLIENTE>{ data($customerId) }&lt;/ns1:PV_CODIGO_CLIENTE>
        &lt;/ns1:InputParameters>
};

declare variable $customerId as xs:string external;

xf:consultaBuroInternoPAIn($customerId)</con:xquery>
    <con:dependency location="../../../BusinessServices/ABKPA/consultaBuroInterno/xsd/ConsultaBuroInterno_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKPA/consultaBuroInterno/xsd/ConsultaBuroInterno_sp"/>
    </con:dependency>
</con:xqueryEntry>