(:: pragma bea:global-element-parameter parameter="$cambiaEstadoAccesoUsuario" element="ns0:cambiaEstadoAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKHN/cambiaEstadoAccesoUsuario/xsd/cambiaEstadoAccesoUsuario_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/PROXYABANKSHN/OSB_K_GIA_USUARIOS_HN/OSB_P_CAMBIO_ESTADO_USUARIO_HN/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CambiaEstadoAccesoUsuario/xq/cambiaEstadoAccesoUsuarioHNIn/";

declare function xf:cambiaEstadoAccesoUsuarioHNIn($cambiaEstadoAccesoUsuario as element(ns0:cambiaEstadoAccesoUsuario))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CODIGO_USUARIO>{ data($cambiaEstadoAccesoUsuario/cambiaEstadoAccesoUsuario/APPLICATION_USER) }</ns1:PV_CODIGO_USUARIO>
            <ns1:PV_CODIGO_ESTADO>{ data($cambiaEstadoAccesoUsuario/cambiaEstadoAccesoUsuario/STATUS) }</ns1:PV_CODIGO_ESTADO>
            <ns1:PV_OBSERVACIONES>{ data($cambiaEstadoAccesoUsuario/cambiaEstadoAccesoUsuario/REASON) }</ns1:PV_OBSERVACIONES>
        </ns1:InputParameters>
};

declare variable $cambiaEstadoAccesoUsuario as element(ns0:cambiaEstadoAccesoUsuario) external;

xf:cambiaEstadoAccesoUsuarioHNIn($cambiaEstadoAccesoUsuario)