xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../../ProviderServices/XSD/ConsultasCuentaT24/v1.0/ConsultasCuentaBS.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $accountNumber as xs:string external;
declare variable $userName as xs:string external;
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


declare function xq:Tx_GetAccountDetail_To_T24($accountNumber as xs:string, 
                                               $userName as xs:string,
                                               $password as xs:string) 
                                               as element() (:: schema-element(ns1:Consultadedetallesdelacuenta) ::) {
    <ns1:Consultadedetallesdelacuenta>
        <WebRequestCommon>
            <userName>{ fn-bea:fail-over( xq:getUsername(data($userName)),data($userName)) }</userName>
            <password>{ fn-bea:fail-over( xq:getPassword(data($userName)),data($password)) }</password>
        </WebRequestCommon>
        <WSACCOUNTLISTType>
            <enquiryInputCollection>
                <columnName>@ID</columnName>
                <criteriaValue>{fn:data($accountNumber)}</criteriaValue>
                <operand>EQ</operand>
            </enquiryInputCollection>
        </WSACCOUNTLISTType>
    </ns1:Consultadedetallesdelacuenta>
};

xq:Tx_GetAccountDetail_To_T24($accountNumber, $userName,$password)