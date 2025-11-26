(:: pragma bea:global-element-parameter parameter="$reversionpagorecaudorefchqtintlResponse" element="ns0:ReversionpagorecaudorefchqtintlResponse" location="../../xsds/ReversaTransaccion/XMLSchema_-193201527.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ReversarTransaccion/ReversarTransaccionPagoRecaudoRefIntChqHeaderOut/";

declare function xf:ReversarTransaccionPagoRecaudoRefIntChqHeaderOut($reversionpagorecaudorefchqtintlResponse as element(ns0:ReversionpagorecaudorefchqtintlResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $reversionpagorecaudorefchqtintlResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $reversionpagorecaudorefchqtintlResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $reversionpagorecaudorefchqtintlResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                let $result :=
                    for $DATETIME in $reversionpagorecaudorefchqtintlResponse/TELLERType/gDATETIME/DATETIME
                    return
                        <valueDate>{ concat("20",$DATETIME) }</valueDate>
                return
                    $result[1]
            }
        </ns1:ResponseHeader>
};

declare variable $reversionpagorecaudorefchqtintlResponse as element(ns0:ReversionpagorecaudorefchqtintlResponse) external;

xf:ReversarTransaccionPagoRecaudoRefIntChqHeaderOut($reversionpagorecaudorefchqtintlResponse)