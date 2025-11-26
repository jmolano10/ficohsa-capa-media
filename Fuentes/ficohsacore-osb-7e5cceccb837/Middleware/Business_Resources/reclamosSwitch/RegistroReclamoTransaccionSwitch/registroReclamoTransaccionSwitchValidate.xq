(:: pragma bea:global-element-parameter parameter="$registroReclamoTransaccionSwitch" element="ns0:registroReclamoTransaccionSwitch" location="registroReclamoTransaccionSwitchTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/registroReclamoTransaccionSwitchTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/reclamosSwitch/RegistroReclamoTransaccionSwitch/registroReclamoTransaccionSwitchValidate/";

declare function xf:registroReclamoTransaccionSwitchValidate($registroReclamoTransaccionSwitch as element(ns0:registroReclamoTransaccionSwitch))
    as xs:string {
        if (fn:string($registroReclamoTransaccionSwitch/SCENARIO/text()) = "" or 
        	fn:string($registroReclamoTransaccionSwitch/CLAIM_CURRENCY/text()) = "" or 
        	fn:string($registroReclamoTransaccionSwitch/CLAIM_AMOUNT/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        	
        ) else if (not(fn:string($registroReclamoTransaccionSwitch/SCENARIO/text()) = ("CFRF","CFRG","CFRV","CVRF","CGRF"))) then (
        	"SCENARIO NOT SUPPORTED"
        	
        ) else (
        	""
        )
};

declare variable $registroReclamoTransaccionSwitch as element(ns0:registroReclamoTransaccionSwitch) external;

xf:registroReclamoTransaccionSwitchValidate($registroReclamoTransaccionSwitch)