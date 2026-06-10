<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$modificaAccesoUsuario" element="ns1:modificaAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:CambiarAreaUsuario" location="../../../BusinessServices/ACSELXGT/GestionAccesosUsuarios/wsdl/WS_AcselxIDM_gt.wsdl" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ModificaAccesoUsuario/xq/cambiarAreaUsuarioGTIn/";
declare namespace ns0 = "http://tempuri.org/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/kvpType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";

declare function xf:cambiarAreaUsuarioGTIn($modificaAccesoUsuario as element(ns1:modificaAccesoUsuario))
    as element(ns0:CambiarAreaUsuario) {
        <ns0:CambiarAreaUsuario>
            <ns0:pvCodigoUsuarioGFF>{ data($modificaAccesoUsuario/modificaAccesoUsuario/APPLICATION_USER) }</ns0:pvCodigoUsuarioGFF>
            <ns0:pvAreaNueva>{ data($modificaAccesoUsuario/modificaAccesoUsuario/DEPARTMENT) }</ns0:pvAreaNueva>
            <ns0:pvPerfilNuevo>{ data($modificaAccesoUsuario/modificaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "PROFILE"]/VALUE) }</ns0:pvPerfilNuevo>
        </ns0:CambiarAreaUsuario>
};

declare variable $modificaAccesoUsuario as element(ns1:modificaAccesoUsuario) external;

xf:cambiarAreaUsuarioGTIn($modificaAccesoUsuario)]]></con:xquery>
    <con:dependency location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ACSELXGT/GestionAccesosUsuarios/wsdl/WS_AcselxIDM_gt.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/ACSELXGT/GestionAccesosUsuarios/wsdl/WS_AcselxIDM_gt"/>
    </con:dependency>
</con:xqueryEntry>