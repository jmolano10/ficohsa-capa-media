xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/TSP/registrarCobroTSP/xsd/registroCobroSP_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registroCobroSP";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/registroCobroTSPIn/";

declare function xf:registroCobroTSPIn($message as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
             {
	            let $messageList := fn:tokenize($message,"@FM")
	            return (
	            <ns0:PV_ID_TRANSACCION>{ $messageList[1] }</ns0:PV_ID_TRANSACCION>,
	            <ns0:PV_CODIGO_TIPO_TRANS>{ $messageList[2] }</ns0:PV_CODIGO_TIPO_TRANS>,
	            <ns0:PV_STMT>{ $messageList[3] }</ns0:PV_STMT>,
	            <ns0:PV_ID_CUENTA>{ $messageList[4] }</ns0:PV_ID_CUENTA>,
	            <ns0:PV_ID_CLIENTE>{ $messageList[5] }</ns0:PV_ID_CLIENTE>,
	            <ns0:PV_MONEDA>{ $messageList[6] }</ns0:PV_MONEDA>,
	            <ns0:PV_FECHA>{ $messageList[7] }</ns0:PV_FECHA>,
	            <ns0:PV_MOTIVO></ns0:PV_MOTIVO>,
	            <ns0:PV_MONTO>{ $messageList[8] }</ns0:PV_MONTO>,
	            <ns0:PV_MONTO_TSP>{ $messageList[9] }</ns0:PV_MONTO_TSP>
	            )
	        }
        </ns0:InputParameters>
};

declare variable $message as xs:string external;

xf:registroCobroTSPIn($message)