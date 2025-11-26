(:: pragma bea:global-element-parameter parameter="$actualizaTasaReferenciaResponse" element="ns0:actualizaTasaReferenciaResponse" location="../../ActualizaTasaReferencia/xsd/actualizaTasaReferenciaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/actualizaTasaReferenciaTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaTasaReferenciaFacade/xq/actualizaTasaReferenciaFacadeOut/";

declare function xf:actualizaTasaReferenciaFacadeOut($actualizaTasaReferenciaResponse as element(ns0:actualizaTasaReferenciaResponse),
    $transactionId as xs:string,
    $sessionId as xs:string,
    $errorCode as xs:string,
    $message as xs:string)
    as element(ns1:procesaMensajeGenericoT24Response) {
        <ns1:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
        	<MESSAGE>
        	{ 
                if(upper-case($errorCode) = 'SUCCESS')then(
	            	concat(	
	            			$errorCode,
	            			'||',
				            $actualizaTasaReferenciaResponse/COUNTRY, 
	            			'@FM', 
	            			$actualizaTasaReferenciaResponse/RATE, 
	            			'@FM', 
	            			$actualizaTasaReferenciaResponse/SOURCE_CURRENCY, 
	            			'@FM', 
	            			$actualizaTasaReferenciaResponse/TARGET_CURRENCY)
            	)else(
            		concat(	
	            			$errorCode,
	            			'|',
	            			$message
            		)
            	)
            }
            </MESSAGE>
        </ns1:procesaMensajeGenericoT24Response>
};

declare variable $actualizaTasaReferenciaResponse as element(ns0:actualizaTasaReferenciaResponse) external;
declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;
declare variable $errorCode as xs:string external;
declare variable $message as xs:string external;

xf:actualizaTasaReferenciaFacadeOut($actualizaTasaReferenciaResponse,
    $transactionId,
    $sessionId,
    $errorCode,
    $message)