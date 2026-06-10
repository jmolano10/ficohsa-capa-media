<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaDatosTarjetaCredito" location="../../../../../Business_Resources/tarjetaCredito/ConsultaDatosTarjetaCredito/consultaDatosTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/marcaViajeroTCPA/xq/consultaDatosTarjetaCreditoPAIn/";

declare function xf:consultaDatosTarjetaCreditoPAIn($card as xs:string)
    as element(ns0:consultaDatosTarjetaCredito) {
        &lt;ns0:consultaDatosTarjetaCredito>
            &lt;CARD_NUMBER>{ $card }&lt;/CARD_NUMBER>
        &lt;/ns0:consultaDatosTarjetaCredito>
};

declare variable $card as xs:string external;

xf:consultaDatosTarjetaCreditoPAIn($card)</con:xquery>
    <con:dependency location="../../../../../Business_Resources/tarjetaCredito/ConsultaDatosTarjetaCredito/consultaDatosTarjetaCreditoTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/tarjetaCredito/ConsultaDatosTarjetaCredito/consultaDatosTarjetaCreditoTypes"/>
    </con:dependency>
</con:xqueryEntry>