<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/honduras/user";
(:: import schema at "../Schemas/UserLoginT24.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace fic="http://www.w3.org/2005/xquery-local-functions";

 
declare variable $pension as element(ns1:userLoginElement) external;

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
 
declare function fic:extractCredentialsFromSecurity($pension as element(ns1:userLoginElement) ) 
    as element(ns1:connInfoElement){
    <ns1:connInfoElement>
        <ns1:variables>{data($pension/ns1:userLogin)}</ns1:variables>
        <ns1:username>{fn-bea:fail-over( fic:getUsername(data($pension/ns1:userLogin)), data($pension/ns1:userLogin))}</ns1:username>
        <ns1:password>{fn-bea:fail-over( fic:getPassword(data($pension/ns1:userLogin)), data($pension/ns1:userLogin))}</ns1:password>
    </ns1:connInfoElement>
};
 
fic:extractCredentialsFromSecurity($pension)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/UserLoginT24.xsd">
            <con:schema ref="SBHN_Pension_Commons/Schemas/UserLoginT24"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>