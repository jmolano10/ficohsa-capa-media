<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$validaProductoCliente" element="ns0:validaProductoCliente" location="../../ValidaProductoCliente/xsd/validaProductoClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/consultaDetallesCuenta/xsd/consultaDetallesCuenta_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validaProductoClienteTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaDetallesCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoClienteGT/xq/validaProductoClienteCTAGTIn/";

declare function xf:validaProductoClienteCTAGTIn($validaProductoCliente as element(ns0:validaProductoCliente))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            &lt;ns1:ACCOUNT_NUMBER>{ data($validaProductoCliente/PRODUCT_NUMBER) }&lt;/ns1:ACCOUNT_NUMBER>
        &lt;/ns1:InputParameters>
};

declare variable $validaProductoCliente as element(ns0:validaProductoCliente) external;

xf:validaProductoClienteCTAGTIn($validaProductoCliente)</con:xquery>
    <con:dependency location="../../ValidaProductoCliente/xsd/validaProductoClienteTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ValidaProductoCliente/xsd/validaProductoClienteTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABKGT/consultaDetallesCuenta/xsd/consultaDetallesCuenta_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKGT/consultaDetallesCuenta/xsd/consultaDetallesCuenta_sp"/>
    </con:dependency>
</con:xqueryEntry>