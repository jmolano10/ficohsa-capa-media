(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EnvioMensajeSMSFacade/xq/EnvioSMSOUT/";

declare function xf:EnvioSMSOUT($sessionId as xs:string,
    $errorCode as xs:string,
    $messageId as xs:string,
    $validationMessage as xs:string,
    $transactionId as xs:string)
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
            {
        		if($errorCode != 'Success')then(
        		
        			<MESSAGE>{fn:concat($errorCode, '|', $messageId ,'|',$validationMessage)}</MESSAGE>
        			
        		)else(
        		
        			<MESSAGE>{ fn:concat($errorCode) }</MESSAGE>
        			
        		)
        	}
        	
        </ns0:procesaMensajeGenericoT24Response>
};

declare variable $sessionId as xs:string external;
declare variable $errorCode as xs:string external;
declare variable $messageId as xs:string external;
declare variable $validationMessage as xs:string external;
declare variable $transactionId as xs:string external;

xf:EnvioSMSOUT($sessionId,
    $errorCode,
    $messageId,
    $validationMessage,
    $transactionId)