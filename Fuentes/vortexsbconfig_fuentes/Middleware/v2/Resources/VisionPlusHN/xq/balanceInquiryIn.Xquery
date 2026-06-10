<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:BalanceInquiryRequest" location="../../../BusinessServices/VisionPlusHN/vmx/wsdl/VMX.wsdl" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VisionPlusHN/xq/balanceInquiryIn/";
declare namespace ns0 = "http://www.procesa.com/fdcs";

declare function xf:balanceInquiryIn($org as xs:normalizedString,
    $accountNumber as xs:string)
    as element(ns0:BalanceInquiryRequest) {
        <ns0:BalanceInquiryRequest>
            <ARXBII-ORG>{ $org }</ARXBII-ORG>
            <ARXBII-ACCT>{ $accountNumber }</ARXBII-ACCT>
            <ARXBII-DUAL-IND/>
        </ns0:BalanceInquiryRequest>
};

declare variable $org as xs:normalizedString external;
declare variable $accountNumber as xs:string external;

xf:balanceInquiryIn($org,
    $accountNumber)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/VisionPlusHN/vmx/wsdl/VMX.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/VisionPlusHN/vmx/wsdl/VMX"/>
    </con:dependency>
</con:xqueryEntry>