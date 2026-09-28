(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT241" element="ns0:procesaMensajeGenericoT24" location="../xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:envioTransferenciasACH" location="../../EnvioTransferenciasACH/xsd/envioTransferenciasACHTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/envioTransferenciasACHTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/envioTransferenciasACHIn/";

declare function xf:envioTransferenciasACHIn($procesaMensajeGenericoT241 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:envioTransferenciasACH) {
        <ns1:envioTransferenciasACH>
        { 
        	let $messageList := fn:tokenize(data($procesaMensajeGenericoT241/MESSAGE),"@FM") 
        	return (
        		<BANK_ID>{ $messageList[1] }</BANK_ID>,
        		<TRANSACTION>
        			<DESCRIPTION>{ $messageList[2] }</DESCRIPTION>
        			<REFERENCE>{ $messageList[3] }</REFERENCE>
        			<CURRENCY>{ $messageList[13] }</CURRENCY>
        			<AMOUNT>{ $messageList[12] }</AMOUNT>
        		</TRANSACTION>,
        		<ORIGINATOR>
        			<ID>{ $messageList[4] }</ID>
        			<ACCOUNT>{ $messageList[5] }</ACCOUNT>
        			<ACCOUNT_TYPE>{ $messageList[6] }</ACCOUNT_TYPE>
        			<NAME>{ $messageList[7] }</NAME>
        		</ORIGINATOR>,
        		<BENEFICIARY>
        			<ID>{ $messageList[8] }</ID>
        			<ACCOUNT>{ $messageList[9] }</ACCOUNT>
        			<ACCOUNT_TYPE>{ $messageList[10] }</ACCOUNT_TYPE>
        			<NAME>{ $messageList[11] }</NAME>
        		</BENEFICIARY>
        	)
        }
        </ns1:envioTransferenciasACH>
};

declare variable $procesaMensajeGenericoT241 as element(ns0:procesaMensajeGenericoT24) external;

xf:envioTransferenciasACHIn($procesaMensajeGenericoT241)