xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCredito" element="ns0:pagoTarjetaCredito" location="pagoTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/PagoTarjetaCredito/pagoTarjetaCreditoValidRequired/";

declare function xf:pagoTarjetaCreditoValidRequired($pagoTarjetaCredito as element(ns0:pagoTarjetaCredito))
    as xs:boolean {
        if ( fn:string($pagoTarjetaCredito/CREDIT_CARD_NUMBER/text()) != "" and
        	 fn:string($pagoTarjetaCredito/BALANCE_CURRENCY/text()) != "" and 
        	 fn:string($pagoTarjetaCredito/PAYMENT_AMOUNT/text()) != "" and 
        	 fn:string($pagoTarjetaCredito/DEBIT_ACCOUNT/text()) != "" ) then (
        	xs:boolean("1")	 
       	) else (
       		xs:boolean("0")
       	)
};

declare variable $pagoTarjetaCredito as element(ns0:pagoTarjetaCredito) external;

xf:pagoTarjetaCreditoValidRequired($pagoTarjetaCredito)