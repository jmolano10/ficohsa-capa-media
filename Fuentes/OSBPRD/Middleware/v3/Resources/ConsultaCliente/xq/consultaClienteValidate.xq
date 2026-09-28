(:: pragma bea:global-element-parameter parameter="$consultaClienteRequest" element="ns0:consultaClienteRequest" location="../xsd/consultaClientesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaCliente/xq/consultaClienteValidate/";

declare function xf:consultaClienteValidate($consultaClienteRequest as element(ns0:consultaClienteRequest))
    as xs:string {
    	(: Campos requeridos :)
        if (fn:string($consultaClienteRequest/ns0:CUSTOMER_ID_TYPE/text()) = "" or 
        	fn:string($consultaClienteRequest/ns0:CUSTOMER_ID_VALUE/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        	
        (: Tipos permitidos:)
        ) else if (not(fn:string($consultaClienteRequest/ns0:CUSTOMER_ID_TYPE/text()) = ("ACCOUNT_NUMBER","CODE","CUSTOMER_ID","LEGAL_ID","DEBIT_CARD"))) then (
        	"INVALID CUSTOMER_ID_TYPE"
        	
        (: Tipos no implementados:)
        ) else if (fn:string($consultaClienteRequest/ns0:CUSTOMER_ID_TYPE/text()) = ("ACCOUNT_NUMBER")) then (
        	"CUSTOMER_ID_TYPE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"
        	        	
        ) else (
        	""
        )
};

declare variable $consultaClienteRequest as element(ns0:consultaClienteRequest) external;

xf:consultaClienteValidate($consultaClienteRequest)