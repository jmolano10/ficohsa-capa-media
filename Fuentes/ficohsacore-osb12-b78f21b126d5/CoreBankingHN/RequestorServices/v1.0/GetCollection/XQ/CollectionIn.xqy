xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/Collection/Collection.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/getCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/getCollectionTypes.xsd" ::)
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $userName as xs:string external;
declare variable $password as xs:string external;
declare variable $GetCollectionRequest as element() (:: schema-element(ns1:getCollectionRequest) ::) external;

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

declare function local:func($userName as xs:string, 
                            $password as xs:string, 
                            $GetCollectionRequest as element() (:: schema-element(ns1:getCollectionRequest) ::)) 
                            as element() (:: schema-element(ns2:Consultadedetallederecaudo) ::) {
    <ns2:Consultadedetallederecaudo>
        <WebRequestCommon>
            <userName>{ fn-bea:fail-over( local:getUsername(data($userName)),data($userName)) }</userName>
            <password>{ fn-bea:fail-over( local:getPassword(data($userName)),data($password)) }</password>
        </WebRequestCommon>
        <LATAMAGWSPENDINGBILLSType>
            <enquiryInputCollection>
                <columnName>AGR.CONTRACT.ID</columnName>
                <criteriaValue>{fn:data($GetCollectionRequest/ns1:ContractId)}</criteriaValue>
                <operand>EQ</operand>
            </enquiryInputCollection>
            <enquiryInputCollection>
                <columnName>DEBTOR.CODE</columnName>
                <criteriaValue>{fn:replace(fn:data($GetCollectionRequest/ns1:DebtorCode), "Ñ", "#")}</criteriaValue>
                <operand>EQ</operand>
            </enquiryInputCollection>
            <enquiryInputCollection>
                <columnName>TXN.CCY</columnName>
                <criteriaValue>{fn:data($GetCollectionRequest/ns1:Currency)}</criteriaValue>
                <operand>EQ</operand>
            </enquiryInputCollection>
            {
              let $BillReturnType := fn:string($GetCollectionRequest/ns1:BillReturnType/text())
              return
                if($BillReturnType = "One")then(
                  <enquiryInputCollection>
                    <columnName>CHANNEL.IND</columnName>
                    <criteriaValue>ATM</criteriaValue>
                    <operand>EQ</operand>
                  </enquiryInputCollection>
                )else if($BillReturnType = "All")then(
                  <enquiryInputCollection>
                    <columnName>CHANNEL.IND</columnName>
                    <criteriaValue>OTHER</criteriaValue>
                    <operand>EQ</operand>
                  </enquiryInputCollection>
                )else()
            }
        </LATAMAGWSPENDINGBILLSType>
    </ns2:Consultadedetallederecaudo>
};

local:func($userName, $password, $GetCollectionRequest)