(:: pragma bea:global-element-parameter parameter="$activaDesactivaAlertaClienteFicoAlerta" element="ns0:activaDesactivaAlertaClienteFicoAlerta" location="activaDesactivaAlertaClienteFicoAlertaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/activaDesactivaAlertaClienteFicoAlertaTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ficocelAdmin/ActivaDesactivaAlertaClienteFicoAlerta/activaDesactivaAlertaClienteFicoAlertaValidate/";

declare function xf:activaDesactivaAlertaClienteFicoAlertaValidate($activaDesactivaAlertaClienteFicoAlerta as element(ns0:activaDesactivaAlertaClienteFicoAlerta))
    as xs:string {
        if (fn:string($activaDesactivaAlertaClienteFicoAlerta/SUBSCRIPTION_ID/text()) = "" or 
        	fn:string($activaDesactivaAlertaClienteFicoAlerta/ACTIVATE_YES_NO/text()) = "") then (
        	"REQUIRED FILEDS NOT FOUND"
        	
        ) else if (not(fn:string($activaDesactivaAlertaClienteFicoAlerta/ACTIVATE_YES_NO/text()) = ("YES","NO"))) then (
        	"ACTIVE_YES_NO NOT SUPPORTED"
        ) else(
        	""
        )
};

declare variable $activaDesactivaAlertaClienteFicoAlerta as element(ns0:activaDesactivaAlertaClienteFicoAlerta) external;

xf:activaDesactivaAlertaClienteFicoAlertaValidate($activaDesactivaAlertaClienteFicoAlerta)