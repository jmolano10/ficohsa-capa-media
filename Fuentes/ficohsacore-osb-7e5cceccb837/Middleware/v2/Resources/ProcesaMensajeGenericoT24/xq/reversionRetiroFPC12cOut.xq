(:: pragma bea:global-element-parameter parameter="$reversalWithdrawalFPCResponse1" element="ns0:ReversalWithdrawalFPCResponse" location="../../../BusinessServices/ReversionRetiroFPC/Resources/v1.xsd" ::)
(:: pragma bea:global-element-return element="ns1:procesaMensajeGenericoT24Response" location="../xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns2 = "https://www.ficohsa.com/regional/common/commonTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns0 = "https://www.ficohsa.com/regional/pension";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/reversionRetiroFPC12cOut/";

declare function xf:reversionRetiroFPC12cOut($reversalWithdrawalFPCResponse1 as element(ns0:ReversalWithdrawalFPCResponse),
    $sessionId as xs:string,
    $transactionId as xs:string)
    as element(ns1:procesaMensajeGenericoT24Response) {
        <ns1:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
            {
              if (fn:contains(data($reversalWithdrawalFPCResponse1/StatusInfo/Status), "false"))then
              (
                <MESSAGE>{ concat(0 , '|' ,"OK") }</MESSAGE>
              )else (
                <MESSAGE>{ concat(data($reversalWithdrawalFPCResponse1/StatusInfo/Status), '|' ,data($reversalWithdrawalFPCResponse1/ErrorInfo/Description)) }</MESSAGE>
                )
           }
        </ns1:procesaMensajeGenericoT24Response>
};

declare variable $reversalWithdrawalFPCResponse1 as element(ns0:ReversalWithdrawalFPCResponse) external;
declare variable $sessionId as xs:string external;
declare variable $transactionId as xs:string external;

xf:reversionRetiroFPC12cOut($reversalWithdrawalFPCResponse1,
    $sessionId,
    $transactionId)