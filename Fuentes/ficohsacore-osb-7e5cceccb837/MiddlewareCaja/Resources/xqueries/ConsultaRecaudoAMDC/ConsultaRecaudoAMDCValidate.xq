(:: pragma bea:global-element-parameter parameter="$consultaRecaudoAMDC" element="ns0:consultaRecaudoAMDC" location="../../xsds/ConsultaRecaudoAMDC/ConsultaRecaudoAMDC.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoAMDCTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudoAMDC/ConsultaRecaudoAMDCValidate/";

declare function xf:ConsultaRecaudoAMDCValidate($consultaRecaudoAMDC as element(ns0:consultaRecaudoAMDC))
    as xs:string {
        if (fn:string($consultaRecaudoAMDC/CONTRACT_ID/text()) = "" or 
        	fn:string($consultaRecaudoAMDC/DEBTOR_CODE/text()) = "" or 
        	fn:string($consultaRecaudoAMDC/YEAR_TO_PAY/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        
         ) else if ( fn:string($consultaRecaudoAMDC/MONTHS_TO_PAY/text()) != "" and fn:string(fn-bea:fail-over(xs:int($consultaRecaudoAMDC/MONTHS_TO_PAY),"NaN")) = "NaN" ) then (
        	"FIELD MONTHS_TO_PAY MUST BE NUMERIC VALUE"

        ) else if ( fn:string($consultaRecaudoAMDC/MONTHS_TO_PAY/text()) != "" and xs:int($consultaRecaudoAMDC/MONTHS_TO_PAY) <= 0 ) then (
        	"FIELD MONTHS_TO_PAY MUST BE GREATER THAN 0"
        
        ) else (
        	""
        )
};

declare variable $consultaRecaudoAMDC as element(ns0:consultaRecaudoAMDC) external;

xf:ConsultaRecaudoAMDCValidate($consultaRecaudoAMDC)