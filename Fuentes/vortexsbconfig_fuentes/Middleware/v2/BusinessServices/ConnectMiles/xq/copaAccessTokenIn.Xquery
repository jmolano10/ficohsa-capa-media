<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:copaAccessTokenRequest" location="../xsd/copaAccessTokenTypes.xsd" ::)

declare namespace ns0 = "http://copa.com/osb/accesstoken";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/ConnectMiles/xq/copaAccessTokenIn/";

declare function xf:copaAccessTokenIn($audience as xs:string,
    $scope as xs:string,
    $grantType as xs:string,
    $clientId as xs:string,
    $clientSecret as xs:string)
    as element(ns0:copaAccessTokenRequest) {
        <ns0:copaAccessTokenRequest>
            <ns0:AUDIENCE>{ $audience }</ns0:AUDIENCE>
            <ns0:SCOPE>{ $scope }</ns0:SCOPE>
            <ns0:GRANT_TYPE>{ $grantType }</ns0:GRANT_TYPE>
            <ns0:CLIENT_ID>{ $clientId }</ns0:CLIENT_ID>
            <ns0:CLIENT_SECRET>{ $clientSecret }</ns0:CLIENT_SECRET>
        </ns0:copaAccessTokenRequest>
};

declare variable $audience as xs:string external;
declare variable $scope as xs:string external;
declare variable $grantType as xs:string external;
declare variable $clientId as xs:string external;
declare variable $clientSecret as xs:string external;

xf:copaAccessTokenIn($audience,
    $scope,
    $grantType,
    $clientId,
    $clientSecret)]]></con:xquery>
    <con:dependency location="../xsd/copaAccessTokenTypes.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ConnectMiles/xsd/copaAccessTokenTypes"/>
    </con:dependency>
</con:xqueryEntry>