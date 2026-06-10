<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:SessionHeader" location="../../../BusinessServices/SALESFORCE/actualizaSistemaRG/wsdl/actualizaSalesforceRG.wsdl" ::)

declare namespace ns0 = "http://soap.sforce.com/schemas/class/WS_Actualizacion_Datos";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaSistemas/xq/actualizarDatosHead/";

declare function xf:actualizarDatosHead($sessionId as xs:string)
    as element(ns0:SessionHeader) {
        &lt;ns0:SessionHeader>
            &lt;ns0:sessionId>{ data($sessionId) }&lt;/ns0:sessionId>
        &lt;/ns0:SessionHeader>
};

declare variable $sessionId as xs:string external;

xf:actualizarDatosHead($sessionId)</con:xquery>
    <con:dependency location="../../../BusinessServices/SALESFORCE/actualizaSistemaRG/wsdl/actualizaSalesforceRG.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/SALESFORCE/actualizaSistemaRG/wsdl/actualizaSalesforceRG"/>
    </con:dependency>
</con:xqueryEntry>