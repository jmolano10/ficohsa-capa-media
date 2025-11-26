(:: pragma bea:global-element-parameter parameter="$aplicaDebitosdeChequesResponse" element="ns0:AplicaDebitosdeChequesResponse" location="../resources/XMLSchema_1569843523.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/compensacion/aplicaDebitoCheque/aplicaDebitoChequeHeaderOut/";

declare function xf:aplicaDebitoChequeHeaderOut($aplicaDebitosdeChequesResponse as element(ns0:AplicaDebitosdeChequesResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $aplicaDebitosdeChequesResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $aplicaDebitosdeChequesResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $aplicaDebitosdeChequesResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                let $result :=
                    for $DATETIME in $aplicaDebitosdeChequesResponse/TSASERVICEType/gDATETIME/DATETIME
                    return
                        <valueDate>{ concat("20", $DATETIME) }</valueDate>
                return
                    $result[1]
            }
        </ns1:ResponseHeader>
};

declare variable $aplicaDebitosdeChequesResponse as element(ns0:AplicaDebitosdeChequesResponse) external;

xf:aplicaDebitoChequeHeaderOut($aplicaDebitosdeChequesResponse)