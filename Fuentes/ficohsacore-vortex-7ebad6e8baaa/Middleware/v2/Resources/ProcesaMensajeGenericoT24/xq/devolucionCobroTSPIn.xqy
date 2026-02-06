xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:registrarDevolucionCobroTSP" location="../../RegistrarDevolucionCobroTSP/xsd/registrarDevolucionCobroTSPTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/registrarDevolucionCobroTSPTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/devolucionCobroTSPIn/";

declare function xf:devolucionCobroTSPIn($transactionId as xs:string)
    as element(ns0:registrarDevolucionCobroTSP) {
        <ns0:registrarDevolucionCobroTSP>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
        </ns0:registrarDevolucionCobroTSP>
};

declare variable $transactionId as xs:string external;

xf:devolucionCobroTSPIn($transactionId)