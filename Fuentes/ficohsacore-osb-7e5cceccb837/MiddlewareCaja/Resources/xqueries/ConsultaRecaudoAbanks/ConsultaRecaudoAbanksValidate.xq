(:: pragma bea:global-element-parameter parameter="$consultaRecaudoAbanks" element="ns0:consultaRecaudoAbanks" location="../../xsds/ConsultaRecaudoAbanks/ConsultaRecaudoAbanks.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoAbanksTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudoAbanks/ConsultaRecaudoAbanksValidate/";

declare function xf:ConsultaRecaudoAbanksValidate($consultaRecaudoAbanks as element(ns0:consultaRecaudoAbanks))
    as xs:string {
        if (fn:string($consultaRecaudoAbanks/CONTRACT_ID/text()) = "" or 
        	fn:string($consultaRecaudoAbanks/DEBTOR_CODE/text()) = "" or 
        	fn:string($consultaRecaudoAbanks/CURRENCY/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        ) else(
        	""
        )
};

declare variable $consultaRecaudoAbanks as element(ns0:consultaRecaudoAbanks) external;

xf:ConsultaRecaudoAbanksValidate($consultaRecaudoAbanks)