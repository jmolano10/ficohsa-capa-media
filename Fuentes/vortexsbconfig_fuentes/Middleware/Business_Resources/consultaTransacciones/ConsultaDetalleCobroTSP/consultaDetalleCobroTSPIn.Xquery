<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../Resources/ConsultaDetalleCobroTSP/xsd/consultaDetalleCobroTSP_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDetalleCobroTSP";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaTransacciones/ConsultaDetalleCobroTSP/consultaDetalleCobroTSPIn/";

declare function xf:consultaDetalleCobroTSPIn($string1 as xs:string)
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:REFERENCIA>{ $string1 }&lt;/ns0:REFERENCIA>
        &lt;/ns0:InputParameters>
};

declare variable $string1 as xs:string external;

xf:consultaDetalleCobroTSPIn($string1)</con:xquery>
    <con:dependency location="../Resources/ConsultaDetalleCobroTSP/xsd/consultaDetalleCobroTSP_sp.xsd">
        <con:schema ref="Middleware/Business_Resources/consultaTransacciones/Resources/ConsultaDetalleCobroTSP/xsd/consultaDetalleCobroTSP_sp"/>
    </con:dependency>
</con:xqueryEntry>