(:: pragma bea:global-element-parameter parameter="$opConsultaDGIRespuesta" element="ns3:opConsultaDGIRespuesta" location="../../../BusinessServices/CTS/impuesto/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDGI/xq/consultaDGIHeaderOut/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://service.srvaplcobisimpuestos.ecobis.cobiscorp";

declare function xf:consultaDGIHeaderOut($opConsultaDGIRespuesta as element(ns3:opConsultaDGIRespuesta))
    as element(ns0:ResponseHeader) {
    
    	<ns0:ResponseHeader>
    		{
				let $successIndicator := fn:string($opConsultaDGIRespuesta/ns1:contextoRespuesta/ns1:codTipoRespuesta/text())
                return
					if ($successIndicator = "0") then (
	            		<successIndicator>Success</successIndicator>
	            	) else (
	            		<successIndicator>{ $successIndicator }</successIndicator>,
	            		for $message in fn:string($opConsultaDGIRespuesta/ns1:contextoRespuesta/ns1:valDescripcionRespuesta)
	            		return
	            		<messages>{ data($message) }</messages>
	            	) 
            }
        </ns0:ResponseHeader>
};

declare variable $opConsultaDGIRespuesta as element(ns3:opConsultaDGIRespuesta) external;

xf:consultaDGIHeaderOut($opConsultaDGIRespuesta)
