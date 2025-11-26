(:: pragma bea:global-element-parameter parameter="$modificacionDeudor" element="ns0:modificacionDeudor" location="modificacionDeudorTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/modificacionDeudorTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/deudoresRecaudos/modificacionDeudor/modificacionDeudorValidate/";

declare function xf:modificacionDeudorValidate($modificacionDeudor as element(ns0:modificacionDeudor))
    as xs:string {
        if (fn:string($modificacionDeudor/CONTRACT_ID/text()) = "" or 
        	fn:string($modificacionDeudor/DEBTOR_CODE/text()) = "" or 
        	fn:string($modificacionDeudor/DEBTOR_NAME/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        ) else (
        	""
        )
};

declare variable $modificacionDeudor as element(ns0:modificacionDeudor) external;

xf:modificacionDeudorValidate($modificacionDeudor)