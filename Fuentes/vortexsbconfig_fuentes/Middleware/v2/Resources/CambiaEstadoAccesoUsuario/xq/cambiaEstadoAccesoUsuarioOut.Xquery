<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$cambiaEstadoAccesoUsuario" element="ns0:cambiaEstadoAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:cambiaEstadoAccesoUsuarioResponse" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CambiaEstadoAccesoUsuario/xq/cambiaEstadoAccesoUsuarioOut/";

declare function xf:cambiaEstadoAccesoUsuarioOut($cambiaEstadoAccesoUsuario as element(ns0:cambiaEstadoAccesoUsuario))
    as element(ns0:cambiaEstadoAccesoUsuarioResponse) {
        &lt;ns0:cambiaEstadoAccesoUsuarioResponse>
            &lt;APPLICATION_USER>{ data($cambiaEstadoAccesoUsuario/cambiaEstadoAccesoUsuario/APPLICATION_USER) }&lt;/APPLICATION_USER>
        &lt;/ns0:cambiaEstadoAccesoUsuarioResponse>
};

declare variable $cambiaEstadoAccesoUsuario as element(ns0:cambiaEstadoAccesoUsuario) external;

xf:cambiaEstadoAccesoUsuarioOut($cambiaEstadoAccesoUsuario)</con:xquery>
    <con:dependency location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes"/>
    </con:dependency>
</con:xqueryEntry>