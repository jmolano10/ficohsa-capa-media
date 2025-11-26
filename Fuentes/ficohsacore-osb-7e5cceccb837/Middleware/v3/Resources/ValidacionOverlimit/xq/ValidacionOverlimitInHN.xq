xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:validacionOverlimitRequest" location="../xsd/ValidacionOverlimitTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ValidacionOverlimit/ValidacionOverlimitInHN/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/ValidacionOverlimitTypes";

declare function xf:ValidacionOverlimitInHN($CardNumber as xs:string,
    $CardBank as xs:string,
    $CountryCode as xs:string,
    $PaymentAmount as xs:decimal,
    $PaymentCurrency as xs:string,
    $TasaCambio as xs:decimal,
    $CruceMoneda as xs:string)
    as element(ns0:validacionOverlimitRequest) {
         <ns0:validacionOverlimitRequest>
            <CARD_NUMBER>{ $CardNumber }</CARD_NUMBER>
            <CARD_BANK>{ $CardBank }</CARD_BANK>
            <COUNTRY_CODE>{ $CountryCode }</COUNTRY_CODE>
            <PAYMENT_AMOUNT>{ $PaymentAmount }</PAYMENT_AMOUNT>
            <PAYMENT_CURRENCY>{ $PaymentCurrency }</PAYMENT_CURRENCY>
            <EXCHANGE_RATE>{ $TasaCambio }</EXCHANGE_RATE>
         	<COINS_CROSSING>{ $CruceMoneda }</COINS_CROSSING>
        </ns0:validacionOverlimitRequest>
};

declare variable $CardNumber as xs:string external;
declare variable $CardBank as xs:string external;
declare variable $CountryCode as xs:string external;
declare variable $PaymentAmount as xs:decimal external;
declare variable $PaymentCurrency as xs:string external;
declare variable $TasaCambio as xs:decimal external;
declare variable $CruceMoneda as xs:string external;

xf:ValidacionOverlimitInHN($CardNumber,
    $CardBank,
    $CountryCode,
    $PaymentAmount,
    $PaymentCurrency,
    $TasaCambio,
    $CruceMoneda)
