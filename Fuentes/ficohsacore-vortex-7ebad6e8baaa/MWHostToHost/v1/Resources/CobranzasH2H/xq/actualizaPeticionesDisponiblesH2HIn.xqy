xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKHN/actualizaPeticionesDisponiblesH2H/xsd/actualizaPeticionesDisponiblesH2H_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizaPeticionesDisponiblesH2H";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/CobranzasH2H/xq/actualizaPeticionesDisponiblesH2HIn/";

declare function xf:actualizaPeticionesDisponiblesH2HIn($codigoUsuario as xs:string,
    $idProxy as xs:string,
    $operacion as xs:string,
    $cantidadExitosos as xs:int,
    $cantidadErroneos as xs:int)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CODIGOUSUARIO>{ $codigoUsuario }</ns0:PV_CODIGOUSUARIO>
            <ns0:PV_IDPROXY>{ $idProxy }</ns0:PV_IDPROXY>
            <ns0:PV_OPERACION>{ $operacion }</ns0:PV_OPERACION>
            <ns0:PN_CANTIDADEXITOSOS>{ data($cantidadExitosos) }</ns0:PN_CANTIDADEXITOSOS>
            <ns0:PN_CANTIDADERRONEOS>{ data($cantidadErroneos) }</ns0:PN_CANTIDADERRONEOS>
        </ns0:InputParameters>
};

declare variable $codigoUsuario as xs:string external;
declare variable $idProxy as xs:string external;
declare variable $operacion as xs:string external;
declare variable $cantidadExitosos as xs:int external;
declare variable $cantidadErroneos as xs:int external;

xf:actualizaPeticionesDisponiblesH2HIn($codigoUsuario,
    $idProxy,
    $operacion,
    $cantidadExitosos,
    $cantidadErroneos)