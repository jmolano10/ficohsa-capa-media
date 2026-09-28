xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$opConsultaDetalleCuentaRespuesta1" element="ns1:opConsultaDetalleCuentaRespuesta" location="../../../BusinessServices/CTS/cuenta/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns2:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetallesCuenta/xq/consultaDetCuentaNIHeaderOut/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://service.srvaplcobiscuenta.ecobis.cobiscorp";
declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";

declare function xf:consultaDetCuentaNIHeaderOut($opConsultaDetalleCuentaRespuesta1 as element(ns1:opConsultaDetalleCuentaRespuesta))
    as element(ns2:ResponseHeader) {
        <ns2:ResponseHeader>
            {
            	let $successIndicator := fn:string($opConsultaDetalleCuentaRespuesta1/ns0:contextoRespuesta/ns0:codTipoRespuesta/text())
            	let $message := fn:string($opConsultaDetalleCuentaRespuesta1/ns0:contextoRespuesta/ns0:valDescripcionRespuesta/text())
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

declare variable $opConsultaDetalleCuentaRespuesta1 as element(ns1:opConsultaDetalleCuentaRespuesta) external;

xf:consultaDetCuentaNIHeaderOut($opConsultaDetalleCuentaRespuesta1)