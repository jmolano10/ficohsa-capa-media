<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:CardBlockRequest" location="../../../BusinessServices/VisionPlusHN/fdcs/wsdl/Fdcs.wsdl" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VisionPlusHN/xq/cardBlockIn/";

declare function xf:cardBlockIn($orgNumber as xs:string,
    $accountNumber as xs:string,
    $blockCode as xs:string)
    as element(ns0:CardBlockRequest) {
        <ns0:CardBlockRequest>
            <OrgNumber>{ data($orgNumber) }</OrgNumber>
            <AccountNumber>{ $accountNumber }</AccountNumber>
            <BlockCode>{ $blockCode }</BlockCode>
        </ns0:CardBlockRequest>
};

declare variable $orgNumber as xs:string external;
declare variable $accountNumber as xs:string external;
declare variable $blockCode as xs:string external;

xf:cardBlockIn($orgNumber,
    $accountNumber,
    $blockCode)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/VisionPlusHN/fdcs/wsdl/Fdcs.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/VisionPlusHN/fdcs/wsdl/Fdcs"/>
    </con:dependency>
</con:xqueryEntry>