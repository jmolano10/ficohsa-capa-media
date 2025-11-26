(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns0:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaEventosT24Facade/notificaEventosT24Out/";

declare function xf:notificaEventosT24Out($procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24),
    $successIndicator as xs:string,
    $messageId as xs:string,
    $messages as xs:string)
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ data($procesaMensajeGenericoT24/TRANSACTION_ID) }</TRANSACTION_ID>
            <SESSION_ID>{ data($procesaMensajeGenericoT24/SESSION_ID) }</SESSION_ID>
            {
            	if(string($messageId) = '' and string($messages) = '')then(
                 	<MESSAGE>{ $successIndicator }</MESSAGE>
                )elseif(string($messageId) = '') then(
                	<MESSAGE>{ concat($successIndicator, '|' , $messages) }</MESSAGE>
                )elseif(string($messages) = '') then(
                	<MESSAGE>{ concat($successIndicator, '|' , $messageId) }</MESSAGE>
                )else(
                	<MESSAGE>{ concat($successIndicator, '|' , $messageId , '|' , $messages) }</MESSAGE>
                )
            }
        </ns0:procesaMensajeGenericoT24Response>
};

declare variable $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24) external;
declare variable $successIndicator as xs:string external;
declare variable $messageId as xs:string external;
declare variable $messages as xs:string external;

xf:notificaEventosT24Out($procesaMensajeGenericoT24,
    $successIndicator,
    $messageId,
    $messages)