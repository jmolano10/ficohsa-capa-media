(:: pragma bea:global-element-parameter parameter="$consultaDealResponse" element="ns1:consultaDealResponse" location="../../ConsultaDeal/xsd/consultaDealTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDealTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDealFacade/xq/consultaDealFacadeOut/";

declare function xf:consultaDealFacadeOut($consultaDealResponse as element(ns1:consultaDealResponse),
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
		            		$consultaDealResponse/CONTRACT_ID, 
		            		'@FM',
			            	$consultaDealResponse/COUNTRY, 
			            	'@FM',
			            	$consultaDealResponse/CUSTOMER_ID, 
			            	'@FM',
			            	$consultaDealResponse/RATE, 
			            	'@FM',
			            	$consultaDealResponse/SOURCE_AMOUNT, 
			            	'@FM',
			            	$consultaDealResponse/SOURCE_CURRENCY, 
			            	'@FM',
			            	$consultaDealResponse/STATUS, 
			            	'@FM',
			            	$consultaDealResponse/TARGET_AMOUNT, 
			            	'@FM',
			            	$consultaDealResponse/TARGET_CURRENCY)
			            	
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

declare variable $consultaDealResponse as element(ns1:consultaDealResponse) external;
declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;
declare variable $errorCode as xs:string external;
declare variable $message as xs:string external;

xf:consultaDealFacadeOut($consultaDealResponse,
    $transactionId,
    $sessionId,
    $errorCode,
    $message)