xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:OnlineInformationRequest" location="../../../BusinessServices/VisionPlusHN/onlineTransactions_v4/wsdl/OnlineTransactions_v4.wsdl" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VisionPlusHN/xq/onlineInformationIn/";
declare namespace ns0 = "http://www.procesa.com/fdcs/ot";

declare function xf:onlineInformationIn($cardNumber as xs:string,
    $orgId as xs:integer,
    $merchantNumber as xs:integer)
    as element(ns0:OnlineInformationRequest) {
        <ns0:OnlineInformationRequest>
            <CardNumber>{ data($cardNumber) }</CardNumber>
            <OrgId>{ data($orgId) }</OrgId>
            <MerchantNumber>1234</MerchantNumber>
        </ns0:OnlineInformationRequest>
};

declare variable $cardNumber as xs:string external;
declare variable $orgId as xs:integer external;
declare variable $merchantNumber as xs:integer external;

xf:onlineInformationIn($cardNumber,
    $orgId,
    $merchantNumber)