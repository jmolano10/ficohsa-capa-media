<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>(:: pragma bea:global-element-parameter parameter="$consultaDetalleCompletoTransaccion" element="ns0:consultaDetalleCompletoTransaccion" location="consultaDetalleCompletoTransaccionTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleCompletoTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaTransacciones/ConsultaDetalleCompletoTransaccion/consultaDetalleCompletoTransaccionValidate/";

declare function xf:consultaDetalleCompletoTransaccionValidate($consultaDetalleCompletoTransaccion as element(ns0:consultaDetalleCompletoTransaccion))
    as xs:string {
        if (fn:string($consultaDetalleCompletoTransaccion/TRANSACTION_REFERENCE/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        ) else if (not(substring(fn:string($consultaDetalleCompletoTransaccion/TRANSACTION_REFERENCE/text()), 1, 2) = ("FT","TT"))) then (
        	"TRANSACTION_REFERENCE MUST BEGIN WITH FT OR TT"
        ) else(
        	""
        )
};

declare variable $consultaDetalleCompletoTransaccion as element(ns0:consultaDetalleCompletoTransaccion) external;

xf:consultaDetalleCompletoTransaccionValidate($consultaDetalleCompletoTransaccion)</con:xquery>
</con:xqueryEntry>