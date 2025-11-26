(:: pragma bea:global-element-parameter parameter="$generaMensajeSwiftResponse" element="ns1:generaMensajeSwiftResponse" location="../../GeneraMensajeSwift/xsd/generaMensajeSwiftTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)


declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraMensajeSwiftFacade/xq/generaMensajeSwiftFacadeOut/";

declare function xf:generaMensajeSwiftFacadeOut($referenceSwift as xs:string,
    $errorCode as xs:string,
    $validationMessage as xs:string,
    $transactionId as xs:string,
    $sessionId as xs:string,
    $messageId as xs:string,
    $uniqueReference as xs:string)
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
        
        	<TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
        	{
        		if($errorCode != 'Success')then(
        		
        			<MESSAGE>{fn:concat($errorCode, '|', $messageId ,'|',$validationMessage)}</MESSAGE>
        			
        		)else(
        		
        			<MESSAGE>{ fn:concat($errorCode, '|', $referenceSwift, '@FM', $uniqueReference) }</MESSAGE>
        			
        		)
        	}
        	
        </ns0:procesaMensajeGenericoT24Response>
};

declare variable $referenceSwift as xs:string external;
declare variable $errorCode as xs:string external;
declare variable $validationMessage as xs:string external;
declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;
declare variable $messageId as xs:string external;
declare variable $uniqueReference as xs:string external;

xf:generaMensajeSwiftFacadeOut($referenceSwift,
    $errorCode,
    $validationMessage,
    $transactionId,
    $sessionId,
    $messageId,
    $uniqueReference)
