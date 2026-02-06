xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns0:procesaMensajeGenericoT24" location="../xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/FPC/pagoRetiroFPC/xsd/PAGO_RETIRO_FPC_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/PAGO_RETIRO_FPC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/pagoRetiroFPCIn/";

declare function xf:pagoRetiroFPCIn($procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
	            let $messageList := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
	            return (
		            <ns1:P_NUM_SOLICITUD>{ $messageList[1] }</ns1:P_NUM_SOLICITUD>,
		            <ns1:P_MONEDA_P>{ $messageList[2] }</ns1:P_MONEDA_P>,
		            <ns1:P_MONTO_P>{ $messageList[3] }</ns1:P_MONTO_P>,
		            <ns1:P_USU_PAGO>{ $messageList[4] }</ns1:P_USU_PAGO>,
		            <ns1:P_FEC_PAGO>{ xs:date($messageList[5]) }</ns1:P_FEC_PAGO>,
		            <ns1:P_TRANSACCION>{ $messageList[6] }</ns1:P_TRANSACCION>
		        )
	        }
        </ns1:InputParameters>
};

declare variable $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24) external;

xf:pagoRetiroFPCIn($procesaMensajeGenericoT24)