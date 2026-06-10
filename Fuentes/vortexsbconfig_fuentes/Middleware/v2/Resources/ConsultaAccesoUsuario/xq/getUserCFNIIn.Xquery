<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaAccesoUsuario" element="ns1:consultaAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:GetUser" location="../../../BusinessServices/CREDITFORCENI/GestionAccesosUsuarios/xsd/XMLSchema_-336569572.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaAccesoUsuario/xq/getUserCFNIIn/";
declare namespace ns0 = "http://www.creditforce.com/SOA";
declare namespace ns2 = "http://schemas.datacontract.org/2004/07/CreditForce.Common.DataContract.BackEnd.Collection";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";

declare function xf:getUserCFNIIn($consultaAccesoUsuario as element(ns1:consultaAccesoUsuario),
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

xf:getUserCFNIIn($consultaAccesoUsuario,
    $token,
    $userName)]]></con:xquery>
    <con:dependency location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/CREDITFORCENI/GestionAccesosUsuarios/xsd/XMLSchema_-336569572.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/CREDITFORCENI/GestionAccesosUsuarios/xsd/XMLSchema_-336569572"/>
    </con:dependency>
</con:xqueryEntry>