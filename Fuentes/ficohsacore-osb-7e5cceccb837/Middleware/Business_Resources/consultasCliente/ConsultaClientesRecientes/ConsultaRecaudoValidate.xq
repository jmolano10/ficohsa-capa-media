(:: pragma bea:global-element-parameter parameter="$consultaClientesRecientes" element="ns0:consultaClientesRecientes" location="../Resources/consultaClientesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/ConsultaClientesRecientes/ConsultaRecaudoValidate/";

declare function xf:ConsultaRecaudoValidate($consultaClientesRecientes as element(ns0:consultaClientesRecientes))
    as xs:string {
        if (fn:string($consultaClientesRecientes/FIRST_CUSTOMER_ID/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        	
        ) else (
        	""
        )
};

declare variable $consultaClientesRecientes as element(ns0:consultaClientesRecientes) external;

xf:ConsultaRecaudoValidate($consultaClientesRecientes)