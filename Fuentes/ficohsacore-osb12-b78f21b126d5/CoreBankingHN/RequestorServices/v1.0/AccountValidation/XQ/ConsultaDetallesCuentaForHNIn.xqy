xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/ConsultasCuentaT24/v1.0/ConsultasCuentaBS.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/sjEvaluateAbanksAccountTypes";
(:: import schema at "../../../../../MWBanking/Accounts/RequestorServices/XSD/sjEvaluateAbanksAccountTypes.xsd" ::)

declare variable $index as xs:string external;
declare variable $userName as xs:string external;
declare variable $password as xs:string external;
declare variable $account as xs:string external;

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

declare function local:func($index as xs:string, 
                            $userName as xs:string, 
                            $password as xs:string, 
                            $account as xs:string) 
                            as element() (:: schema-element(ns2:Consultadedetallesdelacuenta) ::) {
    <ns2:Consultadedetallesdelacuenta>
        <WebRequestCommon>
            <userName>{ fn-bea:fail-over( local:getUsername(data($userName)),data($userName)) }</userName>
            <password>{ fn-bea:fail-over( local:getPassword(data($userName)),data($password)) }</password>
        </WebRequestCommon>
        <WSACCOUNTLISTType>
            <enquiryInputCollection>
                <columnName>@ID</columnName>
                <criteriaValue>{$account}</criteriaValue>                                               
                <operand>EQ</operand>
            </enquiryInputCollection>
        </WSACCOUNTLISTType>
    </ns2:Consultadedetallesdelacuenta>
};

local:func($index, $userName, $password, $account)