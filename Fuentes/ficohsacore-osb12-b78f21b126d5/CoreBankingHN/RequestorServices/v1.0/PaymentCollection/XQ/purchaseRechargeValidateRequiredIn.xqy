xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/paymentCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/paymentCollectionTypes.xsd" ::)

declare variable $paymentCollectionRequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::) external;

declare function local:func($paymentCollectionRequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::)) as xs:boolean {
    if (fn:string($paymentCollectionRequest/ns1:DebtorCode/text()) != "" and 
        fn:string($paymentCollectionRequest/ns1:ContractId/text()) != "" and 
        fn:string($paymentCollectionRequest/ns1:PaymentInformation/ns1:PaymentAmount/text()) != "" and 
        fn:string($paymentCollectionRequest/ns1:PaymentInformation/ns1:DebitAccount/text()) != "") then (
        xs:boolean("1")        	
    ) else (
        xs:boolean("0")
        )
};

local:func($paymentCollectionRequest)