(:: pragma bea:global-element-return element="ns0:EmbosserInquiryRequest" location="../../../BusinessServices/VisionPlus/vmx/wsdl/VMX.wsdl" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VisionPlus/xq/embosserInquiryIn/";

declare function xf:embosserInquiryIn($org as xs:string,
    $cardNumber as xs:string)
    as element(ns0:EmbosserInquiryRequest) {
        <ns0:EmbosserInquiryRequest>
            <ARXCII-ORG>{ $org }</ARXCII-ORG>
            <ARXCII-CARD>{ $cardNumber }</ARXCII-CARD>
        </ns0:EmbosserInquiryRequest>
};

declare variable $org as xs:string external;
declare variable $cardNumber as xs:string external;

xf:embosserInquiryIn($org,
    $cardNumber)