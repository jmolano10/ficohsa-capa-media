(:: pragma bea:global-element-parameter parameter="$reversiondedatacaptureResponse" element="ns0:ReversiondedatacaptureResponse" location="../Resources/XMLSchema_-987790958.xsd" ::)
(:: pragma bea:global-element-return element="ns1:reversionDataCaptureResponse" location="reversionDataCaptureTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/reversionDataCaptureTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/dataCapture/ReversionDataCapture/reversionDataCaptureOut/";

declare function xf:reversionDataCaptureOut($reversiondedatacaptureResponse as element(ns0:ReversiondedatacaptureResponse))
    as element(ns1:reversionDataCaptureResponse) {
        
        <ns1:reversionDataCaptureResponse>
        {
        	for $VALUEDATE in $reversiondedatacaptureResponse/DATACAPTUREType/VALUEDATE
        	return
            	<TRANSACTION_DATE>{ data($VALUEDATE) }</TRANSACTION_DATE>
        }
        </ns1:reversionDataCaptureResponse>
};

declare variable $reversiondedatacaptureResponse as element(ns0:ReversiondedatacaptureResponse) external;

xf:reversionDataCaptureOut($reversiondedatacaptureResponse)