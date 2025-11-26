(:: pragma bea:global-element-parameter parameter="$bloqueoFondosCuenta" element="ns0:bloqueoFondosCuenta" location="bloqueoFondosCuentaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/bloqueoFondosCuentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/bloqueoPasivos/BloqueoFondosCuenta/bloqueoFondosCuentaValidate/";

declare function xf:bloqueoFondosCuentaValidate($bloqueoFondosCuenta as element(ns0:bloqueoFondosCuenta))
    as xs:string {
        if (fn:string($bloqueoFondosCuenta/ACCOUNT_NUMBER/text()) = "" or 
        	fn:string($bloqueoFondosCuenta/END_DATE/text()) = "" or 
        	fn:string($bloqueoFondosCuenta/BLOCK_AMOUNT/text()) = "" or 
        	fn:string($bloqueoFondosCuenta/DESCRIPTION/text()) = "") then(
        	"REQUIRED FIELDS NOT SUPPLIED"
        ) else(
        	""
        )
};

declare variable $bloqueoFondosCuenta as element(ns0:bloqueoFondosCuenta) external;

xf:bloqueoFondosCuentaValidate($bloqueoFondosCuenta)