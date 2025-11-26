(:: pragma bea:global-element-parameter parameter="$reversionpagorecaudorefobchqResponse" element="ns0:ReversionpagorecaudorefobchqResponse" location="../../xsds/ReversaTransaccion/XMLSchema_-193201527.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ReversarTransaccion/ReversarTransaccionPagoRecaudoRefOBChqHeaderOut/";

declare function xf:ReversarTransaccionPagoRecaudoRefOBChqHeaderOut($reversionpagorecaudorefobchqResponse as element(ns0:ReversionpagorecaudorefobchqResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $reversionpagorecaudorefobchqResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $reversionpagorecaudorefobchqResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $reversionpagorecaudorefobchqResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                let $result :=
                    for $DATETIME in $reversionpagorecaudorefobchqResponse/TELLERType/gDATETIME/DATETIME
                    return
                        <valueDate>{ concat("20",$DATETIME) }</valueDate>
                return
                    $result[1]
            }
        </ns1:ResponseHeader>
};

declare variable $reversionpagorecaudorefobchqResponse as element(ns0:ReversionpagorecaudorefobchqResponse) external;

xf:ReversarTransaccionPagoRecaudoRefOBChqHeaderOut($reversionpagorecaudorefobchqResponse)