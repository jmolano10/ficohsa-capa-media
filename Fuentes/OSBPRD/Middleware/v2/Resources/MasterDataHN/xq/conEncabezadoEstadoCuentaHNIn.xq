xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterDataHN/conEncabezadoEstadoCuenta/xsd/conEncabezadoEstadoCuenta_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MasterDataHN/xq/conEncabezadoEstadoCuentaHNIn/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conEncabezadoEstadoCuenta";

declare function xf:conEncabezadoEstadoCuentaHNIn($countryCode as xs:string,
    $org as xs:string,
    $accountNumber as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ $countryCode }</ns0:Pais>
            <ns0:Org>{ $org }</ns0:Org>
            <ns0:NumCuenta>{ $accountNumber }</ns0:NumCuenta>
        </ns0:InputParameters>
};

declare variable $countryCode as xs:string external;
declare variable $org as xs:string external;
declare variable $accountNumber as xs:string external;

xf:conEncabezadoEstadoCuentaHNIn($countryCode,
    $org,
    $accountNumber)