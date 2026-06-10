<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:SessionHeader" location="../../../BusinessServices/SALESFORCE/recepEvalCreditosPA/wsdl/WS_PAN_Blaze_Recepcion_Eval_Creditos.wsdl" ::)

declare namespace ns0 = "http://soap.sforce.com/schemas/class/WS_Blaze_Recepcion_Eval_Creditos";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ResultadoCalificacionBlaze/xq/precualifyResultHeaderPAIn/";

declare function xf:precualifyResultHeaderPAIn($session as xs:string)
    as element(ns0:SessionHeader) {
        &lt;ns0:SessionHeader>
            &lt;ns0:sessionId>{ $session }&lt;/ns0:sessionId>
        &lt;/ns0:SessionHeader>
};

declare variable $session as xs:string external;

xf:precualifyResultHeaderPAIn($session)</con:xquery>
    <con:dependency location="../../../BusinessServices/SALESFORCE/recepEvalCreditosPA/wsdl/WS_PAN_Blaze_Recepcion_Eval_Creditos.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/SALESFORCE/recepEvalCreditosPA/wsdl/WS_PAN_Blaze_Recepcion_Eval_Creditos"/>
    </con:dependency>
</con:xqueryEntry>