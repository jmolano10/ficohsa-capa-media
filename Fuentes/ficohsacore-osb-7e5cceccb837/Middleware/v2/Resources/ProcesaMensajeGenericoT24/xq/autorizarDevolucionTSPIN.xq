(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT241" element="ns1:procesaMensajeGenericoT24" location="../xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/TSP/AutorizarDevolucionTSP/xsd/autorizarDevolucionTSP_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/autorizarDevolucionTSP";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/autorizarDevolucionTSPIN/";

declare function xf:autorizarDevolucionTSPIN($procesaMensajeGenericoT241 as element(ns1:procesaMensajeGenericoT24))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
             {
	            let $messageList := fn:tokenize(data($procesaMensajeGenericoT241/MESSAGE),"@FM")
	            return (
		            <ns0:PV_ID_TRANSACCION>{ $messageList[2] }</ns0:PV_ID_TRANSACCION>,
		            <ns0:PV_REF_FT_TT_COBRO>{ $messageList[3] }</ns0:PV_REF_FT_TT_COBRO>,
		            <ns0:PV_USUARIO>{ $messageList[4] }</ns0:PV_USUARIO>,
		            <ns0:PV_USER_AUT>{ $messageList[5] }</ns0:PV_USER_AUT>
		        )
	        }            
        </ns0:InputParameters>
};

declare variable $procesaMensajeGenericoT241 as element(ns1:procesaMensajeGenericoT24) external;

xf:autorizarDevolucionTSPIN($procesaMensajeGenericoT241)