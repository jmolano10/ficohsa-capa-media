(:: pragma bea:global-element-parameter parameter="$consultaChequeras1" element="ns0:consultaChequeras" location="consultaChequerasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaChequerasTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/impresionChequeras/ConsultaChequeras/consultaChequerasValidate/";

declare function xf:consultaChequerasValidate($consultaChequeras1 as element(ns0:consultaChequeras))
    as xs:string {
    
        if (fn:string($consultaChequeras1/CHEQUEBOOK_RANGE/text()) = "LAST") then (
    		
	    		if (fn:string($consultaChequeras1/ACCOUNT_NUMBER/text()) = "") then (	        	
		        	"REQUIRED FIELDS NOT SUPPLIED"
		        		
		        ) else (
		        	""
		        	
		        )
    	
    	)
    	else(
		        if (fn:string($consultaChequeras1/ACCOUNT_NUMBER/text()) = "" and 
		        	fn:string($consultaChequeras1/CHEQUEBOOK_STATUS/text()) = "" and 
		        	fn:string($consultaChequeras1/CHQBK_PRINT_STATUS/text()) = "" and 
		        	fn:string($consultaChequeras1/CHEQUEBOOK_RANGE/text()) = "") then (
		        	"REQUIRED FIELDS NOT SUPPLIED"
		        	
		        ) else (
		        	""
		        	
		        )
       )


};

declare variable $consultaChequeras1 as element(ns0:consultaChequeras) external;

xf:consultaChequerasValidate($consultaChequeras1)