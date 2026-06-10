<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/consultaGeneralPrestamo/xsd/ConsultaGeneralPrestamo_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaGeneralPrestamo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoClienteGT/xq/consultaGeneralPTMGTIn/";

declare function xf:consultaGeneralPTMGTIn($ProductNumber as xs:string)
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:LOAN_ID>{ $ProductNumber }&lt;/ns0:LOAN_ID>
        &lt;/ns0:InputParameters>
};

declare variable $ProductNumber as xs:string external;

xf:consultaGeneralPTMGTIn($ProductNumber)</con:xquery>
    <con:dependency location="../../../BusinessServices/ABKGT/consultaGeneralPrestamo/xsd/ConsultaGeneralPrestamo_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKGT/consultaGeneralPrestamo/xsd/ConsultaGeneralPrestamo_sp"/>
    </con:dependency>
</con:xqueryEntry>