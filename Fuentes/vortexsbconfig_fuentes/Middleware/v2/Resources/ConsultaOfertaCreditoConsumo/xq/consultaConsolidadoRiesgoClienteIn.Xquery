<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaConsolidadaRiesgoCliente" location="../../ConsultaConsolidadaRiesgoCliente/xsd/consultaConsolidadaRiesgoClienteTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaConsolidadaRiesgoClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaOfertaCreditoConsumo/xq/consultaConsolidadoRiesgoClienteIn/";

declare function xf:consultaConsolidadoRiesgoClienteIn($customerLegalID as xs:string)
    as element(ns0:consultaConsolidadaRiesgoCliente) {
        &lt;ns0:consultaConsolidadaRiesgoCliente>
            &lt;CUSTOMER_LEGAL_ID>{ $customerLegalID }&lt;/CUSTOMER_LEGAL_ID>
        &lt;/ns0:consultaConsolidadaRiesgoCliente>
};

declare variable $customerLegalID as xs:string external;

xf:consultaConsolidadoRiesgoClienteIn($customerLegalID)</con:xquery>
    <con:dependency location="../../ConsultaConsolidadaRiesgoCliente/xsd/consultaConsolidadaRiesgoClienteTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaConsolidadaRiesgoCliente/xsd/consultaConsolidadaRiesgoClienteTypes"/>
    </con:dependency>
</con:xqueryEntry>