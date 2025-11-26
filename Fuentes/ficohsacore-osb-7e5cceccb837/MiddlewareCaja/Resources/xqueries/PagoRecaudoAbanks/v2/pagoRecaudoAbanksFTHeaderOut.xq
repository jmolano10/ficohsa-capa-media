(:: pragma bea:local-element-parameter parameter="$status1" type="ns0:PagoderecaudoreferenciadodbctaResponse/Status" location="../../../xsds/PagoRecaudos/XMLSchema_-258408779.xsd" ::)
(:: pragma bea:local-element-parameter parameter="$fUNDSTRANSFERType1" type="ns0:PagoderecaudoreferenciadodbctaResponse/FUNDSTRANSFERType" location="../../../xsds/PagoRecaudos/XMLSchema_-258408779.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudoAbanks/v2/pagoRecaudoAbanksFTHeaderOut/";

declare function xf:pagoRecaudoAbanksFTHeaderOut($status1 as element(),
    $fUNDSTRANSFERType1 as element())
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $status1/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $status1/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $status1/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $CREDITVALUEDATE in $fUNDSTRANSFERType1/CREDITVALUEDATE
                return
                    <valueDate>{ data($CREDITVALUEDATE) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $status1 as element() external;
declare variable $fUNDSTRANSFERType1 as element() external;

xf:pagoRecaudoAbanksFTHeaderOut($status1,
    $fUNDSTRANSFERType1)