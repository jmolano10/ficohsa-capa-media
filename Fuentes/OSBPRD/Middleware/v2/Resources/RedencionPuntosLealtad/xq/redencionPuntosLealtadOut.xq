(:: pragma bea:global-element-parameter parameter="$doItemRedemptionResponse" element="ns1:doItemRedemptionResponse" location="../../../BusinessServices/Mastercard/RedemptionService/xsd/RedemptionService.xsd" ::)
(:: pragma bea:global-element-return element="ns0:redencionPuntosLealtadResponse" location="../../ProgramaLealtad/xsd/programaLealtadTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes";
declare namespace ns1 = "http://redemption.ws.mcrewards.mastercard.com/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RedencionPuntosLealtad/xq/redencionPuntosLealtadOut/";

declare function xf:redencionPuntosLealtadOut($legalId as xs:string,
    $customerName as xs:string,
    $points as xs:double,
    $doItemRedemptionResponse as element(ns1:doItemRedemptionResponse))
    as element(ns0:redencionPuntosLealtadResponse) {
        <ns0:redencionPuntosLealtadResponse>
            <LEGAL_ID>{ $legalId }</LEGAL_ID>
            <CUSTOMER_NAME>{ $customerName }</CUSTOMER_NAME>
            <POINTS_REDEEMED>{ $points }</POINTS_REDEEMED>
            {
                for $pointTotalRemaining in $doItemRedemptionResponse/ns1:pointTotalRemaining
                return
                    <REMAINING_BALANCE>{ data($pointTotalRemaining) }</REMAINING_BALANCE>
            }
            {
                for $redemptionId in $doItemRedemptionResponse/ns1:redemptionResults[1]/ns1:redemptionId
                return
                    <REDEMPTION_ID>{ data($redemptionId) }</REDEMPTION_ID>
            }
        </ns0:redencionPuntosLealtadResponse>
};

declare variable $legalId as xs:string external;
declare variable $customerName as xs:string external;
declare variable $points as xs:double external;
declare variable $doItemRedemptionResponse as element(ns1:doItemRedemptionResponse) external;

xf:redencionPuntosLealtadOut($legalId,
    $customerName,
    $points,
    $doItemRedemptionResponse)