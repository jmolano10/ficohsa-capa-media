(:: pragma bea:global-element-return element="ns0:AccountInquiryL8VLRequest" location="../../../BusinessServices/VisionPlusGT/vmx/wsdl/VMX.wsdl" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VisionPlusGT/xq/accountInquiryL8VL/";

declare function xf:accountInquiryL8VL($org as xs:int,
    $accountNumber as xs:string)
    as element(ns0:AccountInquiryL8VLRequest) {
        <ns0:AccountInquiryL8VLRequest>
            <AZXAII-ORG>{ $org }</AZXAII-ORG>
            <AZXAII-ACCT>{ $accountNumber }</AZXAII-ACCT>
        </ns0:AccountInquiryL8VLRequest>
};

declare variable $org as xs:int external;
declare variable $accountNumber as xs:string external;

xf:accountInquiryL8VL($org,
    $accountNumber)