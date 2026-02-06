xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns0:procesaMensajeGenericoT24" location="../xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/FPC/reversionRetiroFPC/xsd/REVERSION_RETIRO_FPC_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/REVERSION_RETIRO_FPC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/reversionRetiroFPCIn/";

declare function xf:reversionRetiroFPCIn($procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
	            let $messageList := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
	            return (
		            <ns1:P_TRANSACCION>{ $messageList[1] }</ns1:P_TRANSACCION>,
		            <ns1:P_NUM_CUENTA>{ $messageList[2] }</ns1:P_NUM_CUENTA>
		        )
	        }
        </ns1:InputParameters>
};

declare variable $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24) external;

xf:reversionRetiroFPCIn($procesaMensajeGenericoT24)