(:: pragma bea:global-element-parameter parameter="$consultaDetalleArchivoDeudores" element="ns0:consultaDetalleArchivoDeudores" location="consultaDetalleArchivoDeudoresTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleArchivoDeudoresTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/archivosConvenios/consultaDetalleArchivoDeudores/consultaDetalleArchivoDeudoresValidate/";

declare function xf:consultaDetalleArchivoDeudoresValidate($consultaDetalleArchivoDeudores as element(ns0:consultaDetalleArchivoDeudores))
    as xs:string {
        if (fn:string($consultaDetalleArchivoDeudores/CONTRACT_ID/text()) = "" or 
        	fn:string($consultaDetalleArchivoDeudores/FILE_NAME/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        
        ) else (
        	""
        )
};

declare variable $consultaDetalleArchivoDeudores as element(ns0:consultaDetalleArchivoDeudores) external;

xf:consultaDetalleArchivoDeudoresValidate($consultaDetalleArchivoDeudores)