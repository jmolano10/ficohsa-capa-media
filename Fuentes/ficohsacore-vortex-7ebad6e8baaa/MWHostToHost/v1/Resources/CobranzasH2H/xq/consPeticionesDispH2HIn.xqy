xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKHN/consultaPeticionesDisponiblesH2H/xsd/consultaPeticionesDisponiblesH2H_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaPeticionesDisponiblesH2H";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/ConsultaCobranzasH2H/xq/consPeticionesDispH2HIn/";

declare function xf:consPeticionesDispH2HIn($codigoUsuario as xs:string,
    $IdProxy as xs:string,
    $operacion as xs:string,
    $numeroPeticiones as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CODIGOUSUARIO>{ $codigoUsuario }</ns0:PV_CODIGOUSUARIO>
            <ns0:PV_IDPROXY>{ $IdProxy }</ns0:PV_IDPROXY>
            <ns0:PV_OPERACION>{ $operacion }</ns0:PV_OPERACION>
            <ns0:PN_CANTIDADPETICIONES>{ data($numeroPeticiones) }</ns0:PN_CANTIDADPETICIONES>
        </ns0:InputParameters>
};

declare variable $codigoUsuario as xs:string external;
declare variable $IdProxy as xs:string external;
declare variable $operacion as xs:string external;
declare variable $numeroPeticiones as xs:string external;

xf:consPeticionesDispH2HIn($codigoUsuario,
    $IdProxy,
    $operacion,
    $numeroPeticiones)