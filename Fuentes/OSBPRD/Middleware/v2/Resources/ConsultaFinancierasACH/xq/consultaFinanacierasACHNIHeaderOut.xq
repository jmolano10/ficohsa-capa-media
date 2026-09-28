(:: pragma bea:global-element-parameter parameter="$opConsultaFinacierasACHRespuesta1" element="ns3:opConsultaFinacierasACHRespuesta" location="../../../BusinessServices/CTS/transferencia/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFinancierasACH/xq/consultaFinanacierasACHNIHeaderOut/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://service.srvaplcobistransferencia.ecobis.cobiscorp";

declare function xf:consultaFinanacierasACHNIHeaderOut($opConsultaFinacierasACHRespuesta1 as element(ns3:opConsultaFinacierasACHRespuesta))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
            	let $successIndicator := fn:string($opConsultaFinacierasACHRespuesta1/ns1:contextoRespuesta/ns1:codTipoRespuesta/text())
            	let $message := fn:string($opConsultaFinacierasACHRespuesta1/ns1:contextoRespuesta/ns1:valDescripcionRespuesta/text())
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

declare variable $opConsultaFinacierasACHRespuesta1 as element(ns3:opConsultaFinacierasACHRespuesta) external;

xf:consultaFinanacierasACHNIHeaderOut($opConsultaFinacierasACHRespuesta1)