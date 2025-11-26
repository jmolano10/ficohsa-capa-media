(:: pragma bea:global-element-parameter parameter="$autorizacionDataCapture" element="ns0:autorizacionDataCapture" location="autorizacionDataCaptureTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autorizacionDataCaptureTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/dataCapture/AutorizacionDataCapture/autorizacionDataCaptureValidation/";

declare function xf:autorizacionDataCaptureValidation($autorizacionDataCapture as element(ns0:autorizacionDataCapture))
    as xs:string {
    	if (fn:string($autorizacionDataCapture/DATA_CAPTURE_ID/text()) = "") then (
    		"REQUIRED FILEDS NOT SUPPLIED"
    	) else (
    		""
    	)
        
};

declare variable $autorizacionDataCapture as element(ns0:autorizacionDataCapture) external;

xf:autorizacionDataCaptureValidation($autorizacionDataCapture)