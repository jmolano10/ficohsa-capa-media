<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:BalanceInquiryRequest" location="../../../BusinessServices/VisionPlus/vmx/wsdl/VMX.wsdl" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VisionPlus/xq/balanceInquiryIn/";

declare function xf:balanceInquiryIn($org as xs:string,
    $accountNumber as xs:string)
    as element(ns0:BalanceInquiryRequest) {
        <ns0:BalanceInquiryRequest>
            <ARXBII-ORG>{ $org }</ARXBII-ORG>
            <ARXBII-ACCT>{ $accountNumber }</ARXBII-ACCT>
            <ARXBII-DUAL-IND/>
        </ns0:BalanceInquiryRequest>
};

declare variable $org as xs:string external;
declare variable $accountNumber as xs:string external;

xf:balanceInquiryIn($org,
    $accountNumber)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/VisionPlus/vmx/wsdl/VMX.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/VisionPlus/vmx/wsdl/VMX"/>
    </con:dependency>
</con:xqueryEntry>