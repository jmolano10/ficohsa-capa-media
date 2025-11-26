(:: pragma bea:global-element-parameter parameter="$consultaRemesas1" element="ns0:consultaRemesas" location="consultaRemesasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesasTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/remesas/ConsultaRemesas/validarTipoConsulta/";

declare function xf:validarTipoConsulta($consultaRemesas1 as element(ns0:consultaRemesas))
    as xs:string {
        if ( fn:string($consultaRemesas1/REMITTANCE_ID/text()) != "" ) then (
        	"ID_BASED"
        ) else if ( fn:string($consultaRemesas1/REMITTER_NAME/text()) != "" and
        			fn:string($consultaRemesas1/BENEFICIARY_NAME/text()) != "") then (
        			"NAME_BASED"
        	   ) else (
        	   		""
        	   )
};

declare variable $consultaRemesas1 as element(ns0:consultaRemesas) external;

xf:validarTipoConsulta($consultaRemesas1)