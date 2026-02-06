xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/INTFC/validaAccesoH2H/xsd/validaAccesoH2H_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validaAccesoH2H";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/CobranzasH2H/xq/validaAccesoH2HIn/";

declare function xf:validaAccesoH2HIn($usuario as xs:string,
    $operacion as xs:string,
    $idProxy as xs:string,
    $codigoPais as xs:string,
    $codigoCliente as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_NOMBREUSUARIO>{ $usuario }</ns0:PV_NOMBREUSUARIO>
            <ns0:PV_OPERACION>{ $operacion }</ns0:PV_OPERACION>
            <ns0:PV_IDPROXY>{ $idProxy }</ns0:PV_IDPROXY>
            <ns0:PV_CODIGOPAIS>{ $codigoPais }</ns0:PV_CODIGOPAIS>
            <ns0:PV_CODIGOCLIENTE>{ $codigoCliente }</ns0:PV_CODIGOCLIENTE>
        </ns0:InputParameters>
};

declare variable $usuario as xs:string external;
declare variable $operacion as xs:string external;
declare variable $idProxy as xs:string external;
declare variable $codigoPais as xs:string external;
declare variable $codigoCliente as xs:string external;

xf:validaAccesoH2HIn($usuario,
    $operacion,
    $idProxy,
    $codigoPais,
    $codigoCliente)