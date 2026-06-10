<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/MDW/desencriptarAES/xsd/desencriptarAES_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Login/xq/desencriptarAESIn/";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/desencriptarAES";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/loginTypes";

declare function xf:desencriptarAESIn($Parametro as xs:string, $Credencial as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_NOMBRE_PARAMETRO>{ $Parametro }</ns1:PV_NOMBRE_PARAMETRO>
            <ns1:PV_TEXTO_CIFRADO>{ data($Credencial) }</ns1:PV_TEXTO_CIFRADO>
        </ns1:InputParameters>
};


declare variable $Parametro as xs:string external;
declare variable $Credencial as xs:string external;

xf:desencriptarAESIn( $Parametro,  $Credencial )]]></con:xquery>
    <con:dependency location="../../../BusinessServices/MDW/desencriptarAES/xsd/desencriptarAES_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MDW/desencriptarAES/xsd/desencriptarAES_sp"/>
    </con:dependency>
</con:xqueryEntry>