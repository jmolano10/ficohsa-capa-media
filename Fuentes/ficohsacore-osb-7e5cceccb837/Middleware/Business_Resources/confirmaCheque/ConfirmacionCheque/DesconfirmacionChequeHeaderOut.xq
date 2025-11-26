(:: pragma bea:global-element-parameter parameter="$desconfirmaciondeChequesResponse1" element="ns0:DesconfirmaciondeChequesResponse" location="../Resources/XMLSchema_-1265051491.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/confirmaCheque/ConfirmacionCheque/DesconfirmacionChequeHeaderOut/";

declare function xf:DesconfirmacionChequeHeaderOut($desconfirmaciondeChequesResponse1 as element(ns0:DesconfirmaciondeChequesResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $desconfirmaciondeChequesResponse1/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $messageId in $desconfirmaciondeChequesResponse1/Status/messageId
                return
                    <messageId>{ data($messageId) }</messageId>
            }
            {
                for $successIndicator in $desconfirmaciondeChequesResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $application in $desconfirmaciondeChequesResponse1/Status/application
                return
                    <application>{ data($application) }</application>
            }
            {
                for $messages in $desconfirmaciondeChequesResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $INPUTDATE in $desconfirmaciondeChequesResponse1/LATAMAGCHEQUECONFIRMDATAType/INPUTDATE
                return
                    <valueDate>{ data($INPUTDATE) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $desconfirmaciondeChequesResponse1 as element(ns0:DesconfirmaciondeChequesResponse) external;

xf:DesconfirmacionChequeHeaderOut($desconfirmaciondeChequesResponse1)