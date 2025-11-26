(:: pragma bea:schema-type-parameter parameter="$status" type="ns0:Status" location="../../xsds/ReversaTxnRecaudos/XMLSchema_728098728.xsd" ::)
(:: pragma bea:schema-type-parameter parameter="$fUNDSTRANSFERType" type="ns0:FUNDSTRANSFERType" location="../../xsds/ReversaTxnRecaudos/XMLSchema_728098728.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ReversarTransaccion/ReversarTransaccionPagoRecaudoTransferHeaderOut/";

declare function xf:ReversarTransaccionPagoRecaudoTransferHeaderOut($status as element(),
    $fUNDSTRANSFERType as element())
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                let $result :=
                    for $DATETIME in $fUNDSTRANSFERType/gDATETIME/DATETIME
                    return
                        <valueDate>{ concat("20",$DATETIME) }</valueDate>
                return
                    $result[1]
            }
        </ns1:ResponseHeader>
};

declare variable $status as element() external;
declare variable $fUNDSTRANSFERType as element() external;

xf:ReversarTransaccionPagoRecaudoTransferHeaderOut($status,
    $fUNDSTRANSFERType)