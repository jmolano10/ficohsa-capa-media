xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/paymentCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/paymentCollectionTypes.xsd" ::)

declare variable $paymentCollectionRequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::) external;

declare function local:func($paymentCollectionRequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::)) as xs:string {
    let $PAYMENT_METHOD := fn-bea:trim(fn:string($paymentCollectionRequest/ns1:PaymentInformation/ns1:PaymentMethod/text()))
    	let $PAYMENT_CURRENCY := fn-bea:trim(fn:string($paymentCollectionRequest/ns1:PaymentInformation/ns1:PaymentCurrency/text()))
    	let $PAYMENT_AMOUNT := fn-bea:trim(fn:string($paymentCollectionRequest/ns1:PaymentInformation/ns1:PaymentAmount/text()))
    	let $DEBIT_ACCOUNT := fn-bea:trim(fn:string($paymentCollectionRequest/ns1:PaymentInformation/ns1:DebitAccount/text()))
    	let $CHEQUE_NUMBER := fn-bea:trim(fn:string($paymentCollectionRequest/ns1:PaymentInformation/ns1:ChequeNumber/text()))
    	let $BANK_CODE := fn-bea:trim(fn:string($paymentCollectionRequest/ns1:PaymentInformation/ns1:BankCode/text()))
    	let $CREDIT_CARD_NUMBER := fn-bea:trim(fn:string($paymentCollectionRequest/ns1:PaymentInformation/ns1:CreditCardNumber/text()))
    	let $EXPIRATION_DATE := fn-bea:trim(fn:string($paymentCollectionRequest/ns1:PaymentInformation/ns1:ExpirationDate/text()))
    	return    
	        if (fn:string($paymentCollectionRequest/ns1:ContractId/text()) = "" or 
	        	fn:string($paymentCollectionRequest/ns1:DebtorCode/text()) = "" or
	        	fn:string($paymentCollectionRequest/ns1:PaymentInformation/ns1:PaymentMethod/text()) = "" or 
	        	fn:string($paymentCollectionRequest/ns1:PaymentInformation/ns1:PaymentCurrency/text()) = "") then (
				"REQUIRED FIELDS NOT SUPPLIED"
				
	        (:: Validaciones de campos requeridos y campos vacío por método de pago :)
			) else if(( $PAYMENT_METHOD = "CASH" and ($DEBIT_ACCOUNT != "" or $CHEQUE_NUMBER != "" or $BANK_CODE != "" or $CREDIT_CARD_NUMBER != "" or $EXPIRATION_DATE != "")) or
				( $PAYMENT_METHOD = "ACCT_DEBIT" and ($DEBIT_ACCOUNT = "" or $CHEQUE_NUMBER != "" or $BANK_CODE != "" or $CREDIT_CARD_NUMBER != "" or $EXPIRATION_DATE != "")) or
				( $PAYMENT_METHOD = "OWN_CHEQUE" and ($DEBIT_ACCOUNT = "" or $CHEQUE_NUMBER = "" or $BANK_CODE != "" or $CREDIT_CARD_NUMBER != "" or $EXPIRATION_DATE != "")) or
				( $PAYMENT_METHOD = "OTHER_BANK_CHEQUE" and ($DEBIT_ACCOUNT != "" or $CHEQUE_NUMBER = "" or $BANK_CODE = "" or $CREDIT_CARD_NUMBER != "" or $EXPIRATION_DATE != "")) or
				( $PAYMENT_METHOD = "INTL_CHQ_US" and ($DEBIT_ACCOUNT != "" or $CHEQUE_NUMBER = "" or $BANK_CODE = "" or $CREDIT_CARD_NUMBER != "" or $EXPIRATION_DATE != ""))) then (        	
	        	"MEDIO DE PAGO NO COINCIDE CON VALORES"
	        	
	        ) else (
	        	""
	        )
};

local:func($paymentCollectionRequest)