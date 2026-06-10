<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterData/conEncabezadoEstadoCuenta/xsd/conEncabezadoEstadoCuenta_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conEncabezadoEstadoCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MasterData/xq/conEncabezadoEstadoCuentaIn/";

declare function xf:conEncabezadoEstadoCuentaIn($org as xs:string,
    $accountNumber as xs:string, $codigoPais as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{$codigoPais}</ns0:Pais>
            <ns0:Org>{ $org }</ns0:Org>
            <ns0:NumCuenta>{ fn-bea:pad-left($accountNumber, 19, '0') }</ns0:NumCuenta>
        </ns0:InputParameters>
};

declare variable $org as xs:string external;
declare variable $accountNumber as xs:string external;
declare variable $codigoPais as xs:string external;

xf:conEncabezadoEstadoCuentaIn($org,
    $accountNumber, $codigoPais)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/MasterData/conEncabezadoEstadoCuenta/xsd/conEncabezadoEstadoCuenta_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MasterData/conEncabezadoEstadoCuenta/xsd/conEncabezadoEstadoCuenta_sp"/>
    </con:dependency>
</con:xqueryEntry>