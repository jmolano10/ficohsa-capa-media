<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:opConsultaTarjetaDebitoSolicitud" location="../../../BusinessServices/CTS/ConsultaDatosTarjetaDebito/xsd/services.xsd" ::)

declare namespace ns0 = "http://service.srvaplcobistarjetadebito.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatosTarjetaDebito/xq/ConsultaDatosTarjetaDebitoNI/";

declare function xf:ConsultaDatosTarjetaDebitoNI($numeroTarjeta as xs:string,
    $CodOriginator as xs:int)
    as element(ns0:opConsultaTarjetaDebitoSolicitud) {
        <ns0:opConsultaTarjetaDebitoSolicitud>
            <contextoTransaccional>
                <codCanalOriginador>{ $CodOriginator }</codCanalOriginador>
            </contextoTransaccional>
            <tarjetaDebito>{ $numeroTarjeta }</tarjetaDebito>
        </ns0:opConsultaTarjetaDebitoSolicitud>
};

declare variable $numeroTarjeta as xs:string external;
declare variable $CodOriginator as xs:int external;

xf:ConsultaDatosTarjetaDebitoNI($numeroTarjeta,
    $CodOriginator)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/CTS/ConsultaDatosTarjetaDebito/xsd/services.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/CTS/ConsultaDatosTarjetaDebito/xsd/services"/>
    </con:dependency>
</con:xqueryEntry>