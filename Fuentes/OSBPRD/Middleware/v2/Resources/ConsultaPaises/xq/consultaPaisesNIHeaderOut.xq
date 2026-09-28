(:: pragma bea:global-element-parameter parameter="$opBuscarPaisesRespuesta" element="ns2:opBuscarPaisesRespuesta" location="../../../BusinessServices/CTS/generalService/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://service.srvaplcobisgenerales.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPaises/xq/consultaPaisesNIHeaderOut/";

declare function xf:consultaPaisesNIHeaderOut($opBuscarPaisesRespuesta as element(ns2:opBuscarPaisesRespuesta))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
            	let $successIndicator := fn:string($opBuscarPaisesRespuesta/ns1:contextoRespuesta/ns1:codTipoRespuesta/text())
            	let $message := fn:string($opBuscarPaisesRespuesta/ns1:contextoRespuesta/ns1:valDescripcionRespuesta/text())
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

declare variable $opBuscarPaisesRespuesta as element(ns2:opBuscarPaisesRespuesta) external;

xf:consultaPaisesNIHeaderOut($opBuscarPaisesRespuesta)