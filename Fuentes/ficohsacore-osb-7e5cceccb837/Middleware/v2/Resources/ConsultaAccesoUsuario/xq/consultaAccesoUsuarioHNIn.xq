(:: pragma bea:global-element-parameter parameter="$consultaAccesoUsuario" element="ns1:consultaAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKHN/consultaAccesoUsuario/xsd/consultaAccesoUsuario_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/PROXYABANKSHN/OSB_K_GIA_USUARIOS_HN/OSB_P_VALIDA_USUARIO_HN/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaAccesoUsuario/xq/consultaAccesoUsuarioHNIn/";

declare function xf:consultaAccesoUsuarioHNIn($consultaAccesoUsuario as element(ns1:consultaAccesoUsuario))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CODIGO_USUARIO>{ data($consultaAccesoUsuario/consultaAccesoUsuario/APPLICATION_USER) }</ns0:PV_CODIGO_USUARIO>
        </ns0:InputParameters>
};

declare variable $consultaAccesoUsuario as element(ns1:consultaAccesoUsuario) external;

xf:consultaAccesoUsuarioHNIn($consultaAccesoUsuario)