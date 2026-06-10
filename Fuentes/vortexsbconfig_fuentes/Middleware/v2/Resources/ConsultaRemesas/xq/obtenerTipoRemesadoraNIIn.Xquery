<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MDWNI/obtenerTipoRemesadoraNI/xsd/ObtenerTipoRemesadora_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ObtenerTipoRemesadora";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesas/xq/obtenerTipoRemesadoraNIIn/";

declare function xf:obtenerTipoRemesadoraNIIn($claveRemesadora as xs:string,
    $usuarioServicio as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CLAVE>{ $claveRemesadora }</ns0:PV_CLAVE>
            <ns0:PV_USUARIO_SERVICIO>{ $usuarioServicio }</ns0:PV_USUARIO_SERVICIO>
        </ns0:InputParameters>
};

declare variable $claveRemesadora as xs:string external;
declare variable $usuarioServicio as xs:string external;

xf:obtenerTipoRemesadoraNIIn($claveRemesadora,
    $usuarioServicio)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/MDWNI/obtenerTipoRemesadoraNI/xsd/ObtenerTipoRemesadora_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MDW/obtenerTipoRemesadoraNI/xsd/ObtenerTipoRemesadora_sp"/>
    </con:dependency>
</con:xqueryEntry>