(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCredito" element="ns0:pagoTarjetaCredito" location="../../xsds/PagoTarjetaCredito/PagoTarjetaCredito.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCredito";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoTarjetaCredito/PagoTarjetaCreditoValidate/";

declare function xf:PagoTarjetaCreditoValidate($pagoTarjetaCredito as element(ns0:pagoTarjetaCredito))
    as xs:string {
        if (fn:string($pagoTarjetaCredito/CREDIT_CARD_NUMBER/text()) = "" or 
        	fn:string($pagoTarjetaCredito/PAYMENT_METHOD/text()) = "" or 
        	fn:string($pagoTarjetaCredito/BALANCE_CURRENCY/text()) = "" or 
        	fn:string($pagoTarjetaCredito/PAYMENT_AMOUNT/text()) = "" or
        	fn:string($pagoTarjetaCredito/PAYMENT_CURRENCY/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        
        (: Métodos de Pago:
        	TC.ME.MN
        	TC.MN.MN
        	TC.VARIASMND.ME
			FROM			(Debito a cuenta)
			FICO.CHQ		(Cheque propio)
			CLEARING		(Cheque de otro banco
			CLEARING.INTL	(Cheque del extranjero)
        :)	
        ) else if(not(fn:string($pagoTarjetaCredito/PAYMENT_METHOD/text()) = ("CASH","OWN_CHEQUE","CLEARING","INTL_CHQ_US"))) then (
        	"PAYMENT_METHOD NOT SUPPORTED"
        	
        ) else (
        	""
        
        )
};

declare variable $pagoTarjetaCredito as element(ns0:pagoTarjetaCredito) external;

xf:PagoTarjetaCreditoValidate($pagoTarjetaCredito)