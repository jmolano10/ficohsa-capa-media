<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaSaldosTarjetaCredito1" element="ns1:consultaSaldosTarjetaCredito" location="consultaSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultarSaldos" location="../Resources/TarjetaDeCredito.wsdl" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/ConsultaSaldosTarjetaCredito/consultaSaldosTarjetaCreditoIn/";

declare function xf:consultaSaldosTarjetaCreditoIn($consultaSaldosTarjetaCredito1 as element(ns1:consultaSaldosTarjetaCredito))
    as element(ns0:consultarSaldos) {
        &lt;ns0:consultarSaldos>
            &lt;ns0:noTarjetaCredito>{ data($consultaSaldosTarjetaCredito1/CARD_NUMBER) }&lt;/ns0:noTarjetaCredito>
        &lt;/ns0:consultarSaldos>
};

declare variable $consultaSaldosTarjetaCredito1 as element(ns1:consultaSaldosTarjetaCredito) external;

xf:consultaSaldosTarjetaCreditoIn($consultaSaldosTarjetaCredito1)</con:xquery>
    <con:dependency location="consultaSaldosTarjetaCreditoTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/tarjetaCredito/ConsultaSaldosTarjetaCredito/consultaSaldosTarjetaCreditoTypes"/>
    </con:dependency>
    <con:dependency location="../Resources/TarjetaDeCredito.wsdl">
        <con:wsdl ref="Middleware/Business_Resources/tarjetaCredito/Resources/TarjetaDeCredito"/>
    </con:dependency>
</con:xqueryEntry>