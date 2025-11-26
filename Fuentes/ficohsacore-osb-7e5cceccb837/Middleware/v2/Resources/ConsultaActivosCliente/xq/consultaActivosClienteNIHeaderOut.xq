(:: pragma bea:global-element-parameter parameter="$opConsultaActivosClienteRespuesta" element="ns2:opConsultaActivosClienteRespuesta" location="../../../BusinessServices/CTS/activos/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://service.srvaplcobisactivos.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaActivosCliente/xq/ConsultaActivosClienteNIHeaderOut/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://dto2.commons.ecobis.cobiscorp";

declare function xf:ConsultaActivosClienteNIHeaderOut($opConsultaActivosClienteRespuesta as element(ns2:opConsultaActivosClienteRespuesta))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
               let $successIndicator := fn:string($opConsultaActivosClienteRespuesta/ns1:contextoRespuesta/ns1:codTipoRespuesta/text())
               let $message := fn:string($opConsultaActivosClienteRespuesta/ns1:contextoRespuesta/ns1:valDescripcionRespuesta/text())
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

declare variable $opConsultaActivosClienteRespuesta as element(ns2:opConsultaActivosClienteRespuesta) external;

xf:ConsultaActivosClienteNIHeaderOut($opConsultaActivosClienteRespuesta)