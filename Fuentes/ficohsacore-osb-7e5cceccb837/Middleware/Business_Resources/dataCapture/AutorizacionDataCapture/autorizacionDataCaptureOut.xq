(:: pragma bea:global-element-parameter parameter="$autorizaciondedatacaptureResponse" element="ns0:AutorizaciondedatacaptureResponse" location="../Resources/XMLSchema_-987790958.xsd" ::)
(:: pragma bea:global-element-return element="ns1:autorizacionDataCaptureResponse" location="autorizacionDataCaptureTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autorizacionDataCaptureTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/dataCapture/AutorizacionDataCapture/autorizacionDataCaptureOut/";

declare function xf:autorizacionDataCaptureOut($autorizaciondedatacaptureResponse as element(ns0:AutorizaciondedatacaptureResponse))
    as element(ns1:autorizacionDataCaptureResponse) {
        <ns1:autorizacionDataCaptureResponse>
        {
        	for $VALUEDATE in $autorizaciondedatacaptureResponse/DATACAPTUREType/VALUEDATE
        	return
            	<TRANSACTION_DATE>{ data($VALUEDATE) }</TRANSACTION_DATE>
        }
        </ns1:autorizacionDataCaptureResponse>
};

declare variable $autorizaciondedatacaptureResponse as element(ns0:AutorizaciondedatacaptureResponse) external;

xf:autorizacionDataCaptureOut($autorizaciondedatacaptureResponse)