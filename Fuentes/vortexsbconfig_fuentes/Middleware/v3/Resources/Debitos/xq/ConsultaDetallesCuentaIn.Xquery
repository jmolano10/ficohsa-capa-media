<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaDetallesCuenta" location="../../../../v2/Resources/ConsultaDetallesCuenta/xsd/consultaDetallesCuentaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/Debitos/xq/ConsultaDetallesCuentaIn/";

declare function xf:ConsultaDetallesCuentaIn($ACCOUNT_NUMBER as xs:string)
    as element(ns0:consultaDetallesCuenta) {
        &lt;ns0:consultaDetallesCuenta>
            &lt;ACCOUNT_NUMBER>{ $ACCOUNT_NUMBER }&lt;/ACCOUNT_NUMBER>
        &lt;/ns0:consultaDetallesCuenta>
};

declare variable $ACCOUNT_NUMBER as xs:string external;

xf:ConsultaDetallesCuentaIn($ACCOUNT_NUMBER)</con:xquery>
    <con:dependency location="../../../../v2/Resources/ConsultaDetallesCuenta/xsd/consultaDetallesCuentaTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaDetallesCuenta/xsd/consultaDetallesCuentaTypes"/>
    </con:dependency>
</con:xqueryEntry>