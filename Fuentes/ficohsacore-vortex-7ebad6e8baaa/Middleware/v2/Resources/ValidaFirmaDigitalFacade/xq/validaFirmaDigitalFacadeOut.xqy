xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$validaFirmaDigitalResponse" element="ns1:validaFirmaDigitalResponse" location="../../OperacionesPagosGlobales/xsd/operacionesPagosGlobalesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesPagosGlobalesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaFirmaDigitalFacade/xq/validaFirmaDigitalFacadeOut/";

declare function xf:validaFirmaDigitalFacadeOut($transactionId as xs:string,
    $sessionId as xs:string,
    $errorCode as xs:string,
    $validationMessage as xs:string,
    $result as xs:string,
    $validaFirmaDigitalResponse as element(ns1:validaFirmaDigitalResponse))
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
            {
               if(upper-case($errorCode) = "SUCCESS")then(
                      <MESSAGE>{concat('Success||',
                       $result,
                        '@FM', $validationMessage)
            		}</MESSAGE>
               )else(
            		<MESSAGE>{concat('ERROR||',
            		$result,
            		 '@FM', $validationMessage)}</MESSAGE>
			     )
            }
        </ns0:procesaMensajeGenericoT24Response>
};

declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;
declare variable $errorCode as xs:string external;
declare variable $validationMessage as xs:string external;
declare variable $result as xs:string external;
declare variable $validaFirmaDigitalResponse as element(ns1:validaFirmaDigitalResponse) external;

xf:validaFirmaDigitalFacadeOut($transactionId,
    $sessionId,
    $errorCode,
    $validationMessage,
    $result,
    $validaFirmaDigitalResponse)