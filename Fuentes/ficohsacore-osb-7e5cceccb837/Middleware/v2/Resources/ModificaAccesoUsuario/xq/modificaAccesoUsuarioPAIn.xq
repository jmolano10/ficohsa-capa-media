(:: pragma bea:global-element-parameter parameter="$modificaAccesoUsuario" element="ns0:modificaAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKPA/modificaAccesoUsuario/xsd/modificaAccesoUsuario_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/kvpType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/PROXYABANKSPA/OSB_K_GIA_USUARIOS/P_CAMBIO_USUARIO/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ModificaAccesoUsuario/xq/modificaAccesoUsuarioPAIn/";

declare function xf:modificaAccesoUsuarioPAIn($modificaAccesoUsuario as element(ns0:modificaAccesoUsuario))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:CODIGO_USUARIO>{ data($modificaAccesoUsuario/modificaAccesoUsuario/APPLICATION_USER) }</ns1:CODIGO_USUARIO>
            <ns1:CODIGO_CARGO>{ data($modificaAccesoUsuario/modificaAccesoUsuario/POSITION_CODE) }</ns1:CODIGO_CARGO>
            <ns1:TIPO_USUARIO>{ data($modificaAccesoUsuario/modificaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "TYPE_OF_USER"]/VALUE) }</ns1:TIPO_USUARIO>
        </ns1:InputParameters>
};

declare variable $modificaAccesoUsuario as element(ns0:modificaAccesoUsuario) external;

xf:modificaAccesoUsuarioPAIn($modificaAccesoUsuario)