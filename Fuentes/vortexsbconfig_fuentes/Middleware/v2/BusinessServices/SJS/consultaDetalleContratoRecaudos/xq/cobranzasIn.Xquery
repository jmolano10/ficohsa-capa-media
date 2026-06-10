<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../CNV/consultaContratosReferenciados/xsd/consultaContratoReferenciado_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaContratoReferenciado";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleContratoRecaudosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleContratoRecaudos/xq/CobranzasIn/";

declare function xf:CobranzasIn($contractId as xs:string)
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:CODIGO_CONTRATO>{ $contractId }&lt;/ns0:CODIGO_CONTRATO>
        &lt;/ns0:InputParameters>
};

declare variable $contractId as xs:string external;

xf:CobranzasIn($contractId)</con:xquery>
    <con:dependency location="../../../CNV/consultaContratosReferenciados/xsd/consultaContratoReferenciado_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/CNV/consultaContratosReferenciados/xsd/consultaContratoReferenciado_sp"/>
    </con:dependency>
</con:xqueryEntry>