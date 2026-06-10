<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/cambiarPuntosANegativo/xsd/cambiarPuntosANegativo_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/cambiarPuntosANegativo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/cambioPuntosANegativoIn/";

declare function xf:cambioPuntosANegativoIn($requestHeader1 as element(ns0:RequestHeader),
    $strNumeroTarjeta as xs:string,
    $strPuntos as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PNUMEROTARJETA>{ $strNumeroTarjeta }</ns1:PNUMEROTARJETA>
            <ns1:PPAISORIGEN>{ data($requestHeader1/Region/SourceBank) }</ns1:PPAISORIGEN>
            <ns1:PPUNTOSACUMULADOS>{ $strPuntos }</ns1:PPUNTOSACUMULADOS>
        </ns1:InputParameters>
};

declare variable $requestHeader1 as element(ns0:RequestHeader) external;
declare variable $strNumeroTarjeta as xs:string external;
declare variable $strPuntos as xs:string external;

xf:cambioPuntosANegativoIn($requestHeader1,
    $strNumeroTarjeta,
    $strPuntos)]]></con:xquery>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABKGT/cambiarPuntosANegativo/xsd/cambiarPuntosANegativo_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKGT/cambiarPuntosANegativo/xsd/cambiarPuntosANegativo_sp"/>
    </con:dependency>
</con:xqueryEntry>