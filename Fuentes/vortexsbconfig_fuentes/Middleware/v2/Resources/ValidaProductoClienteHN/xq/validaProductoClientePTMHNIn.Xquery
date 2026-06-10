<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$validaProductoCliente" element="ns0:validaProductoCliente" location="../../ValidaProductoCliente/xsd/validaProductoClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../../Business_Resources/consultasCliente/Resources/ConsultaListaPrestamos/xsd/ORA_BANK_OSB_K_CONSULTALISTAPRESTAMOS_TOPLEVEL-24OSB_CON_LISTA_PRESTA.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validaProductoClienteTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_K_CONSULTALISTAPRESTAMOS/TOPLEVEL-24OSB_CON_LISTA_PRESTA/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoClienteHN/xq/validaProductoClientePTMHNIn/";

declare function xf:validaProductoClientePTMHNIn($validaProductoCliente as element(ns0:validaProductoCliente))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            &lt;ns1:CUSTOMER_ID>{ data($validaProductoCliente/CUSTOMER_ID) }&lt;/ns1:CUSTOMER_ID>
        &lt;/ns1:InputParameters>
};

declare variable $validaProductoCliente as element(ns0:validaProductoCliente) external;

xf:validaProductoClientePTMHNIn($validaProductoCliente)</con:xquery>
    <con:dependency location="../../ValidaProductoCliente/xsd/validaProductoClienteTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ValidaProductoCliente/xsd/validaProductoClienteTypes"/>
    </con:dependency>
    <con:dependency location="../../../../Business_Resources/consultasCliente/Resources/ConsultaListaPrestamos/xsd/ORA_BANK_OSB_K_CONSULTALISTAPRESTAMOS_TOPLEVEL-24OSB_CON_LISTA_PRESTA.xsd">
        <con:schema ref="Middleware/Business_Resources/consultasCliente/Resources/ConsultaListaPrestamos/xsd/ORA_BANK_OSB_K_CONSULTALISTAPRESTAMOS_TOPLEVEL-24OSB_CON_LISTA_PRESTA"/>
    </con:dependency>
</con:xqueryEntry>