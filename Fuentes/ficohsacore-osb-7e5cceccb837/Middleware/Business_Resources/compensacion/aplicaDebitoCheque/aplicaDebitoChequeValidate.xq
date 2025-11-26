(:: pragma bea:global-element-parameter parameter="$aplicaDebitoCheque" element="ns0:aplicaDebitoCheque" location="aplicaDebitoChequeTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/aplicaDebitoChequeTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/compensacion/aplicaDebitoCheque/aplicaDebitoChequeValidate/";

declare function xf:aplicaDebitoChequeValidate($aplicaDebitoCheque as element(ns0:aplicaDebitoCheque))
    as xs:string {
        if (fn:string($aplicaDebitoCheque/SERVICE_INSTRUCTION/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        ) else (
        	""
        )
};

declare variable $aplicaDebitoCheque as element(ns0:aplicaDebitoCheque) external;

xf:aplicaDebitoChequeValidate($aplicaDebitoCheque)