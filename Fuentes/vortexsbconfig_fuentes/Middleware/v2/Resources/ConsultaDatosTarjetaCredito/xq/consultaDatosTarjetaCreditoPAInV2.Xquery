<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InformacionTarjetaActual" location="../../../BusinessServices/ABKPA/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns0 = "http://alcance.local/wsinfotarjetas/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatosTarjetaCredito/xq/consultaDatosTarjetaCreditoPAInV2/";

declare function xf:consultaDatosTarjetaCreditoPAInV2($noTarjeta as xs:string)
    as element(ns0:InformacionTarjetaActual) {
        &lt;ns0:InformacionTarjetaActual>
            &lt;ns0:noTarjetaCredito>{ fn:string($noTarjeta) }&lt;/ns0:noTarjetaCredito>
        &lt;/ns0:InformacionTarjetaActual>
};

declare variable $noTarjeta as xs:string external;

xf:consultaDatosTarjetaCreditoPAInV2($noTarjeta)</con:xquery>
    <con:dependency location="../../../BusinessServices/ABKPA/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/ABKPA/transaccionesAlcance/wsdl/wsinfotarjetas.asmx"/>
    </con:dependency>
</con:xqueryEntry>