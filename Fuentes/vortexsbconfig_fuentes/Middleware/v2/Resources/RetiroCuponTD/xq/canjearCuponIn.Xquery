<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$retiroCuponTD" element="ns0:retiroCuponTD" location="../../RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/OperacionesTarjetaDebito/CanjearCupon_db/xsd/canjearCupon_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/canjearCupon";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/retiroSinTarjetaDebitoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroCuponTD/xq/canjearCuponIn/";

declare function xf:canjearCuponIn($retiroCuponTD as element(ns0:retiroCuponTD),
    $user as xs:string,
    $uuid as xs:string,
    $pais as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_OPERACION>{ data($retiroCuponTD/OPERATION) }</ns1:PV_OPERACION>
            <ns1:PV_NOMBRE_PUNTO_RET>{ data($retiroCuponTD/WITHDRAWAL_POINT_INFORMATION/NAME) }</ns1:PV_NOMBRE_PUNTO_RET>
            <ns1:PV_ID_PUNTO_RET>{ data($retiroCuponTD/WITHDRAWAL_POINT_INFORMATION/TERMINAL_ID) }</ns1:PV_ID_PUNTO_RET>
            <ns1:PV_TIPO_PUNTO_RET>{ data($retiroCuponTD/WITHDRAWAL_POINT_INFORMATION/TYPE) }</ns1:PV_TIPO_PUNTO_RET>
            <ns1:PV_TRACE>{ data($retiroCuponTD/WITHDRAWAL_POINT_INFORMATION/TRACE) }</ns1:PV_TRACE>
            <ns1:PV_USUARIO>{ $user }</ns1:PV_USUARIO>
            <ns1:PV_TICKET>{ data($retiroCuponTD/TICKET_NUMBER) }</ns1:PV_TICKET>
            <ns1:PV_UUID_TICKET>{ $uuid }</ns1:PV_UUID_TICKET>
            <ns1:PV_PAIS>{ $pais }</ns1:PV_PAIS>
        </ns1:InputParameters>
};

declare variable $retiroCuponTD as element(ns0:retiroCuponTD) external;
declare variable $user as xs:string external;
declare variable $uuid as xs:string external;
declare variable $pais as xs:string external;

xf:canjearCuponIn($retiroCuponTD,
    $user,
    $uuid,
    $pais)]]></con:xquery>
    <con:dependency location="../../RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/OperacionesTarjetaDebito/CanjearCupon_db/xsd/canjearCupon_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/OperacionesTarjetaDebito/CanjearCupon_db/xsd/canjearCupon_sp"/>
    </con:dependency>
</con:xqueryEntry>