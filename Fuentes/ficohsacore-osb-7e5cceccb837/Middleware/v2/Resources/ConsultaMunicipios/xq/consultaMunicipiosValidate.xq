(:: pragma bea:global-element-parameter parameter="$consultaMunicipios" element="ns0:consultaMunicipios" location="../../../../Business_Resources/direcciones/ConsultaMunicipios/consultaMunicipiosTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMunicipios/xq/consultaMunicipiosValidate/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaMunicipiosTypes";


declare function xf:ValidaCampos($consultaMunicipios as element(ns0:consultaMunicipios))     
{				
	let $campos as xs:string* := ("COUNTRY_CODE", "DEPT_CODE")	
	for $item at $index in $campos			
	return  					
		if (fn:string($consultaMunicipios/*[local-name()=$item]/text()) ne "") then ( ) else (fn:concat(fn:string($item)))  
};


declare function xf:consultaMunicipiosValidate($consultaMunicipios as element(ns0:consultaMunicipios))
    as xs:string {
    let $message := fn:string-join(xf:ValidaCampos($consultaMunicipios),",")
   	return
	        if (fn:string($message) ne "") 
        	then (fn:concat("REQUIRED FIELDS NOT SUPPLIED: ",$message)) 
        	else ("")      
};

declare variable $consultaMunicipios as element(ns0:consultaMunicipios) external;

xf:consultaMunicipiosValidate($consultaMunicipios)