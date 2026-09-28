(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns0:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)

declare namespace ns2 = "";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudo/xq/pagoCobranzasValidate/";

declare function xf:pagoCobranzasValidate($pagoRecaudo as element(ns0:pagoRecaudo))
    as xs:string {
        let $PAYMENT_METHOD := fn-bea:trim(fn:string($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_METHOD/text()))
    	let $PAYMENT_CURRENCY := fn-bea:trim(fn:string($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_CURRENCY/text()))
    	let $PAYMENT_AMOUNT := fn-bea:trim(fn:string($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_AMOUNT/text()))
    	let $DEBIT_ACCOUNT := fn-bea:trim(fn:string($pagoRecaudo/PAYMENT_INFORMATION/DEBIT_ACCOUNT/text()))
    	let $CHEQUE_NUMBER := fn-bea:trim(fn:string($pagoRecaudo/PAYMENT_INFORMATION/CHEQUE_NUMBER/text()))
    	let $BANK_CODE := fn-bea:trim(fn:string($pagoRecaudo/PAYMENT_INFORMATION/BANK_CODE/text()))
    	let $CREDIT_CARD_NUMBER := fn-bea:trim(fn:string($pagoRecaudo/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER/text()))
    	let $EXPIRATION_DATE := fn-bea:trim(fn:string($pagoRecaudo/PAYMENT_INFORMATION/EXPIRATION_DATE/text()))
    	return    
	        if (fn:string($pagoRecaudo/CONTRACT_ID/text()) = "" or 
	        	fn:string($pagoRecaudo/DEBTOR_CODE/text()) = "" or
	        	fn:string($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_METHOD/text()) = "" or 
	        	fn:string($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_CURRENCY/text()) = "") then (
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

declare variable $pagoRecaudo as element(ns0:pagoRecaudo) external;

xf:pagoCobranzasValidate($pagoRecaudo)