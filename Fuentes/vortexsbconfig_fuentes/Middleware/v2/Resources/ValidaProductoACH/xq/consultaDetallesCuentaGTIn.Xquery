<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$validaProductoACH1" element="ns0:validaProductoACH" location="../xsd/validaProductoACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/consultaDetallesCuenta/xsd/consultaDetallesCuenta_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validaProductoACHTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaDetallesCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoACH/xq/consultaDetallesCuentaGTIn/";

declare function xf:consultaDetallesCuentaGTIn($validaProductoACH1 as element(ns0:validaProductoACH))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            &lt;ns1:ACCOUNT_NUMBER>{ data($validaProductoACH1/PRODUCT_NUMBER) }&lt;/ns1:ACCOUNT_NUMBER>
        &lt;/ns1:InputParameters>
};

declare variable $validaProductoACH1 as element(ns0:validaProductoACH) external;

xf:consultaDetallesCuentaGTIn($validaProductoACH1)</con:xquery>
    <con:dependency location="../xsd/validaProductoACHTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ValidaProductoACH/xsd/validaProductoACHTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABKGT/consultaDetallesCuenta/xsd/consultaDetallesCuenta_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKGT/consultaDetallesCuenta/xsd/consultaDetallesCuenta_sp"/>
    </con:dependency>
</con:xqueryEntry>