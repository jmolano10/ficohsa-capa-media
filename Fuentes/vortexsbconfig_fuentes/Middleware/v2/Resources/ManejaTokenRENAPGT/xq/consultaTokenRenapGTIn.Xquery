<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$manejaTokenRENAP" element="ns0:manejaTokenRENAP" location="../xsd/manejaTokenRENAPGTTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/RENAP/consultaTokenRenap/xsd/consultaTokenRenap_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaTokenRenap";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/manejaTokenRENAPGTTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ManejaTokenRENAPGT/xq/consultaTokenRenapGTIn/";

declare function xf:consultaTokenRenapGTIn($manejaTokenRENAP as element(ns0:manejaTokenRENAP))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:LN_TOKEN>{ data($manejaTokenRENAP/TOKEN) }</ns1:LN_TOKEN>
            <ns1:LN_FECHA_HORA>{ data($manejaTokenRENAP/FECHA_EXPIRACION) }</ns1:LN_FECHA_HORA>
        </ns1:InputParameters>
};

declare variable $manejaTokenRENAP as element(ns0:manejaTokenRENAP) external;

xf:consultaTokenRenapGTIn($manejaTokenRENAP)]]></con:xquery>
    <con:dependency location="../xsd/manejaTokenRENAPGTTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ManejaTokenRENAPGT/xsd/manejaTokenRENAPGTTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/RENAP/consultaTokenRenap/xsd/consultaTokenRenap_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/RENAP/consultaTokenRenap/xsd/consultaTokenRenap_sp"/>
    </con:dependency>
</con:xqueryEntry>