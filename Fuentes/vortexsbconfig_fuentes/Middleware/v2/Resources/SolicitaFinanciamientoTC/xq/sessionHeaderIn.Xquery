<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:SessionHeader" location="../../../BusinessServices/External/SalesforceHNIngresaGestionExtra/wsdl/SalesforceHNIngresaGestionExtra.wsdl" ::)

declare namespace ns0 = "http://soap.sforce.com/schemas/class/WS_IngresaGestionExtra";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Generales/xq/sessionHeaderIn/";

declare function xf:sessionHeaderIn($sessionId as xs:string)
    as element(ns0:SessionHeader) {
        &lt;ns0:SessionHeader>
            &lt;ns0:sessionId>{ $sessionId }&lt;/ns0:sessionId>
        &lt;/ns0:SessionHeader>
};

declare variable $sessionId as xs:string external;

xf:sessionHeaderIn($sessionId)</con:xquery>
    <con:dependency location="../../../BusinessServices/External/SalesforceHNIngresaGestionExtra/wsdl/SalesforceHNIngresaGestionExtra.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/External/SalesforceHNIngresaGestionExtra/wsdl/SalesforceHNIngresaGestionExtra"/>
    </con:dependency>
</con:xqueryEntry>