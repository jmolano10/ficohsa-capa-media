<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaUsuariosPGA" location="../../ConsultaUsuarioPGA/xsd/consultaUsuariosPGATypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaUsuariosPGATypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Login/xq/ConsultaUsuarioPGAIn/";

declare function xf:ConsultaUsuarioPGAIn($usuario as xs:string,
    $App as xs:string)
    as element(ns0:consultaUsuariosPGA) {
        <ns0:consultaUsuariosPGA>
            <USERNAME>{ $usuario }</USERNAME>
            <APPLICATION>{ $App }</APPLICATION>
        </ns0:consultaUsuariosPGA>
};

declare variable $usuario as xs:string external;
declare variable $App as xs:string external;

xf:ConsultaUsuarioPGAIn($usuario,
    $App)]]></con:xquery>
    <con:dependency location="../../ConsultaUsuarioPGA/xsd/consultaUsuariosPGATypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaUsuarioPGA/xsd/consultaUsuariosPGATypes"/>
    </con:dependency>
</con:xqueryEntry>