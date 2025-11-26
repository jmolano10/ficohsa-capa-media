(:: pragma bea:global-element-parameter parameter="$opConsultaFinacierasACHRespuesta1" element="ns3:opConsultaFinacierasACHRespuesta" location="../../../BusinessServices/CTS/transferencia/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaFinancierasACHResponse" location="../../../../Business_Resources/Core/consultaFinancierasACH/consultaFinancierasACHTypes.xsd" ::)

declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns2 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaFinancierasACHTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFinancierasACH/xq/consultaFinanacierasACHNIOut/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://service.srvaplcobistransferencia.ecobis.cobiscorp";

declare function xf:consultaFinanacierasACHNIOut($opConsultaFinacierasACHRespuesta1 as element(ns3:opConsultaFinacierasACHRespuesta),
    $tiposProducto as xs:string)
    as element(ns1:consultaFinancierasACHResponse) {
        <ns1:consultaFinancierasACHResponse>
            <ns1:consultaFinancierasACHResponseType>
                {
                    for $banco in $opConsultaFinacierasACHRespuesta1/ns0:banco
                    return
                        <ns1:consultaFinancierasACHResponseRecordType>
                            {
                                for $codigoAch in $banco/ns0:codigoAch
                                return
                                    <DESTINATION_CODE>{ data($codigoAch) }</DESTINATION_CODE>
                            }
                            {
                                for $nombreBanco in $banco/ns0:nombreBanco
                                return
                                    <DESTINATION_NAME>{ data($nombreBanco) }</DESTINATION_NAME>
                            }
                            <ns1:consultaFinancierasACHDetailResponseType>
                                {
                                	for $tipo in tokenize($tiposProducto, '\|')
                                	return                                 	
                                	<ns1:consultaFinancierasACHDetailResponseRecordType>
                                		<TYPE_OF_PRODUCT>{ $tipo }</TYPE_OF_PRODUCT>
                                		<MIN_PRODUCT_ID_LENGTH>1</MIN_PRODUCT_ID_LENGTH>
					                    <MAX_PRODUCT_ID_LENGTH>100</MAX_PRODUCT_ID_LENGTH>
					                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
					                    <PRODUCT_ID_SAMPLE></PRODUCT_ID_SAMPLE>                                		                                	                               
                                	</ns1:consultaFinancierasACHDetailResponseRecordType>
                                }   
                            </ns1:consultaFinancierasACHDetailResponseType>
                        </ns1:consultaFinancierasACHResponseRecordType>
                }
            </ns1:consultaFinancierasACHResponseType>
        </ns1:consultaFinancierasACHResponse>
};

declare variable $opConsultaFinacierasACHRespuesta1 as element(ns3:opConsultaFinacierasACHRespuesta) external;
declare variable $tiposProducto as xs:string external;

xf:consultaFinanacierasACHNIOut($opConsultaFinacierasACHRespuesta1,
    $tiposProducto)