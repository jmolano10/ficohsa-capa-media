xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$epOriginacionResponse" element="ns0:epOriginacionResponse" location="../../../BusinessServices/BLAZE/wsdl/originacionesGT.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:evaluaCreditoClienteResponse" location="../xsd/evaluaCreditoClienteTypes.xsd" ::)

declare namespace ns0 = "http://webservices.alcance.com.hn/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EvaluaCreditoCliente/xq/evaluaCreditoClienteOut/";



declare function xf:evaluaCreditoClienteOut($epOriginacionResponse as element(ns0:epOriginacionResponse))
    as element(ns1:evaluaCreditoClienteResponse) {
        <ns1:evaluaCreditoClienteResponse>
        	{	
        		
        	   let $temp := fn:replace(data($epOriginacionResponse/return), "\|", ",.,")	
	           let $cadena := fn:replace(data($temp), "&amp;", "@")
	           let $cadenaNombres := substring-before($cadena, '@')
	           let $cadenaValores := substring-after($cadena, '@')
	           let $listValores := fn:tokenize($cadenaValores,",.,")
	           let $listNombres := fn:tokenize($cadenaNombres,",.,")
	          
	           for $i in 0 to count($listNombres)
	           return 
	           (	
	           		if ($listNombres[$i] = "CUSTOMER_ID") then (
		            	<CUSTOMER_ID>{ $listValores[$i] }</CUSTOMER_ID>
		            ) else if ($listNombres[$i] = "REPORTED") then (
		            	<REPORTED>{ $listValores[$i] }</REPORTED>
		            ) else if ($listNombres[$i] = "HIT") then (
		            	<HIT>{ $listValores[$i] }</HIT>
		            ) else if ($listNombres[$i] = "HIT_SINREF") then (
		            	<HIT_SINREF>{ $listValores[$i] }</HIT_SINREF>
		            ) else if ($listNombres[$i] = "HIT_SCORE") then (
		            	<HIT_SCORE>{ $listValores[$i] }</HIT_SCORE>
		            ) else if ($listNombres[$i] = "NO_HIT_SCORE") then (
		            	<NO_HIT_SCORE>{ $listValores[$i] }</NO_HIT_SCORE>
		            ) else if ($listNombres[$i] = "VALID_REFERENCE_TYPE") then (
		            	<VALID_REFERENCE_TYPE>{ $listValores[$i] }</VALID_REFERENCE_TYPE>
		            ) else if ($listNombres[$i] = "ENTITY_REFERENCE") then (
		            	<ENTITY_REFERENCE>{ $listValores[$i] }</ENTITY_REFERENCE>
		            ) else if ($listNombres[$i] = "RISK_LEVEL") then (
		            	<RISK_LEVEL>{ $listValores[$i] }</RISK_LEVEL>
		            ) else if ($listNombres[$i] = "REFERENCE_VALID_TIME") then (
		            	<REFERENCE_VALID_TIME>{ $listValores[$i] }</REFERENCE_VALID_TIME>
		            ) else if ($listNombres[$i] = "MAX_AMOUNT_BANK") then (
		            	<MAX_AMOUNT_BANK>{ $listValores[$i] }</MAX_AMOUNT_BANK>
		            ) else if ($listNombres[$i] = "MAX_AMOUNT_COMMERCE") then (
		            	<MAX_AMOUNT_COMMERCE>{ $listValores[$i] }</MAX_AMOUNT_COMMERCE>
		            ) else if ($listNombres[$i] = "LIMIT_MAX_CARDS") then (
		            	<LIMIT_MAX_CARDS>{ $listValores[$i] }</LIMIT_MAX_CARDS>
		            ) else if ($listNombres[$i] = "ASSIGNED_LIMIT") then (
		            	<ASSIGNED_LIMIT>{ $listValores[$i] }</ASSIGNED_LIMIT>
		            ) else if ($listNombres[$i] = "SUGGESTED_PRODUCT") then (
		            	<SUGGESTED_PRODUCT>{ $listValores[$i] }</SUGGESTED_PRODUCT>
		            ) else if ($listNombres[$i] = "RESULT") then (
		            	<RESULT>{ $listValores[$i] }</RESULT>
		            ) else if ($listNombres[$i] = "RATE_LOAN") then (
		            	<RATE_LOAN>{ $listValores[$i] }</RATE_LOAN>
		            ) else if ($listNombres[$i] = "AMOUNT_LOAN") then (
		            	<AMOUNT_LOAN>{ $listValores[$i] }</AMOUNT_LOAN>
		            ) else ()
		            
	           )
	        }
            
        </ns1:evaluaCreditoClienteResponse>
};

declare variable $epOriginacionResponse as element(ns0:epOriginacionResponse) external;

xf:evaluaCreditoClienteOut($epOriginacionResponse)