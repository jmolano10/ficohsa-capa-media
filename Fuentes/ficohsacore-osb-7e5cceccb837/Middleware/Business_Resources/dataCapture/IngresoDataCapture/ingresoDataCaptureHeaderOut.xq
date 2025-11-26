(:: pragma bea:global-element-parameter parameter="$ingresodeDataCaptureResponse" element="ns0:IngresodeDataCaptureResponse" location="../../Core/Resources/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/ingresoDataCapture/ingresoDataCaptureHeaderOut/";

declare function xf:ingresoDataCaptureHeaderOut($ingresodeDataCaptureResponse as element(ns0:IngresodeDataCaptureResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $ingresodeDataCaptureResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $ingresodeDataCaptureResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $ingresodeDataCaptureResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $VALUEDATE in $ingresodeDataCaptureResponse/DATACAPTUREType/VALUEDATE
                return
                    <valueDate>{ data($VALUEDATE) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $ingresodeDataCaptureResponse as element(ns0:IngresodeDataCaptureResponse) external;

xf:ingresoDataCaptureHeaderOut($ingresodeDataCaptureResponse)