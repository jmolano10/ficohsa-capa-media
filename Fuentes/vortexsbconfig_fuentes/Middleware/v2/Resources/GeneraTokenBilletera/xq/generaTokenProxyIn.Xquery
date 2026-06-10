<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:generaTokenBilletera" location="../../PagosMasivosBilletera/xsd/pagosMasivosBilleteraTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraTokenBilletera/xq/generaTokenProxyIn/";

declare function xf:generaTokenProxyIn($SECURITY_KEY as xs:string)
    as element(ns0:generaTokenBilletera) {
        &lt;ns0:generaTokenBilletera>
            &lt;SECURITY_KEY>{ $SECURITY_KEY }&lt;/SECURITY_KEY>
        &lt;/ns0:generaTokenBilletera>
};

declare variable $SECURITY_KEY as xs:string external;

xf:generaTokenProxyIn($SECURITY_KEY)</con:xquery>
    <con:dependency location="../../PagosMasivosBilletera/xsd/pagosMasivosBilleteraTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/PagosMasivosBilletera/xsd/pagosMasivosBilleteraTypes"/>
    </con:dependency>
</con:xqueryEntry>