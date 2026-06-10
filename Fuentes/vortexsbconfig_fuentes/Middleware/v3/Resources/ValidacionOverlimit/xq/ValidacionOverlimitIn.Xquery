<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:validacionOverlimitRequest" location="../xsd/ValidacionOverlimitTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/ValidacionOverlimitTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidacionOverlimit/xq/ValidacionOverlimitIn/";

declare function xf:ValidacionOverlimitIn($CardNumber as xs:string,
    $CardBank as xs:string,
    $CountryCode as xs:string,
    $PaymentAmount as xs:decimal,
    $PaymentCurrency as xs:string)
    as element(ns0:validacionOverlimitRequest) {
        <ns0:validacionOverlimitRequest>
            <CARD_NUMBER>{ $CardNumber }</CARD_NUMBER>
            <CARD_BANK>{ $CardBank }</CARD_BANK>
            <COUNTRY_CODE>{ $CountryCode }</COUNTRY_CODE>
            <PAYMENT_AMOUNT>{ $PaymentAmount }</PAYMENT_AMOUNT>
            <PAYMENT_CURRENCY>{ $PaymentCurrency }</PAYMENT_CURRENCY>
        </ns0:validacionOverlimitRequest>
};

declare variable $CardNumber as xs:string external;
declare variable $CardBank as xs:string external;
declare variable $CountryCode as xs:string external;
declare variable $PaymentAmount as xs:decimal external;
declare variable $PaymentCurrency as xs:string external;

xf:ValidacionOverlimitIn($CardNumber,
    $CardBank,
    $CountryCode,
    $PaymentAmount,
    $PaymentCurrency)]]></con:xquery>
    <con:dependency location="../xsd/ValidacionOverlimitTypes.xsd">
        <con:schema ref="Middleware/v3/Resources/ValidacionOverlimit/xsd/ValidacionOverlimitTypes"/>
    </con:dependency>
</con:xqueryEntry>