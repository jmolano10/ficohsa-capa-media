(:: pragma bea:global-element-parameter parameter="$pagoRemesaCreditoCuenta" element="ns0:pagoRemesaCreditoCuenta" location="pagoRemesaCreditoCuentaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesaCreditoCuentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/remesas/PagoRemesaCreditoCuenta/pagoRemesaCreditoCuentaValidate/";


declare function xf:ValidaCampos($pagoRemesaCreditoCuenta as element(ns0:pagoRemesaCreditoCuenta))     
{				
	let $campos as xs:string* := ("REMITTANCE_ID", "REMITTANCE_DATE", "CURRENCY", "ACCOUNT_NUMBER", "AMOUNT", "REMITTER_NAME", "REMITTER_ADDRESS", "BENEFICIARY_NAME", "BENEF_PHONE_NUMBER", "EXCHANGE_RATE", "COUNTRY_OF_ORIGIN", "STATE_OF_ORIGIN", "CITY_OF_ORIGIN","REF_CURRENCY","REF_EXCHANGE_RATE","REF_AMOUNT")	
	for $item at $index in $campos			
	return  					
		if (fn:string($pagoRemesaCreditoCuenta/*[local-name()=$item]/text()) ne "") then ( ) else (fn:concat(fn:string($item)))  
};


declare function xf:pagoRemesaCreditoCuentaValidate($pagoRemesaCreditoCuenta as element(ns0:pagoRemesaCreditoCuenta)) as xs:string {	        	 
	let $message := fn:string-join(xf:ValidaCampos($pagoRemesaCreditoCuenta),",")
   	return
	        if (fn:string($message) ne "") 
        	then (fn:concat("REQUIRED FIELDS NOT SUPPLIED: ",$message)) 
        	else ("")            	    
  	   
};

declare variable $pagoRemesaCreditoCuenta as element(ns0:pagoRemesaCreditoCuenta) external;


xf:pagoRemesaCreditoCuentaValidate($pagoRemesaCreditoCuenta)     

(: xf:ValidaCampos2($pagoRemesaCreditoCuenta)   :)