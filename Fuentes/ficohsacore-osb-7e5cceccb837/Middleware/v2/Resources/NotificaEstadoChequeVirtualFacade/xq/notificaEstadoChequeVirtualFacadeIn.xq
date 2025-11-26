xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns0:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:notificaEstadoChequeVirtual" location="../../NotificaEstadoChequeVirtual/xsd/notificaEstadoChequeVirtualTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaEstadoChequeVirtualFacade/xq/notificaEstadoChequeVirtualFacadeIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/notificaEstadoChequeVirtualTypes";

declare function xf:notificaEstadoChequeVirtualFacadeIn($procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:notificaEstadoChequeVirtual) {
        <ns1:notificaEstadoChequeVirtual>
            {
	            let $messageList := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
	            return (
		            <ID_RECORD_REF>{ $messageList[1] }</ID_RECORD_REF>,
		            <USER_CODE>{ $messageList[2] }</USER_CODE>,
					<CHEQUE_NO>{ $messageList[3] }</CHEQUE_NO>,
					<CURRENCY>{ $messageList[4] }</CURRENCY>,
					<AMOUNT>{ $messageList[5] }</AMOUNT>,
					<DATE_TIME>{ $messageList[6] }</DATE_TIME>,
					<ISSUING_BANK>{ $messageList[7] }</ISSUING_BANK>,
					<STATUS>{ $messageList[8] }</STATUS>,
					<MESSAGE>{ $messageList[9] }</MESSAGE>
		        )
	        }
        </ns1:notificaEstadoChequeVirtual>
};

declare variable $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24) external;

xf:notificaEstadoChequeVirtualFacadeIn($procesaMensajeGenericoT24)
