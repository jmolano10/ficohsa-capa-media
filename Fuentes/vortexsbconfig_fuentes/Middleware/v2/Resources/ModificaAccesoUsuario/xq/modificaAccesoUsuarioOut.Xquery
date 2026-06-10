<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$modificaAccesoUsuario" element="ns0:modificaAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:modificaAccesoUsuarioResponse" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/kvpType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ModificaAccesoUsuario/xq/modificaAccesoUsuarioOut/";

declare function xf:modificaAccesoUsuarioOut($modificaAccesoUsuario as element(ns0:modificaAccesoUsuario))
    as element(ns0:modificaAccesoUsuarioResponse) {
        &lt;ns0:modificaAccesoUsuarioResponse>
            &lt;APPLICATION_USER>{ data($modificaAccesoUsuario/modificaAccesoUsuario/APPLICATION_USER) }&lt;/APPLICATION_USER>
        &lt;/ns0:modificaAccesoUsuarioResponse>
};

declare variable $modificaAccesoUsuario as element(ns0:modificaAccesoUsuario) external;

xf:modificaAccesoUsuarioOut($modificaAccesoUsuario)</con:xquery>
    <con:dependency location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes"/>
    </con:dependency>
</con:xqueryEntry>