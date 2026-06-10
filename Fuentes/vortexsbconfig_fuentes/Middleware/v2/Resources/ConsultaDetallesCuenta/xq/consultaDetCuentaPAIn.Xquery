<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDetallesCuenta" element="ns0:consultaDetallesCuenta" location="../xsd/consultaDetallesCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKPA/consultaDetallesCuenta/xsd/consultaDetallesCuenta_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDetallesCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetallesCuenta/xq/consultaDetCuentaPAIn/";

declare function xf:consultaDetCuentaPAIn($consultaDetallesCuenta as element(ns0:consultaDetallesCuenta))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            &lt;ns1:ACCOUNT_NUMBER>{ data($consultaDetallesCuenta/ACCOUNT_NUMBER) }&lt;/ns1:ACCOUNT_NUMBER>
        &lt;/ns1:InputParameters>
};

declare variable $consultaDetallesCuenta as element(ns0:consultaDetallesCuenta) external;

xf:consultaDetCuentaPAIn($consultaDetallesCuenta)</con:xquery>
    <con:dependency location="../xsd/consultaDetallesCuentaTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaDetallesCuenta/xsd/consultaDetallesCuentaTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABKPA/consultaDetallesCuenta/xsd/consultaDetallesCuenta_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKPA/consultaDetallesCuenta/xsd/consultaDetallesCuenta_sp"/>
    </con:dependency>
</con:xqueryEntry>