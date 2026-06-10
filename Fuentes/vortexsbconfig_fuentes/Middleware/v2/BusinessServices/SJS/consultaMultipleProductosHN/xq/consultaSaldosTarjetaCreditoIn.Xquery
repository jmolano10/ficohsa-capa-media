<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaDatosTarjetaCredito" location="../../../../Resources/ConsultaDatosTarjetaCredito/xsd/consultaDatosTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosHN/xq/consultaSaldosTarjetaCreditoIn/";

declare function xf:consultaSaldosTarjetaCreditoIn($ID as xs:string)
    as element(ns0:consultaDatosTarjetaCredito) {
        &lt;ns0:consultaDatosTarjetaCredito>
            &lt;CARD_NUMBER>{ $ID }&lt;/CARD_NUMBER>
        &lt;/ns0:consultaDatosTarjetaCredito>
};

declare variable $ID as xs:string external;

xf:consultaSaldosTarjetaCreditoIn($ID)</con:xquery>
    <con:dependency location="../../../../Resources/ConsultaDatosTarjetaCredito/xsd/consultaDatosTarjetaCreditoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaDatosTarjetaCredito/xsd/consultaDatosTarjetaCreditoTypes"/>
    </con:dependency>
</con:xqueryEntry>