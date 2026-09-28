(:: pragma bea:global-element-parameter parameter="$opConsultaMovimientoCuentaRespuesta" element="ns1:opConsultaMovimientoCuentaRespuesta" location="../../../BusinessServices/CTS/cuenta/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns1 = "http://service.srvaplcobiscuenta.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosCuenta/xq/ConsultaMovimientosCuentaNIHeaderOut/";

declare function xf:ConsultaMovimientosCuentaNIHeaderOut($opConsultaMovimientoCuentaRespuesta as element(ns1:opConsultaMovimientoCuentaRespuesta))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
            	let $successIndicator := $opConsultaMovimientoCuentaRespuesta/ns2:contextoRespuesta/ns2:codTipoRespuesta
            	let $message := $opConsultaMovimientoCuentaRespuesta/ns2:contextoRespuesta/ns2:valDescripcionRespuesta
            	return            	
	            	if ($successIndicator  = "0") then (
	            		<successIndicator>Success</successIndicator>
	            	) else (
	            		<successIndicator>{ $successIndicator }</successIndicator>,
	            		<messages>{ $message }</messages>
	            	)            	
            }
        </ns0:ResponseHeader>
};

declare variable $opConsultaMovimientoCuentaRespuesta as element(ns1:opConsultaMovimientoCuentaRespuesta) external;

xf:ConsultaMovimientosCuentaNIHeaderOut($opConsultaMovimientoCuentaRespuesta)