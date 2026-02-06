xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:Consultadedetallesdelacuenta" location="../../../Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Genericos/consultaDetalleCuentaHNIn/";
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

declare function xf:consultaDetalleCuentaHNIn($username as xs:string,
    $password as xs:string,
    $accountNumber as xs:string)
    as element(ns0:Consultadedetallesdelacuenta) {
        <ns0:Consultadedetallesdelacuenta>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername($username),$username) }</userName>
                <password>{ fn-bea:fail-over( getPassword($username),$password) }</password>
            </WebRequestCommon>
            <WSACCOUNTLISTType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ $accountNumber }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSACCOUNTLISTType>
        </ns0:Consultadedetallesdelacuenta>
};

declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $accountNumber as xs:string external;

xf:consultaDetalleCuentaHNIn($username,
    $password,
    $accountNumber)