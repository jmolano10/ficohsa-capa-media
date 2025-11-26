xquery version "1.0" encoding "Cp1252";
(:: pragma bea:schema-type-parameter parameter="$status" type="ns0:Status" location="../../xsds/PagoRecaudos/XMLSchema_-258408779.xsd" ::)
(:: pragma bea:schema-type-parameter parameter="$fUNDSTRANSFERType" type="ns0:FUNDSTRANSFERType" location="../../xsds/PagoRecaudos/XMLSchema_-258408779.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudo/PagoRecaudoTransferHeaderOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";

declare function xf:PagoRecaudoTransferHeaderOut($status as element(),
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
                for $CREDITVALUEDATE in $fUNDSTRANSFERType/CREDITVALUEDATE
                return
                    <valueDate>{ data($CREDITVALUEDATE) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $status as element() external;
declare variable $fUNDSTRANSFERType as element() external;

xf:PagoRecaudoTransferHeaderOut($status,
    $fUNDSTRANSFERType)