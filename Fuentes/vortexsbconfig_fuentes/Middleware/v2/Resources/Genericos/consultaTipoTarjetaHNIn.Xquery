<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:sjConsultaTipoTarjeta" location="../../BusinessServices/SJS/consultaTipoTarjeta/xsd/sjConsultaTipoTarjeta.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaTipoTarjeta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Genericos/consultaTipoTarjetaHNIn/";

declare function xf:consultaTipoTarjetaHNIn($username as xs:string,
    $password as xs:string,
    $binNumber as xs:string)
    as element(ns0:sjConsultaTipoTarjeta) {
        <ns0:sjConsultaTipoTarjeta>
            <ns0:USERNAME>{ $username }</ns0:USERNAME>
            <ns0:PASSWORD>{ $password }</ns0:PASSWORD>
            <ns0:BIN_NUMBER>{ $binNumber }</ns0:BIN_NUMBER>
        </ns0:sjConsultaTipoTarjeta>
};

declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $binNumber as xs:string external;

xf:consultaTipoTarjetaHNIn($username,
    $password,
    $binNumber)]]></con:xquery>
    <con:dependency location="../../BusinessServices/SJS/consultaTipoTarjeta/xsd/sjConsultaTipoTarjeta.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/SJS/consultaTipoTarjeta/xsd/sjConsultaTipoTarjeta"/>
    </con:dependency>
</con:xqueryEntry>