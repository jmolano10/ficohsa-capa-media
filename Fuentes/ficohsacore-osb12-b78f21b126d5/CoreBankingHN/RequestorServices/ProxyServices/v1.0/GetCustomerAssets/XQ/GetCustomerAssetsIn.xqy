xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../../ProviderServices/XSD/GetCustomerAssetsDynamo/getCustomerAssetsDynamo.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/GetCustomerAssetsIn";
declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $customerId as xs:string external;

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

declare function ns1:getCustomerAssetsIn($username as xs:string,
                                        $password as xs:string,
                                        $customerId as xs:string) as element() (:: schema-element(ns2:ConsultaClienteCuentasdeAhorro) ::) {
    <ns2:ConsultaClienteCuentasdeAhorro>
        <WebRequestCommon>
            <userName>{ fn-bea:fail-over( xq:getUsername(data($username)),data($username)) }</userName>
            <password>{ fn-bea:fail-over( xq:getPassword(data($username)),data($password)) }</password>
        </WebRequestCommon>
        <WSFICOLINKSAVINGSACCTType>
            <enquiryInputCollection>
                <columnName>CUSTOMER</columnName>
                <criteriaValue>{fn:data($customerId)}</criteriaValue>
                <operand>EQ</operand>
            </enquiryInputCollection>
        </WSFICOLINKSAVINGSACCTType>
    </ns2:ConsultaClienteCuentasdeAhorro>
};

ns1:getCustomerAssetsIn($username, $password, $customerId)