xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ActualizaDatosGFF/ObtenerEquivalencia/xsd/obtenerEquivalencia_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraDatosActualizados/xq/obtenerEquivalenciaIn/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerEquivalencia";

declare function xf:obtenerEquivalenciaIn($uuid as xs:string,
    $customerId as xs:string,
    $targetSystem as xs:string,
    $targetCountry as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:P_UUID>{ $uuid }</ns0:P_UUID>
            <ns0:P_CUSTOMER_ID>{ $customerId }</ns0:P_CUSTOMER_ID>
            <ns0:P_TARGET_SYSTEM>{ string($targetSystem) }</ns0:P_TARGET_SYSTEM>
            <ns0:P_TARGET_COUNTRY>{ $targetCountry }</ns0:P_TARGET_COUNTRY>
        </ns0:InputParameters>
};

declare variable $uuid as xs:string external;
declare variable $customerId as xs:string external;
declare variable $targetSystem as xs:string external;
declare variable $targetCountry as xs:string external;

xf:obtenerEquivalenciaIn($uuid,
    $customerId,
    $targetSystem,
    $targetCountry)