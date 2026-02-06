xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:cashOpenToBuyInquiry" location="../../../../../v2/Resources/CashOpenToBuyInquiry/xsd/cashOpenToBuyInquiryTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/cashOpenToBuyInquiryTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/BusinessServices/SJS/ConsultaMaestraSaldosTarjetaCreditoNI/xq/cashOpenToBuyInquiryIn/";

declare function xf:cashOpenToBuyInquiryIn($countryCode as xs:string,
    $accountNumber as xs:string,
    $org as xs:string)
    as element(ns0:cashOpenToBuyInquiry) {
        <ns0:cashOpenToBuyInquiry>
            <CountryCode>{ $countryCode }</CountryCode>
            <OrgNumber>{ data($org) }</OrgNumber>
            <AccountNumber>{ $accountNumber }</AccountNumber>
        </ns0:cashOpenToBuyInquiry>
};

declare variable $countryCode as xs:string external;
declare variable $accountNumber as xs:string external;
declare variable $org as xs:string external;

xf:cashOpenToBuyInquiryIn($countryCode,
    $accountNumber,
    $org)