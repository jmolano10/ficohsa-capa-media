(:: pragma bea:global-element-return element="ns0:AccountInquiryVARequest" location="../../../BusinessServices/VisionPlusHN/fdcs/wsdl/Fdcs.wsdl" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCuentaTC/xq/accountInquiryVAIn/";

declare function xf:accountInquiryVAIn($org as xs:string,
    $accountNumber as xs:string,
    $foreignUse as xs:string)
    as element(ns0:AccountInquiryVARequest) {
        <ns0:AccountInquiryVARequest>
            <ARXAII-ORG>{ data($org) }</ARXAII-ORG>
            <ARXAII-ACCT>{ data($accountNumber) }</ARXAII-ACCT>
            <ARXAII-FOREIGN-USE>
            { 
              if(data($foreignUse) = 'BASE')then (
              
                     '0'
              
             )elseif(data($foreignUse) = 'ALT')then (
             
                     '1'    
             )else ()
            }
            </ARXAII-FOREIGN-USE>
        </ns0:AccountInquiryVARequest>
};

declare variable $org as xs:string external;
declare variable $accountNumber as xs:string external;
declare variable $foreignUse as xs:string external;

xf:accountInquiryVAIn($org,
    $accountNumber,
    $foreignUse)