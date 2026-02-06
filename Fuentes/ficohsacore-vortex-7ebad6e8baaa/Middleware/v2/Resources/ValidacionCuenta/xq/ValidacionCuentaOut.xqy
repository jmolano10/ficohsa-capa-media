xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:validacionCuentaResponse" location="../../../../Business_Resources/validacionCuenta/ValidacionCuenta/validacionCuentaType.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/validacionCuenta/ValidacionCuentaOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validacionCuentaType";

declare function xf:ValidacionCuentaOut($accountFound as xs:string,
    $accountCurrencyFound as xs:string,
    $accountPostingRestrictFound as xs:string,
    $accountNameFound as xs:string,
    $accountCancelled as xs:string,
    $accountInactiveMarkerFound as xs:string)
    as element(ns0:validacionCuentaResponse) {
        <ns0:validacionCuentaResponse>
            <ACCOUNT_NUMBER>{ $accountFound }</ACCOUNT_NUMBER>
            <ACCOUNT_NAME>{ $accountNameFound }</ACCOUNT_NAME>
            {
            	if($accountCurrencyFound != 'false') then(
            		<CURRENCY>{ $accountCurrencyFound }</CURRENCY>
            	)
            	else ()            	
            }
            {
            	if($accountCancelled = 'true') then(
            		<ACCOUNT_STATUS>CANCELLED</ACCOUNT_STATUS>
            	)else if($accountPostingRestrictFound = '') then (
            		
            		if($accountInactiveMarkerFound = '') then(
            			<ACCOUNT_STATUS>ACTIVE</ACCOUNT_STATUS>
            		)
            		else(
            			<ACCOUNT_STATUS>INACTIVE</ACCOUNT_STATUS>
            		)
            		
            		)
            	else(
            		<ACCOUNT_STATUS>{ fn:concat('BLOCKED ',$accountPostingRestrictFound) }</ACCOUNT_STATUS>
            	)
            }
            
        </ns0:validacionCuentaResponse>
};

declare variable $accountFound as xs:string external;
declare variable $accountCurrencyFound as xs:string external;
declare variable $accountPostingRestrictFound as xs:string external;
declare variable $accountNameFound as xs:string external;
declare variable $accountCancelled as xs:string external;
declare variable $accountInactiveMarkerFound as xs:string external;

xf:ValidacionCuentaOut($accountFound,
    $accountCurrencyFound,
    $accountPostingRestrictFound,
    $accountNameFound,
    $accountCancelled,
    $accountInactiveMarkerFound)