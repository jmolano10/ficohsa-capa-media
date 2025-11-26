(:: pragma bea:global-element-parameter parameter="$consultaRemesas" element="ns0:consultaRemesas" location="consultaRemesasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesasTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/remesas/ConsultaRemesas/consultaRemesasValidate/";

declare function xf:consultaRemesasValidate($consultaRemesas as element(ns0:consultaRemesas))
    as xs:string {
        if (fn:string($consultaRemesas/REMITTANCE_ID/text()) = "" and 
        	fn:string($consultaRemesas/REMITTER_NAME/text()) = "" and 
        	fn:string($consultaRemesas/BENEFICIARY_NAME/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        	
        ) else if ( (fn:string($consultaRemesas/REMITTANCE_ID/text()) != "" and 
        				(fn:string($consultaRemesas/REMITTER_NAME/text()) != "" or
        				 fn:string($consultaRemesas/BENEFICIARY_NAME/text()) != "")) or
        				 
        			(fn:string($consultaRemesas/REMITTER_NAME/text()) != "" and 
        				(fn:string($consultaRemesas/REMITTANCE_ID/text()) != "" or
        				 fn:string($consultaRemesas/BENEFICIARY_NAME/text()) = "")) or
        				 
        			(fn:string($consultaRemesas/BENEFICIARY_NAME/text()) != "" and 
        				(fn:string($consultaRemesas/REMITTANCE_ID/text()) != "" or
        				 fn:string($consultaRemesas/REMITTER_NAME/text()) = ""))
        ) then (
        	"QUERY AVAILABLE ONLY BY REMITTANCE_ID OR BY REMITTER_NAME AND BENEFICIARY_NAME"
        ) else (
        	""
        )
};

declare variable $consultaRemesas as element(ns0:consultaRemesas) external;

xf:consultaRemesasValidate($consultaRemesas)