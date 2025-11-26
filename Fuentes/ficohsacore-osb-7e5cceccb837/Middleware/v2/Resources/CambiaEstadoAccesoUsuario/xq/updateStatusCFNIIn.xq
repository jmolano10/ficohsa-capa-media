xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$cambiaEstadoAccesoUsuario" element="ns1:cambiaEstadoAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:UpdateStatus" location="../../../BusinessServices/CREDITFORCENI/GestionAccesosUsuarios/xsd/XMLSchema_-336569572.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CambiaEstadoAccesoUsuario/xq/updateStatusCFNIIn/";
declare namespace ns0 = "http://www.creditforce.com/SOA";
declare namespace ns2 = "http://schemas.datacontract.org/2004/07/CreditForce.Common.DataContract.BackEnd.Collection";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";

declare function xf:updateStatusCFNIIn($cambiaEstadoAccesoUsuario as element(ns1:cambiaEstadoAccesoUsuario),
    $token as xs:string,
    $userName as xs:string)
    as element(ns0:UpdateStatus) {
        <ns0:UpdateStatus>
            <ns0:userReq>
                <ns2:Token>{ $token }</ns2:Token>
                <ns2:User_Name>{ $userName }</ns2:User_Name>
                <ns2:Application_User>{ data($cambiaEstadoAccesoUsuario/cambiaEstadoAccesoUsuario/APPLICATION_USER) }</ns2:Application_User>
                <ns2:Reason>{ data($cambiaEstadoAccesoUsuario/cambiaEstadoAccesoUsuario/REASON) }</ns2:Reason>
                <ns2:Status>{ data($cambiaEstadoAccesoUsuario/cambiaEstadoAccesoUsuario/STATUS) }</ns2:Status>
            </ns0:userReq>
        </ns0:UpdateStatus>
};

declare variable $cambiaEstadoAccesoUsuario as element(ns1:cambiaEstadoAccesoUsuario) external;
declare variable $token as xs:string external;
declare variable $userName as xs:string external;

xf:updateStatusCFNIIn($cambiaEstadoAccesoUsuario,
    $token,
    $userName)