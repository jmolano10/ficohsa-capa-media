(:: pragma bea:global-element-parameter parameter="$modificaAccesoUsuario" element="ns0:modificaAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/JTeller/ModificaAccesoUsuario/xsd/updateUser_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/kvpType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/UpdateUser";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ModificaAccesoUsuario/xq/updateUserGTIn/";

declare function xf:updateUserGTIn($modificaAccesoUsuario as element(ns0:modificaAccesoUsuario))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:usr_code>{ data($modificaAccesoUsuario/modificaAccesoUsuario/APPLICATION_USER) }</ns1:usr_code>
            <ns1:type_user>{ data($modificaAccesoUsuario/modificaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "TYPE_OF_USER"]/VALUE) }</ns1:type_user>
            <ns1:level_user>{ data($modificaAccesoUsuario/modificaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "USER_LEVEL"]/VALUE) }</ns1:level_user>
        </ns1:InputParameters>
};

declare variable $modificaAccesoUsuario as element(ns0:modificaAccesoUsuario) external;

xf:updateUserGTIn($modificaAccesoUsuario)