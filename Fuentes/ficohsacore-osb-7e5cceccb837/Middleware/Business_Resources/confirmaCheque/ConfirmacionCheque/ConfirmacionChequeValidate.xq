(:: pragma bea:global-element-parameter parameter="$confirmacionCheque" element="ns0:confirmacionCheque" location="confirmacionChequeTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/confirmacionChequeTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/confirmaCheque/ConfirmacionCheque/ConfirmacionChequeValidate/";

declare function xf:ConfirmacionChequeValidate($confirmacionCheque as element(ns0:confirmacionCheque))
    as xs:string {
    
    	if (fn:string($confirmacionCheque/CONFIRMATION_TYPE/text()) = "22") then (
    		
    		if (fn:string($confirmacionCheque/DEBIT_ACCOUNT/text()) = "" or 
	        	fn:string($confirmacionCheque/CHEQUE_NUMBER/text()) = "" ) then (	        	
	        	"REQUIRED FIELDS NOT SUPPLIED"
	        		
	        ) else (
	        	""
	        	
	        )
    	
    	)
    	else(
	        if (fn:string($confirmacionCheque/DEBIT_ACCOUNT/text()) = "" or 
	        	fn:string($confirmacionCheque/CHEQUE_NUMBER/text()) = "" or 
	        	fn:string($confirmacionCheque/CONFIRMATION_TYPE/text()) = "" or 
	        	fn:string($confirmacionCheque/BENEFICIARY_NAME/text()) = "" or 
	        	fn:string($confirmacionCheque/AMOUNT/text()) = "") then (
	        	"REQUIRED FIELDS NOT SUPPLIED"
	        	
	        ) else if (not(fn:string($confirmacionCheque/CONFIRMATION_TYPE/text()) = ("20","21","22"))) then (
	        	"CONFIRMATION TYPE NOT SUPPORTED"
	        	
	        ) else (
	        	""
	        	
	        )
       )
};

declare variable $confirmacionCheque as element(ns0:confirmacionCheque) external;

xf:ConfirmacionChequeValidate($confirmacionCheque)