xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaEstadoCheque1" element="ns0:consultaEstadoCheque" location="consultaEstadoChequeTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/confirmaCheque/consultaEstadoCheque/consultaEstadoChequeValidate/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoChequeTypes";

declare function xf:consultaEstadoChequeValidate($consultaEstadoCheque1 as element(ns0:consultaEstadoCheque))
    as xs:string {
        
    		if (fn:string($consultaEstadoCheque1/DEBIT_ACCOUNT/text()) = "" or 
	        	fn:string($consultaEstadoCheque1/CHEQUE_NUMBER/text()) = "" ) then (
	        	"REQUIRED FIELDS NOT SUPPLIED"
	        	
	        )  else (
	        	""
	        	
	        )
    	
};

declare variable $consultaEstadoCheque1 as element(ns0:consultaEstadoCheque) external;

xf:consultaEstadoChequeValidate($consultaEstadoCheque1)