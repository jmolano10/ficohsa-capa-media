<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$gestionCupon" element="ns0:gestionCupon" location="../../RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/OperacionesTarjetaDebito/ValidaCancelacionCupon_db/xsd/validaCancelacionCupon_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validaCancelacionCupon";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/retiroSinTarjetaDebitoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GestionCupon/xq/validaCancelacionCuponIn/";

declare function xf:validaCancelacionCuponIn($gestionCupon as element(ns0:gestionCupon),
    $user as xs:string,
    $pais as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_TICKET>{ data($gestionCupon/TICKET_NUMBER) }</ns1:PV_TICKET>
            <ns1:PV_UUID_TICKET>{ data($gestionCupon/TRANSACTION_ID) }</ns1:PV_UUID_TICKET>
            <ns1:PV_USUARIO>{ $user }</ns1:PV_USUARIO>
            <ns1:PV_PAIS>{ $pais }</ns1:PV_PAIS>
        </ns1:InputParameters>
};

declare variable $gestionCupon as element(ns0:gestionCupon) external;
declare variable $user as xs:string external;
declare variable $pais as xs:string external;

xf:validaCancelacionCuponIn($gestionCupon,
    $user,
    $pais)]]></con:xquery>
    <con:dependency location="../../RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/OperacionesTarjetaDebito/ValidaCancelacionCupon_db/xsd/validaCancelacionCupon_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/OperacionesTarjetaDebito/ValidaCancelacionCupon_db/xsd/validaCancelacionCupon_sp"/>
    </con:dependency>
</con:xqueryEntry>