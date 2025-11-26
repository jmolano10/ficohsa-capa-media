(:: pragma bea:global-element-parameter parameter="$confirmaciondechequesResponse" element="ns0:ConfirmaciondechequesResponse" location="../Resources/XMLSchema_-1265051491.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/reservaFondosCheque/ReservaFondosCheque/reservaFondosChequeHeaderOut/";

declare function xf:reservaFondosChequeHeaderOut($confirmaciondechequesResponse as element(ns0:ConfirmaciondechequesResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $confirmaciondechequesResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $confirmaciondechequesResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $confirmaciondechequesResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $ISSUINGDATE in $confirmaciondechequesResponse/LATAMAGCHEQUECONFIRMDATAType/ISSUINGDATE
                return
                    <valueDate>{ data($ISSUINGDATE) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $confirmaciondechequesResponse as element(ns0:ConfirmaciondechequesResponse) external;

xf:reservaFondosChequeHeaderOut($confirmaciondechequesResponse)