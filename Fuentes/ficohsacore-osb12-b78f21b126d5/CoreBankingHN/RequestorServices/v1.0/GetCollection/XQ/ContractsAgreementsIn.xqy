xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/ContractsAgreements/ContractsAgreements.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/collectionContractDetailTypes";
(:: import schema at "../XSD/collectionContractDetailTypes.xsd" ::)
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $CollectionContractDetailRequest as element() (:: schema-element(ns1:CollectionContractDetailRequest) ::) external;

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

declare function local:func($CollectionContractDetailRequest as element() (:: schema-element(ns1:CollectionContractDetailRequest) ::)) 
                            as element() (:: schema-element(ns2:Consultadetallecontratorecaudo) ::) {
    <ns2:Consultadetallecontratorecaudo>
        <WebRequestCommon>
            <userName>{ fn-bea:fail-over( local:getUsername(fn:data($CollectionContractDetailRequest/ns1:Username)),fn:data($CollectionContractDetailRequest/ns1:Username)) }</userName>
            <password>{ fn-bea:fail-over( local:getPassword(fn:data($CollectionContractDetailRequest/ns1:Username)),fn:data($CollectionContractDetailRequest/ns1:Password)) }</password>
        </WebRequestCommon>
        <WSCOLLECTIONCONDSType>
            <enquiryInputCollection>
                <columnName>@ID</columnName>
                <criteriaValue>{fn:data($CollectionContractDetailRequest/ns1:ContractId)}</criteriaValue>
                <operand>EQ</operand>
            </enquiryInputCollection>
        </WSCOLLECTIONCONDSType>
    </ns2:Consultadetallecontratorecaudo>
};

local:func($CollectionContractDetailRequest)