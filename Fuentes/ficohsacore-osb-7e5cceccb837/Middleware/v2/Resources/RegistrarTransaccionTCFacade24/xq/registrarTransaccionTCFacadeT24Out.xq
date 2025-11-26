(:: pragma bea:global-element-parameter parameter="$registrarTransaccionTCResponse" element="ns1:RegistrarTransaccionTCResponse" location="../../RegistrarTransaccionTC/xsd/RegistrarTransaccionTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/RegistrarTransaccionTCTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistrarTransaccionTCFacade24/xq/registrarTransaccionTCFacadeT24Out/";

declare function xf:registrarTransaccionTCFacadeT24Out($transactionId as xs:string,
    $sessionId as xs:string,
    $errorCode as xs:string,
    $validationMessage as xs:string,
    $registrarTransaccionTCResponse as element(ns1:RegistrarTransaccionTCResponse))
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
            {
            	if(upper-case($errorCode) = "SUCCESS")then(	
            	
		            	<MESSAGE>{ 
		            	concat(
		            		'SUCCESS||MESSAGES',
		            		'@FM',
		            		$registrarTransaccionTCResponse/TRANSACTION_AUT , 
		            		'@FM',
		            		$registrarTransaccionTCResponse/DATE_TIMEAUT ,
		            		'@FM',
		            		$registrarTransaccionTCResponse/DATETIME_CORE ,
		            		'@FM',
		            		$registrarTransaccionTCResponse/REFERENCE_NUMBER ,
		            		'@FM',
		            		$registrarTransaccionTCResponse/MESSAGES_CORE 
		            	) 
		            }
		            </MESSAGE>
            
            )else if(upper-case($errorCode) = "NO RECORDS")then(
			     	<MESSAGE>ERROR|No se encontraron registros</MESSAGE>
			     )else(
			     	<MESSAGE>{concat('ERROR|', $validationMessage)}</MESSAGE>
			     )
            }
            
            
        </ns0:procesaMensajeGenericoT24Response>
};

declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;
declare variable $errorCode as xs:string external;
declare variable $validationMessage as xs:string external;
declare variable $registrarTransaccionTCResponse as element(ns1:RegistrarTransaccionTCResponse) external;

xf:registrarTransaccionTCFacadeT24Out($transactionId,
    $sessionId,
    $errorCode,
    $validationMessage,
    $registrarTransaccionTCResponse)