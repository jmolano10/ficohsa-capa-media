(:: pragma bea:global-element-parameter parameter="$liquidaDealResponse" element="ns1:liquidaDealResponse" location="../../LiquidaDeal/xsd/liquidaDealTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/liquidaDealTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/LiquidaDeal/xq/liquidaDealFacadeOut/";

declare function xf:liquidaDealFacadeOut($liquidaDealResponse as element(ns1:liquidaDealResponse),
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
		            		$liquidaDealResponse/CONTRACT_ID,
			            	'@FM',
			            	$liquidaDealResponse/COUNTRY,
			            	'@FM',
			            	$liquidaDealResponse/CUSTOMER_ID
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

declare variable $liquidaDealResponse as element(ns1:liquidaDealResponse) external;
declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;
declare variable $errorCode as xs:string external;
declare variable $message as xs:string external;

xf:liquidaDealFacadeOut($liquidaDealResponse,
    $transactionId,
    $sessionId,
    $errorCode,
    $message)