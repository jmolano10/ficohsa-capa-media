<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:validacionToken" location="../../Autenticacion/xsd/autenticacionInternaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autenticacionInternaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/autorizacionTokenIn/";

declare function xf:autorizacionTokenIn($username as xs:string,
    $tokenNumber as xs:string)
    as element(ns0:validacionToken) {
        <ns0:validacionToken>
            <USERNAME>{ $username }</USERNAME>
            <TOKEN>{ $tokenNumber }</TOKEN>
        </ns0:validacionToken>
};

declare variable $username as xs:string external;
declare variable $tokenNumber as xs:string external;

xf:autorizacionTokenIn($username,
    $tokenNumber)]]></con:xquery>
    <con:dependency location="../../Autenticacion/xsd/autenticacionInternaTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/Autenticacion/xsd/autenticacionInternaTypes"/>
    </con:dependency>
</con:xqueryEntry>