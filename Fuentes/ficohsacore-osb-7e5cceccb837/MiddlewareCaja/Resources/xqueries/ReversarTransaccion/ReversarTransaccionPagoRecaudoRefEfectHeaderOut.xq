(:: pragma bea:global-element-parameter parameter="$reversionpagorecaudorefefecResponse" element="ns0:ReversionpagorecaudorefefecResponse" location="../../xsds/ReversaTransaccion/XMLSchema_-193201527.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ReversarTransaccion/ReversarTransaccionPagoRecaudoRefEfectHeaderOut/";

declare function xf:ReversarTransaccionPagoRecaudoRefEfectHeaderOut($reversionpagorecaudorefefecResponse as element(ns0:ReversionpagorecaudorefefecResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $reversionpagorecaudorefefecResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $reversionpagorecaudorefefecResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $reversionpagorecaudorefefecResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                let $result :=
                    for $DATETIME in $reversionpagorecaudorefefecResponse/TELLERType/gDATETIME/DATETIME
                    return
                        <valueDate>{ concat("20",$DATETIME) }</valueDate>
                return
                    $result[1]
            }
        </ns1:ResponseHeader>
};

declare variable $reversionpagorecaudorefefecResponse as element(ns0:ReversionpagorecaudorefefecResponse) external;

xf:ReversarTransaccionPagoRecaudoRefEfectHeaderOut($reversionpagorecaudorefefecResponse)