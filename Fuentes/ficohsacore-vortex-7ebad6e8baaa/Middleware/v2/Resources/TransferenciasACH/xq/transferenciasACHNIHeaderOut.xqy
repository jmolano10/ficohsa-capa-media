xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$opTransferenciaIndividualACHRespuesta" element="ns0:opTransferenciaIndividualACHRespuesta" location="../../../BusinessServices/CTS/transferencia/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns4:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/transferenciasACHNIHeaderOut/";
declare namespace ns2 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns1 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns4 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns3 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns0 = "http://service.srvaplcobistransferencia.ecobis.cobiscorp";

declare function xf:transferenciasACHNIHeaderOut($opTransferenciaIndividualACHRespuesta as element(ns0:opTransferenciaIndividualACHRespuesta))
    as element(ns4:ResponseHeader) {
        <ns4:ResponseHeader>
        	{
                if(fn:string($opTransferenciaIndividualACHRespuesta/ns2:salienteIndividualACHRespuesta/ns2:referenciaTrn/text()) != "") then (
                	<transactionId>{ data($opTransferenciaIndividualACHRespuesta/ns2:salienteIndividualACHRespuesta/ns2:referenciaTrn) }</transactionId>
                ) else ()
            }
        	{
            	let $successIndicator := fn:string($opTransferenciaIndividualACHRespuesta/ns2:contextoRespuesta/ns2:codTipoRespuesta/text())
            	let $message := fn:string($opTransferenciaIndividualACHRespuesta/ns2:contextoRespuesta/ns2:valDescripcionRespuesta/text())
            	return 
	            	if ($successIndicator  = "0") then (
	            		<successIndicator>Success</successIndicator>,
	            		<valueDate>{fn-bea:date-to-string-with-format('yyyyMMdd',current-date())}</valueDate>
	            	) else (
	            		<successIndicator>{ $successIndicator }</successIndicator>,
	            		<messages>{ $message }</messages>
	            	) 
            }
        </ns4:ResponseHeader>
};
declare variable $opTransferenciaIndividualACHRespuesta as element(ns0:opTransferenciaIndividualACHRespuesta) external;

xf:transferenciasACHNIHeaderOut($opTransferenciaIndividualACHRespuesta)