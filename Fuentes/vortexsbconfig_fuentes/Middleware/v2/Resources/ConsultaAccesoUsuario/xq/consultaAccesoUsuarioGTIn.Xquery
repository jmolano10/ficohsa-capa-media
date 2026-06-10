<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaAccesoUsuario" element="ns1:consultaAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/consultaAccesoUsuario/xsd/consultaAccesoUsuario_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/PROXYABANKSGT/OSB_K_GIA_USUARIOS/P_VALIDA_USUARIO/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaAccesoUsuario/xq/consultaAccesoUsuarioGTIn/";

declare function xf:consultaAccesoUsuarioGTIn($consultaAccesoUsuario as element(ns1:consultaAccesoUsuario))
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:CODIGO_USUARIO>{ data($consultaAccesoUsuario/consultaAccesoUsuario/APPLICATION_USER) }&lt;/ns0:CODIGO_USUARIO>
        &lt;/ns0:InputParameters>
};

declare variable $consultaAccesoUsuario as element(ns1:consultaAccesoUsuario) external;

xf:consultaAccesoUsuarioGTIn($consultaAccesoUsuario)</con:xquery>
    <con:dependency location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABKGT/consultaAccesoUsuario/xsd/consultaAccesoUsuario_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKGT/consultaAccesoUsuario/xsd/consultaAccesoUsuario_sp"/>
    </con:dependency>
</con:xqueryEntry>