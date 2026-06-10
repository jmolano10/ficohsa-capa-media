<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaAccesoUsuario" element="ns1:consultaAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultarUsuario" location="../../../BusinessServices/ACSELXGT/GestionAccesosUsuarios/wsdl/WS_AcselxIDM_gt.wsdl" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaAccesoUsuario/xq/consultarUsuarioGTIn/";

declare function xf:consultarUsuarioGTIn($consultaAccesoUsuario as element(ns1:consultaAccesoUsuario))
    as element(ns0:ConsultarUsuario) {
        &lt;ns0:ConsultarUsuario>
            &lt;ns0:pvCodigoUsuarioGFF>{ data($consultaAccesoUsuario/consultaAccesoUsuario/APPLICATION_USER) }&lt;/ns0:pvCodigoUsuarioGFF>
        &lt;/ns0:ConsultarUsuario>
};

declare variable $consultaAccesoUsuario as element(ns1:consultaAccesoUsuario) external;

xf:consultarUsuarioGTIn($consultaAccesoUsuario)</con:xquery>
    <con:dependency location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ACSELXGT/GestionAccesosUsuarios/wsdl/WS_AcselxIDM_gt.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/ACSELXGT/GestionAccesosUsuarios/wsdl/WS_AcselxIDM_gt"/>
    </con:dependency>
</con:xqueryEntry>