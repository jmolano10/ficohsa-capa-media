xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$creaAccesoUsuario" element="ns1:creaAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/creaAccesoUsuario/xsd/creaAccesoUsuario_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/PROXYABANKSGT/OSB_K_GIA_USUARIOS/P_ALTA_USUARIO/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/kvpType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaAccesoUsuario/xq/creaAccesoUsuarioGTIn/";

declare function xf:creaAccesoUsuarioGTIn($creaAccesoUsuario as element(ns1:creaAccesoUsuario))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:CODIGO_USUARIO>{ data($creaAccesoUsuario/creaAccesoUsuario/APPLICATION_USER) }</ns0:CODIGO_USUARIO>
            <ns0:NOMBRES>{ concat(data($creaAccesoUsuario/creaAccesoUsuario/FIRST_NAME),' ', data($creaAccesoUsuario/creaAccesoUsuario/SECOND_NAME)) }</ns0:NOMBRES>
            <ns0:PRIMER_APELLIDO>{ data($creaAccesoUsuario/creaAccesoUsuario/FIRST_LASTNAME) }</ns0:PRIMER_APELLIDO>
            <ns0:SEGUNDO_APELLIDO>{ data($creaAccesoUsuario/creaAccesoUsuario/SECOND_LASTNAME) }</ns0:SEGUNDO_APELLIDO>
            <ns0:CODIGO_AGENCIA>{ data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "AGENCY"]/VALUE) }</ns0:CODIGO_AGENCIA>
            <ns0:CODIGO_CARGO>{ data($creaAccesoUsuario/creaAccesoUsuario/POSITION_CODE) }</ns0:CODIGO_CARGO>
            <ns0:TIPO_USUARIO>{ data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "TYPE_OF_USER"]/VALUE) }</ns0:TIPO_USUARIO>
            <ns0:EMAIL>{ data($creaAccesoUsuario/creaAccesoUsuario/EMAIL) }</ns0:EMAIL>
        </ns0:InputParameters>
};

declare variable $creaAccesoUsuario as element(ns1:creaAccesoUsuario) external;

xf:creaAccesoUsuarioGTIn($creaAccesoUsuario)