(:: pragma bea:global-element-parameter parameter="$reversionPuntosLealtad" element="ns0:reversionPuntosLealtad" location="../../ProgramaLealtad/xsd/programaLealtadTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:creditRedemption" location="../../../BusinessServices/Mastercard/RedemptionService/xsd/RedemptionService.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes";
declare namespace ns1 = "http://redemption.ws.mcrewards.mastercard.com/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversionPuntosLealtad/xq/creditRedemptionIn/";

declare function xf:creditRedemptionIn($reversionPuntosLealtad as element(ns0:reversionPuntosLealtad))
    as element(ns1:creditRedemption) {
        <ns1:creditRedemption>
            <ns1:redemptionId>{ data($reversionPuntosLealtad/REDEMPTION_ID) }</ns1:redemptionId>
            <ns1:creditDescription>{ data($reversionPuntosLealtad/CREDIT_DESCRIPTION) }</ns1:creditDescription>
            <ns1:userId>{ data($reversionPuntosLealtad/USER_ID) }</ns1:userId>
        </ns1:creditRedemption>
};

declare variable $reversionPuntosLealtad as element(ns0:reversionPuntosLealtad) external;

xf:creditRedemptionIn($reversionPuntosLealtad)