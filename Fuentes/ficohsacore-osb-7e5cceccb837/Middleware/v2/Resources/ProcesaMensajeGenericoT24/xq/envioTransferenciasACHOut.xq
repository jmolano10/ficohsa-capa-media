(:: pragma bea:global-element-parameter parameter="$envioTransferenciasACHResponse1" element="ns1:envioTransferenciasACHResponse" location="../../EnvioTransferenciasACH/xsd/envioTransferenciasACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/envioTransferenciasACHTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/envioTransferenciasACHOut/";

declare function xf:envioTransferenciasACHOut($envioTransferenciasACHResponse1 as element(ns1:envioTransferenciasACHResponse),
    $sessionID as xs:string,
    $txnID as xs:string)
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ data($txnID) }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionID }</SESSION_ID>
            <MESSAGE>
                {
                    let $itemDetails  := ($envioTransferenciasACHResponse1/ITEM_DETAILS)  
                    let $result  := ($envioTransferenciasACHResponse1/RESULT)  
                    return
                        (fn:concat(
                        fn:string($result/SUCCESS_INDICATOR/text()),"|",
                        fn:string($result/REASON_CODE/text()),"|",
                        fn:string($result/RESULT_MESSAGE/text()),"|",
                        fn:string($result/ORIGINAL_MESSAGE_ID/text())
                        ))
                }
			</MESSAGE>
        </ns0:procesaMensajeGenericoT24Response>
};

declare variable $envioTransferenciasACHResponse1 as element(ns1:envioTransferenciasACHResponse) external;
declare variable $sessionID as xs:string external;
declare variable $txnID as xs:string external;

xf:envioTransferenciasACHOut($envioTransferenciasACHResponse1,
    $sessionID,
    $txnID)