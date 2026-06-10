<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaEstadoCuentaTC1" element="ns0:consultaEstadoCuentaTC" location="consultaEstadoCuentaTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultarUltimoEC" location="../Resources/TarjetaDeCredito.wsdl" ::)

declare namespace ns1 = "http://tempuri.org/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoCuentaTCTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/ConsultaEstadoCuentaTC/consultaEstadoCuentaTCIn/";

declare function xf:consultaEstadoCuentaTCIn($consultaEstadoCuentaTC1 as element(ns0:consultaEstadoCuentaTC))
    as element(ns1:ConsultarUltimoEC) {
        &lt;ns1:ConsultarUltimoEC>
            &lt;ns1:noTarjetaCredito>{ data($consultaEstadoCuentaTC1/CARD_NUMBER) }&lt;/ns1:noTarjetaCredito>
        &lt;/ns1:ConsultarUltimoEC>
};

declare variable $consultaEstadoCuentaTC1 as element(ns0:consultaEstadoCuentaTC) external;

xf:consultaEstadoCuentaTCIn($consultaEstadoCuentaTC1)</con:xquery>
    <con:dependency location="consultaEstadoCuentaTCTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/tarjetaCredito/ConsultaEstadoCuentaTC/consultaEstadoCuentaTCTypes"/>
    </con:dependency>
    <con:dependency location="../Resources/TarjetaDeCredito.wsdl">
        <con:wsdl ref="Middleware/Business_Resources/tarjetaCredito/Resources/TarjetaDeCredito"/>
    </con:dependency>
</con:xqueryEntry>