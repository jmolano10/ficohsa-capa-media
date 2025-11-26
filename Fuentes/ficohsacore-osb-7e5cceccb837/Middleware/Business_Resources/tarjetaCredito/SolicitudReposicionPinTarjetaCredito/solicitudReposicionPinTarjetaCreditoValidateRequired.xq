xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$solicitudReposicionPinTarjetaCredito" element="ns0:solicitudReposicionPinTarjetaCredito" location="solicitudReposicionPinTarjetaCreditoTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareAbanks/Business_Resources/tarjetaCredito/SolicitudReposicionPinTarjetaCredito/solicitudReposicionPinTarjetaCreditoValidateRequired/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/solicitudReposicionPinTarjetaCreditoTypes";

declare function xf:solicitudReposicionPinTarjetaCreditoValidateRequired($solicitudReposicionPinTarjetaCredito as element(ns0:solicitudReposicionPinTarjetaCredito))
    as xs:boolean {
        if( fn:string($solicitudReposicionPinTarjetaCredito/USER_ID/text()) = "" or 
        	fn:string($solicitudReposicionPinTarjetaCredito/EMAIL_ADDRESS/text()) = "" or
        	fn:string($solicitudReposicionPinTarjetaCredito/CUSTOMER_ID/text()) = "" or
        	fn:string($solicitudReposicionPinTarjetaCredito/CARD_NUMBER/text()) = "" or
        	fn:string($solicitudReposicionPinTarjetaCredito/CUSTOMER_LEGAL_ID/text()) = "" or
        	fn:string($solicitudReposicionPinTarjetaCredito/WITHDRAWAL_BRANCH_CODE/text()) = "" ) then (
        		xs:boolean("0")
        )
        else (
        	xs:boolean("1")
        )
};

declare variable $solicitudReposicionPinTarjetaCredito as element(ns0:solicitudReposicionPinTarjetaCredito) external;

xf:solicitudReposicionPinTarjetaCreditoValidateRequired($solicitudReposicionPinTarjetaCredito)