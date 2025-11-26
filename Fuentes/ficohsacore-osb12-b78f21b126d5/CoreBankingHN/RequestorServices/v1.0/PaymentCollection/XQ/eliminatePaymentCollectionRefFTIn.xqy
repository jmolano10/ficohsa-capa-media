xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/PaymentCollection/XMLSchema_-263071553.xsd" ::)
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";


declare variable $status as element() external;
declare variable $username as xs:string external;
declare variable $password as xs:string external;

(: Función encargada de realizar el mapeo de usuario:)
declare function local:getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function local:getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function local:func($status as element(), 
                            $username as xs:string, 
                            $password as xs:string) 
                            as element() (:: schema-element(ns1:EliminacionpagorecaudorefFT) ::) {
    <ns1:EliminacionpagorecaudorefFT>
          <WebRequestCommon>
                <userName>{ fn-bea:fail-over( local:getUsername(data($username)),data($username)) }</userName>
                <password>{ fn-bea:fail-over( local:getPassword(data($username)),data($password)) }</password>
          </WebRequestCommon>
          <FUNDSTRANSFERREFCOLLACTRFWSCOPYType>
                {
                    for $transactionId in $status/transactionId
                    return
                        <transactionId>{ data($transactionId) }</transactionId>
                }
            </FUNDSTRANSFERREFCOLLACTRFWSCOPYType>
    </ns1:EliminacionpagorecaudorefFT>
};

local:func($status, $username, $password)