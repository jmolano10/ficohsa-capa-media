<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../v2/BusinessServices/ABK/consultarPtmoMigrado/xsd/consultarPtmoMigrado_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarPtmoMigrado";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoPrestamo/consultaGeneralPrestamo/consultaPtmoMigradoIn/";

declare function xf:consultaPtmoMigradoIn($loanNumber as xs:string)
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            &lt;ns1:PV_NUMERO_PRESTAMO>{ $loanNumber }&lt;/ns1:PV_NUMERO_PRESTAMO>
        &lt;/ns1:InputParameters>
};

declare variable $loanNumber as xs:string external;

xf:consultaPtmoMigradoIn($loanNumber)</con:xquery>
    <con:dependency location="../../v2/BusinessServices/ABK/consultarPtmoMigrado/xsd/consultarPtmoMigrado_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABK/consultarPtmoMigrado/xsd/consultarPtmoMigrado_sp"/>
    </con:dependency>
</con:xqueryEntry>