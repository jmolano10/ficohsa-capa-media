(:: pragma bea:global-element-return element="ns0:OnlineInformationRequest" location="../../../BusinessServices/VisionPlus/onlineTransactions_v3/wsdl/OnlineTransactions_v3.wsdl" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs/ot";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VisionPlus/xq/onlineInformationIn/";

declare function xf:onlineInformationIn($cardNumber as xs:string,
    $orgId as xs:int,
    $merchantNumber as xs:int)
    as element(ns0:OnlineInformationRequest) {
        <ns0:OnlineInformationRequest>
            <CardNumber>{ data($cardNumber) }</CardNumber>
            <OrgId>{ data($orgId) }</OrgId>
            <MerchantNumber>1234</MerchantNumber>
        </ns0:OnlineInformationRequest>
};

declare variable $cardNumber as xs:string external;
declare variable $orgId as xs:int external;
declare variable $merchantNumber as xs:int external;

xf:onlineInformationIn($cardNumber,
    $orgId,
    $merchantNumber)