xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT241" element="ns0:procesaMensajeGenericoT24" location="../xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABK/actualizaNombreCliente/xsd/actualizaNombreCliente_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizaNombreCliente";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/actualizaNombreClienteIN/";

declare function xf:actualizaNombreClienteIN($procesaMensajeGenericoT241 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {           
            let $messageList := fn:tokenize(data($procesaMensajeGenericoT241/MESSAGE),"@FM")
	            return (		    
		    			<ns1:CUENTA>{ data($messageList[2]) }</ns1:CUENTA>,
		    			<ns1:NOMBRE>{ data($messageList[3]) }</ns1:NOMBRE>
		        )
            
            }
        </ns1:InputParameters>
};

declare variable $procesaMensajeGenericoT241 as element(ns0:procesaMensajeGenericoT24) external;

xf:actualizaNombreClienteIN($procesaMensajeGenericoT241)