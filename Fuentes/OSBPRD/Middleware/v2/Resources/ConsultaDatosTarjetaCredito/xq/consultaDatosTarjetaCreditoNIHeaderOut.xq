xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$opConsultaDatosTarjetaCreditoRespuesta" element="ns3:opConsultaDatosTarjetaCreditoRespuesta" location="../../../BusinessServices/CTS/tarjetaCredito/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatosTarjetaCredito/xq/consultaDatosTarjetaCreditoNIHeaderOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://service.srvaplcobistarjetacredito.ecobis.cobiscorp";

declare function xf:consultaDatosTarjetaCreditoNIHeaderOut($opConsultaDatosTarjetaCreditoRespuesta as element(ns3:opConsultaDatosTarjetaCreditoRespuesta))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
        	{
            	let $successIndicator := fn:string($opConsultaDatosTarjetaCreditoRespuesta/ns1:contextoRespuesta/ns1:codTipoRespuesta/text())
            	let $message := fn:string($opConsultaDatosTarjetaCreditoRespuesta/ns1:contextoRespuesta/ns1:valDescripcionRespuesta/text())
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

declare variable $opConsultaDatosTarjetaCreditoRespuesta as element(ns3:opConsultaDatosTarjetaCreditoRespuesta) external;

xf:consultaDatosTarjetaCreditoNIHeaderOut($opConsultaDatosTarjetaCreditoRespuesta)