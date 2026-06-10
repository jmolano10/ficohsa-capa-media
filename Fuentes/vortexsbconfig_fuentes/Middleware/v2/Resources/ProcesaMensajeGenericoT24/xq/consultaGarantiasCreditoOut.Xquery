<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$responseHeader" element="ns2:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/PWS/consultaGarantiasCredito/xsd/consultaGarantiasCredito_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/consultaGarantiasCreditoOut/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaGarantiasCredito";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";

declare function xf:consultaGarantiasCreditoOut($responseHeader as element(ns2:ResponseHeader),
    $outputParameters as element(ns1:OutputParameters),
    $transactionId as xs:string,
    $sessionId as xs:string)
    as element(ns0:procesaMensajeGenericoT24Response) {
		<ns0:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
            <MESSAGE>
            {
            	let $message := (
            	if (fn:upper-case(fn:string($responseHeader/successIndicator/text())) = "SUCCESS") then (
           			fn:concat("0|SUCCESS|", fn:string($outputParameters/ns1:LV_DETALLE/text()))
            	) else (
            		fn:concat("1|ERROR|", fn:string($outputParameters/ns1:LV_DETALLE/text()))
            	)
            	)return $message
            }
            </MESSAGE>
        </ns0:procesaMensajeGenericoT24Response>
};

declare variable $responseHeader as element(ns2:ResponseHeader) external;
declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;

xf:consultaGarantiasCreditoOut($responseHeader,
    $outputParameters,
    $transactionId,
    $sessionId)]]></con:xquery>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/PWS/consultaGarantiasCredito/xsd/consultaGarantiasCredito_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/PWS/consultaGarantiasCredito/xsd/consultaGarantiasCredito_sp"/>
    </con:dependency>
    <con:dependency location="../xsd/procesaMensajeGenericoT24Types.xsd">
        <con:schema ref="Middleware/v2/Resources/ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types"/>
    </con:dependency>
</con:xqueryEntry>