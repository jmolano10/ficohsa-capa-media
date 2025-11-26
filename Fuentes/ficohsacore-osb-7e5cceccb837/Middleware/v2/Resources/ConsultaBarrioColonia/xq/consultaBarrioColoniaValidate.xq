(:: pragma bea:global-element-parameter parameter="$consultaBarrioColonia" element="ns0:consultaBarrioColonia" location="../../../../Business_Resources/direcciones/ConsultaBarrioColonia/consultaBarrioColoniaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaBarrioColoniaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaBarrioColonia/xq/consultaBarrioColoniaValidate/";

declare function xf:consultaBarrioColoniaValidate($consultaBarrioColonia as element(ns0:consultaBarrioColonia))
    as xs:string {
        if (fn:string($consultaBarrioColonia/CITY_CODE/text()) = "" or 
        	fn:string($consultaBarrioColonia/DEPT_CODE/text()) = "" or 
        	fn:string($consultaBarrioColonia/COUNTRY_CODE/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        )
        else (
            ""
        )
};

declare variable $consultaBarrioColonia as element(ns0:consultaBarrioColonia) external;

xf:consultaBarrioColoniaValidate($consultaBarrioColonia)