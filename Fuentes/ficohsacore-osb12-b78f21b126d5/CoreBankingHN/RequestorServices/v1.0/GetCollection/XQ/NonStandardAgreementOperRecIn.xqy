xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/getCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/getCollectionTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/NonStandardAgreementOperRec";
(:: import schema at "../../../../ProviderServices/XSD/NonStandardAgreementOperRec/NonStandardAgreementOperRec_sp.xsd" ::)
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $GetCollectionRequest as element() (:: schema-element(ns1:getCollectionRequest) ::) external;
declare variable $userName as xs:string external;

(: Función encargada de realizar el mapeo de usuario:)
declare function local:getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

declare function local:func($GetCollectionRequest as element() (:: schema-element(ns1:getCollectionRequest) ::), 
                            $userName as xs:string) 
                            as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:CONTRACT_ID>{fn:data($GetCollectionRequest/ns1:ContractId)}</ns2:CONTRACT_ID>
        <ns2:DEBTOR_CODE>{fn:data($GetCollectionRequest/ns1:DebtorCode)}</ns2:DEBTOR_CODE>
        <ns2:CHANNEL_CODE>{ fn-bea:fail-over( local:getUsername(data($userName)),data($userName)) }</ns2:CHANNEL_CODE>
        <ns2:USER_ID>{ fn-bea:fail-over( local:getUsername(data($userName)),data($userName)) }</ns2:USER_ID>
        <ns2:CURRENCY>{fn:data($GetCollectionRequest/ns1:Currency)}</ns2:CURRENCY>
        <ns2:OPERATION_CODE>1</ns2:OPERATION_CODE>
        <ns2:ADDITIONAL_INFO>
            {
                for $Data in $GetCollectionRequest/ns1:AdditionalInfo/ns1:Data
                return 
                <ns2:ADDITIONAL_INFO_ITEM>{fn:data($Data)}</ns2:ADDITIONAL_INFO_ITEM>
            }
        </ns2:ADDITIONAL_INFO>
    </ns2:InputParameters>
};

local:func($GetCollectionRequest, $userName)