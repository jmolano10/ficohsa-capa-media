<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:cashOpenToBuyInquiry" location="../../../../Resources/CashOpenToBuyInquiry/xsd/cashOpenToBuyInquiryTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/cashOpenToBuyInquiryTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaSaldosTarjetaCredito/xq/cashOpenToBuyIn/";

declare function xf:cashOpenToBuyIn($org as xs:string,
    $accountNumber as xs:string,
    $countryCode as xs:string)
    as element(ns0:cashOpenToBuyInquiry) {
        <ns0:cashOpenToBuyInquiry>
            <CountryCode>{ $countryCode }</CountryCode>
            <OrgNumber>{ data($org) }</OrgNumber>
            <AccountNumber>{ data($accountNumber) }</AccountNumber>
        </ns0:cashOpenToBuyInquiry>
};

declare variable $org as xs:string external;
declare variable $accountNumber as xs:string external;
declare variable $countryCode as xs:string external;

xf:cashOpenToBuyIn($org,
    $accountNumber,
    $countryCode)]]></con:xquery>
    <con:dependency location="../../../../Resources/CashOpenToBuyInquiry/xsd/cashOpenToBuyInquiryTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/CashOpenToBuyInquiry/xsd/cashOpenToBuyInquiryTypes"/>
    </con:dependency>
</con:xqueryEntry>