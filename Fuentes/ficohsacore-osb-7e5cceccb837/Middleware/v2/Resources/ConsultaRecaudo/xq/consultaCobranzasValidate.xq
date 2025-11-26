xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaRecaudo" element="ns0:consultaRecaudo" location="../../../../Business_Resources/recaudos/consultaRecaudo/consultaRecaudoTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCobranzas/xq/consultaCobranzasValidate/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";

declare function xf:consultaCobranzasValidate($consultaRecaudo as element(ns0:consultaRecaudo))
    as xs:string {
        if (fn:string($consultaRecaudo/CONTRACT_ID/text()) = "" or 
        	fn:string($consultaRecaudo/DEBTOR_CODE/text()) = "" or 
        	fn:string($consultaRecaudo/CURRENCY/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        ) else(
        	""
        )
};

declare variable $consultaRecaudo as element(ns0:consultaRecaudo) external;

xf:consultaCobranzasValidate($consultaRecaudo)