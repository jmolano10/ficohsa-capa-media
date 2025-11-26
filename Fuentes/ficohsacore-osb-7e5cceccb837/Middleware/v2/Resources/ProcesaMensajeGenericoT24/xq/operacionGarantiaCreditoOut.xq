xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$responseHeader" element="ns2:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/PWS/operacionGarantiaCredito/xsd/operacionGarantiaCredito_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:procesaMensajeGenericoT24Response" location="../xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/operacionGarantiaCreditoOut/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/operacionGarantiaCredito";

declare function xf:operacionGarantiaCreditoOut($responseHeader as element(ns2:ResponseHeader),
    $outputParameters as element(ns0:OutputParameters),
    $transactionId as xs:string,
    $sessionId as xs:string)
    as element(ns1:procesaMensajeGenericoT24Response) {
        <ns1:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
            <MESSAGE>
            {
            if (fn:upper-case(fn:string($responseHeader/successIndicator/text())) = "SUCCESS") then (
            	fn:concat("0|SUCCESS|", fn:string($outputParameters/ns0:LV_RESPUESTA/text()))
            ) else 
            	fn:concat("1|ERROR|", fn:string($outputParameters/ns0:LV_RESPUESTA/text()))
            }
            </MESSAGE>
        </ns1:procesaMensajeGenericoT24Response>
};

declare variable $responseHeader as element(ns2:ResponseHeader) external;
declare variable $outputParameters as element(ns0:OutputParameters) external;
declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;

xf:operacionGarantiaCreditoOut($responseHeader,
    $outputParameters,
    $transactionId,
    $sessionId)