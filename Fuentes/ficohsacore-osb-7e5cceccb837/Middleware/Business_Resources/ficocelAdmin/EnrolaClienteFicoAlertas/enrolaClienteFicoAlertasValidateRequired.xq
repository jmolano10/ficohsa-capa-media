(:: pragma bea:global-element-parameter parameter="$enrolaClienteFicoAlertas" element="ns0:enrolaClienteFicoAlertas" location="enrolaClienteFicoAlertasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/enrolaClienteFicoAlertasTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ficocelAdmin/EnrolaClienteFicoAlertas/enrolaClienteFicoAlertasValidateRequired/";

declare function xf:enrolaClienteFicoAlertasValidateRequired($enrolaClienteFicoAlertas as element(ns0:enrolaClienteFicoAlertas))
    as xs:boolean {
        if (fn:string($enrolaClienteFicoAlertas/CUSTOMER_ID/text()) != "" and 
        	fn:string($enrolaClienteFicoAlertas/PHONE_ID/text()) != "" and 
        	fn:string($enrolaClienteFicoAlertas/CARRIER/text()) != "") then (
        	xs:boolean("1")
        ) else (
        	xs:boolean("0")
        )
};

declare variable $enrolaClienteFicoAlertas as element(ns0:enrolaClienteFicoAlertas) external;

xf:enrolaClienteFicoAlertasValidateRequired($enrolaClienteFicoAlertas)