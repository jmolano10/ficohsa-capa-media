xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opConsultaAgenciasRespuesta" element="ns3:opConsultaAgenciasRespuesta" location="../../../BusinessServices/CTS/generalService/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaAgenciasBancoResponse" location="../../../../Business_Resources/Core/consultaAgenciasBanco/consultaAgenciasBancoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaAgenciasBancoTypes";
declare namespace ns2 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaAgenciasBanco/xq/consultaAgenciasBancoNIOut/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://service.srvaplcobisgenerales.ecobis.cobiscorp";

declare function xf:consultaAgenciasBancoNIOut($opConsultaAgenciasRespuesta as element(ns3:opConsultaAgenciasRespuesta))
    as element(ns0:consultaAgenciasBancoResponse) {
        <ns0:consultaAgenciasBancoResponse>
            <ns0:consultaAgenciasBancoResponseType>
                {
                    for $oficina in $opConsultaAgenciasRespuesta/ns1:oficina
                    return
                        <ns0:consultaAgenciasBancoResponseRecordType>
                            {
                                for $codOficina in $oficina/ns1:codOficina
                                return
                                    <BRANCH_CODE>{ data($codOficina) }</BRANCH_CODE>
                            }
                            {
                                for $valOficina in $oficina/ns1:valOficina
                                return
                                    <BRANCH_NAME>{ data($valOficina) }</BRANCH_NAME>
                            }
                            {
                                for $valTipoOficina in $oficina/ns1:valTipoOficina
                                return
                                    <BRANCH_TYPE>{ data($valTipoOficina) }</BRANCH_TYPE>
                            }
                            {
                                let $valZonaGeografica := string($oficina/ns1:valZonaGeografica/text())
                                return
                                	if( $valZonaGeografica != '' )then(
                                		<GEOGRAPHIC_ZONE>{ $valZonaGeografica }</GEOGRAPHIC_ZONE>
                                	)else(
                                		<GEOGRAPHIC_ZONE/>
                                	)   
                            }
                            <SERVICES_AVAILABLE>
	                        	<SERVICE>
	                            	<NAME>ALLOWSCHQBKPRINT</NAME>
	                                <VALUE>NONE</VALUE>	
	                        	</SERVICE>
	                        	<SERVICE>
	                            	<NAME>ALLOWSCASHIERCHQPRINT</NAME>
	                                <VALUE>NONE</VALUE>	
	                        	</SERVICE>
	                        	<SERVICE>
	                            	<NAME>CHQPRINTZONE</NAME>
	                                <VALUE>NONE</VALUE>	
	                        	</SERVICE>                        	
	                    	</SERVICES_AVAILABLE>
                        </ns0:consultaAgenciasBancoResponseRecordType>
                }
            </ns0:consultaAgenciasBancoResponseType>
        </ns0:consultaAgenciasBancoResponse>
};

declare variable $opConsultaAgenciasRespuesta as element(ns3:opConsultaAgenciasRespuesta) external;

xf:consultaAgenciasBancoNIOut($opConsultaAgenciasRespuesta)