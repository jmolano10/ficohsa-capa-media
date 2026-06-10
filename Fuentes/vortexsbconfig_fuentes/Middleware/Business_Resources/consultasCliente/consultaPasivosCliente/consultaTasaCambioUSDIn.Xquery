<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaTasaCambio" location="../../Core/consultaTasaCambio/consultaTasaCambioTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTasaCambioTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaPasivosCliente/consultaTasaCambioUSDIn/";

declare function xf:consultaTasaCambioUSDIn($monedaLocal as xs:string,
    $monedaExtranjera as xs:string)
    as element(ns0:consultaTasaCambio) {
        <ns0:consultaTasaCambio>
            <SOURCE_CURRENCY>{ $monedaLocal }</SOURCE_CURRENCY>
            <TARGET_CURRENCY>{ $monedaExtranjera }</TARGET_CURRENCY>
        </ns0:consultaTasaCambio>
};

declare variable $monedaLocal as xs:string external;
declare variable $monedaExtranjera as xs:string external;

xf:consultaTasaCambioUSDIn($monedaLocal,
    $monedaExtranjera)]]></con:xquery>
    <con:dependency location="../../Core/consultaTasaCambio/consultaTasaCambioTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/Core/consultaTasaCambio/consultaTasaCambioTypes"/>
    </con:dependency>
</con:xqueryEntry>