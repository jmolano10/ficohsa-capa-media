xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$opConsultaComisionesRespuesta" element="ns1:opConsultaComisionesRespuesta" location="../../../BusinessServices/CTS/cuenta/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaComisiones/xq/consultaComisionesNIHeaderOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns1 = "http://service.srvaplcobiscuenta.ecobis.cobiscorp";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://dto2.commons.ecobis.cobiscorp";

declare function xf:consultaComisionesNIHeaderOut($opConsultaComisionesRespuesta as element(ns1:opConsultaComisionesRespuesta))
    as element(ns0:ResponseHeader) {
         <ns0:ResponseHeader>
        	 {
           		if (fn:string($opConsultaComisionesRespuesta/ns2:contextoRespuesta/ns2:codTipoRespuesta/text()) = ("0","00")) then (
	                  	<successIndicator>Success</successIndicator>
	        		)
			    else
				    ( 
	        	   		<successIndicator> {data($opConsultaComisionesRespuesta/ns2:contextoRespuesta/ns2:codTipoRespuesta)}</successIndicator>, 
	               		<messages> {data($opConsultaComisionesRespuesta/ns2:contextoRespuesta/ns2:valDescripcionRespuesta)} </messages>
		            )
            }
        </ns0:ResponseHeader>
};

declare variable $opConsultaComisionesRespuesta as element(ns1:opConsultaComisionesRespuesta) external;

xf:consultaComisionesNIHeaderOut($opConsultaComisionesRespuesta)
