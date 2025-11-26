xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$evaluaCuentaAbanksTypeRequest1" element="ns0:EvaluaCuentaAbanksTypeRequest" location="../xsd/EvaluaCuentaAbanks.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/validacionCuenta/ValidacionCuenta2.0/EvaluaCuentaAbanks/FormatearCuentaIn/";
declare namespace ns0 = "EvaluaCuentaAbanks";

declare function xf:FormatearCuentaIn($evaluaCuentaAbanksTypeRequest1 as element(ns0:EvaluaCuentaAbanksTypeRequest),
    $counter as xs:string)
    as xs:string {
        		let $account := data($evaluaCuentaAbanksTypeRequest1/ns0:ACCOUNT_ID)
                return
                
                if (xs:integer($counter) = 1) then (		    	
		    	<ns0:ACCOUNT_ID>{ $account }</ns0:ACCOUNT_ID>
		    	)
		    	else if (xs:integer($counter) = 2) then (
		    	
		    	<ns0:ACCOUNT_ID>{ fn:concat('0', $account) }</ns0:ACCOUNT_ID>
		    	)
		    	else (
		    	
		    	<ns0:ACCOUNT_ID>{ fn:concat('00', $account) }</ns0:ACCOUNT_ID>
		    	)
};

declare variable $evaluaCuentaAbanksTypeRequest1 as element(ns0:EvaluaCuentaAbanksTypeRequest) external;
declare variable $counter as xs:string external;

xf:FormatearCuentaIn($evaluaCuentaAbanksTypeRequest1,
    $counter)