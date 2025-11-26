(:: pragma bea:global-element-parameter parameter="$actualizacionLibretaAhorro" element="ns0:actualizacionLibretaAhorro" location="../../xsds/ActualizacionLibretaAhorro/ActualizacionLibretaAhorro.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/actualizacionLibretaAhorroTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ActualizacionLibretaAhorro/ActualizacionLibretaAhorroValidate/";

declare function xf:ActualizacionLibretaAhorroValidate($actualizacionLibretaAhorro as element(ns0:actualizacionLibretaAhorro))
    as xs:string {
        if (fn:string($actualizacionLibretaAhorro/ACCOUNT_NUMBER/text()) = "" or 
        	fn:string($actualizacionLibretaAhorro/NEXT_PASSBOOK_LINE/text()) = "" or 
        	fn:string($actualizacionLibretaAhorro/PAGE_NUMBER/text()) = "") then (
        	"REQUIRED FILEDS NOT SUPPLIED"
        	
        ) else if(fn:string(number($actualizacionLibretaAhorro/NEXT_PASSBOOK_LINE)) = 'NaN') then (
        	"NEXT_PASSBOOK_LINE MUST BE A NUMERIC VALUE"
        
        ) else if(fn:string(number($actualizacionLibretaAhorro/PAGE_NUMBER)) = 'NaN') then (
        	"PAGE_NUMBER MUST BE A NUMERIC VALUE"
        
        ) else if(number($actualizacionLibretaAhorro/NEXT_PASSBOOK_LINE) > 20 or
        		  number($actualizacionLibretaAhorro/NEXT_PASSBOOK_LINE) < 1) then (
        	"NEXT_PASSBOOK_LINE MUST BE BETWEEN 1 AND 20"
        	
        ) else if(number($actualizacionLibretaAhorro/PAGE_NUMBER) < 1) then (
        	"PAGE_NUMBER MUST BE A POSITIVE NUMBER"
        	        	
        ) else (
        	""
        )
};

declare variable $actualizacionLibretaAhorro as element(ns0:actualizacionLibretaAhorro) external;

xf:ActualizacionLibretaAhorroValidate($actualizacionLibretaAhorro)