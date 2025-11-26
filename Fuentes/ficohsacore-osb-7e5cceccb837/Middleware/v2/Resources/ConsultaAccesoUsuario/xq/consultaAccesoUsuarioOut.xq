(:: pragma bea:global-element-parameter parameter="$consultaAccesoUsuario" element="ns0:consultaAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaAccesoUsuarioResponse" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaAccesoUsuario/xq/consultaAccesoUsuarioOut/";

declare function xf:consultaAccesoUsuarioOut($consultaAccesoUsuario as element(ns0:consultaAccesoUsuario))
    as element(ns0:consultaAccesoUsuarioResponse) {
        <ns0:consultaAccesoUsuarioResponse>
            <APPLICATION_USER>{ data($consultaAccesoUsuario/consultaAccesoUsuario/APPLICATION_USER) }</APPLICATION_USER>
        </ns0:consultaAccesoUsuarioResponse>
};

declare variable $consultaAccesoUsuario as element(ns0:consultaAccesoUsuario) external;

xf:consultaAccesoUsuarioOut($consultaAccesoUsuario)