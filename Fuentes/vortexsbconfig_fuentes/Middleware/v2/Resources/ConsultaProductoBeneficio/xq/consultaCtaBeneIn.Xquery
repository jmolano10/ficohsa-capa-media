<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaCuentaBeneficios" location="../../ConsultaCuentaBeneficios/xsd/consultaCuentaBeneficiosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaCuentaBeneficiosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProductoBeneficio/xq/consultaCtaBeneIn/";

declare function xf:consultaCtaBeneIn($account as xs:string)
    as element(ns0:consultaCuentaBeneficios) {
        &lt;ns0:consultaCuentaBeneficios>
            &lt;ACCOUNT_NUMBER>{ $account }&lt;/ACCOUNT_NUMBER>
        &lt;/ns0:consultaCuentaBeneficios>
};

declare variable $account as xs:string external;

xf:consultaCtaBeneIn($account)</con:xquery>
    <con:dependency location="../../ConsultaCuentaBeneficios/xsd/consultaCuentaBeneficiosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaCuentaBeneficios/xsd/consultaCuentaBeneficiosTypes"/>
    </con:dependency>
</con:xqueryEntry>