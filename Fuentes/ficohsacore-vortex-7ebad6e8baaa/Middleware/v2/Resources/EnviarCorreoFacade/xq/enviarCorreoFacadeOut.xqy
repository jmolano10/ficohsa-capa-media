xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$enviarCorreoResponse" element="ns0:enviarCorreoResponse" location="../../OperacionesCorreoElectronico/xsd/operacionesCorreoElectronicoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesCorreoElectronicoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EnviarCorreoFacade/xq/enviarCorreoFacadeOut/";

declare function xf:enviarCorreoFacadeOut($transactionId as xs:string,
    $sessionId as xs:string,
    $errorCode as xs:string,
    $validationMessage as xs:string,
    $enviarCorreoResponse as element(ns0:enviarCorreoResponse))
    as element(ns1:procesaMensajeGenericoT24Response) {
        <ns1:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
            {
               if(upper-case($errorCode) = "SUCCESS")then(
                 <MESSAGE>{ 
            			concat(
            			'Success||',
            			$enviarCorreoResponse/ID_SENT_EMAIL ,
            			'@FM',
            			$enviarCorreoResponse/MESSAGE ,
            			'@FM',
            			$enviarCorreoResponse/DATE_ADD_SENT_EMAIL
            			)
            		}</MESSAGE>
               )else(
			     	<MESSAGE>{concat('ERROR||', $validationMessage,'@FM')}</MESSAGE>
			     )
            }
        </ns1:procesaMensajeGenericoT24Response>
};

declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;
declare variable $errorCode as xs:string external;
declare variable $validationMessage as xs:string external;
declare variable $enviarCorreoResponse as element(ns0:enviarCorreoResponse) external;

xf:enviarCorreoFacadeOut($transactionId,
    $sessionId,
    $errorCode,
    $validationMessage,
    $enviarCorreoResponse)