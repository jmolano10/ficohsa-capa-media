(:: pragma bea:global-element-parameter parameter="$responseHeader1" element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/reversionCobroTSPOut/";

declare function xf:reversionCobroTSPOut($responseHeader1 as element(ns1:ResponseHeader),
    $transactionId as xs:string,
    $sessionId as xs:string,
    $txnReference as xs:string)
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
            <MESSAGE>
            { 
            	if (fn:upper-case(fn:string($responseHeader1/successIndicator/text())) = "SUCCESS") then (
           			fn:concat("0|SUCCESS|",$txnReference)
            	) else (
            		fn:concat("1|ERROR|",$responseHeader1/messages[1]/text())
            	)
            }
            </MESSAGE>
        </ns0:procesaMensajeGenericoT24Response>
};

declare variable $responseHeader1 as element(ns1:ResponseHeader) external;
declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;
declare variable $txnReference as xs:string external;

xf:reversionCobroTSPOut($responseHeader1,
    $transactionId,
    $sessionId,
    $txnReference)