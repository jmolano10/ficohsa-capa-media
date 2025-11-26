xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/paymentCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/paymentCollectionTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/RecordOperationNonStandartAgreement";
(:: import schema at "../../../../ProviderServices/XSD/RecordOperationNonStandartAgreement/RecordOperationNonStandartAgreement_sp.xsd" ::)
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $paymentCollectionRequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::) external;
declare variable $operationType as xs:string external;

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

declare function local:func($username as xs:string, 
                            $password as xs:string, 
                            $paymentCollectionRequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::), 
                            $operationType as xs:string) 
                            as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:CONTRACT_ID>{ data($paymentCollectionRequest/ns1:ContractId) }</ns2:CONTRACT_ID>
        <ns2:DEBTOR_CODE>{ data($paymentCollectionRequest/ns1:DebtorCode) }</ns2:DEBTOR_CODE>
        <ns2:CHANNEL_CODE>{ fn:data($username) }</ns2:CHANNEL_CODE>
        <ns2:USER_ID>{ fn:data($username) }</ns2:USER_ID>
        {
                for $PAYMENT_AMOUNT in $paymentCollectionRequest/ns1:PaymentInformation/ns1:PaymentAmount
                return
                    <ns2:TOTAL_AMOUNT>{ data($PAYMENT_AMOUNT) }</ns2:TOTAL_AMOUNT>
            }
            <ns2:CURRENCY>{ data($paymentCollectionRequest/ns1:PaymentInformation/ns1:PaymentCurrency) }</ns2:CURRENCY>
            <ns2:OPERATION_CODE>{ $operationType }</ns2:OPERATION_CODE>
            <ns2:ADDITIONAL_INFO>
                {
                    for $DATA in $paymentCollectionRequest/ns1:AdditionalInfo/ns1:Data
                    return
                        <ns2:ITEM>{ data($DATA) }</ns2:ITEM>
                }
            </ns2:ADDITIONAL_INFO>
    </ns2:InputParameters>	
};

local:func($username, $password, $paymentCollectionRequest, $operationType)