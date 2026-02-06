xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaDetalleTransaccionCombinada1" element="ns0:consultaDetalleTransaccionCombinada" location="consultaDetalleTransaccionCombinadaTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaTransacciones/ConsultaDetalleTransaccionCombinada/consultaDetalleTransaccionCombinadaValidate/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleTransaccionCombinadaTypes";

declare function xf:consultaDetalleTransaccionCombinadaValidate($consultaDetalleTransaccionCombinada1 as element(ns0:consultaDetalleTransaccionCombinada))
    as xs:string {
		if (fn:string($consultaDetalleTransaccionCombinada1/TRANSACTION_REFERENCE/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        ) else(
        	""
        )
};

declare variable $consultaDetalleTransaccionCombinada1 as element(ns0:consultaDetalleTransaccionCombinada) external;

xf:consultaDetalleTransaccionCombinadaValidate($consultaDetalleTransaccionCombinada1)