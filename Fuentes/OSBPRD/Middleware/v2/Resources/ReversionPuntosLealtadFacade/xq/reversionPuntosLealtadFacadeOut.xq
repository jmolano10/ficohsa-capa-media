(:: pragma bea:global-element-parameter parameter="$reversionPuntosLealtadResponse" element="ns0:reversionPuntosLealtadResponse" location="../../ProgramaLealtad/xsd/programaLealtadTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversionPuntosLealtadFacade/xq/reversionPuntosLealtadFacadeOut/";

declare function xf:reversionPuntosLealtadFacadeOut($transactionId as xs:string,
    $sessionId as xs:string,
    $errorCode as xs:string,
    $validationMessage as xs:string,
    $reversionPuntosLealtadResponse as element(ns0:reversionPuntosLealtadResponse))
    as element(ns1:procesaMensajeGenericoT24Response) {
        <ns1:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
            {
            	if(upper-case($errorCode) = "SUCCESS")then(
	            	<MESSAGE>{ 
	            		concat(
		            		'Success||',	
		            		 $reversionPuntosLealtadResponse/LEGAL_ID ,
		            		 '@FM',
		            		 $reversionPuntosLealtadResponse/CUSTOMER_NAME,
		            		 '@FM',
		            		  $reversionPuntosLealtadResponse/POINTS_AVAILABLE, 
		            		 '@FM',
		            		 $reversionPuntosLealtadResponse/CREDIT_RESULT/REDEMPTION_ID,
		            		 '@FM',
		            		  $reversionPuntosLealtadResponse/CREDIT_RESULT/TOTAL_POINTS_CREDITED,
		            		 '@FM', 
		            		 $reversionPuntosLealtadResponse/CREDIT_RESULT/CREDIT_REDEMPTION_ID
	            		 )
	            		 
	            	}</MESSAGE>
      			)else if(upper-case($errorCode) = "NO RECORDS")then(
			     	<MESSAGE>ERROR|No se encontraron registros</MESSAGE>
			     )else(
			     	<MESSAGE>{concat('ERROR|', $validationMessage)}</MESSAGE>
			     )
      		}
        </ns1:procesaMensajeGenericoT24Response>
};

declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;
declare variable $errorCode as xs:string external;
declare variable $validationMessage as xs:string external;
declare variable $reversionPuntosLealtadResponse as element(ns0:reversionPuntosLealtadResponse) external;

xf:reversionPuntosLealtadFacadeOut($transactionId,
    $sessionId,
    $errorCode,
    $validationMessage,
    $reversionPuntosLealtadResponse)