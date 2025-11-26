(:: pragma bea:global-element-parameter parameter="$enrolaAlertaClienteFicoAlertas" element="ns0:enrolaAlertaClienteFicoAlertas" location="enrolaAlertaClienteFicoAlertasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/enrolaAlertaClienteFicoAlertasTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ficocelAdmin/EnrolaAlertaClienteFicoAlertas/enrolaAlertaClienteFicoAlertasValidateRequired/";

declare function xf:enrolaAlertaClienteFicoAlertasValidateRequired($enrolaAlertaClienteFicoAlertas as element(ns0:enrolaAlertaClienteFicoAlertas))
    as xs:boolean {
        if (fn:string($enrolaAlertaClienteFicoAlertas/ALERT_TYPE/text()) != "" and 
        	fn:string($enrolaAlertaClienteFicoAlertas/PRODUCT_ID/text()) != "") then (
        	xs:boolean("1")
        ) else ( 
            xs:boolean("0")
        )
};

declare variable $enrolaAlertaClienteFicoAlertas as element(ns0:enrolaAlertaClienteFicoAlertas) external;

xf:enrolaAlertaClienteFicoAlertasValidateRequired($enrolaAlertaClienteFicoAlertas)