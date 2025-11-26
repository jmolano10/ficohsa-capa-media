(:: pragma bea:global-element-parameter parameter="$obtenerRemesaResponse" element="ns1:obtenerRemesaResponse" location="../../ObtenerRemesa/xsd/obtenerRemesaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/obtenerRemesaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ObtenerRemesaFacade/xq/obtenerRemesaFacadeOut/";

declare function xf:obtenerRemesaFacadeOut($obtenerRemesaResponse as element(ns1:obtenerRemesaResponse),
    $transactionId as xs:string,
    $sessionId as xs:string,
    $errorCode as xs:string,
    $message as xs:string)
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
        	<MESSAGE>
        	{ 
	            if(upper-case($errorCode) = 'SUCCESS')then(
	             	concat(	
	            			$errorCode,
	            			'||',
		            		$obtenerRemesaResponse/DEBIT_ACCOUNT, 
		            		'@FM',
			            	$obtenerRemesaResponse/BENEFICIARY_NAMES, 
			            	'@FM',
			            	$obtenerRemesaResponse/BENEFICIARY_SURNAMES, 
			            	'@FM',
			            	$obtenerRemesaResponse/DESTINATION_COUNTRY, 
			            	'@FM',
			            	$obtenerRemesaResponse/DESTINATION_STATE, 
			            	'@FM',
			            	$obtenerRemesaResponse/DESTINATION_CITY, 
			            	'@FM',
			            	$obtenerRemesaResponse/REMITTER_NAMES, 
			            	'@FM',
			            	$obtenerRemesaResponse/REMITTER_SURNAMES, 
			            	'@FM',
			            	$obtenerRemesaResponse/REMITTER_ID_TYPE, 
			            	'@FM',
			            	$obtenerRemesaResponse/REMITTER_ID_NUMBER, 
			            	'@FM',
			            	$obtenerRemesaResponse/REMITTER_ADDRESS, 
			            	'@FM',
			            	$obtenerRemesaResponse/REMITTER_PHONE, 
			            	'@FM',
			            	$obtenerRemesaResponse/EXCHANGE_RATE, 
			            	'@FM',
			            	$obtenerRemesaResponse/ORIGIN_CURRENCY, 
			            	'@FM',
			            	$obtenerRemesaResponse/SHIPPING_AMOUNT, 
			            	'@FM',
			            	$obtenerRemesaResponse/CHARGE_APPLIED, 
			            	'@FM',
			            	$obtenerRemesaResponse/GENERIC1, 
			            	'@FM',
			            	$obtenerRemesaResponse/GENERIC2
			          	)
			    )else(
			        concat(	
	            			$errorCode,
	            			'|',
	            			$message
	            	)
	            )
           }
           </MESSAGE>
        </ns0:procesaMensajeGenericoT24Response>
};

declare variable $obtenerRemesaResponse as element(ns1:obtenerRemesaResponse) external;
declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;
declare variable $errorCode as xs:string external;
declare variable $message as xs:string external;

xf:obtenerRemesaFacadeOut($obtenerRemesaResponse,
    $transactionId,
    $sessionId,
    $errorCode,
    $message)