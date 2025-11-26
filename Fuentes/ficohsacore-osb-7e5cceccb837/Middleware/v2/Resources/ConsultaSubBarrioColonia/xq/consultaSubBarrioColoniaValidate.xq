(:: pragma bea:global-element-parameter parameter="$consultaSubBarrioColonia" element="ns0:consultaSubBarrioColonia" location="../xsd/consultaSubBarrioColoniaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSubBarrioColoniaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSubBarrioColonia/xq/consultaSubBarrioColoniaValidate/";

declare function xf:consultaSubBarrioColoniaValidate($consultaSubBarrioColonia as element(ns0:consultaSubBarrioColonia))
    as xs:string {
        if (
        	fn:string($consultaSubBarrioColonia/DISTRICT_CODE/text()) = "" or
        	fn:string($consultaSubBarrioColonia/CITY_CODE/text()) = "" or 
        	fn:string($consultaSubBarrioColonia/DEPT_CODE/text()) = "" or 
        	fn:string($consultaSubBarrioColonia/COUNTRY_CODE/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        )
        else (
            ""
        )
};

declare variable $consultaSubBarrioColonia as element(ns0:consultaSubBarrioColonia) external;

xf:consultaSubBarrioColoniaValidate($consultaSubBarrioColonia)