<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft" encoding "Cp1252";
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

xf:consultaDetalleTransaccionCombinadaValidate($consultaDetalleTransaccionCombinada1)</con:xquery>
    <con:dependency location="consultaDetalleTransaccionCombinadaTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/consultaTransacciones/ConsultaDetalleTransaccionCombinada/consultaDetalleTransaccionCombinadaTypes"/>
    </con:dependency>
</con:xqueryEntry>