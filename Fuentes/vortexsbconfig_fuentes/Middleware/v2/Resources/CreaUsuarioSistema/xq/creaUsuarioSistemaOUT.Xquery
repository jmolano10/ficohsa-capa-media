<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:creaUsuarioSistemaResponse" location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/aperturaProductosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaUsuarioSistema/xq/creaUsuarioSistemaOUT/";

declare function xf:creaUsuarioSistemaOUT($username as xs:string)
    as element(ns0:creaUsuarioSistemaResponse) {
        &lt;ns0:creaUsuarioSistemaResponse>
            &lt;USER_NAME>{ $username }&lt;/USER_NAME>
        &lt;/ns0:creaUsuarioSistemaResponse>
};

declare variable $username as xs:string external;

xf:creaUsuarioSistemaOUT($username)</con:xquery>
    <con:dependency location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/AperturaProductos/xsd/aperturaProductosTypes"/>
    </con:dependency>
</con:xqueryEntry>