<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$generarCuponRetiro" element="ns0:generarCuponRetiro" location="../../RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/OperacionesTarjetaDebito/GenerarCupon_db/xsd/generacionCupones_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/generacionCupones";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/retiroSinTarjetaDebitoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GenerarCuponRetiro/xq/generacionCuponesIn/";

declare function xf:generacionCuponesIn($generarCuponRetiro as element(ns0:generarCuponRetiro),
    $uuid as xs:string,
    $user as xs:string,
    $codDespignorar as xs:string,
    $pais as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_UUID>{ $uuid }</ns1:PV_UUID>
            <ns1:PV_CUSTOMER>{ data($generarCuponRetiro/CUSTOMER_ID) }</ns1:PV_CUSTOMER>
            <ns1:PV_CUENTA>{ data($generarCuponRetiro/ACCOUNT_NUMBER) }</ns1:PV_CUENTA>
            <ns1:PV_MONEDA>{ data($generarCuponRetiro/CURRENCY) }</ns1:PV_MONEDA>
            <ns1:PN_MONTO>{ data($generarCuponRetiro/AMOUNT) }</ns1:PN_MONTO>
            <ns1:PN_VIGENCIA>{ data($generarCuponRetiro/TIME_TICKET) }</ns1:PN_VIGENCIA>
            <ns1:PV_DESPIGNORAR>{ $codDespignorar }</ns1:PV_DESPIGNORAR>
            <ns1:PV_USUARIO>{ $user }</ns1:PV_USUARIO>
            {
                for $CHANNEL in $generarCuponRetiro/CHANNEL
                return
                    <ns1:PV_CANAL>{ data($CHANNEL) }</ns1:PV_CANAL>
            }
            <ns1:PV_PAIS>{ $pais }</ns1:PV_PAIS>
        </ns1:InputParameters>
};

declare variable $generarCuponRetiro as element(ns0:generarCuponRetiro) external;
declare variable $uuid as xs:string external;
declare variable $user as xs:string external;
declare variable $codDespignorar as xs:string external;
declare variable $pais as xs:string external;

xf:generacionCuponesIn($generarCuponRetiro,
    $uuid,
    $user,
    $codDespignorar,
    $pais)]]></con:xquery>
    <con:dependency location="../../RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/OperacionesTarjetaDebito/GenerarCupon_db/xsd/generacionCupones_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/OperacionesTarjetaDebito/GenerarCupon_db/xsd/generacionCupones_sp"/>
    </con:dependency>
</con:xqueryEntry>