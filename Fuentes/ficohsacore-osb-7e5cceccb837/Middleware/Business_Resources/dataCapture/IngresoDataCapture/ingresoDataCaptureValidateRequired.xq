xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$ingresoDataCapture" element="ns0:ingresoDataCapture" location="ingresoDataCaptureTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/ingresoDataCapture/ingresoDataCaptureValidateRequired/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/ingresoDataCaptureTypes";

declare function xf:ingresoDataCaptureValidateRequired($ingresoDataCapture as element(ns0:ingresoDataCapture))
    as xs:boolean {
		if( fn:string($ingresoDataCapture/BATCH_ID/text()) = "" or 
        	fn:string($ingresoDataCapture/CURRENCY/text()) = "" or
        	fn:string($ingresoDataCapture/AMOUNT/text()) = "" or
        	fn:string($ingresoDataCapture/DESCRIPTION/text()) = "" or
        	not (fn:string($ingresoDataCapture/DEBIT_CREDIT/text()) = ( "DEBIT" , "CREDIT" )) 
        	
        	) then (
        		xs:boolean("0")
        )
        else (
        	xs:boolean("1")
        )	
};

declare variable $ingresoDataCapture as element(ns0:ingresoDataCapture) external;

xf:ingresoDataCaptureValidateRequired($ingresoDataCapture)