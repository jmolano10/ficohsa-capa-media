xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns0:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaFinanciamientosCliente" location="../../ConsultaFinanciamientosCliente/xsd/consultaFinanciamientosClienteTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaFinanciamientosClienteTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFinanciamientosClienteFacade/xq/consultaFinanciamientosClienteFacadeT24In/";

declare function xf:consultaFinanciamientosClienteFacadeT24In($procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:consultaFinanciamientosCliente) {
        <ns1:consultaFinanciamientosCliente>
        	{
        		let $messageListFM := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
        		return(
	        			<SEARCH_VALUE>{ $messageListFM[2] }</SEARCH_VALUE>,
	            		<SEARCH_CRITERIA>{ $messageListFM[1] }</SEARCH_CRITERIA>,
	            		if($messageListFM[3] != "")then(
	            			<LOGO>{ $messageListFM[3] }</LOGO>
	            		)else(),
	            		if($messageListFM[4] != "") then (
	            			<PRODUCT_TYPE>{ $messageListFM[4] }</PRODUCT_TYPE>
	            		) else()
            	)
        	}            
        </ns1:consultaFinanciamientosCliente>
};

declare variable $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24) external;

xf:consultaFinanciamientosClienteFacadeT24In($procesaMensajeGenericoT24)