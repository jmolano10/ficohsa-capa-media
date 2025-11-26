(:: pragma bea:global-element-parameter parameter="$registrarRTE" element="ns0:registrarRTE" location="../../xsds/RegistrarRTE/RegistrarRTE.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/registrarRTETypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RegistrarRTE/RegistrarRTEValidate/";

declare function xf:RegistrarRTEValidate($registrarRTE as element(ns0:registrarRTE))
    as xs:string {
        if (fn:string($registrarRTE/TELLER_TRANS_ID/text()) = "" or 
        	fn:string($registrarRTE/ORIGINAND_TARGET/text()) = "" or 
        	fn:string($registrarRTE/OWNER_TXN/text()) = "" or 
        	fn:string($registrarRTE/ID_NUMBER/text()) = "" or 
        	fn:string($registrarRTE/BEHALF_ID_NUMBER/text()) = "" or 
        	fn:string($registrarRTE/BEN_ID_NUMBER/text()) = "" or
        	fn:string($registrarRTE/RELATION_WITH_BENEFICIARY/text()) = "" or
        	fn:string($registrarRTE/BEHALF_REL_WITH_BEN/text()) = "" or
        	fn:string($registrarRTE/OPERATION_TYPE/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        	
		) else if (not(fn:string($registrarRTE/OPERATION_TYPE/text()) = ("1","2"))) then (
			"OPERATION_TYPE NOT SUPPORTED"
				
        ) else (
        	""
        )
};

declare variable $registrarRTE as element(ns0:registrarRTE) external;

xf:RegistrarRTEValidate($registrarRTE)