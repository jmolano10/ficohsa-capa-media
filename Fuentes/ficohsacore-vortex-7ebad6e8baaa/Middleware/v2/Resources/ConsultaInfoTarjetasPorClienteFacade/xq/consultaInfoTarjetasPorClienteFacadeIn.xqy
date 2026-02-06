xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns0:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaInfoTarjetasPorCliente" location="../xsd/consultaInfoTarjetasPorClienteTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaInfoTarjetasPorCliente/xq/consultaInfoTarjetasPorClienteFacadeIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaInfoTarjetasPorClienteTypes";

declare function xf:consultaInfoTarjetasPorClienteFacadeIn($procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:consultaInfoTarjetasPorCliente) {
        <ns1:consultaInfoTarjetasPorCliente>
            {
            	let $messageListFM := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
        		return(
        			<CUSTOMER_ID_TYPE>{ data($messageListFM[1]) }</CUSTOMER_ID_TYPE>,
		            <CUSTOMER_ID_VALUE>{ data($messageListFM[2]) }</CUSTOMER_ID_VALUE>
		        )
            }        	
        </ns1:consultaInfoTarjetasPorCliente>
};

declare variable $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24) external;

xf:consultaInfoTarjetasPorClienteFacadeIn($procesaMensajeGenericoT24)