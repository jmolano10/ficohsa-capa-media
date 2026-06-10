<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:gestionCuponResponse" location="../../RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/retiroSinTarjetaDebitoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GestionCupon/xq/gestionCuponOut/";

declare function xf:gestionCuponOut($uuid as xs:string,
    $cupon as xs:string,
    $transactionId as xs:string,
    $refT24 as xs:string)
    as element(ns0:gestionCuponResponse) {
        <ns0:gestionCuponResponse>
            <TICKET_NUMBER>{ $cupon }</TICKET_NUMBER>
            <TRANSACTION_ID>{ $uuid }</TRANSACTION_ID>
            <TRANSACTION_CORE_ID>{ $transactionId }</TRANSACTION_CORE_ID>
            <REF_T24>{ $refT24 }</REF_T24>
        </ns0:gestionCuponResponse>
};

declare variable $uuid as xs:string external;
declare variable $cupon as xs:string external;
declare variable $transactionId as xs:string external;
declare variable $refT24 as xs:string external;

xf:gestionCuponOut($uuid,
    $cupon,
    $transactionId,
    $refT24)]]></con:xquery>
    <con:dependency location="../../RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes"/>
    </con:dependency>
</con:xqueryEntry>