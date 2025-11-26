xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/Collection/Collection.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/getCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/getCollectionTypes.xsd" ::)
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $GetCollectionRequest as element() (:: schema-element(ns1:getCollectionRequest) ::) external;
declare variable $UserName as xs:string external;
declare variable $password as xs:string external;

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
                            $UserName as xs:string, 
                            $password as xs:string) 
                            as element() (:: schema-element(ns2:CalculoCobranzasReferenciadas) ::) {
    <ns2:CalculoCobranzasReferenciadas>
        <WebRequestCommon>
            <userName>{ fn-bea:fail-over( local:getUsername(data($UserName)),data($UserName)) }</userName>
            <password>{ fn-bea:fail-over( local:getPassword(data($UserName)),data($password)) }</password>
        </WebRequestCommon>
        <NOFILELATAMCALCREFDUEWSType>
            <enquiryInputCollection>
                    <columnName>CONTRACT.ID</columnName>
                    <criteriaValue>{ data($GetCollectionRequest/ns1:ContractId) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                 <enquiryInputCollection>
                    <columnName>DUE.DATE</columnName>
                    <criteriaValue>{ data($GetCollectionRequest/ns1:BillDate) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                 <enquiryInputCollection>
                    <columnName>AMOUNT</columnName>
                    <criteriaValue>{ data($GetCollectionRequest/ns1:BillAmount) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                 <enquiryInputCollection>
                    <columnName>CURRENCY</columnName>
                    <criteriaValue>{ data($GetCollectionRequest/ns1:Currency) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
        </NOFILELATAMCALCREFDUEWSType>
    </ns2:CalculoCobranzasReferenciadas>
};

local:func($GetCollectionRequest, $UserName, $password)