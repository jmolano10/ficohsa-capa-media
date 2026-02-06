xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:redencionPuntosLealtadResponse" location="../../ProgramaLealtad/xsd/programaLealtadTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RedencionPuntosLealtad/xq/redencionPuntosLealtadHNOut/";

declare function xf:redencionPuntosLealtadHNOut($legalId as xs:string,
    $customerName as xs:string,
    $points as xs:string,
    $pointTotalRemaining as xs:string,
    $redemptionId as xs:string)
    as element(ns0:redencionPuntosLealtadResponse) {
        <ns0:redencionPuntosLealtadResponse>
            <LEGAL_ID>{ $legalId }</LEGAL_ID>
            <CUSTOMER_NAME>{ $customerName }</CUSTOMER_NAME>
            <POINTS_REDEEMED>{ data($points) }</POINTS_REDEEMED>
            <REMAINING_BALANCE>{ data($pointTotalRemaining) }</REMAINING_BALANCE>
            <REDEMPTION_ID>{ data($redemptionId) }</REDEMPTION_ID>
        </ns0:redencionPuntosLealtadResponse>
};

declare variable $legalId as xs:string external;
declare variable $customerName as xs:string external;
declare variable $points as xs:string external;
declare variable $pointTotalRemaining as xs:string external;
declare variable $redemptionId as xs:string external;

xf:redencionPuntosLealtadHNOut($legalId,
    $customerName,
    $points,
    $pointTotalRemaining,
    $redemptionId)