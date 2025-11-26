xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/AccountInquiryT24/XMLSchema_378991004.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/accountMovements";
(:: import schema at "../../../../../MWBanking/Accounts/RequestorServices/XSD/getAccountMovementsTypes.xsd" ::)
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $userName as xs:string external;
declare variable $password as xs:string external;
declare variable $GetAccountMovementsRequest as element() (:: schema-element(ns1:getAccountMovementsRequest) ::) external;

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

declare function local:func($userName as xs:string, 
                            $password as xs:string, 
                            $GetAccountMovementsRequest as element() (:: schema-element(ns1:getAccountMovementsRequest) ::)) 
                            as element() (:: schema-element(ns2:Consultadedetallesdelacuenta) ::) {
    <ns2:Consultadedetallesdelacuenta>
        <WebRequestCommon>
            <userName>{ fn-bea:fail-over( local:getUsername(data($userName)),data($userName)) }</userName>
            <password>{ fn-bea:fail-over( local:getPassword(data($userName)),data($password)) }</password>
        </WebRequestCommon>
        <WSACCOUNTLISTType>
            <enquiryInputCollection>
                <columnName>@ID</columnName>
                <criteriaValue>{fn:data($GetAccountMovementsRequest/AccountNumber)}</criteriaValue>
                    <operand>EQ</operand>
            </enquiryInputCollection>
        </WSACCOUNTLISTType>
    </ns2:Consultadedetallesdelacuenta>
};

local:func($userName, $password, $GetAccountMovementsRequest)