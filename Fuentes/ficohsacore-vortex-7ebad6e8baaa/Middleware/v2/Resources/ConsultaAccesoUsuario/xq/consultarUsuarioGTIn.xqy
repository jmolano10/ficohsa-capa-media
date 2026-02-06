xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaAccesoUsuario" element="ns1:consultaAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultarUsuario" location="../../../BusinessServices/ACSELXGT/GestionAccesosUsuarios/wsdl/WS_AcselxIDM_gt.wsdl" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaAccesoUsuario/xq/consultarUsuarioGTIn/";

declare function xf:consultarUsuarioGTIn($consultaAccesoUsuario as element(ns1:consultaAccesoUsuario))
    as element(ns0:ConsultarUsuario) {
        <ns0:ConsultarUsuario>
            <ns0:pvCodigoUsuarioGFF>{ data($consultaAccesoUsuario/consultaAccesoUsuario/APPLICATION_USER) }</ns0:pvCodigoUsuarioGFF>
        </ns0:ConsultarUsuario>
};

declare variable $consultaAccesoUsuario as element(ns1:consultaAccesoUsuario) external;

xf:consultarUsuarioGTIn($consultaAccesoUsuario)