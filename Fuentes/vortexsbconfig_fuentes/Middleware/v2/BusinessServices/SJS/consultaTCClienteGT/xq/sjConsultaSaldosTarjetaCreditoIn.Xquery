<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaSaldosTarjetaCredito" location="../../../../Resources/ConsultaSaldosTarjetaCredito/xsd/consultaSaldosTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaTCClienteGT/xq/sjConsultaSaldosTarjetaCreditoIn/";

declare function xf:sjConsultaSaldosTarjetaCreditoIn($cardNumber as xs:string)
    as element(ns0:consultaSaldosTarjetaCredito) {
        &lt;ns0:consultaSaldosTarjetaCredito>
            &lt;CARD_NUMBER>{ $cardNumber }&lt;/CARD_NUMBER>
        &lt;/ns0:consultaSaldosTarjetaCredito>
};

declare variable $cardNumber as xs:string external;

xf:sjConsultaSaldosTarjetaCreditoIn($cardNumber)</con:xquery>
    <con:dependency location="../../../../Resources/ConsultaSaldosTarjetaCredito/xsd/consultaSaldosTarjetaCreditoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xsd/consultaSaldosTarjetaCreditoTypes"/>
    </con:dependency>
</con:xqueryEntry>