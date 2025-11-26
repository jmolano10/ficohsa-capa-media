(:: pragma bea:global-element-parameter parameter="$ingresodeDataCaptureResponse" element="ns0:IngresodeDataCaptureResponse" location="../Resources/XMLSchema_-987790958.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ingresoDataCaptureResponse" location="ingresoDataCaptureTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/ingresoDataCaptureTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/dataCapture/IngresoDataCapture/ingresoDataCaptureOut/";

declare function xf:ingresoDataCaptureOut($ingresodeDataCaptureResponse as element(ns0:IngresodeDataCaptureResponse))
    as element(ns1:ingresoDataCaptureResponse) {
        <ns1:ingresoDataCaptureResponse>
        {
        	let $RECORDSTATUS := fn:string($ingresodeDataCaptureResponse/DATACAPTUREType/RECORDSTATUS/text())
        	return
		        if ($RECORDSTATUS != "") then (
		        	<RECORD_STATUS>{ $RECORDSTATUS }</RECORD_STATUS>
		        ) else ()
		}
        </ns1:ingresoDataCaptureResponse>
};

declare variable $ingresodeDataCaptureResponse as element(ns0:IngresodeDataCaptureResponse) external;

xf:ingresoDataCaptureOut($ingresodeDataCaptureResponse)