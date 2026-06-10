<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:ConsultarEstadosCuentaUltimoCorte" location="../../../../v2/BusinessServices/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns0 = "http://alcance.local/wsinfotarjetas/";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoTarjetaCredito/xq/validacionTarjeta_PAIn/";

declare function xf:validacionTarjeta_PAIn($CreditCardNumber as xs:string)
    as element(ns0:ConsultarEstadosCuentaUltimoCorte) {
        &lt;ns0:ConsultarEstadosCuentaUltimoCorte>
            &lt;ns0:noTarjetaCredito>{ $CreditCardNumber }&lt;/ns0:noTarjetaCredito>
        &lt;/ns0:ConsultarEstadosCuentaUltimoCorte>
};

declare variable $CreditCardNumber as xs:string external;

xf:validacionTarjeta_PAIn($CreditCardNumber)</con:xquery>
    <con:dependency location="../../../../v2/BusinessServices/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/transaccionesAlcance/wsdl/wsinfotarjetas.asmx"/>
    </con:dependency>
</con:xqueryEntry>