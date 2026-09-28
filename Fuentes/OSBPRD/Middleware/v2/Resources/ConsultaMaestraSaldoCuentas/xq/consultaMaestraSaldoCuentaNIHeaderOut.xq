xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$opConsultaMaestraSaldosRespuesta" element="ns3:opConsultaMaestraSaldosRespuesta" location="../../../BusinessServices/CTS/cuenta/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns4:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMaestraSaldoCuentas/xq/consultaMaestraSaldoCuentaNIHeaderOut/";
declare namespace ns2 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns4 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns3 = "http://service.srvaplcobiscuenta.ecobis.cobiscorp";
declare namespace ns0 = "http://dto2.sdf.cts.cobis.cobiscorp.com";

declare function xf:consultaMaestraSaldoCuentaNIHeaderOut($opConsultaMaestraSaldosRespuesta as element(ns3:opConsultaMaestraSaldosRespuesta))
    as element(ns4:ResponseHeader) {
        <ns4:ResponseHeader>
        	{
		       	let $successIndicator := fn:string($opConsultaMaestraSaldosRespuesta/ns1:contextoRespuesta/ns1:codTipoRespuesta/text())
		       	let $message := fn:string($opConsultaMaestraSaldosRespuesta/ns1:contextoRespuesta/ns1:valDescripcionRespuesta/text())
		       	return 
			       	if ($successIndicator  = ('0', '00')) then (
			        	<successIndicator>Success</successIndicator>
			       	) else (
			       		<successIndicator>{ $successIndicator }</successIndicator>,
			       		<messages>{ $message }</messages>
			       	)
		   }
	   </ns4:ResponseHeader>
};

declare variable $opConsultaMaestraSaldosRespuesta as element(ns3:opConsultaMaestraSaldosRespuesta) external;

xf:consultaMaestraSaldoCuentaNIHeaderOut($opConsultaMaestraSaldosRespuesta)