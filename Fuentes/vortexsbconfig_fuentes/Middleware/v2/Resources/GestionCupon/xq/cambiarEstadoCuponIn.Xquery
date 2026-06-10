<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$gestionCupon" element="ns0:gestionCupon" location="../../RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/OperacionesTarjetaDebito/CambiaEstadoCupon_db/xsd/cambiaEstadoCupon_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/cambiaEstadoCupon";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/retiroSinTarjetaDebitoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GestionCupon/xq/cambiarEstadoCuponIn/";

declare function xf:cambiarEstadoCuponIn($gestionCupon as element(ns0:gestionCupon),
    $estado as xs:string,
    $user as xs:string,
    $transactionId as xs:string,
    $refT24 as xs:string,
    $pais as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_ESTADO>{ $estado }</ns1:PV_ESTADO>
            <ns1:PV_TIPO>{ data($gestionCupon/TYPE) }</ns1:PV_TIPO>
            <ns1:PV_UUID_TICKET>{ data($gestionCupon/TRANSACTION_ID) }</ns1:PV_UUID_TICKET>
            <ns1:PV_REF_T24>{ $refT24 }</ns1:PV_REF_T24>
            <ns1:PV_ID_TRANS_CORE>{ $transactionId }</ns1:PV_ID_TRANS_CORE>
            <ns1:PV_USUARIO>{ $user }</ns1:PV_USUARIO>
            <ns1:PV_PAIS>{ $pais }</ns1:PV_PAIS>
            <ns1:PV_REQ>{ fn-bea:serialize($gestionCupon) }</ns1:PV_REQ>
        </ns1:InputParameters>
};

declare variable $gestionCupon as element(ns0:gestionCupon) external;
declare variable $estado as xs:string external;
declare variable $user as xs:string external;
declare variable $transactionId as xs:string external;
declare variable $refT24 as xs:string external;
declare variable $pais as xs:string external;

xf:cambiarEstadoCuponIn($gestionCupon,
    $estado,
    $user,
    $transactionId,
    $refT24,
    $pais)]]></con:xquery>
    <con:dependency location="../../RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/OperacionesTarjetaDebito/CambiaEstadoCupon_db/xsd/cambiaEstadoCupon_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/OperacionesTarjetaDebito/CambiaEstadoCupon_db/xsd/cambiaEstadoCupon_sp"/>
    </con:dependency>
</con:xqueryEntry>