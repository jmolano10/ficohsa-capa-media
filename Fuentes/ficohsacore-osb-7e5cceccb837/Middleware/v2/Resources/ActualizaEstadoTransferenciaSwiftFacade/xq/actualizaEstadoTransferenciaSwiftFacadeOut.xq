(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaEstadoTransferenciaSwiftFacade/xq/actualizaEstadoTransferenciaSwiftFacade/";

declare function xf:actualizaEstadoTransferenciaSwiftFacade($transactionId as xs:string,
    $sessionId as xs:string,
    $message as xs:string)
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ data($transactionId) }</TRANSACTION_ID>
            <SESSION_ID>{ data($sessionId) }</SESSION_ID>
            <MESSAGE>{ data($message) }</MESSAGE>
        </ns0:procesaMensajeGenericoT24Response>
};

declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;
declare variable $message as xs:string external;

xf:actualizaEstadoTransferenciaSwiftFacade($transactionId,
    $sessionId,
    $message)
