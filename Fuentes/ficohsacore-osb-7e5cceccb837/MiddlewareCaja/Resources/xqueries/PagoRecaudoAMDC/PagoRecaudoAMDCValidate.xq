xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$pagoRecaudoAMDC" element="ns0:pagoRecaudoAMDC" location="../../xsds/PagoRecaudoAMDC/PagoRecaudoAMDC.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudoAMDC/PagoRecaudoAMDCValidate/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoAMDCTypes";

declare function xf:PagoRecaudoAMDCValidate($pagoRecaudoAMDC as element(ns0:pagoRecaudoAMDC))
    as xs:string {
    	let $PAYMENT_METHOD := fn-bea:trim(fn:string($pagoRecaudoAMDC/PAYMENT_INFORMATION/PAYMENT_METHOD/text()))
    	let $PAYMENT_CURRENCY := fn-bea:trim(fn:string($pagoRecaudoAMDC/PAYMENT_INFORMATION/PAYMENT_CURRENCY/text()))
    	let $PAYMENT_AMOUNT := fn-bea:trim(fn:string($pagoRecaudoAMDC/PAYMENT_INFORMATION/PAYMENT_AMOUNT/text()))
    	let $DEBIT_ACCOUNT := fn-bea:trim(fn:string($pagoRecaudoAMDC/PAYMENT_INFORMATION/DEBIT_ACCOUNT/text()))
    	let $CHEQUE_NUMBER := fn-bea:trim(fn:string($pagoRecaudoAMDC/PAYMENT_INFORMATION/CHEQUE_NUMBER/text()))
    	let $BANK_CODE := fn-bea:trim(fn:string($pagoRecaudoAMDC/PAYMENT_INFORMATION/BANK_CODE/text()))
    	let $CREDIT_CARD_NUMBER := fn-bea:trim(fn:string($pagoRecaudoAMDC/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER/text()))
    	let $EXPIRATION_DATE := fn-bea:trim(fn:string($pagoRecaudoAMDC/PAYMENT_INFORMATION/EXPIRATION_DATE/text()))
    	return    
	        if (fn:string($pagoRecaudoAMDC/CONTRACT_ID/text()) = "" or 
	        	fn:string($pagoRecaudoAMDC/DEBTOR_CODE/text()) = "" or
	        	fn:string($pagoRecaudoAMDC/IDENTITY_TYPE/text()) = "" or 
	        	fn:string($pagoRecaudoAMDC/YEAR_TO_PAY/text()) = "" or
	        	fn:string($pagoRecaudoAMDC/MONTHS_TO_PAY/text()) = "" or  
	        	fn:string($pagoRecaudoAMDC/PAYMENT_INFORMATION/PAYMENT_METHOD/text()) = "" or 
	        	fn:string($pagoRecaudoAMDC/PAYMENT_INFORMATION/PAYMENT_CURRENCY/text()) = "") then (
	        	"REQUIRED FIELDS NOT SUPPLIED"
	
	        ) else if (not(fn:string($pagoRecaudoAMDC/PAYMENT_INFORMATION/PAYMENT_METHOD/text()) = ("CASH","ACCT_DEBIT","OWN_CHEQUE","OTHER_BANK_CHEQUE","CREDIT_CARD","INTL_CHQ_US"))) then (
	        	"PAYMENT_METHOD NOT SUPPORTED"
	        	
	        ) else if ( fn:string($pagoRecaudoAMDC/MONTHS_TO_PAY/text()) != "" and fn:string(fn-bea:fail-over(xs:int($pagoRecaudoAMDC/MONTHS_TO_PAY),"NaN")) = "NaN" ) then (
	        	"FIELD MONTHS_TO_PAY MUST BE NUMERIC VALUE"
	
	        ) else if ( fn:string($pagoRecaudoAMDC/MONTHS_TO_PAY/text()) != "" and xs:int($pagoRecaudoAMDC/MONTHS_TO_PAY) <= 0 ) then (
	        	"FIELD MONTHS_TO_PAY MUST BE GREATER THAN 0"
	        	
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

declare variable $pagoRecaudoAMDC as element(ns0:pagoRecaudoAMDC) external;

xf:PagoRecaudoAMDCValidate($pagoRecaudoAMDC)