xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/CoreBS/XMLSchema_1628019553.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/getExchangeRateTypes";
(:: import schema at "../../../../../MWBanking/ConsumerService/XSD/getExchangeRateTypes.xsd" ::)
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $GetExchangeRateRequest as element() (:: schema-element(ns1:getExchangeRateRequest) ::) external;
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

declare function local:func($GetExchangeRateRequest as element() (:: schema-element(ns1:getExchangeRateRequest) ::), 
                            $username as xs:string, 
                            $password as xs:string) 
                            as element() (:: schema-element(ns2:Consultadetasadecambiolcy) ::) {
    <ns2:Consultadetasadecambiolcy>
        <WebRequestCommon>
            <userName>{ fn-bea:fail-over( local:getUsername(data($username)),data($username)) }</userName>
            <password>{ fn-bea:fail-over( local:getPassword(data($username)),data($password)) }</password>
        </WebRequestCommon>
        <WSLCYEXCHRATEType>
            <enquiryInputCollection>
                <columnName>CURRENCY.CODE</columnName>
                <criteriaValue>{fn:data($GetExchangeRateRequest/ns1:SourceCurrency)}</criteriaValue>
                <operand>EQ</operand>
            </enquiryInputCollection>
        </WSLCYEXCHRATEType>
    </ns2:Consultadetasadecambiolcy>
};

local:func($GetExchangeRateRequest, $username, $password)