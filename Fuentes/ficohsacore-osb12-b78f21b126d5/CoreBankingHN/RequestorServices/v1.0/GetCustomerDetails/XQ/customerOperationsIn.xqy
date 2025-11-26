xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/CustomerOperations/XMLSchema_210494809.xsd" ::)

declare namespace ns2="http://www.ficohsa.com/midleware.services/customerOperationsIn";
declare namespace xq="http://www.w3.org/2005/xquery-local-functions";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $customerId as xs:string external;
declare variable $queryType as xs:string external;

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

declare function ns2:customerOperationsIn($username as xs:string, 
                                          $password as xs:string, 
                                          $customerId as xs:string,
                                          $queryType as xs:string) 
                                          as element() (:: schema-element(ns1:ConsultaClientesparaDYNAMO) ::) {
    <ns1:ConsultaClientesparaDYNAMO>
        <WebRequestCommon>
            <userName>{ fn-bea:fail-over( xq:getUsername(data($username)),data($username)) }</userName>
            <password>{ fn-bea:fail-over( xq:getPassword(data($username)),data($password)) }</password>
        </WebRequestCommon>
        {
            if (fn:data($queryType) = 'CustomerId') then
              <WSCUSTOMERDYNType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{fn:data($customerId)}</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
              </WSCUSTOMERDYNType>
            else if (fn:data($queryType) = 'LegalId') then
              <WSCUSTOMERDYNType>
                <enquiryInputCollection>
                    <columnName>LR.INDX.LEGALID</columnName>
                    <criteriaValue>{fn:data($customerId)}</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
              </WSCUSTOMERDYNType>
            else
              <WSCUSTOMERDYNType/>
        }
    </ns1:ConsultaClientesparaDYNAMO>
};

ns2:customerOperationsIn($username, $password, $customerId, $queryType)