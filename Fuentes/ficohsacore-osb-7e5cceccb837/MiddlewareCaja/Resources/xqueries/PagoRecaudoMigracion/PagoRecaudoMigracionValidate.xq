(:: pragma bea:global-element-parameter parameter="$pagoRecaudoMigracion" element="ns0:pagoRecaudoMigracion" location="../../xsds/PagoRecaudoMigracion/PagoRecaudoMigracion.xsd" ::)

declare namespace ns2 = "";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoMigracionTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudoMigracion/PagoRecaudoMigracionValidate/";

declare function xf:PagoRecaudoMigracionValidate($pagoRecaudoMigracion as element(ns0:pagoRecaudoMigracion))
    as xs:string {
    	let $PAYMENT_METHOD := fn-bea:trim(fn:string($pagoRecaudoMigracion/PAYMENT_INFORMATION/PAYMENT_METHOD/text()))
    	let $PAYMENT_CURRENCY := fn-bea:trim(fn:string($pagoRecaudoMigracion/PAYMENT_INFORMATION/PAYMENT_CURRENCY/text()))
    	let $PAYMENT_AMOUNT := fn-bea:trim(fn:string($pagoRecaudoMigracion/PAYMENT_INFORMATION/PAYMENT_AMOUNT/text()))
    	let $DEBIT_ACCOUNT := fn-bea:trim(fn:string($pagoRecaudoMigracion/PAYMENT_INFORMATION/DEBIT_ACCOUNT/text()))
    	let $CHEQUE_NUMBER := fn-bea:trim(fn:string($pagoRecaudoMigracion/PAYMENT_INFORMATION/CHEQUE_NUMBER/text()))
    	let $BANK_CODE := fn-bea:trim(fn:string($pagoRecaudoMigracion/PAYMENT_INFORMATION/BANK_CODE/text()))
    	let $CREDIT_CARD_NUMBER := fn-bea:trim(fn:string($pagoRecaudoMigracion/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER/text()))
    	let $EXPIRATION_DATE := fn-bea:trim(fn:string($pagoRecaudoMigracion/PAYMENT_INFORMATION/EXPIRATION_DATE/text()))
    	return 
	        if (fn:string($pagoRecaudoMigracion/CONTRACT_ID/text()) = "" or 
	        	fn:string($pagoRecaudoMigracion/ORD_PARTY_ID/text()) = "" or 
	        	fn:string($pagoRecaudoMigracion/ORD_PARTY_NAME/text()) = "" or 
	        	fn:string($pagoRecaudoMigracion/REQUEST_CITY/text()) = "" or 
	        	fn:string($pagoRecaudoMigracion/REQUEST_TYPE/text()) = "" or 
	        	fn:string($pagoRecaudoMigracion/PASSPORT_DURATION/text()) = "" or 
	        	fn:string($pagoRecaudoMigracion/PAYMENT_INFORMATION/PAYMENT_METHOD/text()) = "" or 
	        	fn:string($pagoRecaudoMigracion/PAYMENT_INFORMATION/PAYMENT_CURRENCY/text()) = "") then (
	        	"REQUIRED FIELDS NOT SUPPLIED"
	        	
	        ) else if(not(fn:string($pagoRecaudoMigracion/PAYMENT_INFORMATION/PAYMENT_METHOD/text()) = ("CASH","ACCT_DEBIT","OWN_CHEQUE","OTHER_BANK_CHEQUE","CREDIT_CARD","INTL_CHQ_US"))) then (	
	        	"PAYMENT_METHOD NOT SUPPORTED"
	        		
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

declare variable $pagoRecaudoMigracion as element(ns0:pagoRecaudoMigracion) external;

xf:PagoRecaudoMigracionValidate($pagoRecaudoMigracion)