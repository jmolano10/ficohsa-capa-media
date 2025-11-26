xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultadeclienteResponse1" element="ns0:ConsultadeclienteResponse" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaDatosCliente/xq/ConsultaClienteOut/";
declare namespace ns0 = "T24WebServicesImpl";

declare function xf:ConsultaClienteOut($consultadeclienteResponse1 as element(ns0:ConsultadeclienteResponse))
    as xs:string {
        if (fn:string($consultadeclienteResponse1/Status/successIndicator/text()) != "Success") then (
        	fn:string($consultadeclienteResponse1/Status/messages/text())
        ) else (
        	if (fn:empty($consultadeclienteResponse1/WSCUSTOMERType/ZERORECORDS/text())) then (
        		""
        	) else (
        		$consultadeclienteResponse1/WSCUSTOMERType/ZERORECORDS/text()
        	)
        ) 
};

declare variable $consultadeclienteResponse1 as element(ns0:ConsultadeclienteResponse) external;

xf:ConsultaClienteOut($consultadeclienteResponse1)