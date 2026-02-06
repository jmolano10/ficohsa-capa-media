xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaAccesoUsuario" element="ns1:consultaAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:GetUser" location="../../../BusinessServices/CREDITFORCEPA/GestionAccesosUsuarios/xsd/XMLSchema_-336569570.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaAccesoUsuario/xq/getUserCFPAIn/";
declare namespace ns0 = "http://www.creditforce.com/SOA";
declare namespace ns2 = "http://schemas.datacontract.org/2004/07/CreditForce.Common.DataContract.BackEnd.Collection";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";

declare function xf:getUserCFPAIn($consultaAccesoUsuario as element(ns1:consultaAccesoUsuario),
    $token as xs:string,
    $userName as xs:string)
    as element(ns0:GetUser) {
        <ns0:GetUser>
            <ns0:userReq>
                <ns2:Token>{ $token }</ns2:Token>
                <ns2:User_Name>{ $userName }</ns2:User_Name>
                <ns2:Application_User>{ data($consultaAccesoUsuario/consultaAccesoUsuario/APPLICATION_USER) }</ns2:Application_User>
            </ns0:userReq>
        </ns0:GetUser>
};

declare variable $consultaAccesoUsuario as element(ns1:consultaAccesoUsuario) external;
declare variable $token as xs:string external;
declare variable $userName as xs:string external;

xf:getUserCFPAIn($consultaAccesoUsuario,
    $token,
    $userName)