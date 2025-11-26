(:: pragma bea:global-element-parameter parameter="$consultaVentanilla" element="ns0:consultaVentanilla" location="consultaVentanillaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaVentanillaTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/consultaVentanilla/consultaVentanillaValidate/";

declare function xf:consultaVentanillaValidate($consultaVentanilla as element(ns0:consultaVentanilla))
    as xs:string {
        if (fn:string($consultaVentanilla/TILL_ID/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        
        ) else if (fn:string(number($consultaVentanilla/TILL_ID/text())) = "NaN" or
        		   not(number($consultaVentanilla/TILL_ID/text()) >= 0 and number($consultaVentanilla/TILL_ID/text()) <= 9999)  ) then (
			"TILL_ID MUST BE BETWEEN 0 AND 9999"
			
        ) else if (not(string-length($consultaVentanilla/TILL_ID/text()) >= 1 and string-length($consultaVentanilla/TILL_ID/text()) <= 4)) then (
			"TILL_ID LENGTH MUST BE BETWEEN 1 AND 4"
			
        ) else (
        	""
        )
};

declare variable $consultaVentanilla as element(ns0:consultaVentanilla) external;

xf:consultaVentanillaValidate($consultaVentanilla)