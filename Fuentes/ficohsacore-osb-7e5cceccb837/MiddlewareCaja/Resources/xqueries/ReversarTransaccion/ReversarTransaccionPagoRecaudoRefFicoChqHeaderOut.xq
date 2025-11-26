(:: pragma bea:global-element-parameter parameter="$reversionpagorecaudorefficochqResponse" element="ns0:ReversionpagorecaudorefficochqResponse" location="../../xsds/ReversaTransaccion/XMLSchema_-193201527.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ReversarTransaccion/ReversarTransaccionPagoRecaudoRefFicoChqHeaderOut/";

declare function xf:ReversarTransaccionPagoRecaudoRefFicoChqHeaderOut($reversionpagorecaudorefficochqResponse as element(ns0:ReversionpagorecaudorefficochqResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $reversionpagorecaudorefficochqResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $reversionpagorecaudorefficochqResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $reversionpagorecaudorefficochqResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                let $result :=
                    for $DATETIME in $reversionpagorecaudorefficochqResponse/FUNDSTRANSFERType/gDATETIME/DATETIME
                    return
                        <valueDate>{ concat("20",$DATETIME) }</valueDate>
                return
                    $result[1]
            }
        </ns1:ResponseHeader>
};

declare variable $reversionpagorecaudorefficochqResponse as element(ns0:ReversionpagorecaudorefficochqResponse) external;

xf:ReversarTransaccionPagoRecaudoRefFicoChqHeaderOut($reversionpagorecaudorefficochqResponse)