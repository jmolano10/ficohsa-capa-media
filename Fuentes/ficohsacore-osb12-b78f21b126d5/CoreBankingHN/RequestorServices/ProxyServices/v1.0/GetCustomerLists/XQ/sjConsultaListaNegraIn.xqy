xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="T24WebServicesImpl";
(:: import schema at "../../../../../ProviderServices/XSD/GetCustomerLists/V1.0/GetCustomerLists_BS.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/getCustomerListsHN_SJ";
(:: import schema at "../XSD/GetCustomerListsHN_SJ.xsd" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/sjConsultaListasCliente";
declare namespace xq="http://www.w3.org/2005/xquery-local-functions";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $legalId as xs:string external;
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

declare function ns1:sjConsultaListaNegraIn($legalId as xs:string, $username as xs:string, $password as xs:string) as element() (:: schema-element(ns3:Consultadelistanegra) ::) {
    <ns3:Consultadelistanegra>
        <WebRequestCommon>
            <userName>{ fn-bea:fail-over( xq:getUsername(data($username)),data($username)) }</userName>
            <password>{ fn-bea:fail-over( xq:getPassword(data($username)),data($password)) }</password>
        </WebRequestCommon>
        <WSFICOBLACKLISTDETType>
            <enquiryInputCollection>
                <columnName>DOC.NUMBER</columnName>
                <criteriaValue>{fn:data($legalId)}</criteriaValue>
                <operand>EQ</operand>
            </enquiryInputCollection>
        </WSFICOBLACKLISTDETType>
    </ns3:Consultadelistanegra>
};

ns1:sjConsultaListaNegraIn($legalId, $username, $password)