(:: pragma bea:global-element-return element="ns0:BalanceInquiryRequest" location="../../../BusinessServices/VisionPlusPA/vmx/wsdl/VMX.wsdl" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VisionPlusPA/xq/balanceInquiryIn/";

declare function xf:balanceInquiryIn($org as xs:int,
    $accountNumber as xs:string)
    as element(ns0:BalanceInquiryRequest) {
        <ns0:BalanceInquiryRequest>
            <ARXBII-ORG>{ $org }</ARXBII-ORG>
            <ARXBII-ACCT>{ $accountNumber }</ARXBII-ACCT>
            <ARXBII-DUAL-IND/>
        </ns0:BalanceInquiryRequest>
};

declare variable $org as xs:int external;
declare variable $accountNumber as xs:string external;

xf:balanceInquiryIn($org,
    $accountNumber)