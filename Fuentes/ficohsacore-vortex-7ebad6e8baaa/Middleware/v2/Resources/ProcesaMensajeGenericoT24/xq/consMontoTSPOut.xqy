xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaMontoTSPClienteResponse1" element="ns1:consultaMontoTSPClienteResponse" location="../../ConsultaMontoTSP/xsd/consultaMontoTSPTransferenciaTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$responseHeader1" element="ns2:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMontoTSPTransferenciaTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/consMontoTSPOut/";

declare function xf:consMontoTSPOut($transactionId as xs:string,
    $sessionId as xs:string,
    $consultaMontoTSPClienteResponse1 as element(ns1:consultaMontoTSPClienteResponse),
    $responseHeader1 as element(ns2:ResponseHeader))
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
        <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
        <SESSION_ID>{ $sessionId }</SESSION_ID>
        {
        	if  (fn:upper-case(fn:string($responseHeader1/successIndicator/text())) = "SUCCESS") then
        	(
            	<MESSAGE>{ concat('0|SUCCESS|',$consultaMontoTSPClienteResponse1/RATABLE_INDICATOR/text(),'#*',$consultaMontoTSPClienteResponse1/NON_RATABLE_REASON/text(),'#*',
            	$consultaMontoTSPClienteResponse1/TRANSACTION_AMOUNT/text(),'#*',$consultaMontoTSPClienteResponse1/RATE_AMOUNT/text(),'#*',
            	$consultaMontoTSPClienteResponse1/CREDIT_ACCOUNT/text(),'#*', $consultaMontoTSPClienteResponse1/LOG_ID/text()) }</MESSAGE>
            )
            else
            (
            	<MESSAGE></MESSAGE>
            )
        }
        </ns0:procesaMensajeGenericoT24Response>
};

declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;
declare variable $consultaMontoTSPClienteResponse1 as element(ns1:consultaMontoTSPClienteResponse) external;
declare variable $responseHeader1 as element(ns2:ResponseHeader) external;

xf:consMontoTSPOut($transactionId,
    $sessionId,
    $consultaMontoTSPClienteResponse1,
    $responseHeader1)