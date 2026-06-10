<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:credenciales" location="../../../BusinessServices/ACSELXHN/GestionAccesosUsuarios/wsdl/WS_AcselxIDM.wsdl" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaAccesoUsuario/xq/gestionAccesosUsuariosHeaderIn/";

declare function xf:gestionAccesosUsuariosHeaderIn($usuario as xs:string,
    $contraseña as xs:string,
    $publicacion as xs:string)
    as element(ns0:credenciales) {
        <ns0:credenciales>
            <ns0:usuario>{ $usuario }</ns0:usuario>
            <ns0:clave>{ $contraseña }</ns0:clave>
            <ns0:publicacion>{ data($publicacion) }</ns0:publicacion>
        </ns0:credenciales>
};

declare variable $usuario as xs:string external;
declare variable $contraseña as xs:string external;
declare variable $publicacion as xs:string external;

xf:gestionAccesosUsuariosHeaderIn($usuario,
    $contraseña,
    $publicacion)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/ACSELXHN/GestionAccesosUsuarios/wsdl/WS_AcselxIDM.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/ACSELXHN/GestionAccesosUsuarios/wsdl/WS_AcselxIDM"/>
    </con:dependency>
</con:xqueryEntry>