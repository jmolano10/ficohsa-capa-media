xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace fdcs="http://www.procesa.com/fdcs";
(:: import schema at "../Resources/VMX.wsdl" ::)

declare variable $org as xs:int external;
declare variable $accountNumber as xs:string external;


declare function local:accountInquiryVAIn() as element() (:: schema-element(fdcs:AccountInquiryVARequest) ::) {
    <fdcs:AccountInquiryVARequest>
      <ARXAII-ORG>{ $org }</ARXAII-ORG>
      <ARXAII-ACCT>{ $accountNumber }</ARXAII-ACCT>
    </fdcs:AccountInquiryVARequest>
};
local:accountInquiryVAIn()