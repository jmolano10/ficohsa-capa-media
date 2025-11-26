(:: pragma bea:global-element-return element="ns0:AccountInquiryVARequest" location="../../../BusinessServices/VisionPlusHN/vmx/wsdl/VMX.wsdl" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MasterDataHN/xq/accountInquiryVAIn_StringParams/";

declare function xf:accountInquiryVAIn_StringParams($org as xs:int,
    $accountNumber as xs:string)
    as element(ns0:AccountInquiryVARequest) {
        <ns0:AccountInquiryVARequest>
            <ARXAII-ORG>{ $org }</ARXAII-ORG>
            <ARXAII-ACCT>{ $accountNumber }</ARXAII-ACCT>
        </ns0:AccountInquiryVARequest>
};

declare variable $org as xs:int external;
declare variable $accountNumber as xs:string external;

xf:accountInquiryVAIn_StringParams($org,
    $accountNumber)