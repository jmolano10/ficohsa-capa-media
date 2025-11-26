(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns0:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaPasivosClienteRequest" location="../../../../Business_Resources/consultasCliente/Resources/consultaClientesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPasivosClienteFacade/xq/consultaPasivosClienteIn/";

declare function xf:consultaPasivosClienteIn($procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:consultaPasivosClienteRequest) {
        <ns1:consultaPasivosClienteRequest>
        {
        	let $messageListFM := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
        	return(
	            <CUSTOMER_ID>{ $messageListFM[1] }</CUSTOMER_ID>,
	            <LIABILITY_TYPE>{ $messageListFM[2] }</LIABILITY_TYPE>
            
            )
        }
        </ns1:consultaPasivosClienteRequest>
};

declare variable $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24) external;

xf:consultaPasivosClienteIn($procesaMensajeGenericoT24)
