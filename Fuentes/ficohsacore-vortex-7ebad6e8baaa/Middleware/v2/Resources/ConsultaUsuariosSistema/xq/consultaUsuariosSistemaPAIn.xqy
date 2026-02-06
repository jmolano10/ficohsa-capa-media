xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaUsuariosSistema" element="ns1:consultaUsuariosSistema" location="../xsd/consultaUsuariosSistemaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKPA/consultaUsuariosSistema/xsd/consultaUsuariosSistema_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaUsuariosSistema";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaUsuariosSistemaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaUsuariosSistema/xq/consultaUsuariosSistemaPAIn/";

declare function xf:consultaUsuariosSistemaPAIn($consultaUsuariosSistema as element(ns1:consultaUsuariosSistema))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            {
                for $USER_ID in $consultaUsuariosSistema/USER_ID
                return
                    <ns0:CODIGO_USUARIO>{ data($USER_ID) }</ns0:CODIGO_USUARIO>
            }
            {
                for $SIGN_ON_NAME in $consultaUsuariosSistema/SIGN_ON_NAME
                return
                    <ns0:NOMBRE_INICIO_SESION>{ data($SIGN_ON_NAME) }</ns0:NOMBRE_INICIO_SESION>
            }
            {
                for $OFFICER_DAO in $consultaUsuariosSistema/OFFICER_DAO
                return
                    <ns0:OFICIAL_DAO>{ data($OFFICER_DAO) }</ns0:OFICIAL_DAO>
            }
            {
                for $APPLICATION in $consultaUsuariosSistema/APPLICATION
                return
                    <ns0:APLICACION>{ data($APPLICATION) }</ns0:APLICACION>
            }
            {
                for $BRANCH_CODE in $consultaUsuariosSistema/BRANCH_CODE
                return
                    <ns0:CODIGO_AGENCIA>{ string(data($BRANCH_CODE)) }</ns0:CODIGO_AGENCIA>
            }
        </ns0:InputParameters>
};

declare variable $consultaUsuariosSistema as element(ns1:consultaUsuariosSistema) external;

xf:consultaUsuariosSistemaPAIn($consultaUsuariosSistema)