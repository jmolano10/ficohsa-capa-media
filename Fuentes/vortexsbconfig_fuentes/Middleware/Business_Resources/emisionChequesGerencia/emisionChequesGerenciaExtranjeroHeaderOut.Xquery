<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$emisiondechequedegerenciaFCYResponse" element="ns0:EmisiondechequedegerenciaFCYResponse" location="Resources/XMLSchema_-1805424041.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/emisionChequesGerencia/emisionChequesGerenciaExtranjeroHeaderOut/";

declare function xf:emisionChequesGerenciaExtranjeroHeaderOut($emisiondechequedegerenciaFCYResponse as element(ns0:EmisiondechequedegerenciaFCYResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $emisiondechequedegerenciaFCYResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $emisiondechequedegerenciaFCYResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $emisiondechequedegerenciaFCYResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $DEBITVALUEDATE in $emisiondechequedegerenciaFCYResponse/FUNDSTRANSFERType/DEBITVALUEDATE
                return
                    <valueDate>{ data($DEBITVALUEDATE) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $emisiondechequedegerenciaFCYResponse as element(ns0:EmisiondechequedegerenciaFCYResponse) external;

xf:emisionChequesGerenciaExtranjeroHeaderOut($emisiondechequedegerenciaFCYResponse)]]></con:xquery>
    <con:dependency location="Resources/XMLSchema_-1805424041.xsd">
        <con:schema ref="Middleware/Business_Resources/emisionChequesGerencia/Resources/XMLSchema_-1805424041"/>
    </con:dependency>
    <con:dependency location="../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/Business_Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>