(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns0:pagoRecaudo" location="pagoRecaudoTypes.xsd" ::)

declare namespace ns2 = "";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoValidate/";

declare function xf:pagoRecaudoValidate($pagoRecaudo as element(ns0:pagoRecaudo))
    as xs:string {
        if (fn:string($pagoRecaudo/CONTRACT_ID/text()) = "" or 
        	fn:string($pagoRecaudo/DEBTOR_CODE/text()) = "" or 
        	fn:string($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_METHOD/text()) = "" or 
        	fn:string($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_CURRENCY/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        
        ) else if (not(fn:string($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_METHOD/text()) = ("CASH","ACCT_DEBIT","OWN_CHEQUE","OTHER_BANK_CHEQUE","CREDIT_CARD","INTL_CHQ_US","INTL_CHQ_NON_US"))) then (
        	"PAYMENT_METHOD NOT SUPPORTED"
        	
        ) else (
        	""
        )
};

declare variable $pagoRecaudo as element(ns0:pagoRecaudo) external;

xf:pagoRecaudoValidate($pagoRecaudo)