<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:retiroCuponTDResponse" location="../../RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/retiroSinTarjetaDebitoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroCuponTD/xq/retiroCuponTDOut/";

declare function xf:retiroCuponTDOut($uuid as xs:string,
    $cupon as xs:string)
    as element(ns0:retiroCuponTDResponse) {
        <ns0:retiroCuponTDResponse>
            <TICKET_NUMBER>{ $cupon }</TICKET_NUMBER>
            <TRANSACTION_ID>{ $uuid }</TRANSACTION_ID>
            <TRANSACTION_DATE>{ fn:substring(fn:string(fn:current-dateTime()),0,20) }</TRANSACTION_DATE>
        </ns0:retiroCuponTDResponse>
};

declare variable $uuid as xs:string external;
declare variable $cupon as xs:string external;

xf:retiroCuponTDOut($uuid,
    $cupon)]]></con:xquery>
    <con:dependency location="../../RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes"/>
    </con:dependency>
</con:xqueryEntry>