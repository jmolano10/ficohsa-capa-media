<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:CashOTBInquiryRequest" location="../../../BusinessServices/VisionPlus/fdcs/wsdl/Fdcs.wsdl" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VisionPlus/xq/cashOpenToBuyInquiryIn/";

declare function xf:cashOpenToBuyInquiryIn($org as xs:string,
    $accountNumber as xs:string)
    as element(ns0:CashOTBInquiryRequest) {
        <ns0:CashOTBInquiryRequest>
            <OrgNumber>{ data($org) }</OrgNumber>
            <ForeignUse></ForeignUse>
            <AccountNumber>{ $accountNumber }</AccountNumber>
        </ns0:CashOTBInquiryRequest>
};

declare variable $org as xs:string external;
declare variable $accountNumber as xs:string external;

xf:cashOpenToBuyInquiryIn($org,
    $accountNumber)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/VisionPlus/fdcs/wsdl/Fdcs.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/VisionPlus/fdcs/wsdl/Fdcs"/>
    </con:dependency>
</con:xqueryEntry>