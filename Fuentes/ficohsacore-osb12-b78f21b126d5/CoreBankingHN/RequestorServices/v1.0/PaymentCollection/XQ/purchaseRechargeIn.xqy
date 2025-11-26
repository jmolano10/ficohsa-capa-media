xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/Recharges/XMLSchema_-1504397414.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/paymentCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/paymentCollectionTypes.xsd" ::)
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $uuid as xs:string external;
declare variable $password as xs:string external;
declare variable $username as xs:string external;
declare variable $paymentCollectionRequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::) external;

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

declare function local:func($uuid as xs:string, 
                            $password as xs:string, 
                            $username as xs:string, 
                            $paymentCollectionRequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::)) 
                            as element() (:: schema-element(ns2:Compraderecargacondbcta) ::) {
    <ns2:Compraderecargacondbcta>
           <WebRequestCommon>
                <userName>{ fn-bea:fail-over( local:getUsername(data($username)),data($username)) }</userName>
                <password>{ fn-bea:fail-over( local:getPassword(data($username)),data($password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl/>
                <messageId>{ $uuid }</messageId>
                <noOfAuth/>
                <replace/>
            </OfsFunction>
            <FUNDSTRANSFERLATAMMOBRCHGWSType>
                <DEBITACCOUNT>{ data($paymentCollectionRequest/ns1:PaymentInformation/ns1:DebitAccount) }</DEBITACCOUNT>
                <AMOUNT>{ data($paymentCollectionRequest/ns1:PaymentInformation/ns1:PaymentAmount) }</AMOUNT>
                <LRAGCLIENTID>{ data($paymentCollectionRequest/ns1:ContractId) }</LRAGCLIENTID>
                <LRREMITMOBILE>{ data($paymentCollectionRequest/ns1:DebtorCode) }</LRREMITMOBILE>
            </FUNDSTRANSFERLATAMMOBRCHGWSType>
    </ns2:Compraderecargacondbcta>
};

local:func($uuid, $password, $username, $paymentCollectionRequest)