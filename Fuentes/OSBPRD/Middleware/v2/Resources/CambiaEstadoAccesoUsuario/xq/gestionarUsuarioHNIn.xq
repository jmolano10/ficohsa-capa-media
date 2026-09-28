(:: pragma bea:global-element-parameter parameter="$cambiaEstadoAccesoUsuario" element="ns1:cambiaEstadoAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:GestionarUsuario" location="../../../BusinessServices/ACSELXHN/GestionAccesosUsuarios/wsdl/WS_AcselxIDM.wsdl" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CambiaEstadoAccesoUsuario/xq/gestionarUsuarioHNIn/";

declare function xf:gestionarUsuarioHNIn($cambiaEstadoAccesoUsuario as element(ns1:cambiaEstadoAccesoUsuario))
    as element(ns0:GestionarUsuario) {
        <ns0:GestionarUsuario>
            <ns0:pvCodigoUsuarioGFF>{ data($cambiaEstadoAccesoUsuario/cambiaEstadoAccesoUsuario/APPLICATION_USER) }</ns0:pvCodigoUsuarioGFF>
            <ns0:pvAccion>{ data($cambiaEstadoAccesoUsuario/cambiaEstadoAccesoUsuario/STATUS) }</ns0:pvAccion>
        </ns0:GestionarUsuario>
};

declare variable $cambiaEstadoAccesoUsuario as element(ns1:cambiaEstadoAccesoUsuario) external;

xf:gestionarUsuarioHNIn($cambiaEstadoAccesoUsuario)