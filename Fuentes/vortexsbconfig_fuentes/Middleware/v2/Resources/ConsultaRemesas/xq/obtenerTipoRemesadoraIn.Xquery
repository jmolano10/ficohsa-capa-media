<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MDW/obtenerTipoRemesadora/xsd/ObtenerTipoRemesadora_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ObtenerTipoRemesadora";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesas/xq/obtenerTipoRemesadoraIn/";

declare function xf:obtenerTipoRemesadoraIn($ClaveRemesadora as xs:string,
    $UsuarioServicio as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CLAVE>{ $ClaveRemesadora }</ns0:PV_CLAVE>
            <ns0:PV_USUARIO_SERVICIO>{ $UsuarioServicio }</ns0:PV_USUARIO_SERVICIO>
        </ns0:InputParameters>
};

declare variable $ClaveRemesadora as xs:string external;
declare variable $UsuarioServicio as xs:string external;

xf:obtenerTipoRemesadoraIn($ClaveRemesadora,
    $UsuarioServicio)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/MDW/obtenerTipoRemesadora/xsd/ObtenerTipoRemesadora_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MDW/obtenerTipoRemesadora/xsd/ObtenerTipoRemesadora_sp"/>
    </con:dependency>
</con:xqueryEntry>