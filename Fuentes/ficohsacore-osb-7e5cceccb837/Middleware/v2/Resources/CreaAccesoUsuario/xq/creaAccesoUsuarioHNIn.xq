(:: pragma bea:global-element-parameter parameter="$creaAccesoUsuario" element="ns0:creaAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKHN/creaAccesoUsuario/xsd/creaAccesoUsuario_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/kvpType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/PROXYABANKSHN/OSB_K_GIA_USUARIOS_HN/OSB_P_ALTA_USUARIO_HN/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaAccesoUsuario/xq/creaAccesoUsuarioHNIn/";

declare function xf:creaAccesoUsuarioHNIn($creaAccesoUsuario as element(ns0:creaAccesoUsuario))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CODIGO_USUARIO>{ data($creaAccesoUsuario/creaAccesoUsuario/APPLICATION_USER) }</ns1:PV_CODIGO_USUARIO>
            <ns1:PV_NOMBRES>{ concat(data($creaAccesoUsuario/creaAccesoUsuario/FIRST_NAME),' ', data($creaAccesoUsuario/creaAccesoUsuario/SECOND_NAME)) }</ns1:PV_NOMBRES>
            <ns1:PV_PRIMER_APELLIDO>{ data($creaAccesoUsuario/creaAccesoUsuario/FIRST_LASTNAME) }</ns1:PV_PRIMER_APELLIDO>
            <ns1:PV_SEGUNDO_APELLIDO>{ data($creaAccesoUsuario/creaAccesoUsuario/SECOND_LASTNAME) }</ns1:PV_SEGUNDO_APELLIDO>
            <ns1:PV_CODIGO_AGENCIA>{ data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "AGENCY"]/VALUE) }</ns1:PV_CODIGO_AGENCIA>
            <ns1:PV_CODIGO_CARGO>{ data($creaAccesoUsuario/creaAccesoUsuario/POSITION_CODE) }</ns1:PV_CODIGO_CARGO>
            <ns1:PV_TIPO_USUARIO>{ data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "TYPE_OF_USER"]/VALUE) }</ns1:PV_TIPO_USUARIO>
            <ns1:PV_EMAIL>{ data($creaAccesoUsuario/creaAccesoUsuario/EMAIL) }</ns1:PV_EMAIL>
        </ns1:InputParameters>
};

declare variable $creaAccesoUsuario as element(ns0:creaAccesoUsuario) external;

xf:creaAccesoUsuarioHNIn($creaAccesoUsuario)