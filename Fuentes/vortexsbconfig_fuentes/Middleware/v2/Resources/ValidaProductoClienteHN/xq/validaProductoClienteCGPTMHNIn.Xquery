<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$validaProductoCliente" element="ns0:validaProductoCliente" location="../../ValidaProductoCliente/xsd/validaProductoClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../../Business_Resources/consultaGeneralPrestamo/Resources/ConsultaGeneralPrestamo/xsd/ORA_BANK_OSB_CON_GENERAL_PRESTAMO.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validaProductoClienteTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_CON_GENERAL_PRESTAMO/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoClienteHN/xq/validaProductoClienteCGPTMHNIn/";

declare function xf:validaProductoClienteCGPTMHNIn($validaProductoCliente as element(ns0:validaProductoCliente))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            &lt;ns1:LOAN_ID>{ data($validaProductoCliente/PRODUCT_NUMBER) }&lt;/ns1:LOAN_ID>
        &lt;/ns1:InputParameters>
};

declare variable $validaProductoCliente as element(ns0:validaProductoCliente) external;

xf:validaProductoClienteCGPTMHNIn($validaProductoCliente)</con:xquery>
    <con:dependency location="../../ValidaProductoCliente/xsd/validaProductoClienteTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ValidaProductoCliente/xsd/validaProductoClienteTypes"/>
    </con:dependency>
    <con:dependency location="../../../../Business_Resources/consultaGeneralPrestamo/Resources/ConsultaGeneralPrestamo/xsd/ORA_BANK_OSB_CON_GENERAL_PRESTAMO.xsd">
        <con:schema ref="Middleware/Business_Resources/consultaGeneralPrestamo/Resources/ConsultaGeneralPrestamo/xsd/ORA_BANK_OSB_CON_GENERAL_PRESTAMO"/>
    </con:dependency>
</con:xqueryEntry>