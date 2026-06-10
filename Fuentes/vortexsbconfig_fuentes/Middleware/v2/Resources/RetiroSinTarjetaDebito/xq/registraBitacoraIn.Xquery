<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/OperacionesTarjetaDebito/RegistraBitacora_db/xsd/registraBitacora_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraBitacora";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroSinTarjetaDebito/xq/registraBitacoraIn/";

declare function xf:registraBitacoraIn($ticket as xs:string,
    $uuid as xs:string,
    $usuario as xs:string,
    $pais as xs:string,
    $tipoRegistro as xs:string,
    $host as xs:string,
    $operacion as xs:string,
    $contenido as xs:string,
    $codRespuesta as xs:string,
    $mensaje as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_TICKET>{ $ticket }</ns0:PV_TICKET>
            <ns0:PV_UUID_TICKET>{ $uuid }</ns0:PV_UUID_TICKET>
            <ns0:PV_USUARIO>{ $usuario }</ns0:PV_USUARIO>
            <ns0:PV_PAIS>{ $pais }</ns0:PV_PAIS>
            <ns0:PV_TIPO_REGISTRO>{ $tipoRegistro }</ns0:PV_TIPO_REGISTRO>
            <ns0:PV_HOST>{ $host }</ns0:PV_HOST>
            <ns0:PV_OPERACION>{ $operacion }</ns0:PV_OPERACION>
            <ns0:PV_CONTENIDO>{ $contenido }</ns0:PV_CONTENIDO>
            <ns0:PV_COD_RESPUESTA>{ $codRespuesta }</ns0:PV_COD_RESPUESTA>
            <ns0:PV_MENSAJE_RSP>{ $mensaje }</ns0:PV_MENSAJE_RSP>
        </ns0:InputParameters>
};

declare variable $ticket as xs:string external;
declare variable $uuid as xs:string external;
declare variable $usuario as xs:string external;
declare variable $pais as xs:string external;
declare variable $tipoRegistro as xs:string external;
declare variable $host as xs:string external;
declare variable $operacion as xs:string external;
declare variable $contenido as xs:string external;
declare variable $codRespuesta as xs:string external;
declare variable $mensaje as xs:string external;

xf:registraBitacoraIn($ticket,
    $uuid,
    $usuario,
    $pais,
    $tipoRegistro,
    $host,
    $operacion,
    $contenido,
    $codRespuesta,
    $mensaje)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/OperacionesTarjetaDebito/RegistraBitacora_db/xsd/registraBitacora_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/OperacionesTarjetaDebito/RegistraBitacora_db/xsd/registraBitacora_sp"/>
    </con:dependency>
</con:xqueryEntry>