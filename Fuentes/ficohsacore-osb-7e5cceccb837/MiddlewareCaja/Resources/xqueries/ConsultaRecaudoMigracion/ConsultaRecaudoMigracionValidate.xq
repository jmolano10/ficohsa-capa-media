(:: pragma bea:global-element-parameter parameter="$consultaRecaudoMigracion" element="ns0:consultaRecaudoMigracion" location="../../xsds/ConsultaRecaudoMigracion/ConsultaRecaudoMigracion.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoMigracionTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudoMigracion/ConsultaRecaudoMigracionValidate/";

declare function xf:ConsultaRecaudoMigracionValidate($consultaRecaudoMigracion as element(ns0:consultaRecaudoMigracion))
    as xs:string {
        if (fn:string($consultaRecaudoMigracion/CONTRACT_ID/text()) = "" or 
        	fn:string($consultaRecaudoMigracion/ORD_PARTY_ID/text()) = "" or 
        	fn:string($consultaRecaudoMigracion/ORD_PARTY_NAME/text()) = "" or 
        	fn:string($consultaRecaudoMigracion/REQUEST_CITY/text()) = "" or 
        	fn:string($consultaRecaudoMigracion/REQUEST_TYPE/text()) = "" or 
        	fn:string($consultaRecaudoMigracion/PASSPORT_DURATION/text()) = "" or 
        	fn:string($consultaRecaudoMigracion/PAYMENT_CURRENCY/text()) = "") then (
			"REQUIRED FIELDS NOT SUPPLIED"
        	
        ) else (
        	""
        )
};

declare variable $consultaRecaudoMigracion as element(ns0:consultaRecaudoMigracion) external;

xf:ConsultaRecaudoMigracionValidate($consultaRecaudoMigracion)