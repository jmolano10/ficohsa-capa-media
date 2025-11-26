xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/Remittances/Remittances.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/getRemittancesTypes";
(:: import schema at "../../../../../MWBanking/Remittances/RequestorServices/XSD/getRemittances.xsd" ::)
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $username as text() external;
declare variable $password as text() external;
declare variable $getRemittancesRequest as element() (:: schema-element(ns1:getRemittancesRequest) ::) external;

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

declare function local:func($username as text(), 
                            $password as text(), 
                            $getRemittancesRequest as element() (:: schema-element(ns1:getRemittancesRequest) ::)) 
                            as element() (:: schema-element(ns2:Consultaderemesa) ::) {
    <ns2:Consultaderemesa>
        <WebRequestCommon>
            <userName>{ fn-bea:fail-over( local:getUsername(data($username)),data($username)) }</userName>
            <password>{ fn-bea:fail-over( local:getPassword(data($username)),data($password)) }</password>
            <company></company>
        </WebRequestCommon>
        <WSLATAMAGREMITTANCEINFOType>
                {
                    if ($getRemittancesRequest/ns1:RemittanceId)
                    then( 
                      <enquiryInputCollection>
                         <columnName>REMITTANCE.KEY</columnName>
                          <criteriaValue>{fn:data($getRemittancesRequest/ns1:RemittanceId)}</criteriaValue>
                          <operand>EQ</operand>
                      </enquiryInputCollection>
                    )else ()
                }
        </WSLATAMAGREMITTANCEINFOType>
    </ns2:Consultaderemesa>
};

local:func($username, $password, $getRemittancesRequest)
