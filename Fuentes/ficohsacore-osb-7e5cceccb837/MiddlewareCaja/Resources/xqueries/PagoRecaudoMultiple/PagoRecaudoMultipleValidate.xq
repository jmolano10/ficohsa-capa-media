xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$pagoRecaudoMultiple" element="ns0:pagoRecaudoMultiple" location="../../xsds/PagoRecaudoMultiple/PagoRecaudoMultiple.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudoMultiple/PagoRecaudoMultipleValidate/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoMultipleTypes";

declare function xf:PagoRecaudoMultipleValidate($pagoRecaudoMultiple as element(ns0:pagoRecaudoMultiple))
    as xs:string {
    	let $PAYMENT_METHOD := fn-bea:trim(fn:string($pagoRecaudoMultiple/PAYMENT_INFORMATION/PAYMENT_METHOD/text()))
    	let $PAYMENT_CURRENCY := fn-bea:trim(fn:string($pagoRecaudoMultiple/PAYMENT_INFORMATION/PAYMENT_CURRENCY/text()))
    	let $PAYMENT_AMOUNT := fn-bea:trim(fn:string($pagoRecaudoMultiple/PAYMENT_INFORMATION/PAYMENT_AMOUNT/text()))
    	let $DEBIT_ACCOUNT := fn-bea:trim(fn:string($pagoRecaudoMultiple/PAYMENT_INFORMATION/DEBIT_ACCOUNT/text()))
    	let $CHEQUE_NUMBER := fn-bea:trim(fn:string($pagoRecaudoMultiple/PAYMENT_INFORMATION/CHEQUE_NUMBER/text()))
    	let $BANK_CODE := fn-bea:trim(fn:string($pagoRecaudoMultiple/PAYMENT_INFORMATION/BANK_CODE/text()))
    	let $CREDIT_CARD_NUMBER := fn-bea:trim(fn:string($pagoRecaudoMultiple/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER/text()))
    	let $EXPIRATION_DATE := fn-bea:trim(fn:string($pagoRecaudoMultiple/PAYMENT_INFORMATION/EXPIRATION_DATE/text()))
    	return 
	        if (fn:string($pagoRecaudoMultiple/CONTRACT_ID/text()) = "" or 
	        	fn:string($pagoRecaudoMultiple/DEBTOR_CODE/text()) = "" or 
	        	fn:string($pagoRecaudoMultiple/PAYMENT_INFORMATION/PAYMENT_METHOD/text()) = "" or 
	        	fn:string($pagoRecaudoMultiple/PAYMENT_INFORMATION/PAYMENT_CURRENCY/text()) = "") then (
	        	"REQUIRED FIELDS NOT SUPPLIED"
	        
	        ) else if (not(fn:string($pagoRecaudoMultiple/PAYMENT_INFORMATION/PAYMENT_METHOD/text()) = ("CASH","ACCT_DEBIT","OWN_CHEQUE","OTHER_BANK_CHEQUE","CREDIT_CARD","INTL_CHQ_US","INTL_CHQ_NON_US"))) then (
	        	"PAYMENT_METHOD NOT SUPPORTED"
	
	        ) else if (not(fn:string($pagoRecaudoMultiple/EXTENDED_COLLECTION_YES_NO/text()) = ("YES","NO",""))) then (
	        	"EXTENDED_COLLECTION_YES_NO NOT SUPPORTED"
	        	
	        ) else if ( fn:string($pagoRecaudoMultiple/NUMBER_OF_BILLS/text()) != "" and fn:string($pagoRecaudoMultiple/BILL_NUMBER/text()) != "" ) then (
	        	"FIELDS NUMBER_OF_BILLS AND BILL_NUMBER ARE MUTUALLY EXCLUSIVE"
	        
	        ) else if ( fn:string($pagoRecaudoMultiple/NUMBER_OF_BILLS/text()) != "" and fn:string(fn-bea:fail-over(xs:int($pagoRecaudoMultiple/NUMBER_OF_BILLS),"NaN")) = "NaN" ) then (
	        	"FIELD NUMBER_OF_BILLS MUST BE NUMERIC VALUE"
	
	        ) else if ( fn:string($pagoRecaudoMultiple/NUMBER_OF_BILLS/text()) != "" and xs:int($pagoRecaudoMultiple/NUMBER_OF_BILLS) <= 0 ) then (
	        	"FIELD NUMBER_OF_BILLS MUST BE GREATER THAN 0"
	        	
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

declare variable $pagoRecaudoMultiple as element(ns0:pagoRecaudoMultiple) external;

xf:PagoRecaudoMultipleValidate($pagoRecaudoMultiple)