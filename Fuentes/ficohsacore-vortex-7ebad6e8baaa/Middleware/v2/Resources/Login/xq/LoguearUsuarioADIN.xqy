xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/MDW/LoginUsuarioAD/LogueoAD/xsd/LoguearUsuarioAD_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/LoguearUsuarioAD";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/loginTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Login/xq/LoguearUsuarioADIN/";

declare function xf:LoguearUsuarioADIN($Credencial as xs:string , $Username as xs:string, $Pais as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:LDAP_USER>{ $Username }</ns1:LDAP_USER>
            <ns1:LDAP_PWD>{ $Credencial }</ns1:LDAP_PWD>
            <ns1:PAIS_DN>{ $Pais }</ns1:PAIS_DN>
        </ns1:InputParameters>
};

declare variable $Username as xs:string external;
declare variable $Credencial as xs:string external;
declare variable $Pais as xs:string external;


xf:LoguearUsuarioADIN( $Credencial , $Username , $Pais )