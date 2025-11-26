(:: pragma bea:global-element-parameter parameter="$consultaLimitesCliente" element="ns0:consultaLimitesCliente" location="../Resources/consultaClientesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaLimitesCliente/consultaLimitesClienteValidate/";

declare function xf:consultaLimitesClienteValidate($consultaLimitesCliente as element(ns0:consultaLimitesCliente))
    as xs:string {
        if (fn:string($consultaLimitesCliente/CUSTOMER_ID/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        ) else (
        	""
        )
};

declare variable $consultaLimitesCliente as element(ns0:consultaLimitesCliente) external;

xf:consultaLimitesClienteValidate($consultaLimitesCliente)