xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../../../../v2/Resources/ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ValidacionOverlimitFacade/xq/validacionOverlimitT24Out/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";

declare function xf:validacionOverlimitT24Out($transactionId as xs:string,
    $sessionId as xs:string,
    $errorCode as xs:string,
    $validationMessage as xs:string,
    $clientId as xs:string)
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
            {
            	if(upper-case($errorCode) = "" and $validationMessage = "")then(	
            	
		            <MESSAGE>{ 
		            	concat(
		            		'SUCCESS||MESSAGES',
		            		'@FM',
		            		$clientId  
		            	) 
		            }
		            </MESSAGE>	
		            
            	)else if(upper-case($errorCode) = "" and $validationMessage = 'OVL001 MONTO A PAGAR EXCEDE EL LIMITE PERMITIDO')then(
				   <MESSAGE>{ 
		            	concat(
		            		'ERROR||MESSAGES',
		            		'@FMCliente excede el limite permitido para pagos con venta de divisas'  
		            	) 
		            }
		            </MESSAGE>
				)else if(upper-case($errorCode) = "" and $validationMessage = 'NO ES PERMITIDO EFECTUAR UN PAGO MAYOR AL MONTO ADEUDADO.')then(
				   <MESSAGE>{ 
		            	concat(
		            		'ERROR||MESSAGES',
		            		'@FMNo es permitido efectuar un pago mayor al monto adeudado'  
		            	) 
		            }
		            </MESSAGE>
				     )else(
				     	<MESSAGE>{concat('SYSTEMERROR||', 'El sistema de validacion de saldos no se encuentra disponbile@FM', $validationMessage)}</MESSAGE>
				     )
	            }
        </ns0:procesaMensajeGenericoT24Response>
};

declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;
declare variable $errorCode as xs:string external;
declare variable $validationMessage as xs:string external;
declare variable $clientId as xs:string external;

xf:validacionOverlimitT24Out($transactionId,
    $sessionId,
    $errorCode,
    $validationMessage,
    $clientId)