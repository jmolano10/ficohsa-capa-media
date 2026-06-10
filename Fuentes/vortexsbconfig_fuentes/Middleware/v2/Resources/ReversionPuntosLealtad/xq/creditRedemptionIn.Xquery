<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$reversionPuntosLealtad" element="ns0:reversionPuntosLealtad" location="../../ProgramaLealtad/xsd/programaLealtadTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:creditRedemption" location="../../../BusinessServices/Mastercard/RedemptionService/xsd/RedemptionService.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes";
declare namespace ns1 = "http://redemption.ws.mcrewards.mastercard.com/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversionPuntosLealtad/xq/creditRedemptionIn/";

declare function xf:creditRedemptionIn($reversionPuntosLealtad as element(ns0:reversionPuntosLealtad))
    as element(ns1:creditRedemption) {
        <ns1:creditRedemption>
            <ns1:redemptionId>{ data($reversionPuntosLealtad/REDEMPTION_ID) }</ns1:redemptionId>
            <ns1:creditDescription>{ data($reversionPuntosLealtad/CREDIT_DESCRIPTION) }</ns1:creditDescription>
            <ns1:userId>{ data($reversionPuntosLealtad/USER_ID) }</ns1:userId>
        </ns1:creditRedemption>
};

declare variable $reversionPuntosLealtad as element(ns0:reversionPuntosLealtad) external;

xf:creditRedemptionIn($reversionPuntosLealtad)]]></con:xquery>
    <con:dependency location="../../ProgramaLealtad/xsd/programaLealtadTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ProgramaLealtad/xsd/programaLealtadTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/Mastercard/RedemptionService/xsd/RedemptionService.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/Mastercard/RedemptionService/xsd/RedemptionService"/>
    </con:dependency>
</con:xqueryEntry>