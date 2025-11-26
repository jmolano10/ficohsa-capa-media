(:: pragma bea:global-element-return element="ns0:AccountInquiryL8VLRequest" location="../../../BusinessServices/VisionPlusHN/fdcs/wsdl/Fdcs.wsdl" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCuentaTC/xq/accountInquiryL8VLIn/";

declare function xf:accountInquiryL8VLIn($org as xs:string,
    $accountNumber as xs:string,
    $foreignUse as xs:string)
    as element(ns0:AccountInquiryL8VLRequest) {
        <ns0:AccountInquiryL8VLRequest>
            <AZXAII-ORG>{ data($org) }</AZXAII-ORG>
            <AZXAII-ACCT>{ data($accountNumber) }</AZXAII-ACCT>
            <AZXAII-FOREIGN-USE>
            { 
              if(data($foreignUse) = 'BASE')then (
              
                     '0'
              
             )elseif(data($foreignUse) = 'ALT')then (
             
                     '1'
             
             )else ()
            }
            </AZXAII-FOREIGN-USE>
        </ns0:AccountInquiryL8VLRequest>
};

declare variable $org as xs:string external;
declare variable $accountNumber as xs:string external;
declare variable $foreignUse as xs:string external;

xf:accountInquiryL8VLIn($org,
    $accountNumber,
    $foreignUse)