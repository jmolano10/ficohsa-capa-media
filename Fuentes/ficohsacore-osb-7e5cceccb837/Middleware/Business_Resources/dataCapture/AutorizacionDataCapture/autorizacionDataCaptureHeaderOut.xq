(:: pragma bea:global-element-parameter parameter="$autorizaciondedatacaptureResponse" element="ns0:AutorizaciondedatacaptureResponse" location="../Resources/XMLSchema_-987790958.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/dataCapture/AutorizacionDataCapture/autorizacionDataCaptureHeaderOut/";

declare function xf:autorizacionDataCaptureHeaderOut($autorizaciondedatacaptureResponse as element(ns0:AutorizaciondedatacaptureResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $autorizaciondedatacaptureResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $autorizaciondedatacaptureResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $autorizaciondedatacaptureResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $autorizaciondedatacaptureResponse as element(ns0:AutorizaciondedatacaptureResponse) external;

xf:autorizacionDataCaptureHeaderOut($autorizaciondedatacaptureResponse)