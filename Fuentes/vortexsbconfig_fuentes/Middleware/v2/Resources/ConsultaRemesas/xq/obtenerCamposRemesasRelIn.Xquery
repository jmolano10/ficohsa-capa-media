<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MDW/obtenerCamposRemesasRel/xsd/obtenerCamposRemesasRel_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerCamposRemesasRel";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesas/xq/obtenerCamposRemesasRelIn/";

declare function xf:obtenerCamposRemesasRelIn($contrato as xs:decimal)
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:PN_ID_CONVENIO>{ $contrato }&lt;/ns0:PN_ID_CONVENIO>
        &lt;/ns0:InputParameters>
};

declare variable $contrato as xs:decimal external;

xf:obtenerCamposRemesasRelIn($contrato)</con:xquery>
    <con:dependency location="../../../BusinessServices/MDW/obtenerCamposRemesasRel/xsd/obtenerCamposRemesasRel_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MDW/obtenerCamposRemesasRel/xsd/obtenerCamposRemesasRel_sp"/>
    </con:dependency>
</con:xqueryEntry>