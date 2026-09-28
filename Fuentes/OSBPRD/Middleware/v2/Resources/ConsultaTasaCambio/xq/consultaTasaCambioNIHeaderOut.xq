(:: pragma bea:global-element-parameter parameter="$opBuscarTasaCambioRespuesta1" element="ns3:opBuscarTasaCambioRespuesta" location="../../../BusinessServices/CTS/tesoreria/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTasaCambio/xq/consultaTasaCambioNIHeaderOut/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://service.srvaplcobistesoreria.ecobis.cobiscorp";

declare function xf:consultaTasaCambioNIHeaderOut($opBuscarTasaCambioRespuesta1 as element(ns3:opBuscarTasaCambioRespuesta))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
            	let $successIndicator := fn:string($opBuscarTasaCambioRespuesta1/ns1:contextoRespuesta/ns1:codTipoRespuesta/text())
            	let $message := fn:string($opBuscarTasaCambioRespuesta1/ns1:contextoRespuesta/ns1:valDescripcionRespuesta/text())
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

declare variable $opBuscarTasaCambioRespuesta1 as element(ns3:opBuscarTasaCambioRespuesta) external;

xf:consultaTasaCambioNIHeaderOut($opBuscarTasaCambioRespuesta1)