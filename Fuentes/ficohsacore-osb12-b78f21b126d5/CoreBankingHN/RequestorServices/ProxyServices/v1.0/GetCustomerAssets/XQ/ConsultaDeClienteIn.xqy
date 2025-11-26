xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../../ProviderServices/XSD/v1.0/getCustomerAssets.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/ConsultaDeClienteIn";
declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $customerId as xs:string external;
declare variable $username as xs:string external;
declare variable $password as xs:string external;

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

declare function ns1:consultaDeClienteIn($username as xs:string, $password as xs:string, $customerId as xs:string) as element() (:: schema-element(ns2:Consultadecliente) ::) {
    <ns2:Consultadecliente>
        <WebRequestCommon>
            <userName>{ fn-bea:fail-over( xq:getUsername(data($username)),data($username)) }</userName>
            <password>{ fn-bea:fail-over( xq:getPassword(data($username)),data($password)) }</password>
        </WebRequestCommon>
        <WSCUSTOMERType>
            <enquiryInputCollection>
                <columnName>@ID</columnName>
                <criteriaValue>{fn:data($customerId)}</criteriaValue>
                <operand>EQ</operand>
            </enquiryInputCollection>
        </WSCUSTOMERType>
    </ns2:Consultadecliente>
};

ns1:consultaDeClienteIn($username, $password, $customerId)