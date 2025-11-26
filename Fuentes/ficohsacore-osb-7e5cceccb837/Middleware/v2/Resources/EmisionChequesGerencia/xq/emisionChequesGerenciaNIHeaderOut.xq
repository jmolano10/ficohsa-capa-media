(:: pragma bea:global-element-parameter parameter="$opSolicitudChequeGerenciaRespuesta" element="ns3:opSolicitudChequeGerenciaRespuesta" location="../../../BusinessServices/CTS/cheques/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EmisionChequesGerencia/xq/emisionChequesGerenciaNIHeaderOut/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://service.srvaplcobischeques.ecobis.cobiscorp";

declare function xf:emisionChequesGerenciaNIHeaderOut($opSolicitudChequeGerenciaRespuesta as element(ns3:opSolicitudChequeGerenciaRespuesta))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
        	
        	{
        		let $transactionId := fn:string($opSolicitudChequeGerenciaRespuesta/ns1:transaccion/ns1:valNumAprobacionCore/text())
        		return
                if( $transactionId != "") then (
                	<transactionId>{ $transactionId  }</transactionId>
                ) else ()
            }
        
            {
            	let $successIndicator := fn:string($opSolicitudChequeGerenciaRespuesta/ns1:contextoRespuesta/ns1:codTipoRespuesta/text())
            	let $message := fn:string($opSolicitudChequeGerenciaRespuesta/ns1:contextoRespuesta/ns1:valDescripcionRespuesta/text())
            	return 
	            	if ($successIndicator  = "0") then (
	            		<successIndicator>Success</successIndicator>,
	            		<valueDate>{fn-bea:dateTime-to-string-with-format('yyyyMMdd', data($opSolicitudChequeGerenciaRespuesta/ns1:transaccion/ns1:fechaTransac))}</valueDate>
	            	) else (
	            		<successIndicator>{ $successIndicator }</successIndicator>,
	            		<messages>{ $message }</messages>
	            	) 
            }
        </ns0:ResponseHeader>
};

declare variable $opSolicitudChequeGerenciaRespuesta as element(ns3:opSolicitudChequeGerenciaRespuesta) external;

xf:emisionChequesGerenciaNIHeaderOut($opSolicitudChequeGerenciaRespuesta)
