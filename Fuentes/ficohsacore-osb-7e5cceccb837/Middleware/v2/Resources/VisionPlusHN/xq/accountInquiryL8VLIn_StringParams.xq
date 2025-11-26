(:: pragma bea:global-element-return element="ns0:AccountInquiryL8VLRequest" location="../../../BusinessServices/VisionPlusHN/vmx/wsdl/VMX.wsdl" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MasterDataHN/xq/accountInquiryL8VLIn_StringParams/";

declare function xf:accountInquiryL8VLIn_StringParams($org as xs:int,
    $accountNumber as xs:string)
    as element(ns0:AccountInquiryL8VLRequest) {
        <ns0:AccountInquiryL8VLRequest>
            <AZXAII-ORG>{ $org }</AZXAII-ORG>
            <AZXAII-ACCT>{ $accountNumber }</AZXAII-ACCT>
        </ns0:AccountInquiryL8VLRequest>
};

declare variable $org as xs:int external;
declare variable $accountNumber as xs:string external;

xf:accountInquiryL8VLIn_StringParams($org,
    $accountNumber)