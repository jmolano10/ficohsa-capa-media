xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaUsuarioLdapRequest1" element="ns1:consultaUsuarioLdapRequest" location="../xsd/consultaUsuarioLdapTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/consultaInfoUsuarioAD/xsd/consultarInfoUsuarioAD_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaUsuarioLdapTypes/v2";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarInfoUsuarioAD";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaUsuarioLdap/xq/consultaUsuarioIn/";

declare function xf:consultaUsuarioIn($requestHeader1 as element(ns2:RequestHeader),
    $consultaUsuarioLdapRequest1 as element(ns1:consultaUsuarioLdapRequest),
    $base_dn as xs:string,
    $user_dn as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:LDAP_USER>{ concat(data($requestHeader1/Authentication/UserName),$user_dn) }</ns0:LDAP_USER>
            <ns0:LDAP_PWD>{ data($requestHeader1/Authentication/Password) }</ns0:LDAP_PWD>
            <ns0:USUARIO_AD>{ data($consultaUsuarioLdapRequest1/USER_NAME) }</ns0:USUARIO_AD>
            <ns0:BASE_DN>{ $base_dn }</ns0:BASE_DN>
        </ns0:InputParameters>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $consultaUsuarioLdapRequest1 as element(ns1:consultaUsuarioLdapRequest) external;
declare variable $base_dn as xs:string external;
declare variable $user_dn as xs:string external;

xf:consultaUsuarioIn($requestHeader1,
    $consultaUsuarioLdapRequest1,
    $base_dn,
    $user_dn)