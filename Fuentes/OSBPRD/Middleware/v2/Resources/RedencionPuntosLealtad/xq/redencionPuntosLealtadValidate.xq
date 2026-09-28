(:: pragma bea:global-element-parameter parameter="$redencionPuntosLealtad" element="ns0:redencionPuntosLealtad" location="../../ProgramaLealtad/xsd/programaLealtadTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RedencionPuntosLealtad/xq/redencionPuntosLealtadValidate/";

declare function xf:redencionPuntosLealtadValidate($redencionPuntosLealtad as element(ns0:redencionPuntosLealtad))
    as xs:string {
        if ( not(fn:string($redencionPuntosLealtad/REDEMPTION_DETAILS/REDEMPTION_METHOD/text()) = ("CASH")) ) then (
        	"Método de redención no permitido"
        ) else (
        	""
        )
};

declare variable $redencionPuntosLealtad as element(ns0:redencionPuntosLealtad) external;

xf:redencionPuntosLealtadValidate($redencionPuntosLealtad)