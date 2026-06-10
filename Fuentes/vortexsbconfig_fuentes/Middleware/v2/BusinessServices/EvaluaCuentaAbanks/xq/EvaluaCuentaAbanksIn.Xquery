<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
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
    $counter)</con:xquery>
    <con:dependency location="../xsd/EvaluaCuentaAbanks.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/EvaluaCuentaAbanks/xsd/EvaluaCuentaAbanks"/>
    </con:dependency>
</con:xqueryEntry>