(:: pragma bea:global-element-parameter parameter="$reversiondedatacaptureResponse" element="ns0:ReversiondedatacaptureResponse" location="../Resources/XMLSchema_-987790958.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/dataCapture/ReversionDataCapture/reversionDataCaptureHeaderOut/";

declare function xf:reversionDataCaptureHeaderOut($reversiondedatacaptureResponse as element(ns0:ReversiondedatacaptureResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $reversiondedatacaptureResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $reversiondedatacaptureResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $reversiondedatacaptureResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $reversiondedatacaptureResponse as element(ns0:ReversiondedatacaptureResponse) external;

xf:reversionDataCaptureHeaderOut($reversiondedatacaptureResponse)