xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterDataGT/conTransaccionesActuales/xsd/conTransaccionesActuales_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conTransaccionesActuales";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MasterDataGT/xq/conTransaccionesActualesIn/";

declare function xf:conTransaccionesActualesIn($codPais as xs:string,
    $org as xs:string,
    $numeroTarjetaCuenta as xs:string,
    $tipo as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ $codPais }</ns0:Pais>
            <ns0:Org>{ $org }</ns0:Org>
            <ns0:NumCuenta>{ data($numeroTarjetaCuenta) }</ns0:NumCuenta>
            <ns0:Tipo>{ data($tipo) }</ns0:Tipo>
        </ns0:InputParameters>
};

declare variable $codPais as xs:string external;
declare variable $org as xs:string external;
declare variable $numeroTarjetaCuenta as xs:string external;
declare variable $tipo as xs:string external;

xf:conTransaccionesActualesIn($codPais,
    $org,
    $numeroTarjetaCuenta,
    $tipo)