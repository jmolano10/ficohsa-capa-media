xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/getServiceAccountDataIn";
declare namespace xq="http://www.w3.org/2005/xquery-local-functions";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $serviceAccountName as xs:string external;
declare variable $type as xs:string external;

(: Función encargada de realizar el mapeo de usuario:)
declare function xq:getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };
 
 (: Función encargada de realizar el mapeo de contraseña:)
declare function xq:getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function ns1:getServiceAccountDataIn($serviceAccountName as xs:string, 
                                             $type as xs:string) as xs:string {
    if ($type = 'username') then
        xs:string(fn-bea:fail-over( xq:getUsername($serviceAccountName),""))
    else
        xs:string(fn-bea:fail-over( xq:getPassword($serviceAccountName),""))
};

ns1:getServiceAccountDataIn($serviceAccountName, $type)
