<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:generarCuponRetiroResponse" location="../../RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/retiroSinTarjetaDebitoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GenerarCuponRetiro/xq/generarCuponRetiroOut/";

declare function xf:generarCuponRetiroOut($uuid as xs:string,
    $cupon as xs:string,
    $fechaVencimiento as xs:string,
    $qr as xs:string)
    as element(ns0:generarCuponRetiroResponse) {
        <ns0:generarCuponRetiroResponse>
            <TICKET_NUMBER>{ $cupon }</TICKET_NUMBER>
            <TRANSACTION_ID>{ $uuid }</TRANSACTION_ID>
            <DATE_TICKET>{ fn:substring($fechaVencimiento,0,20) }</DATE_TICKET>
            <QR_CODE>{ $qr }</QR_CODE>
        </ns0:generarCuponRetiroResponse>
};

declare variable $uuid as xs:string external;
declare variable $cupon as xs:string external;
declare variable $fechaVencimiento as xs:string external;
declare variable $qr as xs:string external;

xf:generarCuponRetiroOut($uuid,
    $cupon,
    $fechaVencimiento,
    $qr)]]></con:xquery>
    <con:dependency location="../../RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes"/>
    </con:dependency>
</con:xqueryEntry>