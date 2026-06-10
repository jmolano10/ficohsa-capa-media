<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:onlineInformation" location="../../../../Resources/OnlineInformation/xsd/onlineInformationTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/onlineInformationTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaCuentaTCHN/xq/onlineInformationIn/";

declare function xf:onlineInformationIn($accountNumber as xs:string,
    $org as xs:string,
    $countryCode as xs:string)
    as element(ns0:onlineInformation) {
        <ns0:onlineInformation>
            <CountryCode>{ data($countryCode) }</CountryCode>
            <OrgNumber>{ data($org) }</OrgNumber>
            <AccountNumber>{ data($accountNumber) }</AccountNumber>
        </ns0:onlineInformation>
};

declare variable $accountNumber as xs:string external;
declare variable $org as xs:string external;
declare variable $countryCode as xs:string external;

xf:onlineInformationIn($accountNumber,
    $org,
    $countryCode)]]></con:xquery>
    <con:dependency location="../../../../Resources/OnlineInformation/xsd/onlineInformationTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/OnlineInformation/xsd/onlineInformationTypes"/>
    </con:dependency>
</con:xqueryEntry>