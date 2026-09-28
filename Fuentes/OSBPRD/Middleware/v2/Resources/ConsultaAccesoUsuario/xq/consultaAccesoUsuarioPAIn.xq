(:: pragma bea:global-element-parameter parameter="$consultaAccesoUsuario" element="ns0:consultaAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKPA/consultaAccesoUsuario/xsd/consultaAccesoUsuario_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/PROXYABANKSPA/OSB_K_GIA_USUARIOS/P_VALIDA_USUARIO/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaAccesoUsuario/xq/consultaAccesoUsuarioPAIn/";

declare function xf:consultaAccesoUsuarioPAIn($consultaAccesoUsuario as element(ns0:consultaAccesoUsuario))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:CODIGO_USUARIO>{ data($consultaAccesoUsuario/consultaAccesoUsuario/APPLICATION_USER) }</ns1:CODIGO_USUARIO>
        </ns1:InputParameters>
};

declare variable $consultaAccesoUsuario as element(ns0:consultaAccesoUsuario) external;

xf:consultaAccesoUsuarioPAIn($consultaAccesoUsuario)