<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaConsolidadaRiesgoCliente" location="../../ConsultaConsolidadaRiesgoCliente/xsd/consultaConsolidadaRiesgoClienteTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaConsolidadaRiesgoClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPrestamoATM/xq/consultaConsolidadaRiesgoClienteIn/";

declare function xf:consultaConsolidadaRiesgoClienteIn($legalId as xs:string)
    as element(ns0:consultaConsolidadaRiesgoCliente) {
        &lt;ns0:consultaConsolidadaRiesgoCliente>
            &lt;CUSTOMER_LEGAL_ID>{ $legalId }&lt;/CUSTOMER_LEGAL_ID>
        &lt;/ns0:consultaConsolidadaRiesgoCliente>
};

declare variable $legalId as xs:string external;

xf:consultaConsolidadaRiesgoClienteIn($legalId)</con:xquery>
    <con:dependency location="../../ConsultaConsolidadaRiesgoCliente/xsd/consultaConsolidadaRiesgoClienteTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaConsolidadaRiesgoCliente/xsd/consultaConsolidadaRiesgoClienteTypes"/>
    </con:dependency>
</con:xqueryEntry>