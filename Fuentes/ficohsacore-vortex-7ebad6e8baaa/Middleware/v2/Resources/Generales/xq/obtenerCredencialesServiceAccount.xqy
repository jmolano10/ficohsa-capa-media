xquery version "2004-draft";
(:: pragma  type="xs:anyType" ::)
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroATMConCupon/xq/obtenerCredencialesServiceAccount/";

declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
    let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
        return
            $data/con:username/text()
 };
 
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
    let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
        return
            $data/con:password/text()
 };
 
declare function xf:obtenerCredencialesServiceAccount($usuario as xs:string)
    as element(*) {
        <Authentication>
            <UserName>{ fn-bea:fail-over( getUsername($usuario), '') }</UserName>
            <Password>{ fn-bea:fail-over( getPassword($usuario),'') }</Password>
        </Authentication>
};

declare variable $usuario as xs:string external;

xf:obtenerCredencialesServiceAccount($usuario)