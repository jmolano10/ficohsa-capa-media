<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaSaldosTarjetaCredito1" element="ns0:consultaSaldosTarjetaCredito" location="../xsd/consultaSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultarSaldosVasa" location="../../../BusinessServices/ABKGT/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace ns1 = "http://alcance.local/wsinfotarjetas/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/consultaSaldosTarjetaCredito/xq/consultaSaldosTarjetaCreditoIn/";

declare function xf:consultaSaldosTarjetaCreditoIn($consultaSaldosTarjetaCredito1 as element(ns0:consultaSaldosTarjetaCredito))
    as element(ns1:ConsultarSaldosVasa) {
        &lt;ns1:ConsultarSaldosVasa>
            &lt;ns1:noTarjetaCredito>{ data($consultaSaldosTarjetaCredito1/CARD_NUMBER) }&lt;/ns1:noTarjetaCredito>
        &lt;/ns1:ConsultarSaldosVasa>
};

declare variable $consultaSaldosTarjetaCredito1 as element(ns0:consultaSaldosTarjetaCredito) external;

xf:consultaSaldosTarjetaCreditoIn($consultaSaldosTarjetaCredito1)</con:xquery>
    <con:dependency location="../xsd/consultaSaldosTarjetaCreditoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xsd/consultaSaldosTarjetaCreditoTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABKGT/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/ABKGT/transaccionesAlcance/wsdl/wsinfotarjetas.asmx"/>
    </con:dependency>
</con:xqueryEntry>