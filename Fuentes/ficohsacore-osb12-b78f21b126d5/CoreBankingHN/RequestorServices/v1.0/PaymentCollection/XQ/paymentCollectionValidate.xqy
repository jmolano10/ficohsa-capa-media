xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/paymentCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/paymentCollectionTypes.xsd" ::)

declare variable $paymentCollectionrequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::) external;

declare function local:func($paymentCollectionrequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::)) as xs:string {

            if (fn:string($paymentCollectionrequest/ns1:ContractId/text()) = "" or 
        	fn:string($paymentCollectionrequest/ns1:DebtorCode/text()) = "" or 
        	fn:string($paymentCollectionrequest/ns1:PaymentInformation/ns1:PaymentMethod/text()) = "" or 
        	fn:string($paymentCollectionrequest/ns1:PaymentInformation/ns1:PaymentCurrency/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        
        ) else if (not(fn:string($paymentCollectionrequest/ns1:PaymentInformation/ns1:PaymentMethod/text()) = ("CASH","ACCT_DEBIT","OWN_CHEQUE","OTHER_BANK_CHEQUE","CREDIT_CARD","INTL_CHQ_US","INTL_CHQ_NON_US"))) then (
        	"PAYMENT_METHOD NOT SUPPORTED"
        	
        ) else (
        	""
        )
};

local:func($paymentCollectionrequest)