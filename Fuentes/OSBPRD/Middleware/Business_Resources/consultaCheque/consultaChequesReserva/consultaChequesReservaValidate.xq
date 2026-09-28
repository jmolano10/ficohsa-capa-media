(:: pragma bea:global-element-parameter parameter="$consultaChequesReserva" element="ns0:consultaChequesReserva" location="consultaChequesReservaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaChequesReservaTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaCheque/consultaChequesReserva/consultaChequesReservaValidate/";

declare function xf:consultaChequesReservaValidate($consultaChequesReserva as element(ns0:consultaChequesReserva))
    as xs:string {
        if (fn:string($consultaChequesReserva/ACCOUNT_NUMBER/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        	
        ) else (
        	""
        )
};

declare variable $consultaChequesReserva as element(ns0:consultaChequesReserva) external;

xf:consultaChequesReservaValidate($consultaChequesReserva)