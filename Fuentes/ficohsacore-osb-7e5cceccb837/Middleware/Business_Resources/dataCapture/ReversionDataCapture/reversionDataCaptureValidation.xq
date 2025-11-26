(:: pragma bea:global-element-parameter parameter="$reversionDataCapture" element="ns0:reversionDataCapture" location="reversionDataCaptureTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/reversionDataCaptureTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/dataCapture/ReversionDataCapture/reversionDataCaptureValidation/";

declare function xf:reversionDataCaptureValidation($reversionDataCapture as element(ns0:reversionDataCapture))
    as xs:string {
    	if ( fn:string($reversionDataCapture/DATA_CAPTURE_ID/text()) = "") then (
    		"REQUIRED FIELDS NOT SUPPLIED"
    	) else (
    		""
    	)
};

declare variable $reversionDataCapture as element(ns0:reversionDataCapture) external;

xf:reversionDataCaptureValidation($reversionDataCapture)