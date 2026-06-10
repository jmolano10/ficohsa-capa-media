<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/TENGO/ConsultaDatosCuponATM/xsd/consultaCuponTengoATM_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCuponTengoATM";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversaCuponATM/xq/consultarCuponTengodbIn/";

declare function xf:consultarCuponTengodbIn($retrievalReference as xs:string)
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:PV_RETRIEVAL_REF>{ $retrievalReference }&lt;/ns0:PV_RETRIEVAL_REF>
        &lt;/ns0:InputParameters>
};

declare variable $retrievalReference as xs:string external;

xf:consultarCuponTengodbIn($retrievalReference)</con:xquery>
    <con:dependency location="../../../BusinessServices/TENGO/ConsultaDatosCuponATM/xsd/consultaCuponTengoATM_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/TENGO/ConsultaDatosCuponATM/xsd/consultaCuponTengoATM_sp"/>
    </con:dependency>
</con:xqueryEntry>