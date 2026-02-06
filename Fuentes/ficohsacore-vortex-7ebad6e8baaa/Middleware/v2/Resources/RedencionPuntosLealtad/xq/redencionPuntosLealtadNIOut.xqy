xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:redencionPuntosLealtadResponse" location="../../ProgramaLealtad/xsd/programaLealtadTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RedencionPuntosLealtad/xq/redencionPuntosLealtadNIOut/";

declare function xf:redencionPuntosLealtadNIOut($legalId as xs:string,
    $customerName as xs:string,
    $pointsRedeemed as xs:string,
    $remainingBalance as xs:string,
    $redemptionId as xs:string)
    as element(ns0:redencionPuntosLealtadResponse) {
        <ns0:redencionPuntosLealtadResponse>
            <LEGAL_ID>{ $legalId }</LEGAL_ID>
            <CUSTOMER_NAME>{ $customerName }</CUSTOMER_NAME>
            <POINTS_REDEEMED>{ xs:decimal($pointsRedeemed) }</POINTS_REDEEMED>
            {
            	if($remainingBalance != '') then
            	( 
            		<REMAINING_BALANCE>{ xs:decimal($remainingBalance) }</REMAINING_BALANCE>
            	) else ()
            }                        
            <REDEMPTION_ID>{ xs:long($redemptionId) }</REDEMPTION_ID>            
        </ns0:redencionPuntosLealtadResponse>
};

declare variable $legalId as xs:string external;
declare variable $customerName as xs:string external;
declare variable $pointsRedeemed as xs:string external;
declare variable $redemptionId as xs:string external;
declare variable $remainingBalance as xs:string external;

xf:redencionPuntosLealtadNIOut($legalId,
    $customerName,
    $pointsRedeemed,
    $remainingBalance,
    $redemptionId)