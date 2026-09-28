(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MDW/actualizarTokenTelered/xsd/actualizarTokenTelered_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizarTokenTelered";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/LoginTelered/xq/actualizarTokenTeleredIn/";

declare function xf:actualizarTokenTeleredIn($aplicacion as xs:string,
    $region as xs:string,
    $sesion as xs:string,
    $usuarioCanal as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_APLICACION>{ $aplicacion }</ns0:PV_APLICACION>
            <ns0:PV_REGION>{ $region }</ns0:PV_REGION>
            <ns0:PV_SESION>{ $sesion }</ns0:PV_SESION>
            <ns0:PV_USUARIOCANAL>{ fn:upper-case($usuarioCanal)  }</ns0:PV_USUARIOCANAL>
        </ns0:InputParameters>
};

declare variable $aplicacion as xs:string external;
declare variable $region as xs:string external;
declare variable $sesion as xs:string external;
declare variable $usuarioCanal as xs:string external;

xf:actualizarTokenTeleredIn($aplicacion,
    $region,
    $sesion,
    $usuarioCanal)