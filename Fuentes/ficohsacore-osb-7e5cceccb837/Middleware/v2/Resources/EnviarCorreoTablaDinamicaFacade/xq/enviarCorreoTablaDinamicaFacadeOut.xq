(:: pragma bea:global-element-parameter parameter="$enviarCorreoTablaDinamicaResponse" element="ns0:enviarCorreoTablaDinamicaResponse" location="../../OperacionesCorreoElectronico/xsd/operacionesCorreoElectronicoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesCorreoElectronicoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EnviarCorreoTablaDinamicaFacade/xq/enviarCorreoTablaDinamicaFacadeOut/";

declare function xf:enviarCorreoTablaDinamicaFacadeOut($transactionId as xs:string,
    $sessionId as xs:string,
    $errorCode as xs:string,
    $validationMessage as xs:string,
    $enviarCorreoTablaDinamicaResponse as element(ns0:enviarCorreoTablaDinamicaResponse))
    as element(ns1:procesaMensajeGenericoT24Response) {
        <ns1:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
            {
               if(upper-case($errorCode) = "SUCCESS")then(
                 <MESSAGE>{ 
            			concat(
            			'Success||',
            			$enviarCorreoTablaDinamicaResponse/ID_SENT_EMAIL ,
            			'@FM',
            			$enviarCorreoTablaDinamicaResponse/MESSAGE ,
            			'@FM',
            			$enviarCorreoTablaDinamicaResponse/DATE_ADD_SENT_EMAIL
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
declare variable $enviarCorreoTablaDinamicaResponse as element(ns0:enviarCorreoTablaDinamicaResponse) external;

xf:enviarCorreoTablaDinamicaFacadeOut($transactionId,
    $sessionId,
    $errorCode,
    $validationMessage,
    $enviarCorreoTablaDinamicaResponse)
