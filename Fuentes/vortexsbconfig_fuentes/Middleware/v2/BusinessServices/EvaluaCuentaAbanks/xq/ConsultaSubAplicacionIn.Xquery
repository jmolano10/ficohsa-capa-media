<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../consultaSubaplicacionValida/xsd/CONS_SUBAPP_VALIDA_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/CONS_SUBAPP_VALIDA";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/validacionCuenta/ValidacionCuenta2.0/EvaluaCuentaAbanks/ConsultaSubAplicacionIn/";

declare function xf:ConsultaSubAplicacionIn($subApplicacion as xs:string)
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:VA_SUBAPLICACION>{ $subApplicacion }&lt;/ns0:VA_SUBAPLICACION>
        &lt;/ns0:InputParameters>
};

declare variable $subApplicacion as xs:string external;

xf:ConsultaSubAplicacionIn($subApplicacion)</con:xquery>
    <con:dependency location="../../consultaSubaplicacionValida/xsd/CONS_SUBAPP_VALIDA_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/consultaSubaplicacionValida/xsd/CONS_SUBAPP_VALIDA_sp"/>
    </con:dependency>
</con:xqueryEntry>