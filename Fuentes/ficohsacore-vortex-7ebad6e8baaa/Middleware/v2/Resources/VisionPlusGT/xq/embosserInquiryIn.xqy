xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:EmbosserInquiryRequest" location="../../../BusinessServices/VisionPlusGT/vmx/wsdl/VMX.wsdl" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VisionPlusGT/xq/embosserInquiryIn/";

declare function xf:embosserInquiryIn($org as xs:int,
    $cardNumber as xs:string)
    as element(ns0:EmbosserInquiryRequest) {
        <ns0:EmbosserInquiryRequest>
            <ARXCII-ORG>{ $org }</ARXCII-ORG>
            <ARXCII-CARD>{ $cardNumber }</ARXCII-CARD>
        </ns0:EmbosserInquiryRequest>
};

declare variable $org as xs:int external;
declare variable $cardNumber as xs:string external;

xf:embosserInquiryIn($org,
    $cardNumber)