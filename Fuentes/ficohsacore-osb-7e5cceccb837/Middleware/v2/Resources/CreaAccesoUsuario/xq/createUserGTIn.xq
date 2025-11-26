(:: pragma bea:global-element-parameter parameter="$creaAccesoUsuario" element="ns1:creaAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/JTeller/CreaAccesoUsuario/xsd/createUser_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/CreateUser";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/kvpType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaAccesoUsuario/xq/createUserGTIn/";

declare function xf:createUserGTIn($creaAccesoUsuario as element(ns1:creaAccesoUsuario))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:usr_code>{ data($creaAccesoUsuario/creaAccesoUsuario/APPLICATION_USER) }</ns0:usr_code>
            <ns0:usr_name>{ concat(data($creaAccesoUsuario/creaAccesoUsuario/FIRST_NAME),' ', data($creaAccesoUsuario/creaAccesoUsuario/SECOND_NAME),' ', data($creaAccesoUsuario/creaAccesoUsuario/FIRST_LASTNAME),' ', data($creaAccesoUsuario/creaAccesoUsuario/SECOND_LASTNAME)) }</ns0:usr_name>
            <ns0:agency>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "AGENCY"]/VALUE)) }</ns0:agency>
            <ns0:working_day>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "WORKDAY"]/VALUE)) }</ns0:working_day>
            <ns0:department>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "DEPARTMENT_CODE"]/VALUE)) }</ns0:department>
            <ns0:status>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "EMPLOYEE_STATUS"]/VALUE)) }</ns0:status>
            <ns0:type_user>{  (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "TYPE_OF_USER"]/VALUE)) }</ns0:type_user>
            <ns0:level_user>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "USER_LEVEL"]/VALUE)) }</ns0:level_user>
            <ns0:host_equiv>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "EQUIVALENT_IN_HOST"]/VALUE)) }</ns0:host_equiv>
            <ns0:user_module>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "MODULE_USER"]/VALUE)) }</ns0:user_module>
            <ns0:menu_role>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "MENU"]/VALUE)) }</ns0:menu_role>
            <ns0:spool_admin>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "SPOOL"]/VALUE)) }</ns0:spool_admin>
            <ns0:usr_domain>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "DOMAIN"]/VALUE)) }</ns0:usr_domain>
        </ns0:InputParameters>
};

declare variable $creaAccesoUsuario as element(ns1:creaAccesoUsuario) external;

xf:createUserGTIn($creaAccesoUsuario)