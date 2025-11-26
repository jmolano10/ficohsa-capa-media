(:: pragma bea:global-element-return element="ns0:OnlineUpdateCardRequest" location="../../../BusinessServices/VisionPlus/onlineTransactions_v3/wsdl/OnlineTransactions_v3.wsdl" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs/ot";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VisionPlus/xq/onlineUpdateCardIn/";

declare function xf:onlineUpdateCardIn($requestType as xs:string,
    $cardNumber as xs:string,
    $orgId as xs:string,
    $merchantNumber as xs:string,
    $updateValue as xs:string)
    as element(ns0:OnlineUpdateCardRequest) {
        <ns0:OnlineUpdateCardRequest>
            <RequestType>{ $requestType }</RequestType>
            <CardNumber>{ $cardNumber }</CardNumber>
            <OrgId>{ data($orgId) }</OrgId>
            <MerchantNumber>{ data($merchantNumber) }</MerchantNumber>
            <UpdateValue>{ $updateValue }</UpdateValue>
        </ns0:OnlineUpdateCardRequest>
};

declare variable $requestType as xs:string external;
declare variable $cardNumber as xs:string external;
declare variable $orgId as xs:string external;
declare variable $merchantNumber as xs:string external;
declare variable $updateValue as xs:string external;

xf:onlineUpdateCardIn($requestType,
    $cardNumber,
    $orgId,
    $merchantNumber,
    $updateValue)