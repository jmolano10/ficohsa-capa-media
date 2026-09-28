(:: pragma bea:global-element-parameter parameter="$consultaRecaudo" element="ns0:consultaRecaudo" location="consultaRecaudoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/recaudos/consultaRecaudo/consultaRecaudoValidate/";

declare function xf:consultaRecaudoValidate($consultaRecaudo as element(ns0:consultaRecaudo))
    as xs:string {
        if (fn:string($consultaRecaudo/CONTRACT_ID/text()) = "" or 
        	fn:string($consultaRecaudo/DEBTOR_CODE/text()) = "" or 
        	fn:string($consultaRecaudo/CURRENCY/text()) = "") then(
        	"REQUIRED FIELDS NOT SUPPLIED"
        	
        ) else if (not(fn:string($consultaRecaudo/BILL_RETURN_TYPE/text()) = ("ONE","ALL",""))) then (
        	"BILL_RETURN_TYPE NOT SUPPORTED"
        
        ) else if (not(fn:string($consultaRecaudo/EXTENDED_COLLECTION_YES_NO/text()) = ("YES","NO",""))) then (
        	"EXTENDED_COLLECTION_YES_NO NOT SUPPORTED"
        
        ) else(
        	""
        )
};

declare variable $consultaRecaudo as element(ns0:consultaRecaudo) external;

xf:consultaRecaudoValidate($consultaRecaudo)