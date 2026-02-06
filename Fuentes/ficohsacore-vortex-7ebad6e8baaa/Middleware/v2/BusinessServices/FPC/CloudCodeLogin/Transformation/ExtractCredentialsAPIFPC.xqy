xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/honduras/pension/user";
(:: import schema at "../Schemas/UserLoginTypes.xsd" ::)
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace fic="http://www.w3.org/2005/xquery-local-functions";

declare variable $account as element() (:: schema-element(ns1:serviceAccount) ::) external;

(: Función encargada de extraer el usuario de la cuenta de servicio:)
declare function fic:getUsername ($LDAPId as xs:string)  as xs:string { 
  let $data := fn-bea:lookupBasicCredentials(concat("SB_Security/Common/", upper-case($LDAPId)))
  return
    $data/con:username/text()
 };   

(: Función encargada de extraer la contraseña de la cuenta de servicio:)
declare function fic:getPassword ($LDAPId as xs:string)  as xs:string {      
  let $data := fn-bea:lookupBasicCredentials(concat("SB_Security/Common/", upper-case($LDAPId)))
  return
    $data/con:password/text()
 };
declare function local:func($account as element() (:: schema-element(ns1:serviceAccount) ::)) as element() (:: schema-element(ns1:credentials) ::) {
    <ns1:credentials>
        <ns1:userName>{fn-bea:fail-over(fic:getUsername(data($account/ns1:accountName)),data($account/ns1:accountName))}</ns1:userName>
        <ns1:userPassword>{fn-bea:fail-over(fic:getPassword(data($account/ns1:accountName)),data($account/ns1:accountName))}</ns1:userPassword>
    </ns1:credentials>
};

local:func($account)