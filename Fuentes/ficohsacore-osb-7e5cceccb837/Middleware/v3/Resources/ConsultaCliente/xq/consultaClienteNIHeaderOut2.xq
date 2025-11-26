(:: pragma bea:global-element-parameter parameter="$opConsultaClienteInfoRespuesta" element="ns1:opConsultaClienteInfoRespuesta" location="../../../../v2/BusinessServices/CTS/cliente/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns2:ResponseHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://service.srvaplcobiscliente.ecobis.cobiscorp";
declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaCliente/xq/consultaClienteNIHeaderOut/";

declare function xf:consultaClienteNIHeaderOut($opConsultaClienteInfoRespuesta as element(ns1:opConsultaClienteInfoRespuesta))
    as element(ns2:ResponseHeader) {  
        <ns2:ResponseHeader>
            {
            	let $successIndicator := fn:string($opConsultaClienteInfoRespuesta/ns0:contextoRespuesta/ns0:codTipoRespuesta/text())
            	let $message := fn:string($opConsultaClienteInfoRespuesta/ns0:contextoRespuesta/ns0:valDescripcionRespuesta/text())
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

declare variable $opConsultaClienteInfoRespuesta as element(ns1:opConsultaClienteInfoRespuesta) external;

xf:consultaClienteNIHeaderOut($opConsultaClienteInfoRespuesta)