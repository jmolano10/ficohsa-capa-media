<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:opConsultaTarjetaDebitoSolicitud" location="../../../BusinessServices/CTS/ConsultaDatosTarjetaDebito/xsd/services.xsd" ::)

declare namespace ns1 = "http://dto.srvaplcobistarjetadebito.ecobis.cobiscorp";
declare namespace ns0 = "http://service.srvaplcobistarjetadebito.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatosTarjetaDebito/xq/ConsultaDatosTarjetaDebitoNI/";

declare function xf:ConsultaDatosTarjetaDebitoNI($CodOriginator as xs:int,
    $NumeroTarjeta as xs:string)
    as element(ns0:opConsultaTarjetaDebitoSolicitud) {
        <ns0:opConsultaTarjetaDebitoSolicitud>
            <ns1:contextoTransaccional>
                <ns1:codCanalOriginador>{ $CodOriginator }</ns1:codCanalOriginador>
            </ns1:contextoTransaccional>
            <ns1:tarjetaDebito>{ $NumeroTarjeta }</ns1:tarjetaDebito>
        </ns0:opConsultaTarjetaDebitoSolicitud>
};

declare variable $CodOriginator as xs:int external;
declare variable $NumeroTarjeta as xs:string external;

xf:ConsultaDatosTarjetaDebitoNI($CodOriginator,
    $NumeroTarjeta)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/CTS/ConsultaDatosTarjetaDebito/xsd/services.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/CTS/ConsultaDatosTarjetaDebito/xsd/services"/>
    </con:dependency>
</con:xqueryEntry>