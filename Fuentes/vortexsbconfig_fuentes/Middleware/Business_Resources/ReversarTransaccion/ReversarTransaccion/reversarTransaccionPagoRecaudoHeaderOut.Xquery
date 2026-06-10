<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
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

xf:reversarTransaccionPagoRecaudoHeaderOut($authrevpagorecaudorefdbctaResponse)]]></con:xquery>
    <con:dependency location="../Resources/XMLSchema_-193201527.xsd">
        <con:schema ref="Middleware/Business_Resources/ReversarTransaccion/Resources/XMLSchema_-193201527"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/Business_Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>