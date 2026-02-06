xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$cambiaEstadoAccesoUsuario" element="ns1:cambiaEstadoAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/cambiaEstadoAccesoUsuario/xsd/cambiaEstadoAccesoUsuario_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/PROXYABANKSGT/OSB_K_GIA_USUARIOS/P_BAJA_USUARIO/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CambiaEstadoAccesoUsuario/xq/cambiaEstadoAccesoUsuarioGTIn/";

declare function xf:cambiaEstadoAccesoUsuarioGTIn($cambiaEstadoAccesoUsuario as element(ns1:cambiaEstadoAccesoUsuario))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:CODIGO_USUARIO>{ data($cambiaEstadoAccesoUsuario/cambiaEstadoAccesoUsuario/APPLICATION_USER) }</ns0:CODIGO_USUARIO>
            <ns0:CODIGO_ESTADO>{ data($cambiaEstadoAccesoUsuario/cambiaEstadoAccesoUsuario/STATUS) }</ns0:CODIGO_ESTADO>
        </ns0:InputParameters>
};

declare variable $cambiaEstadoAccesoUsuario as element(ns1:cambiaEstadoAccesoUsuario) external;

xf:cambiaEstadoAccesoUsuarioGTIn($cambiaEstadoAccesoUsuario)