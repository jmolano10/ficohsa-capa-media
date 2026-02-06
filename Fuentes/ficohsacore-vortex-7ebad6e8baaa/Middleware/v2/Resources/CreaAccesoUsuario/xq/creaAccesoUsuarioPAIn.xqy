xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$creaAccesoUsuarioRequest" element="ns0:creaAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../BusinessServices/ABKPA/creaAccesoUsuario/xsd/creaAccesoUsuario_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/PROXYABANKSPA/OSB_K_GIA_USUARIOS/P_ALTA_USUARIO/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/kvpType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaAccesoUsuario/xq/creaAccesoUsuarioPAIn/";

declare function xf:creaAccesoUsuarioPAIn($creaAccesoUsuarioRequest as element(ns0:creaAccesoUsuario))
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            <ns2:CODIGO_USUARIO>{ data($creaAccesoUsuarioRequest/creaAccesoUsuario/APPLICATION_USER) }</ns2:CODIGO_USUARIO>
            <ns2:NOMBRES>{ concat(data($creaAccesoUsuarioRequest/creaAccesoUsuario/FIRST_NAME),' ', data($creaAccesoUsuarioRequest/creaAccesoUsuario/SECOND_NAME)) }</ns2:NOMBRES>
            <ns2:PRIMER_APELLIDO>{ data($creaAccesoUsuarioRequest/creaAccesoUsuario/FIRST_LASTNAME) }</ns2:PRIMER_APELLIDO>
            <ns2:SEGUNDO_APELLIDO>{ data($creaAccesoUsuarioRequest/creaAccesoUsuario/SECOND_LASTNAME) }</ns2:SEGUNDO_APELLIDO>
            <ns2:CODIGO_AGENCIA>{ data($creaAccesoUsuarioRequest/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "AGENCY"]/VALUE) }</ns2:CODIGO_AGENCIA>
            <ns2:CODIGO_CARGO>{ data($creaAccesoUsuarioRequest/creaAccesoUsuario/POSITION_CODE) }</ns2:CODIGO_CARGO>
            <ns2:TIPO_USUARIO>{ data($creaAccesoUsuarioRequest/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "TYPE_OF_USER"]/VALUE) }</ns2:TIPO_USUARIO>
            <ns2:EMAIL>{ data($creaAccesoUsuarioRequest/creaAccesoUsuario/EMAIL) }</ns2:EMAIL>
        </ns2:InputParameters>
};

declare variable $creaAccesoUsuarioRequest as element(ns0:creaAccesoUsuario) external;

xf:creaAccesoUsuarioPAIn($creaAccesoUsuarioRequest)