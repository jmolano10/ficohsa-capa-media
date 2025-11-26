xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/GetMobilePackeages/GetMobilePackeages.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/getCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/getCollectionTypes.xsd" ::)
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $GetCollectionRequest as element() (:: schema-element(ns1:getCollectionRequest) ::) external;
declare variable $Username as xs:string external;
declare variable $Password as xs:string external;

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
                            $Username as xs:string, 
                            $Password as xs:string) 
                            as element() (:: schema-element(ns2:ConsultaPaquetesMoviles) ::) {
    <ns2:ConsultaPaquetesMoviles>
        <WebRequestCommon>
            <userName>{ fn-bea:fail-over( local:getUsername(data($Username)),data($Username)) }</userName>
            <password>{ fn-bea:fail-over( local:getPassword(data($Username)),data($Password)) }</password>
        </WebRequestCommon>
        <WSFICOPARAMPACKAGEType>
            <enquiryInputCollection>
                <columnName>@ID</columnName>
                <criteriaValue>{fn:data($GetCollectionRequest/ns1:ContractId)}</criteriaValue>
                <operand>EQ</operand>
            </enquiryInputCollection>
        </WSFICOPARAMPACKAGEType>
    </ns2:ConsultaPaquetesMoviles>
};

local:func($GetCollectionRequest, $Username, $Password)