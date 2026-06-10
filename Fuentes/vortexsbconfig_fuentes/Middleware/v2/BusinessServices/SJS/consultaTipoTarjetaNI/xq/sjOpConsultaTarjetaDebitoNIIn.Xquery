<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaTipoTarjeta" element="ns2:sjConsultaTipoTarjeta" location="../xsd/sjConsultaTipoTarjetaNI.xsd" ::)
(:: pragma bea:global-element-return element="ns0:opConsultaTarjetaDebitoSolicitud" location="../../../CTS/ConsultaDatosTarjetaDebito/xsd/services.xsd" ::)

declare namespace ns0 = "http://service.srvaplcobistarjetadebito.ecobis.cobiscorp";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaTipoTarjetaNI";
declare namespace ns1 = "http://dto.srvaplcobistarjetadebito.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaTipoTarjetaNI/xq/sjOpConsultaTarjetaDebitoNIIn/";

declare function xf:sjOpConsultaTarjetaDebitoNIIn($sjConsultaTipoTarjeta as element(ns2:sjConsultaTipoTarjeta))
    as element(ns0:opConsultaTarjetaDebitoSolicitud) {
        <ns0:opConsultaTarjetaDebitoSolicitud>
            <ns1:contextoTransaccional>
                <ns1:codCanalOriginador>1</ns1:codCanalOriginador>
            </ns1:contextoTransaccional>
            <ns1:tarjetaDebito>{ data($sjConsultaTipoTarjeta/ns2:CARD_NUMBER) }</ns1:tarjetaDebito>
        </ns0:opConsultaTarjetaDebitoSolicitud>
};

declare variable $sjConsultaTipoTarjeta as element(ns2:sjConsultaTipoTarjeta) external;

xf:sjOpConsultaTarjetaDebitoNIIn($sjConsultaTipoTarjeta)]]></con:xquery>
    <con:dependency location="../xsd/sjConsultaTipoTarjetaNI.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/SJS/consultaTipoTarjetaNI/xsd/sjConsultaTipoTarjetaNI"/>
    </con:dependency>
    <con:dependency location="../../../CTS/ConsultaDatosTarjetaDebito/xsd/services.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/CTS/ConsultaDatosTarjetaDebito/xsd/services"/>
    </con:dependency>
</con:xqueryEntry>