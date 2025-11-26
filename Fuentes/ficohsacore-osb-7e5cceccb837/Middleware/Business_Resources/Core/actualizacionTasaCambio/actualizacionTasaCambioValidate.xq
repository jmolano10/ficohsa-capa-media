(:: pragma bea:global-element-parameter parameter="$actualizacionTasaCambio" element="ns0:actualizacionTasaCambio" location="actualizacionTasaCambioTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/actualizacionTasaCambioTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/actualizacionTasaCambio/actualizacionTasaCambioValidate/";

declare function xf:actualizacionTasaCambioValidate($actualizacionTasaCambio as element(ns0:actualizacionTasaCambio))
    as xs:string {
        if (fn:string($actualizacionTasaCambio/CURRENCY/text()) = "" or 
        	fn:string($actualizacionTasaCambio/BUY_RATE/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        	
        ) else (
        	""
        )
};

declare variable $actualizacionTasaCambio as element(ns0:actualizacionTasaCambio) external;

xf:actualizacionTasaCambioValidate($actualizacionTasaCambio)