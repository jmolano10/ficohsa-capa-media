xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/CoreBS/XMLSchema_1628019553.xsd" ::)
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $userName as xs:string external;
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
 
declare function local:func($userName as xs:string, 
                            $password as xs:string) 
                            as element() (:: schema-element(ns1:Consultadefechadelsistema) ::) {
    <ns1:Consultadefechadelsistema>
        <WebRequestCommon>
            <userName>{ fn-bea:fail-over( local:getUsername(data($userName)),data($userName)) }</userName>
            <password>{ fn-bea:fail-over( local:getPassword(data($userName)),data($password)) }</password>
        </WebRequestCommon>
        <WSDATESType>
            <enquiryInputCollection>
                <columnName>COMPANY.CODE</columnName>
                <criteriaValue>HN0010001</criteriaValue>
                <operand>EQ</operand>
            </enquiryInputCollection>
        </WSDATESType>
    </ns1:Consultadefechadelsistema>
};

local:func($userName, $password)