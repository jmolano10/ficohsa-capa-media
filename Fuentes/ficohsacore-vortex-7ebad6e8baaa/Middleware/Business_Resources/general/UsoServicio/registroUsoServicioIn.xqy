xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../Resources/RegistrarUsoServicio/registrarUsoServicio_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarUsoServicio";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/general/UsoServicio/registroUsoServicioIn/";

declare function xf:registroUsoServicioIn($idServicio as xs:string,
    $idUsuario as xs:string,
    $operacion as xs:string,
    $bancoOrigen as xs:string?)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_SERVICIO>{ $idServicio }</ns0:PV_SERVICIO>
            <ns0:PV_USUARIO>{ fn:upper-case($idUsuario) }</ns0:PV_USUARIO>
            <ns0:PN_OPERACION>{ xs:integer($operacion) }</ns0:PN_OPERACION>
            <ns0:PV_BANCO_ORIGEN>{ $bancoOrigen }</ns0:PV_BANCO_ORIGEN>
        </ns0:InputParameters>
};

declare variable $idServicio as xs:string external;
declare variable $idUsuario as xs:string external;
declare variable $operacion as xs:string external;
declare variable $bancoOrigen as xs:string external;

xf:registroUsoServicioIn($idServicio,
    $idUsuario,
    $operacion,
    $bancoOrigen)