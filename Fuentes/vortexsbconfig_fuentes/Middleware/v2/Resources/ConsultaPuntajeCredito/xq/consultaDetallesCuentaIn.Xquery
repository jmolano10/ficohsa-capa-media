<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaDetallesCuenta" location="../../ConsultaDetallesCuenta/xsd/consultaDetallesCuentaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPuntajeCredito/xq/consultaDetallesCuentaIn/";

declare function xf:consultaDetallesCuentaIn($accountNumber as xs:string)
    as element(ns0:consultaDetallesCuenta) {
        &lt;ns0:consultaDetallesCuenta>
            &lt;ACCOUNT_NUMBER>{ $accountNumber }&lt;/ACCOUNT_NUMBER>
        &lt;/ns0:consultaDetallesCuenta>
};

declare variable $accountNumber as xs:string external;

xf:consultaDetallesCuentaIn($accountNumber)</con:xquery>
    <con:dependency location="../../ConsultaDetallesCuenta/xsd/consultaDetallesCuentaTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaDetallesCuenta/xsd/consultaDetallesCuentaTypes"/>
    </con:dependency>
</con:xqueryEntry>