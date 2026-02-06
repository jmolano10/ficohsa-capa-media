xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:ConsultaMaestraTarjetaDebito" location="../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Genericos/consultaInfoTDHNIn/";
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

declare function xf:consultaInfoTDHNIn($username as xs:string,
    $password as xs:string,
    $cardNumber as xs:string)
    as element(ns0:ConsultaMaestraTarjetaDebito) {
        <ns0:ConsultaMaestraTarjetaDebito>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername($username),$username) }</userName>
                <password>{ fn-bea:fail-over( getPassword($username),$password) }</password>
            </WebRequestCommon>
            <WSFICODEBITCARDCUSTOMERType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ fn:concat("...",$cardNumber) }</criteriaValue>
                    <operand>LK</operand>
                </enquiryInputCollection>
            </WSFICODEBITCARDCUSTOMERType>
        </ns0:ConsultaMaestraTarjetaDebito>
};

declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $cardNumber as xs:string external;

xf:consultaInfoTDHNIn($username,
    $password,
    $cardNumber)