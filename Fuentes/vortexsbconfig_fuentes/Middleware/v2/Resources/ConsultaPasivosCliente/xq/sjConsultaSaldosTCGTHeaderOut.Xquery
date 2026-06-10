<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$responseHeader1" element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaPasivosCliente/xq/sjConsultaSaldosTCHeaderOut/";

declare function xf:sjConsultaSaldosTCHeaderOut($responseHeader1 as element(ns0:ResponseHeader))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $transactionId in $responseHeader1/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $messageId in $responseHeader1/messageId
                return
                    <messageId>{ data($messageId) }</messageId>
            }
            {
                for $successIndicator in $responseHeader1/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $application in $responseHeader1/application
                return
                    <application>{ data($application) }</application>
            }
            {
                for $messages in $responseHeader1/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $valueDate in $responseHeader1/valueDate
                return
                    <valueDate>{ data($valueDate) }</valueDate>
            }
        </ns0:ResponseHeader>
};

declare variable $responseHeader1 as element(ns0:ResponseHeader) external;

xf:sjConsultaSaldosTCHeaderOut($responseHeader1)]]></con:xquery>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>