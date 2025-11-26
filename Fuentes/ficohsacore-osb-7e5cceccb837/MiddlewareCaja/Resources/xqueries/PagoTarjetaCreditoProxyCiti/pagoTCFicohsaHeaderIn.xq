(:: pragma bea:global-element-return element="ns0:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoTarjetaCreditoFicohsa/pagoTarjetaCreditoFicohsaIn/";

(: Función encargada de realizar el mapeo de usuario:)
declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("MiddlewareCaja/ServiceAccounts/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("MiddlewareCaja/ServiceAccounts/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function xf:pagoTarjetaCreditoFicohsaIn($username as xs:string)
    as element(ns0:AutenticacionRequestHeader) {
	        <ns0:AutenticacionRequestHeader>
    	        <UserName>{ getUsername($username) } </UserName>
        	    <Password>{ getPassword($username) }</Password>
        	</ns0:AutenticacionRequestHeader>
};

declare variable $username as xs:string external;

xf:pagoTarjetaCreditoFicohsaIn($username)