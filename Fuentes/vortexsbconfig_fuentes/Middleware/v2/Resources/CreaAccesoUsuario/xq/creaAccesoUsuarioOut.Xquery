<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$creaAccesoUsuario" element="ns0:creaAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:creaAccesoUsuarioResponse" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/kvpType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaAccesoUsuario/xq/creaAccesoUsuarioOut/";

declare function xf:creaAccesoUsuarioOut($creaAccesoUsuario as element(ns0:creaAccesoUsuario))
    as element(ns0:creaAccesoUsuarioResponse) {
        &lt;ns0:creaAccesoUsuarioResponse>
            &lt;APPLICATION_USER>{ data($creaAccesoUsuario/creaAccesoUsuario/APPLICATION_USER) }&lt;/APPLICATION_USER>
        &lt;/ns0:creaAccesoUsuarioResponse>
};

declare variable $creaAccesoUsuario as element(ns0:creaAccesoUsuario) external;

xf:creaAccesoUsuarioOut($creaAccesoUsuario)</con:xquery>
    <con:dependency location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes"/>
    </con:dependency>
</con:xqueryEntry>