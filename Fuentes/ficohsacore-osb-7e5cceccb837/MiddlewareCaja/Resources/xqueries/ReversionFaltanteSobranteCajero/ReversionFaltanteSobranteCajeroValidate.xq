(:: pragma bea:global-element-parameter parameter="$reversionFaltanteSobranteCajero" element="ns0:reversionFaltanteSobranteCajero" location="../../xsds/ReversionFaltanteSobranteCajero/ReversionFaltanteSobranteCajero.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/reversionFaltanteSobranteCajeroTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ReversionFaltanteSobranteCajero/ReversionFaltanteSobranteCajeroValidate/";

declare function xf:ReversionFaltanteSobranteCajeroValidate($reversionFaltanteSobranteCajero as element(ns0:reversionFaltanteSobranteCajero))
    as xs:string {
        if (fn:string($reversionFaltanteSobranteCajero/REVERSAL_TYPE/text()) = "" or 
        	fn:string($reversionFaltanteSobranteCajero/TELLER_ID/text()) = "" or 
        	fn:string($reversionFaltanteSobranteCajero/REVERSAL_AMOUNT/text()) = "" or 
        	fn:string($reversionFaltanteSobranteCajero/REVERSAL_CURRENCY/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        	
        ) elseif ( not(fn:string($reversionFaltanteSobranteCajero/REVERSAL_TYPE/text()) = ('OVERAGE','SHORTAGE')) ) then (
        	"REVERSAL_TYPE NOT SUPPORTED"
        
        ) else (
        	""
        )
};

declare variable $reversionFaltanteSobranteCajero as element(ns0:reversionFaltanteSobranteCajero) external;

xf:ReversionFaltanteSobranteCajeroValidate($reversionFaltanteSobranteCajero)