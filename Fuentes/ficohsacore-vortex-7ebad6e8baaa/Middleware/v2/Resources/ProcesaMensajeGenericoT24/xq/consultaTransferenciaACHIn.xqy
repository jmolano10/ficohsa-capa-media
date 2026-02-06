xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns1:procesaMensajeGenericoT24" location="../xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaTransferenciasACH" location="../../ConsultaTransferenciasACH/xsd/consultaTransferenciasACHTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTransferenciasACHTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/consultaTransferenciaACHIn/";

declare function xf:consultaTransferenciaACHIn($procesaMensajeGenericoT24 as element(ns1:procesaMensajeGenericoT24))
    as element(ns0:consultaTransferenciasACH) {
        <ns0:consultaTransferenciasACH>
                { 
        	let $messageList := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM") 
        	return (
            <TRANSACTION_TYPE>{ $messageList[1] }</TRANSACTION_TYPE>,
            <TRANSACTION_CURRENCY>{ $messageList[2] }</TRANSACTION_CURRENCY>,
            <SEARCH_CRITERIA>{ $messageList[3] }</SEARCH_CRITERIA>,
            <SEARCH_VALUE>{ $messageList[4] }</SEARCH_VALUE>,
            <SEQUENCY_T24>{ $messageList[5] }</SEQUENCY_T24>,
            <UPDATE_BACKEND_YES_NO>{ $messageList[6] }</UPDATE_BACKEND_YES_NO>
                    	)
       			 }
        </ns0:consultaTransferenciasACH>
};

declare variable $procesaMensajeGenericoT24 as element(ns1:procesaMensajeGenericoT24) external;

xf:consultaTransferenciaACHIn($procesaMensajeGenericoT24)