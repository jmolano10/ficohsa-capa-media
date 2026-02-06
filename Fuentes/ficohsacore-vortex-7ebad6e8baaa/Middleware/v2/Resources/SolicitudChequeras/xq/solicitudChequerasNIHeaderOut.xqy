xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opCompraChequeraRespuesta" element="ns3:opCompraChequeraRespuesta" location="../../../BusinessServices/CTS/cheques/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitudChequeras/xq/solicitudChequerasNIHeaderOut/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://service.srvaplcobischeques.ecobis.cobiscorp";

declare function xf:solicitudChequerasNIHeaderOut($opCompraChequeraRespuesta as element(ns3:opCompraChequeraRespuesta))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            <transactionId>{ data($opCompraChequeraRespuesta/ns1:compraChequera/ns1:transaccion/ns1:valNumAprobacionCore) }</transactionId>
            {
            	for $successIndicator in $opCompraChequeraRespuesta/ns1:contextoRespuesta/ns1:codTipoRespuesta/text()
				return
					if ($successIndicator = "0") then (
						<successIndicator>Success</successIndicator>
					)else (
						<successIndicator>{ $successIndicator }</successIndicator>,
						for $message in $opCompraChequeraRespuesta/ns1:contextoRespuesta/ns1:valDescripcionRespuesta
						return
						<messages>{ data($message) }</messages>
					) 
            }
			{
            	for $fechaTransac in $opCompraChequeraRespuesta/ns1:compraChequera/ns1:transaccion/ns1:fechaTransac
            	return
            		<valueDate>{ fn-bea:dateTime-to-string-with-format("yyyyMMdd", $fechaTransac) }</valueDate>
            }		            
        </ns0:ResponseHeader>
};

declare variable $opCompraChequeraRespuesta as element(ns3:opCompraChequeraRespuesta) external;

xf:solicitudChequerasNIHeaderOut($opCompraChequeraRespuesta)