<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaEstadoCuentaTC1" element="ns0:consultaEstadoCuentaTC" location="../../../../Business_Resources/tarjetaCredito/ConsultaEstadoCuentaTC/consultaEstadoCuentaTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultarEstadosCuentaUltimoCorte" location="../../../BusinessServices/ABKGT/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoCuentaTCTypes";
declare namespace ns1 = "http://alcance.local/wsinfotarjetas/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaEstadoCuentaTC/xq/consultaEstadoCuentaTCIn/";

declare function xf:consultaEstadoCuentaTCGTIn($numeroTarjeta as xs:string)
    as element(ns1:ConsultarEstadosCuentaUltimoCorte) {
        &lt;ns1:ConsultarEstadosCuentaUltimoCorte>
            &lt;ns1:noTarjetaCredito>{ data($numeroTarjeta) }&lt;/ns1:noTarjetaCredito>
        &lt;/ns1:ConsultarEstadosCuentaUltimoCorte>
};

declare variable $numeroTarjeta as xs:string external;

xf:consultaEstadoCuentaTCGTIn($numeroTarjeta)</con:xquery>
    <con:dependency location="../../../../Business_Resources/tarjetaCredito/ConsultaEstadoCuentaTC/consultaEstadoCuentaTCTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/tarjetaCredito/ConsultaEstadoCuentaTC/consultaEstadoCuentaTCTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABKGT/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/ABKGT/transaccionesAlcance/wsdl/wsinfotarjetas.asmx"/>
    </con:dependency>
</con:xqueryEntry>