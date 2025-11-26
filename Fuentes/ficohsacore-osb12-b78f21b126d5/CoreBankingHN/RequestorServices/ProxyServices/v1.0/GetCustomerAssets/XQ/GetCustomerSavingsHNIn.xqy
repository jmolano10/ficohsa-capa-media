xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/sjConsultaActivosCliente";
(:: import schema at "../XSD/sjConsultaActivosCliente.xsd" ::)
declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $customerId as xs:string external;

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

declare function local:func($username as xs:string,
                            $password as xs:string,
                            $customerId as xs:string) as element() (:: schema-element(ns1:sjConsultaActivosClienteRequest) ::) {
    <ns1:GetCustomerSavingsRequest>
        <ns1:USERNAME>{fn:data($username)}</ns1:USERNAME>
        <ns1:PASSWORD>{fn:data($password)}</ns1:PASSWORD>
        <ns1:CUSTOMER_ID>{fn:data($customerId)}</ns1:CUSTOMER_ID>
    </ns1:GetCustomerSavingsRequest>
};

local:func($username, $password, $customerId)