(:: pragma bea:global-element-parameter parameter="$authrevpagorecaudorefdbctaResponse" element="ns0:AuthrevpagorecaudorefdbctaResponse" location="../Resources/XMLSchema_-193201527.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ReversarTransaccion/ReversarTransaccion/reversarTransaccionPagoRecaudoHeaderOut/";

declare function xf:reversarTransaccionPagoRecaudoHeaderOut($authrevpagorecaudorefdbctaResponse as element(ns0:AuthrevpagorecaudorefdbctaResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $authrevpagorecaudorefdbctaResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $authrevpagorecaudorefdbctaResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $authrevpagorecaudorefdbctaResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                let $result :=
                    for $DATETIME in $authrevpagorecaudorefdbctaResponse/FUNDSTRANSFERType/gDATETIME/DATETIME
                    return
                        <valueDate>{ concat("20",$DATETIME) }</valueDate>
                return
                    $result[1]
            }
        </ns1:ResponseHeader>
};

declare variable $authrevpagorecaudorefdbctaResponse as element(ns0:AuthrevpagorecaudorefdbctaResponse) external;

xf:reversarTransaccionPagoRecaudoHeaderOut($authrevpagorecaudorefdbctaResponse)