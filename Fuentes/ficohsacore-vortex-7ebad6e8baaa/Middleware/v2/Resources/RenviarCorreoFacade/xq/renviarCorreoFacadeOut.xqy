xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$renviarCorreoResponse" element="ns0:renviarCorreoResponse" location="../../OperacionesCorreoElectronico/xsd/operacionesCorreoElectronicoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RenviarCorreoFacade/xq/renviarCorreoFacadeOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesCorreoElectronicoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";

declare function xf:renviarCorreoFacadeOut($transactionId as xs:string,
    $sessionId as xs:string,
    $errorCode as xs:string,
    $validationMessage as xs:string, $renviarCorreoResponse as element(ns0:renviarCorreoResponse))
    as element(ns1:procesaMensajeGenericoT24Response) {
        <ns1:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
            {
               if(upper-case($errorCode) = "SUCCESS")then(
                 <MESSAGE>{ 
            			concat(
            			'Success||',
            			$renviarCorreoResponse/ID_SENT_EMAIL ,
            			'@FM',
            			$renviarCorreoResponse/MESSAGE_SENT_EMAIL ,
            			'@FM',
            			$renviarCorreoResponse/DATE_ADD_SENT_EMAIL
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
declare variable $renviarCorreoResponse as element(ns0:renviarCorreoResponse) external;

xf:renviarCorreoFacadeOut($transactionId,
    $sessionId,
    $errorCode,
    $validationMessage,$renviarCorreoResponse)