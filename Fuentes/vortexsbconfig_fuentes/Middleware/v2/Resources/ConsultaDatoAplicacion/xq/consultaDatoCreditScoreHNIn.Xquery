<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDatoAplicacion" element="ns0:consultaDatoAplicacion" location="../xsd/consultaDatoAplicacionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/PWS/consultaDatoCreditScore/xsd/consultaDatoCreditScore_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDatoCreditScore";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDatoAplicacionTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatoAplicacion/xq/consultaDatoCreditScoreHNIn/";

declare function xf:consultaDatoCreditScoreHNIn($consultaDatoAplicacion as element(ns0:consultaDatoAplicacion))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            &lt;ns1:P_DATA_IDENTIFIER>{ data($consultaDatoAplicacion/ns0:DATA_IDENTIFIER) }&lt;/ns1:P_DATA_IDENTIFIER>
        &lt;/ns1:InputParameters>
};

declare variable $consultaDatoAplicacion as element(ns0:consultaDatoAplicacion) external;

xf:consultaDatoCreditScoreHNIn($consultaDatoAplicacion)</con:xquery>
    <con:dependency location="../xsd/consultaDatoAplicacionTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaDatoAplicacion/xsd/consultaDatoAplicacionTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/PWS/consultaDatoCreditScore/xsd/consultaDatoCreditScore_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/PWS/consultaDatoCreditScore/xsd/consultaDatoCreditScore_sp"/>
    </con:dependency>
</con:xqueryEntry>