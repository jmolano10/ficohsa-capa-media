(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRetiroFPCFacade/xq/pagoRetiroFPCFacadeOut/";

declare function xf:pagoRetiroFPCFacadeOut($Message as xs:string,
    $transactionId as xs:string,
    $sessionId as xs:string)
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
            <MESSAGE>{ $Message }</MESSAGE>
        </ns0:procesaMensajeGenericoT24Response>
};

declare variable $Message as xs:string external;
declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;

xf:pagoRetiroFPCFacadeOut($Message,
    $transactionId,
    $sessionId)
