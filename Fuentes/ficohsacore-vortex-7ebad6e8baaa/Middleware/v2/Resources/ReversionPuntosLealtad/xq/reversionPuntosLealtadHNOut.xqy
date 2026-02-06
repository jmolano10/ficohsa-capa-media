xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:reversionPuntosLealtadResponse" location="../../ProgramaLealtad/xsd/programaLealtadTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversionPuntosLealtad/xq/reversionPuntosLealtadHNOut/";

declare function xf:reversionPuntosLealtadHNOut($legalId as xs:string,
    $customerName as xs:string,
    $pointsAvailable as xs:string,
    $redemptionId as xs:string,
    $totalPointsCredited as xs:string,
    $creditRedemptionId as xs:string)
    as element(ns0:reversionPuntosLealtadResponse) {
        <ns0:reversionPuntosLealtadResponse>
            <LEGAL_ID>{ $legalId }</LEGAL_ID>
            <CUSTOMER_NAME>{ $customerName }</CUSTOMER_NAME>
            <POINTS_AVAILABLE>{ data($pointsAvailable) }</POINTS_AVAILABLE>
            <CREDIT_RESULT>
                <REDEMPTION_ID>{ data($redemptionId) }</REDEMPTION_ID>
                <TOTAL_POINTS_CREDITED>{ data($totalPointsCredited) }</TOTAL_POINTS_CREDITED>
                <CREDIT_REDEMPTION_ID>{ data($creditRedemptionId) }</CREDIT_REDEMPTION_ID>
            </CREDIT_RESULT>
        </ns0:reversionPuntosLealtadResponse>
};

declare variable $legalId as xs:string external;
declare variable $customerName as xs:string external;
declare variable $pointsAvailable as xs:string external;
declare variable $redemptionId as xs:string external;
declare variable $totalPointsCredited as xs:string external;
declare variable $creditRedemptionId as xs:string external;

xf:reversionPuntosLealtadHNOut($legalId,
    $customerName,
    $pointsAvailable,
    $redemptionId,
    $totalPointsCredited,
    $creditRedemptionId)