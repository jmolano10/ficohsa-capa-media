xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$solicitudReposicionTarjetaCredito" element="ns0:solicitudReposicionTarjetaCredito" location="solicitudReposicionTarjetaCreditoTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareAbanks/Business_Resources/tarjetaCredito/SolicitudReposicionTarjetaCredito/solicitudReposicionTarjetaCreditoValidateRequired/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/solicitudReposicionTarjetaCreditoTypes";

declare function xf:solicitudReposicionTarjetaCreditoValidateRequired($solicitudReposicionTarjetaCredito as element(ns0:solicitudReposicionTarjetaCredito))
    as xs:boolean {
        if( fn:string($solicitudReposicionTarjetaCredito/USER_ID/text()) = "" or 
        	fn:string($solicitudReposicionTarjetaCredito/EMAIL_ADDRESS/text()) = "" or
        	fn:string($solicitudReposicionTarjetaCredito/CUSTOMER_ID/text()) = "" or
        	fn:string($solicitudReposicionTarjetaCredito/CARD_NUMBER/text()) = "" or
        	fn:string($solicitudReposicionTarjetaCredito/CARD_TO_REPLACE/text()) = "" or
        	fn:string($solicitudReposicionTarjetaCredito/REPLACEMENT_REASON/text()) = "" or
        	fn:string($solicitudReposicionTarjetaCredito/WITHDRAWAL_BRANCH_CODE/text()) = "" ) then (
        		xs:boolean("0")
        )
        else (
        	xs:boolean("1")
        )
};

declare variable $solicitudReposicionTarjetaCredito as element(ns0:solicitudReposicionTarjetaCredito) external;

xf:solicitudReposicionTarjetaCreditoValidateRequired($solicitudReposicionTarjetaCredito)