(:: pragma bea:global-element-parameter parameter="$creaAccesoUsuario" element="ns1:creaAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/Cobis/GestionAccesoUsuarios/xsd/gestionAccesosUsuarios_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/gestionAccesosUsuarios";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/kvpType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaAccesoUsuario/xq/creaAccesoUsuarioNIIn/";

declare function xf:creaAccesoUsuarioNIIn($creaAccesoUsuario as element(ns1:creaAccesoUsuario),
    $userSolic as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:s_ssn/>
            <ns0:s_ofi/>
            <ns0:s_term/>
            <ns0:i_modo>4</ns0:i_modo>
            <ns0:i_interfaz>LOCAL</ns0:i_interfaz>
            <ns0:i_user_solic>{ $userSolic }</ns0:i_user_solic>
            <ns0:i_nombre>{ concat( data($creaAccesoUsuario/creaAccesoUsuario/FIRST_NAME) , ' ', data($creaAccesoUsuario/creaAccesoUsuario/SECOND_NAME), ' ', data($creaAccesoUsuario/creaAccesoUsuario/FIRST_LASTNAME), ' ',data($creaAccesoUsuario/creaAccesoUsuario/SECOND_LASTNAME)) }</ns0:i_nombre>
            <ns0:i_login>{ data($creaAccesoUsuario/creaAccesoUsuario/APPLICATION_USER) }</ns0:i_login>
            <ns0:i_sexo>{ data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "GENDER"]/VALUE) }</ns0:i_sexo>
            <ns0:i_nomina>{ data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "PAYROLL"]/VALUE) }</ns0:i_nomina>
            <ns0:i_oficina_ing1>{ data($creaAccesoUsuario/creaAccesoUsuario/MODULES/MODULE[1]/MODULE_ID) }</ns0:i_oficina_ing1>
            <ns0:i_departamento>{ data($creaAccesoUsuario/creaAccesoUsuario/DEPARTMENT) }</ns0:i_departamento>
            <ns0:i_cargo>{ data($creaAccesoUsuario/creaAccesoUsuario/POSITION_CODE) }</ns0:i_cargo>
            <ns0:i_jefe>{ data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "BOSS_CODE"]/VALUE) }</ns0:i_jefe>
            <ns0:i_estado>{ data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "STATUS"]/VALUE) }</ns0:i_estado>
            <ns0:i_rol_ing1>{ data($creaAccesoUsuario/creaAccesoUsuario/ROLES/ROLE[1]/ROLE_ID) }</ns0:i_rol_ing1>
            <ns0:i_oficina_ing2>{ data($creaAccesoUsuario/creaAccesoUsuario/MODULES/MODULE[2]/MODULE_ID) }</ns0:i_oficina_ing2>
            <ns0:i_oficina_ing3>{ data($creaAccesoUsuario/creaAccesoUsuario/MODULES/MODULE[3]/MODULE_ID) }</ns0:i_oficina_ing3>
            <ns0:i_oficina_ing4>{ data($creaAccesoUsuario/creaAccesoUsuario/MODULES/MODULE[4]/MODULE_ID) }</ns0:i_oficina_ing4>
            <ns0:i_oficina_ing5>{ data($creaAccesoUsuario/creaAccesoUsuario/MODULES/MODULE[5]/MODULE_ID) }</ns0:i_oficina_ing5>
            <ns0:i_oficina_ing6>{ data($creaAccesoUsuario/creaAccesoUsuario/MODULES/MODULE[6]/MODULE_ID) }</ns0:i_oficina_ing6>
            <ns0:i_oficina_ing7>{ data($creaAccesoUsuario/creaAccesoUsuario/MODULES/MODULE[7]/MODULE_ID) }</ns0:i_oficina_ing7>
            <ns0:i_oficina_ing8>{ data($creaAccesoUsuario/creaAccesoUsuario/MODULES/MODULE[8]/MODULE_ID) }</ns0:i_oficina_ing8>
            <ns0:i_oficina_ing9>{ data($creaAccesoUsuario/creaAccesoUsuario/MODULES/MODULE[9]/MODULE_ID) }</ns0:i_oficina_ing9>
            <ns0:i_oficina_ing10>{ data($creaAccesoUsuario/creaAccesoUsuario/MODULES/MODULE[10]/MODULE_ID) }</ns0:i_oficina_ing10>
            <ns0:i_oficina_ing11>{ data($creaAccesoUsuario/creaAccesoUsuario/MODULES/MODULE[11]/MODULE_ID) }</ns0:i_oficina_ing11>
            <ns0:i_oficina_ing12>{ data($creaAccesoUsuario/creaAccesoUsuario/MODULES/MODULE[12]/MODULE_ID) }</ns0:i_oficina_ing12>
            <ns0:i_oficina_ing13>{ data($creaAccesoUsuario/creaAccesoUsuario/MODULES/MODULE[13]/MODULE_ID) }</ns0:i_oficina_ing13>
            <ns0:i_oficina_ing14>{ data($creaAccesoUsuario/creaAccesoUsuario/MODULES/MODULE[14]/MODULE_ID) }</ns0:i_oficina_ing14>
            <ns0:i_oficina_ing15>{ data($creaAccesoUsuario/creaAccesoUsuario/MODULES/MODULE[15]/MODULE_ID) }</ns0:i_oficina_ing15>
            <ns0:i_oficina_ing16>{ data($creaAccesoUsuario/creaAccesoUsuario/MODULES/MODULE[16]/MODULE_ID) }</ns0:i_oficina_ing16>
            <ns0:i_oficina_ing17>{ data($creaAccesoUsuario/creaAccesoUsuario/MODULES/MODULE[17]/MODULE_ID) }</ns0:i_oficina_ing17>
            <ns0:i_oficina_ing18>{ data($creaAccesoUsuario/creaAccesoUsuario/MODULES/MODULE[18]/MODULE_ID) }</ns0:i_oficina_ing18>
            <ns0:i_oficina_ing19>{ data($creaAccesoUsuario/creaAccesoUsuario/MODULES/MODULE[19]/MODULE_ID) }</ns0:i_oficina_ing19>
            <ns0:i_oficina_ing20>{ data($creaAccesoUsuario/creaAccesoUsuario/MODULES/MODULE[20]/MODULE_ID) }</ns0:i_oficina_ing20>
            <ns0:i_rol_ing2>{ data($creaAccesoUsuario/creaAccesoUsuario/ROLES/ROLE[2]/ROLE_ID) }</ns0:i_rol_ing2>
            <ns0:i_rol_ing3>{ data($creaAccesoUsuario/creaAccesoUsuario/ROLES/ROLE[3]/ROLE_ID) }</ns0:i_rol_ing3>
            <ns0:i_rol_ing4>{ data($creaAccesoUsuario/creaAccesoUsuario/ROLES/ROLE[4]/ROLE_ID) }</ns0:i_rol_ing4>
            <ns0:i_rol_ing5>{ data($creaAccesoUsuario/creaAccesoUsuario/ROLES/ROLE[5]/ROLE_ID) }</ns0:i_rol_ing5>
            <ns0:i_rol_ing6>{ data($creaAccesoUsuario/creaAccesoUsuario/ROLES/ROLE[6]/ROLE_ID) }</ns0:i_rol_ing6>
            <ns0:i_rol_ing7>{ data($creaAccesoUsuario/creaAccesoUsuario/ROLES/ROLE[7]/ROLE_ID) }</ns0:i_rol_ing7>
            <ns0:i_rol_ing8>{ data($creaAccesoUsuario/creaAccesoUsuario/ROLES/ROLE[8]/ROLE_ID) }</ns0:i_rol_ing8>
            <ns0:i_rol_ing9>{ data($creaAccesoUsuario/creaAccesoUsuario/ROLES/ROLE[9]/ROLE_ID) }</ns0:i_rol_ing9>
            <ns0:i_rol_ing10>{ data($creaAccesoUsuario/creaAccesoUsuario/ROLES/ROLE[10]/ROLE_ID) }</ns0:i_rol_ing10>
            <ns0:i_rol_ing11>{ data($creaAccesoUsuario/creaAccesoUsuario/ROLES/ROLE[11]/ROLE_ID) }</ns0:i_rol_ing11>
            <ns0:i_rol_ing12>{ data($creaAccesoUsuario/creaAccesoUsuario/ROLES/ROLE[12]/ROLE_ID) }</ns0:i_rol_ing12>
            <ns0:i_rol_ing13>{ data($creaAccesoUsuario/creaAccesoUsuario/ROLES/ROLE[13]/ROLE_ID) }</ns0:i_rol_ing13>
            <ns0:i_rol_ing14>{ data($creaAccesoUsuario/creaAccesoUsuario/ROLES/ROLE[14]/ROLE_ID) }</ns0:i_rol_ing14>
            <ns0:i_rol_ing15>{ data($creaAccesoUsuario/creaAccesoUsuario/ROLES/ROLE[15]/ROLE_ID) }</ns0:i_rol_ing15>
            <ns0:i_rol_ing16>{ data($creaAccesoUsuario/creaAccesoUsuario/ROLES/ROLE[16]/ROLE_ID) }</ns0:i_rol_ing16>
            <ns0:i_rol_ing17>{ data($creaAccesoUsuario/creaAccesoUsuario/ROLES/ROLE[17]/ROLE_ID) }</ns0:i_rol_ing17>
            <ns0:i_rol_ing18>{ data($creaAccesoUsuario/creaAccesoUsuario/ROLES/ROLE[18]/ROLE_ID) }</ns0:i_rol_ing18>
            <ns0:i_rol_ing19>{ data($creaAccesoUsuario/creaAccesoUsuario/ROLES/ROLE[19]/ROLE_ID) }</ns0:i_rol_ing19>
            <ns0:i_rol_ing20>{ data($creaAccesoUsuario/creaAccesoUsuario/ROLES/ROLE[20]/ROLE_ID) }</ns0:i_rol_ing20>
        </ns0:InputParameters>
};

declare variable $creaAccesoUsuario as element(ns1:creaAccesoUsuario) external;
declare variable $userSolic as xs:string external;

xf:creaAccesoUsuarioNIIn($creaAccesoUsuario,
    $userSolic)