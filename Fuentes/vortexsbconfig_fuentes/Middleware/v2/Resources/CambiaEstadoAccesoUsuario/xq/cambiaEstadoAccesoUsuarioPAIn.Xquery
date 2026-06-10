<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$cambiaEstadoAccesoUsuario" element="ns0:cambiaEstadoAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKPA/cambiaEstadoAccesoUsuario/xsd/cambiaEstadoAccesoUsuario_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/PROXYABANKSPA/OSB_K_GIA_USUARIOS/P_BAJA_USUARIO/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CambiaEstadoAccesoUsuario/xq/cambiaEstadoAccesoUsuarioPAIn/";

declare function xf:cambiaEstadoAccesoUsuarioPAIn($cambiaEstadoAccesoUsuario as element(ns0:cambiaEstadoAccesoUsuario))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:CODIGO_USUARIO>{ data($cambiaEstadoAccesoUsuario/cambiaEstadoAccesoUsuario/APPLICATION_USER) }</ns1:CODIGO_USUARIO>
            <ns1:CODIGO_ESTADO>{ data($cambiaEstadoAccesoUsuario/cambiaEstadoAccesoUsuario/STATUS) }</ns1:CODIGO_ESTADO>
        </ns1:InputParameters>
};

declare variable $cambiaEstadoAccesoUsuario as element(ns0:cambiaEstadoAccesoUsuario) external;

xf:cambiaEstadoAccesoUsuarioPAIn($cambiaEstadoAccesoUsuario)]]></con:xquery>
    <con:dependency location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABKPA/cambiaEstadoAccesoUsuario/xsd/cambiaEstadoAccesoUsuario_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKPA/cambiaEstadoAccesoUsuario/xsd/cambiaEstadoAccesoUsuario_sp"/>
    </con:dependency>
</con:xqueryEntry>