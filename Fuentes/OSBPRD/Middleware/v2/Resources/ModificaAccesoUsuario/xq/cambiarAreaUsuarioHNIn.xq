(:: pragma bea:global-element-parameter parameter="$modificaAccesoUsuario" element="ns1:modificaAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:CambiarAreaUsuario" location="../../../BusinessServices/ACSELXHN/GestionAccesosUsuarios/wsdl/WS_AcselxIDM.wsdl" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/kvpType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ModificaAccesoUsuario/xq/cambiarAreaUsuarioHNIn/";

declare function xf:cambiarAreaUsuarioHNIn($modificaAccesoUsuario as element(ns1:modificaAccesoUsuario))
    as element(ns0:CambiarAreaUsuario) {
        <ns0:CambiarAreaUsuario>
            <ns0:pvCodigoUsuarioGFF>{ data($modificaAccesoUsuario/modificaAccesoUsuario/APPLICATION_USER) }</ns0:pvCodigoUsuarioGFF>
            <ns0:pvAreaNueva>{ data($modificaAccesoUsuario/modificaAccesoUsuario/DEPARTMENT) }</ns0:pvAreaNueva>
            <ns0:pvPerfilNuevo>{ data($modificaAccesoUsuario/modificaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "PROFILE"]/VALUE) }</ns0:pvPerfilNuevo>
        </ns0:CambiarAreaUsuario>
};

declare variable $modificaAccesoUsuario as element(ns1:modificaAccesoUsuario) external;

xf:cambiarAreaUsuarioHNIn($modificaAccesoUsuario)