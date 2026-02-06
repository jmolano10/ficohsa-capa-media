xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDetalleCompletoTransaccion" element="ns0:consultaDetalleCompletoTransaccion" location="consultaDetalleCompletoTransaccionTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleCompletoTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaTransacciones/ConsultaDetalleCompletoTransaccion/consultaDetalleCompletoTransaccionValidate/";

declare function xf:consultaDetalleCompletoTransaccionValidate($consultaDetalleCompletoTransaccion as element(ns0:consultaDetalleCompletoTransaccion))
    as xs:string {
    	let $txnReference := fn:string($consultaDetalleCompletoTransaccion/TRANSACTION_REFERENCE/text())
    	let $accountNumber := fn:string($consultaDetalleCompletoTransaccion/ACCOUNT_NUMBER/text())
    	return 
		if (substring($txnReference, 1, 2) = ("FT")) then (
        	"FT"
        ) else if (substring($txnReference, 1, 2) = ("TT")) then (
        	"TT"
        ) else if (substring($txnReference, 1, 2) = ("PF")) then (
        	"PD"
        ) else if (substring($txnReference, 1, 3) = ("TFS")) then (
        	"TFS"
        ) else if (fn:string(fn:number($txnReference)) != "Nan"
      				and $accountNumber != "") then (
        	"ABANKS"
        ) else (
        	"DEFAULT"
        )
};

declare variable $consultaDetalleCompletoTransaccion as element(ns0:consultaDetalleCompletoTransaccion) external;

xf:consultaDetalleCompletoTransaccionValidate($consultaDetalleCompletoTransaccion)