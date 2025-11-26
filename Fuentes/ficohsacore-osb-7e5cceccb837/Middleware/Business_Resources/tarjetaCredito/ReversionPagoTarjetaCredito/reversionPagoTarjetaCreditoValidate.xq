(:: pragma bea:global-element-parameter parameter="$reversionPagoTarjetaCredito" element="ns0:reversionPagoTarjetaCredito" location="reversionPagoTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/reversionPagoTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/ReversionPagoTarjetaCredito/reversionPagoTarjetaCreditoValidate/";

declare function xf:reversionPagoTarjetaCreditoValidate($reversionPagoTarjetaCredito as element(ns0:reversionPagoTarjetaCredito))
    as xs:string {
        if (fn:string($reversionPagoTarjetaCredito/CREDIT_CARD_NUMBER/text()) = "" or 
        	fn:string($reversionPagoTarjetaCredito/AMOUNT/text()) = "" or 
        	fn:string($reversionPagoTarjetaCredito/CURRENCY/text()) = "" or 
        	fn:string($reversionPagoTarjetaCredito/PAYMENT_TYPE/text()) = "" or 
        	fn:string($reversionPagoTarjetaCredito/PAYMENT_CHANNEL/text()) = "" or 
        	fn:string($reversionPagoTarjetaCredito/PAYMENT_DATE/text()) = "" or 
        	fn:string($reversionPagoTarjetaCredito/PAYMENT_REFERENCE/text()) = "" or 
        	fn:string($reversionPagoTarjetaCredito/PAYMENT_CODE/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        
        ) else if (fn:string(number($reversionPagoTarjetaCredito/AMOUNT)) = "NaN") then (
        	"AMOUNT FIELD MUST BE A NUMERIC VALUE"
        			
        ) else (
        	""
        )
};

declare variable $reversionPagoTarjetaCredito as element(ns0:reversionPagoTarjetaCredito) external;

xf:reversionPagoTarjetaCreditoValidate($reversionPagoTarjetaCredito)