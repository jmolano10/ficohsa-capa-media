(:: pragma bea:global-element-parameter parameter="$modificaAccesoUsuario" element="ns1:modificaAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/Cobis/GestionAccesoUsuarios/xsd/gestionAccesosUsuarios_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/gestionAccesosUsuarios";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/kvpType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ModificaAccesoUsuario/xq/ModificaAccesoUsuarioNIIn/";

declare function xf:modificaAccesoUsuarioNIIn($modificaAccesoUsuario as element(ns1:modificaAccesoUsuario),
    $userSolic as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
        	<ns0:s_ssn/>
            <ns0:s_ofi/>
            <ns0:s_term/>
            <ns0:i_modo>5</ns0:i_modo>
            <ns0:i_interfaz>LOCAL</ns0:i_interfaz>
            <ns0:i_user_solic>{ $userSolic }</ns0:i_user_solic>
            <ns0:i_nombre/>
            <ns0:i_login>{ data($modificaAccesoUsuario/modificaAccesoUsuario/APPLICATION_USER) }</ns0:i_login>
            <ns0:i_sexo/>
            <ns0:i_nomina/>
            <ns0:i_oficina_ing1>{ data($modificaAccesoUsuario/modificaAccesoUsuario/MODULES/MODULE[1]/MODULE_ID) }</ns0:i_oficina_ing1>
            <ns0:i_departamento/>
            <ns0:i_cargo/>
            <ns0:i_jefe/>
            <ns0:i_estado>{ data($modificaAccesoUsuario/modificaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "STATUS"]/VALUE) }</ns0:i_estado>
            <ns0:i_rol_ing1>{ data($modificaAccesoUsuario/modificaAccesoUsuario/ROLES/ROLE[1]/ROLE_ID) }</ns0:i_rol_ing1>
            <ns0:i_oficina_ing2>{ data($modificaAccesoUsuario/modificaAccesoUsuario/MODULES/MODULE[2]/MODULE_ID) }</ns0:i_oficina_ing2>
            <ns0:i_oficina_ing3>{ data($modificaAccesoUsuario/modificaAccesoUsuario/MODULES/MODULE[3]/MODULE_ID) }</ns0:i_oficina_ing3>
            <ns0:i_oficina_ing4>{ data($modificaAccesoUsuario/modificaAccesoUsuario/MODULES/MODULE[4]/MODULE_ID) }</ns0:i_oficina_ing4>
            <ns0:i_oficina_ing5>{ data($modificaAccesoUsuario/modificaAccesoUsuario/MODULES/MODULE[5]/MODULE_ID) }</ns0:i_oficina_ing5>
            <ns0:i_oficina_ing6>{ data($modificaAccesoUsuario/modificaAccesoUsuario/MODULES/MODULE[6]/MODULE_ID) }</ns0:i_oficina_ing6>
            <ns0:i_oficina_ing7>{ data($modificaAccesoUsuario/modificaAccesoUsuario/MODULES/MODULE[7]/MODULE_ID) }</ns0:i_oficina_ing7>
            <ns0:i_oficina_ing8>{ data($modificaAccesoUsuario/modificaAccesoUsuario/MODULES/MODULE[8]/MODULE_ID) }</ns0:i_oficina_ing8>
            <ns0:i_oficina_ing9>{ data($modificaAccesoUsuario/modificaAccesoUsuario/MODULES/MODULE[9]/MODULE_ID) }</ns0:i_oficina_ing9>
            <ns0:i_oficina_ing10>{ data($modificaAccesoUsuario/modificaAccesoUsuario/MODULES/MODULE[10]/MODULE_ID) }</ns0:i_oficina_ing10>
            <ns0:i_oficina_ing11>{ data($modificaAccesoUsuario/modificaAccesoUsuario/MODULES/MODULE[11]/MODULE_ID) }</ns0:i_oficina_ing11>
            <ns0:i_oficina_ing12>{ data($modificaAccesoUsuario/modificaAccesoUsuario/MODULES/MODULE[12]/MODULE_ID) }</ns0:i_oficina_ing12>
            <ns0:i_oficina_ing13>{ data($modificaAccesoUsuario/modificaAccesoUsuario/MODULES/MODULE[13]/MODULE_ID) }</ns0:i_oficina_ing13>
            <ns0:i_oficina_ing14>{ data($modificaAccesoUsuario/modificaAccesoUsuario/MODULES/MODULE[14]/MODULE_ID) }</ns0:i_oficina_ing14>
            <ns0:i_oficina_ing15>{ data($modificaAccesoUsuario/modificaAccesoUsuario/MODULES/MODULE[15]/MODULE_ID) }</ns0:i_oficina_ing15>
            <ns0:i_oficina_ing16>{ data($modificaAccesoUsuario/modificaAccesoUsuario/MODULES/MODULE[16]/MODULE_ID) }</ns0:i_oficina_ing16>
            <ns0:i_oficina_ing17>{ data($modificaAccesoUsuario/modificaAccesoUsuario/MODULES/MODULE[17]/MODULE_ID) }</ns0:i_oficina_ing17>
            <ns0:i_oficina_ing18>{ data($modificaAccesoUsuario/modificaAccesoUsuario/MODULES/MODULE[18]/MODULE_ID) }</ns0:i_oficina_ing18>
            <ns0:i_oficina_ing19>{ data($modificaAccesoUsuario/modificaAccesoUsuario/MODULES/MODULE[19]/MODULE_ID) }</ns0:i_oficina_ing19>
            <ns0:i_oficina_ing20>{ data($modificaAccesoUsuario/modificaAccesoUsuario/MODULES/MODULE[20]/MODULE_ID) }</ns0:i_oficina_ing20>
            <ns0:i_rol_ing2>{ data($modificaAccesoUsuario/modificaAccesoUsuario/ROLES/ROLE[2]/ROLE_ID) }</ns0:i_rol_ing2>
            <ns0:i_rol_ing3>{ data($modificaAccesoUsuario/modificaAccesoUsuario/ROLES/ROLE[3]/ROLE_ID) }</ns0:i_rol_ing3>
            <ns0:i_rol_ing4>{ data($modificaAccesoUsuario/modificaAccesoUsuario/ROLES/ROLE[4]/ROLE_ID) }</ns0:i_rol_ing4>
            <ns0:i_rol_ing5>{ data($modificaAccesoUsuario/modificaAccesoUsuario/ROLES/ROLE[5]/ROLE_ID) }</ns0:i_rol_ing5>
            <ns0:i_rol_ing6>{ data($modificaAccesoUsuario/modificaAccesoUsuario/ROLES/ROLE[6]/ROLE_ID) }</ns0:i_rol_ing6>
            <ns0:i_rol_ing7>{ data($modificaAccesoUsuario/modificaAccesoUsuario/ROLES/ROLE[7]/ROLE_ID) }</ns0:i_rol_ing7>
            <ns0:i_rol_ing8>{ data($modificaAccesoUsuario/modificaAccesoUsuario/ROLES/ROLE[8]/ROLE_ID) }</ns0:i_rol_ing8>
            <ns0:i_rol_ing9>{ data($modificaAccesoUsuario/modificaAccesoUsuario/ROLES/ROLE[9]/ROLE_ID) }</ns0:i_rol_ing9>
            <ns0:i_rol_ing10>{ data($modificaAccesoUsuario/modificaAccesoUsuario/ROLES/ROLE[10]/ROLE_ID) }</ns0:i_rol_ing10>
            <ns0:i_rol_ing11>{ data($modificaAccesoUsuario/modificaAccesoUsuario/ROLES/ROLE[11]/ROLE_ID) }</ns0:i_rol_ing11>
            <ns0:i_rol_ing12>{ data($modificaAccesoUsuario/modificaAccesoUsuario/ROLES/ROLE[12]/ROLE_ID) }</ns0:i_rol_ing12>
            <ns0:i_rol_ing13>{ data($modificaAccesoUsuario/modificaAccesoUsuario/ROLES/ROLE[13]/ROLE_ID) }</ns0:i_rol_ing13>
            <ns0:i_rol_ing14>{ data($modificaAccesoUsuario/modificaAccesoUsuario/ROLES/ROLE[14]/ROLE_ID) }</ns0:i_rol_ing14>
            <ns0:i_rol_ing15>{ data($modificaAccesoUsuario/modificaAccesoUsuario/ROLES/ROLE[15]/ROLE_ID) }</ns0:i_rol_ing15>
            <ns0:i_rol_ing16>{ data($modificaAccesoUsuario/modificaAccesoUsuario/ROLES/ROLE[16]/ROLE_ID) }</ns0:i_rol_ing16>
            <ns0:i_rol_ing17>{ data($modificaAccesoUsuario/modificaAccesoUsuario/ROLES/ROLE[17]/ROLE_ID) }</ns0:i_rol_ing17>
            <ns0:i_rol_ing18>{ data($modificaAccesoUsuario/modificaAccesoUsuario/ROLES/ROLE[18]/ROLE_ID) }</ns0:i_rol_ing18>
            <ns0:i_rol_ing19>{ data($modificaAccesoUsuario/modificaAccesoUsuario/ROLES/ROLE[19]/ROLE_ID) }</ns0:i_rol_ing19>
            <ns0:i_rol_ing20>{ data($modificaAccesoUsuario/modificaAccesoUsuario/ROLES/ROLE[20]/ROLE_ID) }</ns0:i_rol_ing20>
        </ns0:InputParameters>
};

declare variable $modificaAccesoUsuario as element(ns1:modificaAccesoUsuario) external;
declare variable $userSolic as xs:string external;

xf:modificaAccesoUsuarioNIIn($modificaAccesoUsuario,
    $userSolic)