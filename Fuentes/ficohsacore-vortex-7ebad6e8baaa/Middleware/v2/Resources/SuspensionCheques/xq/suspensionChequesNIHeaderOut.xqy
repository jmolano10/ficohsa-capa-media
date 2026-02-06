xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opSuspensionChequesRespuesta" element="ns3:opSuspensionChequesRespuesta" location="../../../BusinessServices/CTS/cheques/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SuspensionCheques/xq/suspensionChequesNIHeaderOut/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://service.srvaplcobischeques.ecobis.cobiscorp";

declare function xf:suspensionChequesNIHeaderOut($opSuspensionChequesRespuesta as element(ns3:opSuspensionChequesRespuesta))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
        	 {
           		if (fn:string($opSuspensionChequesRespuesta/ns1:contextoRespuesta/ns1:codTipoRespuesta/text()) = ("0","00")) then (
	                    <transactionId>{ data($opSuspensionChequesRespuesta/ns1:transaccion/ns1:valNumAprobacionCore) }</transactionId>,
	                    <successIndicator>Success</successIndicator>,
	                	<valueDate>{ fn-bea:dateTime-to-string-with-format("yyyyMMdd", data($opSuspensionChequesRespuesta/ns1:transaccion/ns1:fechaTransac)) }</valueDate>
				 ) else( 
	        	   		<successIndicator> {data($opSuspensionChequesRespuesta/ns1:contextoRespuesta/ns1:codTipoRespuesta)}</successIndicator>, 
	               		<messages> {data($opSuspensionChequesRespuesta/ns1:contextoRespuesta/ns1:valDescripcionRespuesta)} </messages>
	                 )
              }
        </ns0:ResponseHeader>
};

declare variable $opSuspensionChequesRespuesta as element(ns3:opSuspensionChequesRespuesta) external;

xf:suspensionChequesNIHeaderOut($opSuspensionChequesRespuesta)