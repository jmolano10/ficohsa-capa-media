<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:Action" location="../../../BusinessServices/notificaDivisasEncabezado/xsd/WS_Addressing.xsd" ::)

declare namespace ns0 = "http://www.w3.org/2005/08/addressing";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaDivisas/xq/notificaDivisasRequestHeaderIn/";

declare function xf:notificaDivisasRequestHeaderIn($action as xs:string)
    as element(ns0:Action) {
        &lt;ns0:Action>{ $action }&lt;/ns0:Action>
};

declare variable $action as xs:string external;

xf:notificaDivisasRequestHeaderIn($action)</con:xquery>
    <con:dependency location="../../../BusinessServices/notificaDivisasEncabezado/xsd/WS_Addressing.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/notificaDivisasEncabezado/xsd/WS_Addressing"/>
    </con:dependency>
</con:xqueryEntry>