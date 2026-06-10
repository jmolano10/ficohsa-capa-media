<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaSaldosTarjetaCredito" location="../../../../../Business_Resources/tarjetaCredito/ConsultaSaldosTarjetaCredito/consultaSaldosTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosNI/xq/consultaSaldosTCIn/";

declare function xf:consultaSaldosTCIn($productID as xs:string)
    as element(ns0:consultaSaldosTarjetaCredito) {
        &lt;ns0:consultaSaldosTarjetaCredito>
            &lt;CARD_NUMBER>{ $productID }&lt;/CARD_NUMBER>
        &lt;/ns0:consultaSaldosTarjetaCredito>
};

declare variable $productID as xs:string external;

xf:consultaSaldosTCIn($productID)</con:xquery>
    <con:dependency location="../../../../../Business_Resources/tarjetaCredito/ConsultaSaldosTarjetaCredito/consultaSaldosTarjetaCreditoTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/tarjetaCredito/ConsultaSaldosTarjetaCredito/consultaSaldosTarjetaCreditoTypes"/>
    </con:dependency>
</con:xqueryEntry>