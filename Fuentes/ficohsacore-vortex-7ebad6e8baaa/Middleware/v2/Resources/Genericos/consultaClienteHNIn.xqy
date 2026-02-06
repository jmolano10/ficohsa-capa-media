xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:Consultadecliente" location="../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/TransferenciasACH/xq/consultaClienteIn/";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

(: Función encargada de realizar el mapeo de usuario:)
declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function xf:consultaClienteIn($username as xs:string,
    $password as xs:string,
    $customerId as xs:string)
    as element(ns0:Consultadecliente) {
        <ns0:Consultadecliente>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername($username),$username) }</userName>
                <password>{ fn-bea:fail-over( getPassword($username),$password) }</password>
            </WebRequestCommon>
            <WSCUSTOMERType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ $customerId }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSCUSTOMERType>
        </ns0:Consultadecliente>
};

declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $customerId as xs:string external;

xf:consultaClienteIn($username,
    $password,
    $customerId)