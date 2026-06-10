<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/OperacionesTarjetaDebito/EliminarCupon_db/xsd/eliminarCupon_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/eliminarCupon";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/retiroSinTarjetaDebitoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GenerarCuponRetiro/xq/eliminarCuponIn/";

declare function xf:eliminarCuponIn($cupon as xs:string,
    $uuid as xs:string,
    $user as xs:string,
    $pais as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_TICKET>{ $cupon }</ns1:PV_TICKET>
            <ns1:PV_UUID_TICKET>{ $uuid }</ns1:PV_UUID_TICKET>
            <ns1:PV_USUARIO>{ $user }</ns1:PV_USUARIO>
            <ns1:PV_PAIS>{ $pais }</ns1:PV_PAIS>
        </ns1:InputParameters>
};

declare variable $cupon as xs:string external;
declare variable $uuid as xs:string external;
declare variable $user as xs:string external;
declare variable $pais as xs:string external;

xf:eliminarCuponIn($cupon,
    $uuid,
    $user,
    $pais)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/OperacionesTarjetaDebito/EliminarCupon_db/xsd/eliminarCupon_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/OperacionesTarjetaDebito/EliminarCupon_db/xsd/eliminarCupon_sp"/>
    </con:dependency>
</con:xqueryEntry>