<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$compraRecarga" element="ns0:compraRecarga" location="compraRecargaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/compraRecargaTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/recargas/CompraRecarga/compraRecargaValidateRequired/";

declare function xf:compraRecargaValidateRequired($compraRecarga as element(ns0:compraRecarga))
    as xs:boolean {
        if (fn:string($compraRecarga/PHONE_NUMBER/text()) != "" and 
        	fn:string($compraRecarga/SERVICE_PROVIDER_ID/text()) != "" and 
        	fn:string($compraRecarga/AMOUNT/text()) != "" and 
        	fn:string($compraRecarga/DEBIT_ACCOUNT/text()) != "") then (
        	xs:boolean("1")        	
        ) else (
        	xs:boolean("0")
        )
};

declare variable $compraRecarga as element(ns0:compraRecarga) external;

xf:compraRecargaValidateRequired($compraRecarga)</con:xquery>
    <con:dependency location="compraRecargaTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/recargas/CompraRecarga/compraRecargaTypes"/>
    </con:dependency>
</con:xqueryEntry>