(:: pragma bea:global-element-parameter parameter="$consultaPagoTarjetaCredito" element="ns0:consultaPagoTarjetaCredito" location="consultaPagoTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaPagoTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/ConsultaPagoTarjetaCredito/consultaPagoTarjetaCreditoValidate/";

declare function xf:consultaPagoTarjetaCreditoValidate($consultaPagoTarjetaCredito as element(ns0:consultaPagoTarjetaCredito))
    as xs:string {
        if (fn:string($consultaPagoTarjetaCredito/PAYMENT_REFERENCE/text()) = "" or 
        	fn:string($consultaPagoTarjetaCredito/CREDIT_CARD_NUMBER/text()) = "" or 
        	fn:string($consultaPagoTarjetaCredito/DATE/text()) = "" or 
        	fn:string($consultaPagoTarjetaCredito/AMOUNT/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        		
        ) else (
        	""
        )
};

declare variable $consultaPagoTarjetaCredito as element(ns0:consultaPagoTarjetaCredito) external;

xf:consultaPagoTarjetaCreditoValidate($consultaPagoTarjetaCredito)