<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaAccesoUsuario" element="ns0:consultaAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaAccesoUsuarioResponse" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaAccesoUsuario/xq/consultaAccesoUsuarioOut/";

declare function xf:consultaAccesoUsuarioOut($consultaAccesoUsuario as element(ns0:consultaAccesoUsuario))
    as element(ns0:consultaAccesoUsuarioResponse) {
        &lt;ns0:consultaAccesoUsuarioResponse>
            &lt;APPLICATION_USER>{ data($consultaAccesoUsuario/consultaAccesoUsuario/APPLICATION_USER) }&lt;/APPLICATION_USER>
        &lt;/ns0:consultaAccesoUsuarioResponse>
};

declare variable $consultaAccesoUsuario as element(ns0:consultaAccesoUsuario) external;

xf:consultaAccesoUsuarioOut($consultaAccesoUsuario)</con:xquery>
    <con:dependency location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes"/>
    </con:dependency>
</con:xqueryEntry>