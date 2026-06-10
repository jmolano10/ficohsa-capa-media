<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:EmbosserInquiryL8V6Request" location="../../../BusinessServices/VisionPlusPA/vmx/wsdl/VMX.wsdl" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VisionPlusPA/xq/embosserInquiryL8V6In/";

declare function xf:embosserInquiryL8V6In($cardNumber as xs:string,
    $numberType as xs:integer,
    $org as xs:string)
    as element(ns0:EmbosserInquiryL8V6Request) {
        <ns0:EmbosserInquiryL8V6Request>
            <AZXCII-ORG>{ data($org) }</AZXCII-ORG>
            <AZXCII-CARD>{ $cardNumber }</AZXCII-CARD>
            <AZXCII-SEQ>{ data($numberType) }</AZXCII-SEQ>
        </ns0:EmbosserInquiryL8V6Request>
};

declare variable $cardNumber as xs:string external;
declare variable $numberType as xs:integer external;
declare variable $org as xs:string external;

xf:embosserInquiryL8V6In($cardNumber,
    $numberType,
    $org)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/VisionPlusPA/vmx/wsdl/VMX.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/VisionPlusPA/vmx/wsdl/VMX"/>
    </con:dependency>
</con:xqueryEntry>