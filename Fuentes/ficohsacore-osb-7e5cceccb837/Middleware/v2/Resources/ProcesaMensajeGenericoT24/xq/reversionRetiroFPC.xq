(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/FPC/reversionRetiroFPC/xsd/REVERSION_RETIRO_FPC_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/REVERSION_RETIRO_FPC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/reversionRetiroFPC/";

declare function xf:reversionRetiroFPC($outputParameters as element(ns1:OutputParameters),
    $transactionId as xs:string,
    $sessionId as xs:string)
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
        	<TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
            <MESSAGE>{ concat($outputParameters/ns1:P_ERROR_CODE, '|', $outputParameters/ns1:P_ERROR) }</MESSAGE>
        </ns0:procesaMensajeGenericoT24Response>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;

xf:reversionRetiroFPC($outputParameters,
    $transactionId,
    $sessionId)