<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/general/consultaUsernameServiceAccount/";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

(: Función encargada de realizar el mapeo de usuario:)
declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

declare function xf:consultaUsernameSericeAccount($serviceAccountName as xs:string)
    as xs:string {
        xs:string(fn-bea:fail-over( getUsername($serviceAccountName),""))
};

declare variable $serviceAccountName as xs:string external;

xf:consultaUsernameSericeAccount($serviceAccountName)</con:xquery>
</con:xqueryEntry>