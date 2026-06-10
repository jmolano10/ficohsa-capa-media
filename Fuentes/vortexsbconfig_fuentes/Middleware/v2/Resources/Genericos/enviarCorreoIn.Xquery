<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../BusinessServices/ITB/enviarCorreo/xsd/enviarCorreo_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/enviarCorreo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Genericos/enviarCorreoIn/";

declare function xf:enviarCorreoIn($direccion as xs:string,
    $asunto as xs:string,
    $mensaje as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_DIRECCION>{ $direccion }</ns0:PV_DIRECCION>
            <ns0:PV_MENSAJE>{ $mensaje }</ns0:PV_MENSAJE>
            <ns0:PV_ASUNTO>{ $asunto }</ns0:PV_ASUNTO>
        </ns0:InputParameters>
};

declare variable $direccion as xs:string external;
declare variable $asunto as xs:string external;
declare variable $mensaje as xs:string external;

xf:enviarCorreoIn($direccion,
    $asunto,
    $mensaje)]]></con:xquery>
    <con:dependency location="../../BusinessServices/ITB/enviarCorreo/xsd/enviarCorreo_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ITB/enviarCorreo/xsd/enviarCorreo_sp"/>
    </con:dependency>
</con:xqueryEntry>