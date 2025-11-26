xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaReciboRecaudo" element="ns0:consultaReciboRecaudo" location="../../xsds/ConsultaReciboRecaudo/ConsultaReciboRecaudo.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaReciboRecaudo/ConsultaReciboRecaudoValidate/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaReciboRecaudoTypes";

declare function xf:ConsultaReciboRecaudoValidate($consultaReciboRecaudo as element(ns0:consultaReciboRecaudo))
    as xs:string {
        if (fn:string($consultaReciboRecaudo/TRANSACTION_ID/text()) = "" and fn:string($consultaReciboRecaudo/SERVICE_ID/text()) = "" and 
        	fn:string($consultaReciboRecaudo/PAYMENT_CODE/text()) = "" and 
        	fn:string($consultaReciboRecaudo/TRANSACTION_DATE/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        	
        ) else if (fn:string($consultaReciboRecaudo/TRANSACTION_ID/text()) != "" and
        			(fn:string($consultaReciboRecaudo/SERVICE_ID/text()) != "" or 
        			 fn:string($consultaReciboRecaudo/PAYMENT_CODE/text()) != "" or 
        			 fn:string($consultaReciboRecaudo/TRANSACTION_DATE/text()) != "")) then (
        	"ONLY TRANSACTION_ID FIELD MUST BE COMPLETED"
        	
        ) else if (fn:string($consultaReciboRecaudo/TRANSACTION_ID/text()) = "" and
        			(fn:string($consultaReciboRecaudo/SERVICE_ID/text()) = "" or 
        			 fn:string($consultaReciboRecaudo/PAYMENT_CODE/text()) = "" or 
        			 fn:string($consultaReciboRecaudo/TRANSACTION_DATE/text()) = "")) then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        	        	
        ) else (
        	""
        )
};

declare variable $consultaReciboRecaudo as element(ns0:consultaReciboRecaudo) external;

xf:ConsultaReciboRecaudoValidate($consultaReciboRecaudo)