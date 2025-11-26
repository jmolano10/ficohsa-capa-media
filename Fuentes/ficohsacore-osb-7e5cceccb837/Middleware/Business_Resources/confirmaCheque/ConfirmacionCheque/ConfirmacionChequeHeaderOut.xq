(:: pragma bea:global-element-parameter parameter="$confirmaciondechequesResponse1" element="ns0:ConfirmaciondechequesResponse" location="../Resources/XMLSchema_-1265051491.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/confirmacionCheque/ConfirmacionChequeHeaderOut/";

declare function xf:ConfirmacionChequeHeaderOut($confirmaciondechequesResponse1 as element(ns0:ConfirmaciondechequesResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $confirmaciondechequesResponse1/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $messageId in $confirmaciondechequesResponse1/Status/messageId
                return
                    <messageId>{ data($messageId) }</messageId>
            }
            {
                for $successIndicator in $confirmaciondechequesResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $application in $confirmaciondechequesResponse1/Status/application
                return
                    <application>{ data($application) }</application>
            }
            {
                for $messages in $confirmaciondechequesResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $INPUTDATE in $confirmaciondechequesResponse1/LATAMAGCHEQUECONFIRMDATAType/INPUTDATE
                return
                    <valueDate>{ data($INPUTDATE) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $confirmaciondechequesResponse1 as element(ns0:ConfirmaciondechequesResponse) external;

xf:ConfirmacionChequeHeaderOut($confirmaciondechequesResponse1)