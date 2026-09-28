(:: pragma bea:global-element-parameter parameter="$evaluaCuentaAbanksTypeRequest1" element="ns0:EvaluaCuentaAbanksTypeRequest" location="../xsd/EvaluaCuentaAbanks.xsd" ::)

declare namespace ns0 = "EvaluaCuentaAbanks";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/validacionCuenta/ValidacionCuenta2.0/EvaluaCuentaAbanks/EvaluaCuentaAbanksIn/";

declare function xf:EvaluaCuentaAbanksIn($evaluaCuentaAbanksTypeRequest1 as element(ns0:EvaluaCuentaAbanksTypeRequest),
    $counter as xs:string)
    as xs:string {
    	
    	let $account := data($evaluaCuentaAbanksTypeRequest1/ns0:ACCOUNT_ID[1])                       
        return
        
        	    
    	if (xs:integer($counter) = 1) then (
    	$account
    	)
    	else if (xs:integer($counter) = 2) then (
    	fn:concat('0', $account)
    	)
    	else (
    	fn:concat('00', $account)
    	)
    	    	
};

declare variable $evaluaCuentaAbanksTypeRequest1 as element(ns0:EvaluaCuentaAbanksTypeRequest) external;
declare variable $counter as xs:string external;

xf:EvaluaCuentaAbanksIn($evaluaCuentaAbanksTypeRequest1,
    $counter)