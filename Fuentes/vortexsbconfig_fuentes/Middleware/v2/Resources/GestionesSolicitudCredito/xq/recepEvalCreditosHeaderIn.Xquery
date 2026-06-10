<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:SessionHeader" location="../../../BusinessServices/SALESFORCE/recepEvalCreditos/wsdl/WS_NIC_Recepcion_Eval_Creditos.wsdl" ::)

declare namespace ns0 = "http://soap.sforce.com/schemas/class/WS_NIC_Recepcion_Eval_Creditos";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GestionesSolicitudCredito/xq/recepEvalCreditosHeaderIn/";

declare function xf:recepEvalCreditosHeaderIn($sessionId as xs:string)
    as element(ns0:SessionHeader) {
        &lt;ns0:SessionHeader>
            &lt;ns0:sessionId>{ $sessionId }&lt;/ns0:sessionId>
        &lt;/ns0:SessionHeader>
};

declare variable $sessionId as xs:string external;

xf:recepEvalCreditosHeaderIn($sessionId)</con:xquery>
    <con:dependency location="../../../BusinessServices/SALESFORCE/recepEvalCreditos/wsdl/WS_NIC_Recepcion_Eval_Creditos.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/SALESFORCE/recepEvalCreditos/wsdl/WS_NIC_Recepcion_Eval_Creditos"/>
    </con:dependency>
</con:xqueryEntry>