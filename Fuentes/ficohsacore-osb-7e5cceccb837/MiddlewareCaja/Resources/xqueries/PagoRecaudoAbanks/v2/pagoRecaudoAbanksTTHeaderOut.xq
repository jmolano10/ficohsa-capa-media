(:: pragma bea:local-element-parameter parameter="$status1" type="ns0:PagoderecaudoreferenciadoefecResponse/Status" location="../../../xsds/PagoRecaudos/XMLSchema_-258408779.xsd" ::)
(:: pragma bea:local-element-parameter parameter="$tELLERType1" type="ns0:PagoderecaudoreferenciadoefecResponse/TELLERType" location="../../../xsds/PagoRecaudos/XMLSchema_-258408779.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudoAbanks/v2/pagoRecaudoAbanksTTHeaderOut/";

declare function xf:pagoRecaudoAbanksTTHeaderOut($status1 as element(),
    $tELLERType1 as element())
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
                for $VALUEDATE2 in $tELLERType1/VALUEDATE2
                return
                    <valueDate>{ data($VALUEDATE2) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $status1 as element() external;
declare variable $tELLERType1 as element() external;

xf:pagoRecaudoAbanksTTHeaderOut($status1,
    $tELLERType1)