xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$creditRedemptionResponse" element="ns1:creditRedemptionResponse" location="../../../BusinessServices/Mastercard/RedemptionService/xsd/RedemptionService.xsd" ::)
(:: pragma bea:global-element-return element="ns0:reversionPuntosLealtadResponse" location="../../ProgramaLealtad/xsd/programaLealtadTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes";
declare namespace ns1 = "http://redemption.ws.mcrewards.mastercard.com/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversionPuntosLealtad/xq/reversionPuntosLealtadOut/";

declare function xf:reversionPuntosLealtadOut($legalId as xs:string,
    $customerName as xs:string,
    $creditRedemptionResponse as element(ns1:creditRedemptionResponse))
    as element(ns0:reversionPuntosLealtadResponse) {
        <ns0:reversionPuntosLealtadResponse>
            <LEGAL_ID>{ $legalId }</LEGAL_ID>
            <CUSTOMER_NAME>{ $customerName }</CUSTOMER_NAME>
            {
                for $pointsAvailable in $creditRedemptionResponse/ns1:pointsAvailable
                return
                    <POINTS_AVAILABLE>{ data($pointsAvailable) }</POINTS_AVAILABLE>
            }
            {
                let $result :=
                    for $creditResults in $creditRedemptionResponse/ns1:creditResults
                    return
                        <CREDIT_RESULT>
                            <REDEMPTION_ID>{ data($creditResults/ns1:redemptionId) }</REDEMPTION_ID>
                            {
                                for $totalPointsCredited in $creditResults/ns1:totalPointsCredited
                                return
                                    <TOTAL_POINTS_CREDITED>{ data($totalPointsCredited) }</TOTAL_POINTS_CREDITED>
                            }
                            <CREDIT_REDEMPTION_ID>{ data($creditResults/ns1:creditRedemptionId) }</CREDIT_REDEMPTION_ID>
                        </CREDIT_RESULT>
                return
                    $result[1]
            }
        </ns0:reversionPuntosLealtadResponse>
};

declare variable $legalId as xs:string external;
declare variable $customerName as xs:string external;
declare variable $creditRedemptionResponse as element(ns1:creditRedemptionResponse) external;

xf:reversionPuntosLealtadOut($legalId,
    $customerName,
    $creditRedemptionResponse)