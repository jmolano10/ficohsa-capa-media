<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaMovimientosRecientesTC1" element="ns1:consultaMovimientosRecientesTC" location="consultaMovimientosRecientesTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultarMovsRecientes" location="../Resources/TarjetaDeCredito.wsdl" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMovimientosRecientesTCTypes";
declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/ConsultaMovimientosRecientesTC/consultaMovimientosRecientesTCIn/";

declare function xf:consultaMovimientosRecientesTCIn($consultaMovimientosRecientesTC1 as element(ns1:consultaMovimientosRecientesTC))
    as element(ns0:ConsultarMovsRecientes) {
        &lt;ns0:ConsultarMovsRecientes>
            &lt;ns0:noTarjetaCredito>{ data($consultaMovimientosRecientesTC1/CARD_NUMBER) }&lt;/ns0:noTarjetaCredito>
        &lt;/ns0:ConsultarMovsRecientes>
};

declare variable $consultaMovimientosRecientesTC1 as element(ns1:consultaMovimientosRecientesTC) external;

xf:consultaMovimientosRecientesTCIn($consultaMovimientosRecientesTC1)</con:xquery>
    <con:dependency location="consultaMovimientosRecientesTCTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/tarjetaCredito/ConsultaMovimientosRecientesTC/consultaMovimientosRecientesTCTypes"/>
    </con:dependency>
    <con:dependency location="../Resources/TarjetaDeCredito.wsdl">
        <con:wsdl ref="Middleware/Business_Resources/tarjetaCredito/Resources/TarjetaDeCredito"/>
    </con:dependency>
</con:xqueryEntry>