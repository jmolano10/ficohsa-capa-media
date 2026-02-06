xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:AccountInquiryVARequest" location="../../../BusinessServices/VisionPlusGT/vmx/wsdl/VMX.wsdl" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VisionPlusGT/xq/accountInquiryVAIn/";

declare function xf:accountInquiryVAIn($org as xs:int,
    $accountNumber as xs:string)
    as element(ns0:AccountInquiryVARequest) {
        <ns0:AccountInquiryVARequest>
            <ARXAII-ORG>{ $org }</ARXAII-ORG>
            <ARXAII-ACCT>{ $accountNumber }</ARXAII-ACCT>
        </ns0:AccountInquiryVARequest>
};

declare variable $org as xs:int external;
declare variable $accountNumber as xs:string external;

xf:accountInquiryVAIn($org,
    $accountNumber)