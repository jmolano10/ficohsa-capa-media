xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$gestionesGenericasCRMResponse" element="ns1:gestionesGenericasCRMResponse" location="../GestionesGenericasCRM/xsd/gestionesGenericasCRMTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionesGenericasCRMTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelaIntraExtraPOSFacade/cancelaIntraExtraPOSFacadeOut/";

declare function xf:cancelaIntraExtraPOSFacadeOut($transactionId as xs:string,
    $sessionId as xs:string,
    $errorCode as xs:string,
    $validationMessage as xs:string,
    $gestionesGenericasCRMResponse as element(ns1:gestionesGenericasCRMResponse))
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
            {
            	if(upper-case($errorCode) = "SUCCESS") then(
            		<MESSAGE>{ concat('Success||', $gestionesGenericasCRMResponse/REFERENCE_ID) }</MESSAGE>
            	) else if (upper-case($errorCode) = "NO RECORDS") then (
            		<MESSAGE>ERROR|No se encontraron registros</MESSAGE>
            	) else (
            		<MESSAGE>{concat('ERROR|', $validationMessage)}</MESSAGE>
            	)
            }         
        </ns0:procesaMensajeGenericoT24Response>
};

declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;
declare variable $errorCode as xs:string external;
declare variable $validationMessage as xs:string external;
declare variable $gestionesGenericasCRMResponse as element(ns1:gestionesGenericasCRMResponse) external;

xf:cancelaIntraExtraPOSFacadeOut($transactionId,
    $sessionId,
    $errorCode,
    $validationMessage,
    $gestionesGenericasCRMResponse)