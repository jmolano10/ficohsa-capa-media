xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MDW/consultaCredencialesSalesforcePorOperacion/xsd/actualizaCredencialesSaleForcePorOperacion_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizaCredencialesSaleForcePorOperacion";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/LoginSalesforcePorOperacion/xq/actualizaCredencialesSaleForcePorOperacion/";

declare function xf:actualizaCredencialesSaleForcePorOperacion($session as xs:string,
    $pais as xs:string,
    $operation as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_SESION>{ $session }</ns0:PV_SESION>
            <ns0:PV_CODIGOPAIS>{ $pais }</ns0:PV_CODIGOPAIS>
            <ns0:PV_OPERATION>{ $operation }</ns0:PV_OPERATION>
        </ns0:InputParameters>
};

declare variable $session as xs:string external;
declare variable $pais as xs:string external;
declare variable $operation as xs:string external;

xf:actualizaCredencialesSaleForcePorOperacion($session,
    $pais,
    $operation)