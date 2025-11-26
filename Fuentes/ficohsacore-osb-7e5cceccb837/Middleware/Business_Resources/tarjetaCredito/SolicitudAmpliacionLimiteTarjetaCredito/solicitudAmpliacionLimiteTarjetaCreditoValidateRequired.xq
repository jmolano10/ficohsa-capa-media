xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$solicitudAmpliacionLimiteTarjetaCredito" element="ns0:solicitudAmpliacionLimiteTarjetaCredito" location="solicitudAmpliacionLimiteTarjetaCreditoTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareAbanks/Business_Resources/tarjetaCredito/SolicitudAmpliacionLimiteTarjetaCredito/solicitudAmpliacionLimiteTarjetaCreditoValidateRequired/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/solicitudAmpliacionLimiteTarjetaCreditoTypes";

declare function xf:solicitudAmpliacionLimiteTarjetaCreditoValidateRequired($solicitudAmpliacionLimiteTarjetaCredito as element(ns0:solicitudAmpliacionLimiteTarjetaCredito))
    as xs:boolean {
        if( fn:string($solicitudAmpliacionLimiteTarjetaCredito/USER_ID/text()) = "" or 
        	fn:string($solicitudAmpliacionLimiteTarjetaCredito/EMAIL_ADDRESS/text()) = "" or
        	fn:string($solicitudAmpliacionLimiteTarjetaCredito/CUSTOMER_ID/text()) = "" or
        	fn:string($solicitudAmpliacionLimiteTarjetaCredito/CARD_NUMBER/text()) = "" or
        	fn:string($solicitudAmpliacionLimiteTarjetaCredito/HOME_ADDRESS/text()) = "" or
        	fn:string($solicitudAmpliacionLimiteTarjetaCredito/REGION/text()) = "" or
        	fn:string($solicitudAmpliacionLimiteTarjetaCredito/WORK_COMPANY/text()) = "" or
        	fn:string($solicitudAmpliacionLimiteTarjetaCredito/CURRENT_WORK_POSITION/text()) = "" or
        	fn:string($solicitudAmpliacionLimiteTarjetaCredito/LCY_MONTHLY_SALARY/text()) = "" or
        	fn:string($solicitudAmpliacionLimiteTarjetaCredito/WORK_ADDRESS/text()) = "" or
        	fn:string($solicitudAmpliacionLimiteTarjetaCredito/WORK_PHONE/text()) = "" or
        	fn:string($solicitudAmpliacionLimiteTarjetaCredito/LCY_CURRENT_LIMIT/text()) = "" or
        	fn:string($solicitudAmpliacionLimiteTarjetaCredito/FCY_CURRENT_LIMIT/text()) = "" or
        	fn:string($solicitudAmpliacionLimiteTarjetaCredito/LCY_REQUESTED_LIMIT/text()) = "" or
        	fn:string($solicitudAmpliacionLimiteTarjetaCredito/FCY_REQUESTED_LIMIT/text()) = "" ) then (
        		xs:boolean("0")
        )
        else (
        	xs:boolean("1")
        )
};

declare variable $solicitudAmpliacionLimiteTarjetaCredito as element(ns0:solicitudAmpliacionLimiteTarjetaCredito) external;

xf:solicitudAmpliacionLimiteTarjetaCreditoValidateRequired($solicitudAmpliacionLimiteTarjetaCredito)