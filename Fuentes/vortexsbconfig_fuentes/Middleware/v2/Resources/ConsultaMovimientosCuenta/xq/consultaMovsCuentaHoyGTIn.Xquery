<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaMovimientosCuenta1" element="ns0:consultaMovimientosCuenta" location="../../../../Business_Resources/ConsultasCuenta/Resources/consultasGeneralesCuentasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/consultaMovimientosCuentaHoy/xsd/consultaMovimientosCuentaHoy_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMovimientosCuentaHoy";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaMovimientosCuentaHoy/xq/consultaMovimientosCuentaHoyIn/";

declare function xf:consultaMovimientosCuentaHoyIn($consultaMovimientosCuenta1 as element(ns0:consultaMovimientosCuenta))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            &lt;ns1:ACCOUNT_NUMBER>{ data($consultaMovimientosCuenta1/ACCOUNT_NUMBER) }&lt;/ns1:ACCOUNT_NUMBER>
        &lt;/ns1:InputParameters>
};

declare variable $consultaMovimientosCuenta1 as element(ns0:consultaMovimientosCuenta) external;

xf:consultaMovimientosCuentaHoyIn($consultaMovimientosCuenta1)</con:xquery>
    <con:dependency location="../../../../Business_Resources/ConsultasCuenta/Resources/consultasGeneralesCuentasTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/ConsultasCuenta/Resources/consultasGeneralesCuentasTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABKGT/consultaMovimientosCuentaHoy/xsd/consultaMovimientosCuentaHoy_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKGT/consultaMovimientosCuentaHoy/xsd/consultaMovimientosCuentaHoy_sp"/>
    </con:dependency>
</con:xqueryEntry>