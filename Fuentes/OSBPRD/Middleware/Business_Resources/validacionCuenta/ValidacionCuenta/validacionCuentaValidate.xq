(:: pragma bea:global-element-parameter parameter="$validacionCuenta" element="ns0:validacionCuenta" location="validacionCuentaType.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validacionCuentaType";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/validacionCuenta/ValidacionCuenta/validacionCuentaValidate/";

declare function xf:validacionCuentaValidate($validacionCuenta as element(ns0:validacionCuenta))
    as xs:string {
        if (fn:string($validacionCuenta/ACCOUNT_NUMBER/text()) = "" or 
        	fn:string($validacionCuenta/CHECK_CANCELLED_YES_NO/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        
        ) else if (not(fn:string($validacionCuenta/CHECK_CANCELLED_YES_NO/text()) = ("YES","NO"))) then (
        	"CHECK_CANCELLED_YES_NO NOT SUPPORTED"
        	
        ) else (
        	""
        )
};

declare variable $validacionCuenta as element(ns0:validacionCuenta) external;

xf:validacionCuentaValidate($validacionCuenta)