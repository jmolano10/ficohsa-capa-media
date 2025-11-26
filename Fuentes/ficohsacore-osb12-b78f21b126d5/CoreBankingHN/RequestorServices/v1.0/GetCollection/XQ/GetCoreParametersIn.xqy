xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/GetCoreParameters/GetCoreParameters.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/getCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/getCollectionTypes.xsd" ::)
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $GetCollectionRequest as element() (:: schema-element(ns1:getCollectionRequest) ::) external;
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

declare function local:func($GetCollectionRequest as element() (:: schema-element(ns1:getCollectionRequest) ::), 
                            $username as xs:string, 
                            $password as xs:string) 
                            as element() (:: schema-element(ns2:Consultadeparametroscore) ::) {
    <ns2:Consultadeparametroscore>
        <WebRequestCommon>
            <userName>{ fn-bea:fail-over( local:getUsername(data($username)),data($username)) }</userName>
            <password>{ fn-bea:fail-over( local:getPassword(data($username)),data($password)) }</password>
        </WebRequestCommon>
        <WSCOREPARAMETERSType>
            <enquiryInputCollection>
                <columnName>CURRENCY.CODE</columnName>
                <criteriaValue>
                {
                    let $moneda := fn:data($GetCollectionRequest/ns1:Currency)
                    return
                      if ($moneda = "HNL") then (
                          "USD"
                      )else(
                          $moneda
                      ) 
                }
                </criteriaValue>
                <operand>EQ</operand>
            </enquiryInputCollection>
        </WSCOREPARAMETERSType>
    </ns2:Consultadeparametroscore>
};

local:func($GetCollectionRequest, $username, $password)