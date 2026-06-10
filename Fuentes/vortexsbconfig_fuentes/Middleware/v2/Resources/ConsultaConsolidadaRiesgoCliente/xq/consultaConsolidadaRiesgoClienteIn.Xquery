<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaConsolidadaRiesgoCliente" element="ns1:consultaConsolidadaRiesgoCliente" location="../xsd/consultaConsolidadaRiesgoClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/DataWarehouse/consultaConsolidadaRiesgoCliente/xsd/consultaConsolidadaRiesgoCliente_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaConsolidadaRiesgoCliente/xq/consultaConsolidadaRiesgoClienteIn/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaConsolidadRiesgoCliente";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaConsolidadaRiesgoClienteTypes";

declare function xf:consultaConsolidadaRiesgoClienteIn($consultaConsolidadaRiesgoCliente as element(ns1:consultaConsolidadaRiesgoCliente))
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:IDENTIDAD>{ data($consultaConsolidadaRiesgoCliente/CUSTOMER_LEGAL_ID) }&lt;/ns0:IDENTIDAD>
        &lt;/ns0:InputParameters>
};

declare variable $consultaConsolidadaRiesgoCliente as element(ns1:consultaConsolidadaRiesgoCliente) external;

xf:consultaConsolidadaRiesgoClienteIn($consultaConsolidadaRiesgoCliente)</con:xquery>
    <con:dependency location="../xsd/consultaConsolidadaRiesgoClienteTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaConsolidadaRiesgoCliente/xsd/consultaConsolidadaRiesgoClienteTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/DataWarehouse/consultaConsolidadaRiesgoCliente/xsd/consultaConsolidadaRiesgoCliente_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/DataWarehouse/consultaConsolidadaRiesgoCliente/xsd/consultaConsolidadaRiesgoCliente_sp"/>
    </con:dependency>
</con:xqueryEntry>