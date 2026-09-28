xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:CashOTBInquiryRequest" location="../../../BusinessServices/VisionPlusPA/fdcs/wsdl/Fdcs.wsdl" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VisionPlusPA/cashOpenToBuyInquiryIn/";
declare namespace ns0 = "http://www.procesa.com/fdcs";

declare function xf:cashOpenToBuyInquiryIn($org as xs:string,
    $accountNumber as xs:string)
    as element(ns0:CashOTBInquiryRequest) {
        <ns0:CashOTBInquiryRequest>
        <OrgNumber>{ data($org) }</OrgNumber>
            <ForeignUse></ForeignUse>
            <AccountNumber>{ $accountNumber }</AccountNumber>
        </ns0:CashOTBInquiryRequest>
};

declare variable $org as xs:string external;
declare variable $accountNumber as xs:string external;

xf:cashOpenToBuyInquiryIn($org,
    $accountNumber)