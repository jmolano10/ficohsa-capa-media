xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$transacciondesubastaResponse" element="ns0:TransacciondesubastaResponse" location="../Resources/XMLSchema_-1390898219.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/subasta/transaccionSubasta/transaccionSubastaHeaderOut/";

declare function xf:transaccionSubastaHeaderOut($transacciondesubastaResponse as element(ns0:TransacciondesubastaResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $transacciondesubastaResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $transacciondesubastaResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                let $result :=
                    for $DATETIME in $transacciondesubastaResponse/FUNDSTRANSFERType/gDATETIME/DATETIME
                    return
                        <valueDate>{ concat("20", $DATETIME) }</valueDate>
                return
                    $result[1]
            }
        </ns1:ResponseHeader>
};

declare variable $transacciondesubastaResponse as element(ns0:TransacciondesubastaResponse) external;

xf:transaccionSubastaHeaderOut($transacciondesubastaResponse)