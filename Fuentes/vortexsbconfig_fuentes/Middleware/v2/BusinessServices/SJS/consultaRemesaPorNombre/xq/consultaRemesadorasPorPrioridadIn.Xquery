<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../MDW/consultaRemesadorasPorPrioridad/xsd/consultaRemesadorasPorPrioridad_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRemesadorasPorPrioridad";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaRemesaPorNombre/xq/sjConsultaRemesadorasPorPrioridad/";

declare function xf:sjConsultaRemesadorasPorPrioridad($string as xs:string)
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:PRIORIDAD>{ data($string) }&lt;/ns0:PRIORIDAD>
        &lt;/ns0:InputParameters>
};

declare variable $string as xs:string external;

xf:sjConsultaRemesadorasPorPrioridad($string)</con:xquery>
    <con:dependency location="../../../MDW/consultaRemesadorasPorPrioridad/xsd/consultaRemesadorasPorPrioridad_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MDW/consultaRemesadorasPorPrioridad/xsd/consultaRemesadorasPorPrioridad_sp"/>
    </con:dependency>
</con:xqueryEntry>