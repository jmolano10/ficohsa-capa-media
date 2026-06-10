<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$autorizacionreversionTTResponse" element="ns0:AutorizacionreversionTTResponse" location="../Resources/XMLSchema_-193201527.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ReversarTransaccion/ReversarTransaccion/reversarTransaccionTTHeaderOut/";

declare function xf:reversarTransaccionTTHeaderOut($autorizacionreversionTTResponse as element(ns0:AutorizacionreversionTTResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $autorizacionreversionTTResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $autorizacionreversionTTResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $autorizacionreversionTTResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $VALUEDATE1 in $autorizacionreversionTTResponse/TELLERType/VALUEDATE1
                return
                    <valueDate>{ data($VALUEDATE1) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $autorizacionreversionTTResponse as element(ns0:AutorizacionreversionTTResponse) external;

xf:reversarTransaccionTTHeaderOut($autorizacionreversionTTResponse)]]></con:xquery>
    <con:dependency location="../Resources/XMLSchema_-193201527.xsd">
        <con:schema ref="Middleware/Business_Resources/ReversarTransaccion/Resources/XMLSchema_-193201527"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/Business_Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>