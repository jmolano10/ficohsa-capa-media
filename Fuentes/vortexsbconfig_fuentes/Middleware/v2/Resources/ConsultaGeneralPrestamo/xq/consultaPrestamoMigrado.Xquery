<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABK/consultarPtmoMigrado/xsd/consultarPtmoMigrado_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarPtmoMigrado";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaGeneralPrestamo/xq/consultaPrestamoMigrado/";

declare function xf:consultaPrestamoMigrado($NumerPrestamo as xs:string)
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:PV_NUMERO_PRESTAMO>{ $NumerPrestamo }&lt;/ns0:PV_NUMERO_PRESTAMO>
        &lt;/ns0:InputParameters>
};

declare variable $NumerPrestamo as xs:string external;

xf:consultaPrestamoMigrado($NumerPrestamo)</con:xquery>
    <con:dependency location="../../../BusinessServices/ABK/consultarPtmoMigrado/xsd/consultarPtmoMigrado_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABK/consultarPtmoMigrado/xsd/consultarPtmoMigrado_sp"/>
    </con:dependency>
</con:xqueryEntry>