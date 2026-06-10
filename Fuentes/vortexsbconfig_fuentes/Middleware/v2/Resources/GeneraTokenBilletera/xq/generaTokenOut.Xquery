<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$jwtTengoResponse" element="ns1:jwtTengoResponse" location="../../../BusinessServices/TENGO/PagoMasivoBilletera/xsd/Services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:generaTokenBilleteraResponse" location="../../PagosMasivosBilletera/xsd/pagosMasivosBilleteraTypes.xsd" ::)

declare namespace ns1 = "http://main/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraTokenBilletera/xq/generaTokenOut/";

declare function xf:generaTokenOut($jwtTengoResponse as element(ns1:jwtTengoResponse))
    as element(ns0:generaTokenBilleteraResponse) {
        &lt;ns0:generaTokenBilleteraResponse>
            &lt;SECURITY_TOKEN>{ data($jwtTengoResponse/return/toket) }&lt;/SECURITY_TOKEN>
        &lt;/ns0:generaTokenBilleteraResponse>
};

declare variable $jwtTengoResponse as element(ns1:jwtTengoResponse) external;

xf:generaTokenOut($jwtTengoResponse)</con:xquery>
    <con:dependency location="../../../BusinessServices/TENGO/PagoMasivoBilletera/xsd/Services.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/TENGO/PagoMasivoBilletera/xsd/Services"/>
    </con:dependency>
    <con:dependency location="../../PagosMasivosBilletera/xsd/pagosMasivosBilleteraTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/PagosMasivosBilletera/xsd/pagosMasivosBilleteraTypes"/>
    </con:dependency>
</con:xqueryEntry>