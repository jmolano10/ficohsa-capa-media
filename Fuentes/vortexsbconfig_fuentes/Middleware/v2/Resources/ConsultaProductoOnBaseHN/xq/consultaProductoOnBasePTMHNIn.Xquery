<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaProductoOnBase" element="ns0:consultaProductoOnBase" location="../../ConsultaProductoOnBase/xsd/consultaProductoOnBaseTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../../Business_Resources/consultasCliente/Resources/ConsultaListaPrestamos/xsd/ORA_BANK_OSB_K_CONSULTALISTAPRESTAMOS_TOPLEVEL-24OSB_CON_LISTA_PRESTA.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaProductoOnBaseTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_K_CONSULTALISTAPRESTAMOS/TOPLEVEL-24OSB_CON_LISTA_PRESTA/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProductoOnBaseHN/xq/consultaProductoOnBasePTMHNIn/";

declare function xf:consultaProductoOnBasePTMHNIn($consultaProductoOnBase as element(ns0:consultaProductoOnBase))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            &lt;ns1:CUSTOMER_ID>{ data($consultaProductoOnBase/CUSTOMER_ID) }&lt;/ns1:CUSTOMER_ID>
        &lt;/ns1:InputParameters>
};

declare variable $consultaProductoOnBase as element(ns0:consultaProductoOnBase) external;

xf:consultaProductoOnBasePTMHNIn($consultaProductoOnBase)</con:xquery>
    <con:dependency location="../../ConsultaProductoOnBase/xsd/consultaProductoOnBaseTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaProductoOnBase/xsd/consultaProductoOnBaseTypes"/>
    </con:dependency>
    <con:dependency location="../../../../Business_Resources/consultasCliente/Resources/ConsultaListaPrestamos/xsd/ORA_BANK_OSB_K_CONSULTALISTAPRESTAMOS_TOPLEVEL-24OSB_CON_LISTA_PRESTA.xsd">
        <con:schema ref="Middleware/Business_Resources/consultasCliente/Resources/ConsultaListaPrestamos/xsd/ORA_BANK_OSB_K_CONSULTALISTAPRESTAMOS_TOPLEVEL-24OSB_CON_LISTA_PRESTA"/>
    </con:dependency>
</con:xqueryEntry>