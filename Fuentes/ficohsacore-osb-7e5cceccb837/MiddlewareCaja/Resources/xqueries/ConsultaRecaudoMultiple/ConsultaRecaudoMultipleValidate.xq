xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaRecaudoMultiple" element="ns0:consultaRecaudoMultiple" location="../../xsds/ConsultaRecaudoMultiple/ConsultaRecaudoMultiple.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudoMultiple/ConsultaRecaudoMultipleValidate/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoMultipleTypes";

declare function xf:ConsultaRecaudoMultipleValidate($consultaRecaudoMultiple as element(ns0:consultaRecaudoMultiple))
    as xs:string {
        if (fn:string($consultaRecaudoMultiple/CONTRACT_ID/text()) = "" or 
        	fn:string($consultaRecaudoMultiple/DEBTOR_CODE/text()) = "" or 
        	fn:string($consultaRecaudoMultiple/CURRENCY/text()) = "") then(
        	"REQUIRED FIELDS NOT SUPPLIED"
        	
        ) else if (not(fn:string($consultaRecaudoMultiple/EXTENDED_COLLECTION_YES_NO/text()) = ("YES","NO",""))) then (
        	"EXTENDED_COLLECTION_YES_NO NOT SUPPORTED"
        
        ) else if ( fn:string($consultaRecaudoMultiple/NUMBER_OF_BILLS/text()) != "" and fn:string($consultaRecaudoMultiple/BILL_NUMBER/text()) != "" ) then (
        	"FIELDS NUMBER_OF_BILLS AND BILL_NUMBER ARE MUTUALLY EXCLUSIVE"
        
        ) else if ( fn:string($consultaRecaudoMultiple/NUMBER_OF_BILLS/text()) != "" and fn:string(fn-bea:fail-over(xs:int($consultaRecaudoMultiple/NUMBER_OF_BILLS),"NaN")) = "NaN" ) then (
        	"FIELD NUMBER_OF_BILLS MUST BE NUMERIC VALUE"

        ) else if ( fn:string($consultaRecaudoMultiple/NUMBER_OF_BILLS/text()) != "" and xs:int($consultaRecaudoMultiple/NUMBER_OF_BILLS) <= 0 ) then (
        	"FIELD NUMBER_OF_BILLS MUST BE GREATER THAN 0"
        	        	
        ) else(
        	""
        )
};

declare variable $consultaRecaudoMultiple as element(ns0:consultaRecaudoMultiple) external;

xf:ConsultaRecaudoMultipleValidate($consultaRecaudoMultiple)