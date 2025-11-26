(:: pragma bea:global-element-parameter parameter="$pagodechqporcompensacionResponse1" element="ns0:PagodechqporcompensacionResponse" location="../resources/XMLSchema_1569843523.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/compensacion/pagoChequeCompensacion/pagoChequeCompensacionHeaderOutFalse/";

declare function xf:pagoChequeCompensacionHeaderOutFalse($pagodechqporcompensacionResponse1 as element(ns0:PagodechqporcompensacionResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $pagodechqporcompensacionResponse1/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $messageId in $pagodechqporcompensacionResponse1/Status/messageId
                return
                    <messageId>{ data($messageId) }</messageId>
            }
            <successIndicator>ERROR</successIndicator>
            {
                for $application in $pagodechqporcompensacionResponse1/Status/application
                return
                    <application>{ data($application) }</application>
            }
            {
                for $messages in $pagodechqporcompensacionResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                let $result :=
                    for $DATETIME in $pagodechqporcompensacionResponse1/FICOINWARDCLEARINGType/gDATETIME/DATETIME
                    return
                        <valueDate>{ concat("20",$DATETIME) }</valueDate>
                return
                    $result[1]
            }
        </ns1:ResponseHeader>
};

declare variable $pagodechqporcompensacionResponse1 as element(ns0:PagodechqporcompensacionResponse) external;

xf:pagoChequeCompensacionHeaderOutFalse($pagodechqporcompensacionResponse1)