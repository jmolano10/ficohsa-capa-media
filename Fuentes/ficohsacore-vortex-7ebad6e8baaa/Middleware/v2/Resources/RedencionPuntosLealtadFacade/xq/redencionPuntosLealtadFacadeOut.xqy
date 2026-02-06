xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$redencionPuntosLealtadResponse" element="ns0:redencionPuntosLealtadResponse" location="../../ProgramaLealtad/xsd/programaLealtadTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RedencionPuntosLealtadFacade/xq/redencionPuntosLealtadFacadeOut/";

declare function xf:redencionPuntosLealtadFacadeOut($transactionId as xs:string,
    $sessionId as xs:string,
    $errorCode as xs:string,
    $validationMessage as xs:string,
    $redencionPuntosLealtadResponse as element(ns0:redencionPuntosLealtadResponse))
    as element(ns1:procesaMensajeGenericoT24Response) {
        <ns1:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
            {
            	if(upper-case($errorCode) = "SUCCESS")then(
            		<MESSAGE>{ 
            			concat(
            			'Success||',
            			$redencionPuntosLealtadResponse/LEGAL_ID ,
            			'@FM',
            			$redencionPuntosLealtadResponse/CUSTOMER_NAME ,
            			'@FM',
            			$redencionPuntosLealtadResponse/POINTS_REDEEMED ,
            			'@FM', 
            			$redencionPuntosLealtadResponse/REMAINING_BALANCE ,
            			'@FM',
            			$redencionPuntosLealtadResponse/REDEMPTION_ID
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
declare variable $redencionPuntosLealtadResponse as element(ns0:redencionPuntosLealtadResponse) external;

xf:redencionPuntosLealtadFacadeOut($transactionId,
    $sessionId,
    $errorCode,
    $validationMessage,
    $redencionPuntosLealtadResponse)