xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaMontoTSPCliente" location="../../ConsultaMontoTSP/xsd/consultaMontoTSPTransferenciaTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaMontoTSPTransferenciaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/consMontoTSPIn/";

declare function xf:consMontoTSPIn($requestHeader1 as element(ns1:RequestHeader),
    $message as xs:string)
    as element(ns0:consultaMontoTSPCliente) {
        <ns0:consultaMontoTSPCliente>
        {
        	let $messageList := fn:tokenize($message,"@FM")
        	return(
            		<TRANSACTION_TYPE_CODE>{ $messageList[1]}</TRANSACTION_TYPE_CODE>,
            		<TRANSACTION_ID>{ $messageList[2]}</TRANSACTION_ID>,
            		<TRANSACTION_REFERENCE>{ $messageList[3]}</TRANSACTION_REFERENCE>,
            		<TRANSACTION_CUSTOMER_ID>{ $messageList[4]}</TRANSACTION_CUSTOMER_ID>,
            		<TRANSACTION_ACCOUNT_NUMBER>{ $messageList[5]}</TRANSACTION_ACCOUNT_NUMBER>,
            		<TRANSACTION_AMOUNT>{ $messageList[6]}</TRANSACTION_AMOUNT>,
            		<TRANSACTION_CURRENCY>{ $messageList[7]}</TRANSACTION_CURRENCY>,
            		<TRANSACTION_DATE>{ $messageList[8]}</TRANSACTION_DATE>,
            		<DESTINATION_CUSTOMER_ID>{ $messageList[9]}</DESTINATION_CUSTOMER_ID>,
            		<DESTINATION_ACCOUNT_NUMBER>{ $messageList[10]}</DESTINATION_ACCOUNT_NUMBER>,
            		<DESTINATION_CURRENCY>{ $messageList[11]}</DESTINATION_CURRENCY>,
            		<AGREEMENT_ID>{ $messageList[12]}</AGREEMENT_ID>
            	)
        }
        </ns0:consultaMontoTSPCliente>
};

declare variable $requestHeader1 as element(ns1:RequestHeader) external;
declare variable $message as xs:string external;

xf:consMontoTSPIn($requestHeader1,
    $message)