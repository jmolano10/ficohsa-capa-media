<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/consultaPorcentajeLevenstein/xsd/CONS_PORC_LEVENSTEIN_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/CONS_PORC_LEVENSTEIN";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/validacionCuenta/ValidacionCuenta2.0/ConsultaPorcentajeLevensteinOut/";

declare function xf:ConsultaPorcentajeLevensteinOut($outputParameters1 as element(ns0:OutputParameters))
    as xs:string {   
        data($outputParameters1/ns0:VA_PORCENTAJE)
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:ConsultaPorcentajeLevensteinOut($outputParameters1)</con:xquery>
    <con:dependency location="../../../BusinessServices/consultaPorcentajeLevenstein/xsd/CONS_PORC_LEVENSTEIN_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/consultaPorcentajeLevenstein/xsd/CONS_PORC_LEVENSTEIN_sp"/>
    </con:dependency>
</con:xqueryEntry>