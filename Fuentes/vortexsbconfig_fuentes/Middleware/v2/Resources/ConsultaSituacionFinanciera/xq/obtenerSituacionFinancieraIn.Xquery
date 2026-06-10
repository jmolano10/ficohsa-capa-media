<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/INTFC/obtenerSituacionFinanciera/xsd/obtenerSituacionFinanciera_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerSituacionFinanciera";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSituacionFinanciera/xq/obtenerSituacionFinancieraIn/";

declare function xf:obtenerSituacionFinancieraIn($uuid as xs:string)
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:PV_REFERENCIA_LLAVE>{ $uuid }&lt;/ns0:PV_REFERENCIA_LLAVE>
        &lt;/ns0:InputParameters>
};

declare variable $uuid as xs:string external;

xf:obtenerSituacionFinancieraIn($uuid)</con:xquery>
    <con:dependency location="../../../BusinessServices/INTFC/obtenerSituacionFinanciera/xsd/obtenerSituacionFinanciera_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/INTFC/obtenerSituacionFinanciera/xsd/obtenerSituacionFinanciera_sp"/>
    </con:dependency>
</con:xqueryEntry>