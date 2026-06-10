<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:bloqueoFondosCuenta" location="../../BloqueoFondosCuenta/xsd/bloqueoFondosCuentaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/bloqueoFondosCuentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelarFinanciamiento/xq/bloqueaFondosCuentaIn/";

declare function xf:bloqueaFondosCuentaIn(
    $accountNumber as xs:string,
    $amount as xs:string,
    $currency as xs:string,
    $description as xs:string)
    as element(ns0:bloqueoFondosCuenta) {
        <ns0:bloqueoFondosCuenta>
            <ACCOUNT_NUMBER>{ $accountNumber }</ACCOUNT_NUMBER>
            <END_DATE>{ fn-bea:date-to-string-with-format("yyyyMMdd",fn:current-date()) }</END_DATE>
            <BLOCK_AMOUNT>{ $amount }</BLOCK_AMOUNT>
            <DESCRIPTION>{ $description }</DESCRIPTION>
            <CURRENCY>{ $currency }</CURRENCY>
        </ns0:bloqueoFondosCuenta>
};


declare variable $accountNumber as xs:string external;
declare variable $amount as xs:string external;
declare variable $currency as xs:string external;
declare variable $description as xs:string external;

xf:bloqueaFondosCuentaIn(
    $accountNumber,
    $amount,
    $currency,
    $description)]]></con:xquery>
    <con:dependency location="../../BloqueoFondosCuenta/xsd/bloqueoFondosCuentaTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/BloqueoFondosCuenta/xsd/bloqueoFondosCuentaTypes"/>
    </con:dependency>
</con:xqueryEntry>