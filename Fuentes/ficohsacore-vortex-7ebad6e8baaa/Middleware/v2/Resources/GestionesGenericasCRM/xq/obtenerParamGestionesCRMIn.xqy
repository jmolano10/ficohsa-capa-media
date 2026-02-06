xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MDW/ObtenerParamGestionesCRM/xsd/ObtenerParamGestionesCRM_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ObtenerParamGestionesCRM";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GestionesGenericasCRM/xq/obtenerParamGestionesCRMIn/";

declare function xf:obtenerParamGestionesCRMIn($idServicio as xs:string,
    $usuarioOSB as xs:string,
    $codigoPais as xs:string,
    $tipoGestion as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_IDSERVICIO>{ $idServicio }</ns0:PV_IDSERVICIO>
            <ns0:PV_USUARIOOSB>{ $usuarioOSB }</ns0:PV_USUARIOOSB>
            <ns0:PV_CODIGOPAIS>{ $codigoPais }</ns0:PV_CODIGOPAIS>
            <ns0:PV_TIPOGESTION>{ $tipoGestion }</ns0:PV_TIPOGESTION>
        </ns0:InputParameters>
};

declare variable $idServicio as xs:string external;
declare variable $usuarioOSB as xs:string external;
declare variable $codigoPais as xs:string external;
declare variable $tipoGestion as xs:string external;

xf:obtenerParamGestionesCRMIn($idServicio,
    $usuarioOSB,
    $codigoPais,
    $tipoGestion)