(:: pragma bea:global-element-return element="ns0:OnlineInformationRequest" location="../../../BusinessServices/VisionPlusPA/onlineTransactions_v4/wsdl/OnlineTransactions_v4.wsdl" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs/ot";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VisionPlusPA/xq/onlineInformationIn/";

declare function xf:onlineInformationIn($CardNumber as xs:string,
    $OrgId as xs:int,
    $MerchantNumber as xs:int)
    as element(ns0:OnlineInformationRequest) {
        <ns0:OnlineInformationRequest>
            <CardNumber>{ data($CardNumber) }</CardNumber>
            <OrgId>{ data($OrgId) }</OrgId>
            <MerchantNumber>1234</MerchantNumber>
        </ns0:OnlineInformationRequest>
};

declare variable $CardNumber as xs:string external;
declare variable $OrgId as xs:int external;
declare variable $MerchantNumber as xs:int external;

xf:onlineInformationIn($CardNumber,
    $OrgId,
    $MerchantNumber)