(:: pragma bea:global-element-parameter parameter="$cambiaEstadoAccesoUsuario" element="ns1:cambiaEstadoAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/Cobis/GestionAccesoUsuarios/xsd/gestionAccesosUsuarios_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/gestionAccesosUsuarios";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CambiaEstadoAccesoUsuario/xq/cambiaEstadoAccesoUsuarioNIIn/";

declare function xf:cambiaEstadoAccesoUsuarioNIIn($cambiaEstadoAccesoUsuario as element(ns1:cambiaEstadoAccesoUsuario),
    $userSolic as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
        	<ns0:s_ssn/>
            <ns0:s_ofi/>
            <ns0:s_term/>
            <ns0:i_modo>1</ns0:i_modo>
            <ns0:i_interfaz>LOCAL</ns0:i_interfaz>
            <ns0:i_user_solic>{ $userSolic }</ns0:i_user_solic>
            <ns0:i_nombre/>
            <ns0:i_login>{ data($cambiaEstadoAccesoUsuario/cambiaEstadoAccesoUsuario/APPLICATION_USER) }</ns0:i_login>
            <ns0:i_sexo/>
            <ns0:i_nomina/>
            <ns0:i_oficina_ing1/>
            <ns0:i_departamento/>
            <ns0:i_cargo/>
            <ns0:i_jefe/>
            <ns0:i_estado>{ data($cambiaEstadoAccesoUsuario/cambiaEstadoAccesoUsuario/STATUS) }</ns0:i_estado>
            <ns0:i_rol_ing1/>
            <ns0:i_oficina_ing2/>
            <ns0:i_oficina_ing3/>
            <ns0:i_oficina_ing4/>
            <ns0:i_oficina_ing5/>
            <ns0:i_oficina_ing6/>
            <ns0:i_oficina_ing7/>
            <ns0:i_oficina_ing8/>
            <ns0:i_oficina_ing9/>
            <ns0:i_oficina_ing10/>
            <ns0:i_oficina_ing11/>
            <ns0:i_oficina_ing12/>
            <ns0:i_oficina_ing13/>
            <ns0:i_oficina_ing14/>
            <ns0:i_oficina_ing15/>
            <ns0:i_oficina_ing16/>
            <ns0:i_oficina_ing17/>
            <ns0:i_oficina_ing18/>
            <ns0:i_oficina_ing19/>
            <ns0:i_oficina_ing20/>
            <ns0:i_rol_ing2/>
            <ns0:i_rol_ing3/>
            <ns0:i_rol_ing4/>
            <ns0:i_rol_ing5/>
            <ns0:i_rol_ing6/>
            <ns0:i_rol_ing7/>
            <ns0:i_rol_ing8/>
            <ns0:i_rol_ing9/>
            <ns0:i_rol_ing10/>
            <ns0:i_rol_ing11/>
            <ns0:i_rol_ing12/>
            <ns0:i_rol_ing13/>
            <ns0:i_rol_ing14/>
            <ns0:i_rol_ing15/>
            <ns0:i_rol_ing16/>
            <ns0:i_rol_ing17/>
            <ns0:i_rol_ing18/>
            <ns0:i_rol_ing19/>
            <ns0:i_rol_ing20/>
        </ns0:InputParameters>
};

declare variable $cambiaEstadoAccesoUsuario as element(ns1:cambiaEstadoAccesoUsuario) external;
declare variable $userSolic as xs:string external;

xf:cambiaEstadoAccesoUsuarioNIIn($cambiaEstadoAccesoUsuario,
    $userSolic)