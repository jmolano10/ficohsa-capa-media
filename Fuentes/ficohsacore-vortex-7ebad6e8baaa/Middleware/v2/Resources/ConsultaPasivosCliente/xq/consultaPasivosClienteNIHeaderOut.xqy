xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opConsultaPasivosClienteRespuesta1" element="ns2:opConsultaPasivosClienteRespuesta" location="../../../BusinessServices/CTS/pasivos/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://service.srvaplcobispasivos.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPasivosCliente/xq/consultaPasivosClienteNIHeaderOut/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://dto2.commons.ecobis.cobiscorp";

declare function xf:consultaPasivosClienteNIHeaderOut($opConsultaPasivosClienteRespuesta1 as element(ns2:opConsultaPasivosClienteRespuesta))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
            	let $successIndicator := fn:string($opConsultaPasivosClienteRespuesta1/ns1:contextoRespuesta/ns1:codTipoRespuesta/text())
            	let $message := fn:string($opConsultaPasivosClienteRespuesta1/ns1:contextoRespuesta/ns1:valDescripcionRespuesta/text())
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

declare variable $opConsultaPasivosClienteRespuesta1 as element(ns2:opConsultaPasivosClienteRespuesta) external;

xf:consultaPasivosClienteNIHeaderOut($opConsultaPasivosClienteRespuesta1)