xquery version "2004-draft";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/general/consultaPasswordServiceAccount/";

(: Función encargada de realizar el mapeo de contraseña:)
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function xf:consultaPasswordServiceAccount($serviceAccountName as xs:string)
    as xs:string {
        xs:string(fn-bea:fail-over( getPassword($serviceAccountName), ""))
};

declare variable $serviceAccountName as xs:string external;

xf:consultaPasswordServiceAccount($serviceAccountName)