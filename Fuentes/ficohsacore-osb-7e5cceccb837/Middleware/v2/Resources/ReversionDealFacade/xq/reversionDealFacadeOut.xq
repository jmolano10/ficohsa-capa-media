(:: pragma bea:global-element-parameter parameter="$reversionDealResponse" element="ns1:reversionDealResponse" location="../../ReversionDeal/xsd/reversionDealTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/reversionDealTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversionDealFacade/xq/reversionDealFacadeOut/";

declare function xf:reversionDealFacadeOut($reversionDealResponse as element(ns1:reversionDealResponse),
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
		        			$reversionDealResponse/CONTRACT_ID,
			            	'@FM',
			            	$reversionDealResponse/COUNTRY
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

declare variable $reversionDealResponse as element(ns1:reversionDealResponse) external;
declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;
declare variable $errorCode as xs:string external;
declare variable $message as xs:string external;

xf:reversionDealFacadeOut($reversionDealResponse,
    $transactionId,
    $sessionId,
    $errorCode,
    $message)
