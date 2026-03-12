xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conTransaccionesActuales_v2";
(:: import schema at "../Schemas/conTransaccionesActuales_v2_sp.xsd" ::)

declare variable $codPais as xs:string external;
declare variable $org as xs:string external;
declare variable $numeroTarjetaCuenta as xs:string external;
declare variable $tipo as xs:string external;

declare function local:conTransaccionesActualesIn($codPais as xs:string,
    $org as xs:string,
    $numeroTarjetaCuenta as xs:string,
    $tipo as xs:string)
    as element() (:: schema-element(ns0:InputParameters) ::) {
        <ns0:InputParameters>
            <ns0:Pais>{ $codPais }</ns0:Pais>
            <ns0:Org>{ $org }</ns0:Org>
            <ns0:NumCuenta>{ data($numeroTarjetaCuenta) }</ns0:NumCuenta>
            <ns0:Tipo>{ data($tipo) }</ns0:Tipo>
        </ns0:InputParameters>
};

local:conTransaccionesActualesIn($codPais,
    $org,
    $numeroTarjetaCuenta,
    $tipo)