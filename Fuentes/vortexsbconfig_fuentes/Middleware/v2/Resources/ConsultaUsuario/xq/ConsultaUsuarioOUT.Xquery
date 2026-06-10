<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaUsuarioResponse" location="../xsd/consultaUsuarioTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaUsuarioTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaUsuario/xq/ConsultaUsuarioOUT/";

declare function xf:ConsultaUsuarioOUT($UserName as xs:string)
    as element(ns0:consultaUsuarioResponse) {
        &lt;ns0:consultaUsuarioResponse>
            &lt;USER_NAME>{ $UserName }&lt;/USER_NAME>
        &lt;/ns0:consultaUsuarioResponse>
};

declare variable $UserName as xs:string external;

xf:ConsultaUsuarioOUT($UserName)</con:xquery>
    <con:dependency location="../xsd/consultaUsuarioTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaUsuario/xsd/consultaUsuarioTypes"/>
    </con:dependency>
</con:xqueryEntry>