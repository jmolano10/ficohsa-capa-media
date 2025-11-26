xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$verificarEnvioCorreoResponse" element="ns0:verificarEnvioCorreoResponse" location="../../OperacionesCorreoElectronico/xsd/operacionesCorreoElectronicoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VerificarEnvioCorreoFacade/xq/verificarEnvioCorreoFacadeOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesCorreoElectronicoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";

declare function xf:verificarEnvioCorreoFacadeOut($transactionId as xs:string,
    $sessionId as xs:string,
    $errorCode as xs:string,
    $validationMessage as xs:string, $verificarEnvioCorreoResponse as element(ns0:verificarEnvioCorreoResponse))
    as element(ns1:procesaMensajeGenericoT24Response) {
                <ns1:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
            {
               if(upper-case($errorCode) = "SUCCESS")then(
                 <MESSAGE>{ 
            			concat(
            			'Success||',
            			$verificarEnvioCorreoResponse/ID_SENT_EMAIL ,
            			'@FM',
            			$verificarEnvioCorreoResponse/EMAIL_SUBJECT ,
            			'@FM',
            			$verificarEnvioCorreoResponse/EMAIL_STATUS,
            			'@FM',
            			$verificarEnvioCorreoResponse/MESSAGE_STATUS ,
            			'@FM',
            			$verificarEnvioCorreoResponse/DATE_SENT_EMAIL
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
declare variable $verificarEnvioCorreoResponse as element(ns0:verificarEnvioCorreoResponse) external;

xf:verificarEnvioCorreoFacadeOut($transactionId,
    $sessionId,
    $errorCode,
    $validationMessage,$verificarEnvioCorreoResponse)
