xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/MobilePackages/XMLSchema_-578407725.xsd" ::)
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $uuid as xs:string external;
declare variable $purchaseMovilePackageResponse as element() (:: schema-element(ns1:PagoDePaquetesMovilesFTResponse) ::) external;

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


declare function local:func($username as xs:string, 
                            $password as xs:string, 
                            $uuid as xs:string, 
                            $purchaseMovilePackageResponse as element() (:: schema-element(ns1:PagoDePaquetesMovilesFTResponse) ::)) 
                            as element() (:: schema-element(ns1:ReversionDePaquetesMovilesFT) ::) {
    <ns1:ReversionDePaquetesMovilesFT>
      <WebRequestCommon>
                <userName>{ fn-bea:fail-over( local:getUsername(data($username)),data($username)) }</userName>
                <password>{ fn-bea:fail-over( local:getPassword(data($username)),data($password)) }</password>
      </WebRequestCommon>
      <FUNDSTRANSFERFICOMOBILEPACKAGEREVWSType>
                {
                    for $transactionId in $purchaseMovilePackageResponse/Status/transactionId
                    return
                        <transactionId>{ data($transactionId) }</transactionId>
                }
            </FUNDSTRANSFERFICOMOBILEPACKAGEREVWSType>
    </ns1:ReversionDePaquetesMovilesFT>
};

local:func($username, $password, $uuid, $purchaseMovilePackageResponse)