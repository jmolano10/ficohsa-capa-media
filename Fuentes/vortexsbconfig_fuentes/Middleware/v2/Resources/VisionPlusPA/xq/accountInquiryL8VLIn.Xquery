<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:AccountInquiryL8VLRequest" location="../../../BusinessServices/VisionPlusPA/vmx/wsdl/VMX.wsdl" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VisionPlusPA/xq/accountInquiryL8VLIn/";

declare function xf:accountInquiryL8VLIn($org as xs:int,
    $accountNumber as xs:string)
    as element(ns0:AccountInquiryL8VLRequest) {
        <ns0:AccountInquiryL8VLRequest>
            <AZXAII-ORG>{ $org }</AZXAII-ORG>
            <AZXAII-ACCT>{ $accountNumber }</AZXAII-ACCT>
        </ns0:AccountInquiryL8VLRequest>
};

declare variable $org as xs:int external;
declare variable $accountNumber as xs:string external;

xf:accountInquiryL8VLIn($org,
    $accountNumber)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/VisionPlusPA/vmx/wsdl/VMX.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/VisionPlusPA/vmx/wsdl/VMX"/>
    </con:dependency>
</con:xqueryEntry>