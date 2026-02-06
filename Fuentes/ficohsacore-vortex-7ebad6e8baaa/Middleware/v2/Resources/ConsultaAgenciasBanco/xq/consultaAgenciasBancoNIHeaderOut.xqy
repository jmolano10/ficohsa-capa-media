xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opConsultaAgenciasRespuesta" element="ns3:opConsultaAgenciasRespuesta" location="../../../BusinessServices/CTS/generalService/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaAgenciasBanco/xq/consultaAgenciasBancoNIHeaderOut/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://service.srvaplcobisgenerales.ecobis.cobiscorp";

declare function xf:consultaAgenciasBancoNIHeaderOut($opConsultaAgenciasRespuesta as element(ns3:opConsultaAgenciasRespuesta))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                let $codTipoRespuesta := string($opConsultaAgenciasRespuesta/ns1:contextoRespuesta/ns1:codTipoRespuesta/text())
                return
                	if($codTipoRespuesta = ('0', '00'))then(
                		let $valTipoOficina := string($opConsultaAgenciasRespuesta/ns1:oficina[1]/ns1:valTipoOficina/text())
                		let $codOficina := string($opConsultaAgenciasRespuesta/ns1:oficina[1]/ns1:codOficina/text())
                		return
                		if($valTipoOficina = "" and $codOficina = "")then(
                			<successIndicator>NO RECORDS</successIndicator>,
		                    <messages>No se encontro ningun registro</messages>
                		)else(
                			<successIndicator>Success</successIndicator>
                		)
                	)else(
                		<successIndicator>{ $codTipoRespuesta }</successIndicator>,
	                    <messages>
	                    {
	                    	let $valDescripcionRespuesta := string($opConsultaAgenciasRespuesta/ns1:contextoRespuesta/ns1:valDescripcionRespuesta/text())
		                	return
	                    	if($valDescripcionRespuesta = "")then(
	                    		"No se encontro ningun registro"
	                    	)else(
	                    		$valDescripcionRespuesta
	                    	)
	                    }
	                    </messages>
                	)   
            }
        </ns0:ResponseHeader>
};

declare variable $opConsultaAgenciasRespuesta as element(ns3:opConsultaAgenciasRespuesta) external;

xf:consultaAgenciasBancoNIHeaderOut($opConsultaAgenciasRespuesta)