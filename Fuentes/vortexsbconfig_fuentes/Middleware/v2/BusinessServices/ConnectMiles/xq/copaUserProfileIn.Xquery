<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:copaUserProfileRequest" location="../xsd/copaUserProfileTypes.xsd" ::)

declare namespace ns0 = "http://copa.com/osb/userprofile";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/ConnectMiles/xq/copaUserProfileIn/";

declare function xf:copaUserProfileIn($membershipID as xs:string,
    $copaChannelID as xs:string,
    $authorization as xs:string,
    $ocpApimSubscriptionKey as xs:string)
    as element(ns0:copaUserProfileRequest) {
        <ns0:copaUserProfileRequest>
            <ns0:MEMBERSHIP_ID>{ $membershipID }</ns0:MEMBERSHIP_ID>
            <ns0:COPA_CHANNEL_ID>{ $copaChannelID }</ns0:COPA_CHANNEL_ID>
            <ns0:AUTHORIZATION>{ $authorization }</ns0:AUTHORIZATION>
            <ns0:OCP_APIM_SUBSCRIPTION_KEY>{ $ocpApimSubscriptionKey }</ns0:OCP_APIM_SUBSCRIPTION_KEY>
        </ns0:copaUserProfileRequest>
};

declare variable $membershipID as xs:string external;
declare variable $copaChannelID as xs:string external;
declare variable $authorization as xs:string external;
declare variable $ocpApimSubscriptionKey as xs:string external;

xf:copaUserProfileIn($membershipID,
    $copaChannelID,
    $authorization,
    $ocpApimSubscriptionKey)]]></con:xquery>
    <con:dependency location="../xsd/copaUserProfileTypes.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ConnectMiles/xsd/copaUserProfileTypes"/>
    </con:dependency>
</con:xqueryEntry>