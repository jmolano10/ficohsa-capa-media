(:: pragma bea:global-element-return element="ns0:consultaPuntosLealtadResponse" location="../../ProgramaLealtad/xsd/programaLealtadTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPuntosLealtad/xq/consultaPuntosLealtadPAOut/";

declare function xf:consultaPuntosLealtadPAOut($legalId as xs:string,
    $customerName as xs:string,
    $availablePoints as xs:string,
    $cashEquivalent as xs:string?,
    $cashCurrency as xs:string?,
    $isCashEquivalent as xs:string?)
    as element(ns0:consultaPuntosLealtadResponse) {
        <ns0:consultaPuntosLealtadResponse>
            <LEGAL_ID>{ $legalId }</LEGAL_ID>
            <CUSTOMER_NAME>{ $customerName }</CUSTOMER_NAME>
            {
            	if($availablePoints != "") then (
            		<BALANCE>{floor(xs:decimal($availablePoints))}</BALANCE>
            	)else()	
            }
            {
            	if(string($isCashEquivalent) != "NO") then (
	                if(string($cashEquivalent) != "") then (
	                    <CASH_EQUIVALENT>{ fn-bea:format-number(xs:decimal($cashEquivalent),'###0.00') }</CASH_EQUIVALENT>
	                )else(
	            		<CASH_EQUIVALENT>0</CASH_EQUIVALENT>
            	)
            )else()
            }
            {
            	if(string($isCashEquivalent) != "NO") then (
	            	if($cashCurrency != "") then (
	            		<CASH_CURRENCY>{ $cashCurrency }</CASH_CURRENCY>
	            	) else ()
	            )else()
            }
        </ns0:consultaPuntosLealtadResponse>
};

declare variable $legalId as xs:string external;
declare variable $customerName as xs:string external;
declare variable $availablePoints as xs:string external;
declare variable $cashEquivalent as xs:string? external;
declare variable $cashCurrency as xs:string? external;
declare variable $isCashEquivalent as xs:string? external;

xf:consultaPuntosLealtadPAOut($legalId,
    $customerName,
    $availablePoints,
    $cashEquivalent,
    $cashCurrency,
    $isCashEquivalent)