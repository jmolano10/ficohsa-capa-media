(:: pragma bea:global-element-parameter parameter="$opBuscarFechaSistemaRespuesta" element="ns1:opBuscarFechaSistemaRespuesta" location="../../../BusinessServices/CTS/generalService/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns2:ResponseHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://service.srvaplcobisgenerales.ecobis.cobiscorp";
declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFechaSistema/xq/consultaFechaSistemaNIHeaderOut/";

declare function xf:consultaFechaSistemaNIHeaderOut($opBuscarFechaSistemaRespuesta as element(ns1:opBuscarFechaSistemaRespuesta))
    as element(ns2:ResponseHeader) {
        <ns2:ResponseHeader>
        	{
        		if(fn:string($opBuscarFechaSistemaRespuesta/ns0:contextoRespuesta/ns0:codTipoRespuesta/text()) = "0") then (
        			<successIndicator>Success</successIndicator>
        		) else (        		
        			<successIndicator> 
	        			{
	        				fn:string($opBuscarFechaSistemaRespuesta/ns0:contextoRespuesta/ns0:codTipoRespuesta/text())        				
	    				}
    				</successIndicator>, 
    				<messages> 
	    				{
	    					fn:string($opBuscarFechaSistemaRespuesta/ns0:contextoRespuesta/ns0:valDescripcionRespuesta/text())
						}
					</messages>
        		)
        	}        	
        </ns2:ResponseHeader>
};

declare variable $opBuscarFechaSistemaRespuesta as element(ns1:opBuscarFechaSistemaRespuesta) external;

xf:consultaFechaSistemaNIHeaderOut($opBuscarFechaSistemaRespuesta)