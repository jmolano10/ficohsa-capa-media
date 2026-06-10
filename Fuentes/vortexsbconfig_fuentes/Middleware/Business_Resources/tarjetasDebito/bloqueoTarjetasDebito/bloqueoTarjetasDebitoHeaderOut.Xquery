<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$bloqueodetarjetadedebitoResponse" element="ns0:BloqueodetarjetadedebitoResponse" location="../Resources/XMLSchema_-155258746.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetasDebito/bloqueoTarjetasDebito/bloqueoTarjetasDebitoHeaderOut/";

declare function xf:bloqueoTarjetasDebitoHeaderOut($bloqueodetarjetadedebitoResponse as element(ns0:BloqueodetarjetadedebitoResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $bloqueodetarjetadedebitoResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $bloqueodetarjetadedebitoResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $bloqueodetarjetadedebitoResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $BLOCKDATE in $bloqueodetarjetadedebitoResponse/LATAMCARDORDERType/BLOCKDATE
                return
                    <valueDate>{ data($BLOCKDATE) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $bloqueodetarjetadedebitoResponse as element(ns0:BloqueodetarjetadedebitoResponse) external;

xf:bloqueoTarjetasDebitoHeaderOut($bloqueodetarjetadedebitoResponse)]]></con:xquery>
    <con:dependency location="../Resources/XMLSchema_-155258746.xsd">
        <con:schema ref="Middleware/Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/Business_Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>