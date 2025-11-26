(:: pragma bea:global-element-parameter parameter="$simulapagodechqporcompensacionResponse1" element="ns0:SimulapagodechqporcompensacionResponse" location="../resources/XMLSchema_1569843523.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/compensacion/simulaPagoChequeCompensacion/simulaPagoChequeCompensacionHeaderOutFalse/";

declare function xf:simulaPagoChequeCompensacionHeaderOutFalse($simulapagodechqporcompensacionResponse1 as element(ns0:SimulapagodechqporcompensacionResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $simulapagodechqporcompensacionResponse1/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $messageId in $simulapagodechqporcompensacionResponse1/Status/messageId
                return
                    <messageId>{ data($messageId) }</messageId>
            }
            <successIndicator>ERROR</successIndicator>
            {
                for $application in $simulapagodechqporcompensacionResponse1/Status/application
                return
                    <application>{ data($application) }</application>
            }
            {
                for $messages in $simulapagodechqporcompensacionResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                let $result :=
                    for $DATETIME in $simulapagodechqporcompensacionResponse1/FICOINWARDCLEARINGType/gDATETIME/DATETIME
                    return
                        <valueDate>{ data($DATETIME) }</valueDate>
                return
                    $result[1]
            }
        </ns1:ResponseHeader>
};

declare variable $simulapagodechqporcompensacionResponse1 as element(ns0:SimulapagodechqporcompensacionResponse) external;

xf:simulaPagoChequeCompensacionHeaderOutFalse($simulapagodechqporcompensacionResponse1)