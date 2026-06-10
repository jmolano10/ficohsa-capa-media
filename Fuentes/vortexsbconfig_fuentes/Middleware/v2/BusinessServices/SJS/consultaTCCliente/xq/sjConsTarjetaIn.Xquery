<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:ConsultarSaldosVasa" location="../../../transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns0 = "http://alcance.local/wsinfotarjetas/";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaTCCliente/xq/sjConsTarjetaIn/";

declare function xf:sjConsTarjetaIn($cardNumber as xs:string)
    as element(ns0:ConsultarSaldosVasa) {
        &lt;ns0:ConsultarSaldosVasa>
            &lt;ns0:noTarjetaCredito>{ $cardNumber }&lt;/ns0:noTarjetaCredito>
        &lt;/ns0:ConsultarSaldosVasa>
};

declare variable $cardNumber as xs:string external;

xf:sjConsTarjetaIn($cardNumber)</con:xquery>
    <con:dependency location="../../../transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/transaccionesAlcance/wsdl/wsinfotarjetas.asmx"/>
    </con:dependency>
</con:xqueryEntry>