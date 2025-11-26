(:: pragma bea:global-element-parameter parameter="$reversaVentaMenorResponse" element="ns1:reversaVentaMenorResponse" location="../../ReversaVentaMenor/xsd/reversaVentaMenorTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/reversaVentaMenorTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversaVentaMenorFacade/xq/reversaVentaMenorFacadeOut/";

declare function xf:reversaVentaMenorFacadeOut($reversaVentaMenorResponse as element(ns1:reversaVentaMenorResponse),
	$errorCode as xs:string,
    $sessionId as xs:string)
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
        {	
        	let $transactionId := data($reversaVentaMenorResponse/TRANSACTION_ID)
        	let $errorMessage := data($reversaVentaMenorResponse/ERROR_MESSAGE)
        	return
        	(
	        	<TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>,
	            <SESSION_ID>{ $sessionId }</SESSION_ID>,
	        	if(fn:upper-case($errorCode) = "SUCCESS")then(
		            <MESSAGE>{ concat("0|SUCCESS|",$transactionId, "|", $errorMessage) }</MESSAGE>
			     )else(
			     	<MESSAGE>{ concat("1|ERROR|", $transactionId , "|", $errorMessage) }</MESSAGE>
			     ) 
			)
	    }
        </ns0:procesaMensajeGenericoT24Response>
};

declare variable $reversaVentaMenorResponse as element(ns1:reversaVentaMenorResponse) external;
declare variable  $errorCode as xs:string external;
declare variable $sessionId as xs:string external;

xf:reversaVentaMenorFacadeOut($reversaVentaMenorResponse,
	$errorCode,
    $sessionId)