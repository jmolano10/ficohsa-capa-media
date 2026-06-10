<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:identity" location="../../../BusinessServices/Mastercard/Common/xsd/CommonResponses.xsd" ::)

declare namespace ns0 = "http://common.ws.mcrewards.mastercard.com/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProgramaLealtad/xq/MRSIdentity/";

declare function xf:MRSIdentity($appID as xs:string,
    $institutionName as xs:string)
    as element(ns0:identity) {
        <ns0:identity>
            <ns0:appID>{ $appID }</ns0:appID>
            <ns0:institutionName>{ $institutionName }</ns0:institutionName>
        </ns0:identity>
};

declare variable $appID as xs:string external;
declare variable $institutionName as xs:string external;

xf:MRSIdentity($appID,
    $institutionName)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/Mastercard/Common/xsd/CommonResponses.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/Mastercard/Common/xsd/CommonResponses"/>
    </con:dependency>
</con:xqueryEntry>