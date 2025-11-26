xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$solicitudTarjetaCreditoAdicional" element="ns0:solicitudTarjetaCreditoAdicional" location="solicitudTarjetaCreditoAdicionalTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareAbanks/Business_Resources/tarjetaCredito/SolicitudTarjetaCreditoAdicional/solicitudTarjetaCreditoAdicionalValidateRequired/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/solicitudTarjetaCreditoAdicionalTypes";

declare function xf:solicitudTarjetaCreditoAdicionalValidateRequired($solicitudTarjetaCreditoAdicional as element(ns0:solicitudTarjetaCreditoAdicional))
    as xs:boolean {
        if( fn:string($solicitudTarjetaCreditoAdicional/USER_ID/text()) = "" or 
        	fn:string($solicitudTarjetaCreditoAdicional/EMAIL_ADDRESS/text()) = "" or
        	fn:string($solicitudTarjetaCreditoAdicional/CUSTOMER_ID/text()) = "" or
        	fn:string($solicitudTarjetaCreditoAdicional/CARD_NUMBER/text()) = "" or
        	fn:string($solicitudTarjetaCreditoAdicional/CUSTOMER_LEGAL_ID/text()) = "" or
        	fn:string($solicitudTarjetaCreditoAdicional/FIRST_GIVEN_NAME/text()) = "" or
        	fn:string($solicitudTarjetaCreditoAdicional/FIRST_FAMILY_NAME/text()) = "" or
        	fn:string($solicitudTarjetaCreditoAdicional/SECOND_FAMILY_NAME/text()) = "" or
        	fn:string($solicitudTarjetaCreditoAdicional/NAME_ON_CARD/text()) = "" or
        	fn:string($solicitudTarjetaCreditoAdicional/SECONDARY_CARD_HOLDER_ID/text()) = "" or
        	fn:string($solicitudTarjetaCreditoAdicional/WITHDRAWAL_BRANCH_CODE/text()) = "" ) then (
        		xs:boolean("0")
        )
        else (
        	xs:boolean("1")
        )
};

declare variable $solicitudTarjetaCreditoAdicional as element(ns0:solicitudTarjetaCreditoAdicional) external;

xf:solicitudTarjetaCreditoAdicionalValidateRequired($solicitudTarjetaCreditoAdicional)