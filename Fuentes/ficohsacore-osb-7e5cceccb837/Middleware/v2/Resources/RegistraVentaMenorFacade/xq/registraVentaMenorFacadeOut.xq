(:: pragma bea:global-element-parameter parameter="$registraVentaMenorResponse" element="ns1:registraVentaMenorResponse" location="../../RegistraVentaMenor/xsd/registraVentaMenorTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/registraVentaMenorTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraVentaMenorFacade/xq/registraVentaMenorFacadeOut/";

declare function xf:registraVentaMenorFacadeOut($registraVentaMenorResponse as element(ns1:registraVentaMenorResponse),
    $errorCode as xs:string,
    $sessionId as xs:string)
  
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
        {
        	let $transactionId := data($registraVentaMenorResponse/TRANSACTION_ID)
        	let $errorMessage := data($registraVentaMenorResponse/ERROR_MESSAGE)
        	return
        	(
	            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>,
	            <SESSION_ID>{ $sessionId }</SESSION_ID>,
	        	if(fn:upper-case($errorCode) = "SUCCESS")then(
		            <MESSAGE>{ concat("0|SUCCESS|",$transactionId, "|", $errorMessage) }</MESSAGE>
			     )else(
			     	<MESSAGE>{ concat("1|ERROR|", $transactionId, "|",  $errorMessage) }</MESSAGE>
			     ) 
			)
		}
        </ns0:procesaMensajeGenericoT24Response>
};

declare variable $registraVentaMenorResponse as element(ns1:registraVentaMenorResponse) external;
declare variable  $errorCode as xs:string external;
declare variable $sessionId as xs:string external;

xf:registraVentaMenorFacadeOut($registraVentaMenorResponse, 
 	$errorCode,
    $sessionId)