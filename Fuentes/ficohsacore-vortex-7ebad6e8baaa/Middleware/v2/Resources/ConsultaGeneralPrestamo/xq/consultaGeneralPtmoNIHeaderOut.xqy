xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opConsultaPrestamoRespuesta" element="ns1:opConsultaPrestamoRespuesta" location="../../../BusinessServices/CTS/prestamo/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns2:ResponseHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://service.srvaplcobisprestamo.ecobis.cobiscorp";
declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaGeneralPrestamo/xq/consultaGeneralPtmoNIHeaderOut/";

declare function xf:consultaGeneralPtmoNIHeaderOut($opConsultaPrestamoRespuesta as element(ns1:opConsultaPrestamoRespuesta))
    as element(ns2:ResponseHeader) {
        <ns2:ResponseHeader>
            {
            	let $successIndicator := fn:string($opConsultaPrestamoRespuesta/ns0:contextoRespuesta/ns0:codTipoRespuesta/text())
            	let $message := fn:string($opConsultaPrestamoRespuesta/ns0:contextoRespuesta/ns0:valDescripcionRespuesta/text())
            	return 
	            	if ($successIndicator  = "0") then (
	            		<successIndicator>Success</successIndicator>
	            	) else (
	            		<successIndicator>{ $successIndicator }</successIndicator>,
	            		<messages>{ $message }</messages>
	            	) 
            }
        </ns2:ResponseHeader>
};

declare variable $opConsultaPrestamoRespuesta as element(ns1:opConsultaPrestamoRespuesta) external;

xf:consultaGeneralPtmoNIHeaderOut($opConsultaPrestamoRespuesta)