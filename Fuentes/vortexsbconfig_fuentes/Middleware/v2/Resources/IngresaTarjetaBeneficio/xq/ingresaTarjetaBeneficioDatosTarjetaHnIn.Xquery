<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaDatosTarjetaCredito" location="../../ConsultaDatosTarjetaCredito/xsd/consultaDatosTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTarjetaBeneficios/xq/ingresaTarjetaBeneficioDatosTarjetaHnIn/";

declare function xf:consultaTaarjetaBeneficioDatosTarjetaHnIn($numeroTarjeta as xs:string)
    as element(ns0:consultaDatosTarjetaCredito) {
        &lt;ns0:consultaDatosTarjetaCredito>
            &lt;CARD_NUMBER>{ xs:string(data($numeroTarjeta)) }&lt;/CARD_NUMBER>
        &lt;/ns0:consultaDatosTarjetaCredito>
};

declare variable $numeroTarjeta as xs:string external;

xf:consultaTaarjetaBeneficioDatosTarjetaHnIn($numeroTarjeta)</con:xquery>
    <con:dependency location="../../ConsultaDatosTarjetaCredito/xsd/consultaDatosTarjetaCreditoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaDatosTarjetaCredito/xsd/consultaDatosTarjetaCreditoTypes"/>
    </con:dependency>
</con:xqueryEntry>