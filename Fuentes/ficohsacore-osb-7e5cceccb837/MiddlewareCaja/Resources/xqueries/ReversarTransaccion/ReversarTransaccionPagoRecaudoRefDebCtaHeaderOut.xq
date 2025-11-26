(:: pragma bea:global-element-parameter parameter="$reversionpagorecaudorefdbctaResponse" element="ns0:ReversionpagorecaudorefdbctaResponse" location="../../xsds/ReversaTransaccion/XMLSchema_-193201527.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ReversarTransaccion/ReversarTransaccionPagoRecaudoRefDebCtaHeaderOut/";

declare function xf:ReversarTransaccionPagoRecaudoRefDebCtaHeaderOut($reversionpagorecaudorefdbctaResponse as element(ns0:ReversionpagorecaudorefdbctaResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $reversionpagorecaudorefdbctaResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $reversionpagorecaudorefdbctaResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $reversionpagorecaudorefdbctaResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                let $result :=
                    for $DATETIME in $reversionpagorecaudorefdbctaResponse/FUNDSTRANSFERType/gDATETIME/DATETIME
                    return
                        <valueDate>{ concat("20",$DATETIME) }</valueDate>
                return
                    $result[1]
            }
        </ns1:ResponseHeader>
};

declare variable $reversionpagorecaudorefdbctaResponse as element(ns0:ReversionpagorecaudorefdbctaResponse) external;

xf:ReversarTransaccionPagoRecaudoRefDebCtaHeaderOut($reversionpagorecaudorefdbctaResponse)