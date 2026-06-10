<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:ConsultarSaldosVasa" location="../../../ABKPA/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns0 = "http://alcance.local/wsinfotarjetas/";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosPA/xq/transaccionesAlcanceIn/";

declare function xf:transaccionesAlcanceIn($ID as xs:string)
    as element(ns0:ConsultarSaldosVasa) {
        &lt;ns0:ConsultarSaldosVasa>
            &lt;ns0:noTarjetaCredito>{ $ID }&lt;/ns0:noTarjetaCredito>
        &lt;/ns0:ConsultarSaldosVasa>
};

declare variable $ID as xs:string external;

xf:transaccionesAlcanceIn($ID)</con:xquery>
    <con:dependency location="../../../ABKPA/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/ABKPA/transaccionesAlcance/wsdl/wsinfotarjetas.asmx"/>
    </con:dependency>
</con:xqueryEntry>