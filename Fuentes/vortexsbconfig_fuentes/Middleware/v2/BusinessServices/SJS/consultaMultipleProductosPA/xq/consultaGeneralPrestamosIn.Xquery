<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../ABKPA/consultaGeneralPrestamo/xsd/consultaGeneralPrestamo_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaGeneralPrestamo";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosPA/xq/consultaGeneralPrestamosIn/";

declare function xf:consultaGeneralPrestamosIn($ID as xs:string)
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:LOAN_ID>{ $ID }&lt;/ns0:LOAN_ID>
        &lt;/ns0:InputParameters>
};

declare variable $ID as xs:string external;

xf:consultaGeneralPrestamosIn($ID)</con:xquery>
    <con:dependency location="../../../ABKPA/consultaGeneralPrestamo/xsd/consultaGeneralPrestamo_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKPA/consultaGeneralPrestamo/xsd/consultaGeneralPrestamo_sp"/>
    </con:dependency>
</con:xqueryEntry>