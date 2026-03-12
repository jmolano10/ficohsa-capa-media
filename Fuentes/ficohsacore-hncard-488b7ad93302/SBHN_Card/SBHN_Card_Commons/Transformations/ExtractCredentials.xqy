xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/honduras/user";
(:: import schema at "../Schemas/UserLoginT24.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace fic="http://www.w3.org/2005/xquery-local-functions";


declare variable $account as element(ns1:userLoginElement) external;

(: Función encargada de realizar el mapeo de usuario:)
declare function fic:getUsername ($LDAPId as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("SB_Security/Common/", upper-case($LDAPId)))
  		return
		    $data/con:username/text()
 };   

(: Función encargada de realizar el mapeo de contraseña:)
declare function fic:getPassword ($LDAPId as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("SB_Security/Common/", upper-case($LDAPId)))
  		return
		    $data/con:password/text()
 };
 
declare function fic:extractCredentialsFromSecurity($account as element(ns1:userLoginElement) ) 
    as element(ns1:connInfoElement){
    <ns1:connInfoElement>
        <ns1:variables>{data($account/ns1:userLogin)}</ns1:variables>
        <ns1:username>{fn-bea:fail-over( fic:getUsername(data($account/ns1:userLogin)), data($account/ns1:userLogin))}</ns1:username>
        <ns1:password>{fn-bea:fail-over( fic:getPassword(data($account/ns1:userLogin)), data($account/ns1:userLogin))}</ns1:password>
    </ns1:connInfoElement>
};
 
fic:extractCredentialsFromSecurity($account)