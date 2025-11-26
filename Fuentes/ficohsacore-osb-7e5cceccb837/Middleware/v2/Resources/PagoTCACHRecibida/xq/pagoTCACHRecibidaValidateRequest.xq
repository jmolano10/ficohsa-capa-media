xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$pagoTCACHRecibida" element="ns0:pagoTCACHRecibida" location="../xsd/pagoTCACHRecibida.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoTCACHRecibida/xq/PagoTCACHRecibidaValidateRequest/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoTCACHRecibida";

declare function xf:PagoTCACHRecibidaValidateRequest($pagoTCACHRecibida as element(ns0:pagoTCACHRecibida))
    as xs:boolean {
        if ( fn:string($pagoTCACHRecibida/CREDIT_CARD_NUMBER/text()) != "" and
        	 fn:string($pagoTCACHRecibida/ID_LOG/text()) != "" and
        	 fn:string($pagoTCACHRecibida/BALANCE_CURRENCY/text()) != "" and 
        	 fn:string($pagoTCACHRecibida/PAYMENT_AMOUNT/text()) != "" and 
        	 fn:string($pagoTCACHRecibida/DEBIT_ACCOUNT/text()) != "" ) then (
        	xs:boolean("1")	 
       	) else (
       		xs:boolean("0")
       	)
};

declare variable $pagoTCACHRecibida as element(ns0:pagoTCACHRecibida) external;

xf:PagoTCACHRecibidaValidateRequest($pagoTCACHRecibida)