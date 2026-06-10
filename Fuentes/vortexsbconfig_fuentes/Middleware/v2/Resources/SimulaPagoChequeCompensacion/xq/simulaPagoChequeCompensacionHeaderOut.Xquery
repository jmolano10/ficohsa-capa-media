<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$simulapagodechqporcompensacion_ValidateResponse" element="ns0:Simulapagodechqporcompensacion_ValidateResponse" location="../../../../Business_Resources/compensacion/resources/XMLSchema_1569843523.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SimulaPagoChequeCompensacion/xq/simulaPagoChequeCompensacionHeaderOut/";

declare function xf:simulaPagoChequeCompensacionHeaderOut($simulapagodechqporcompensacion_ValidateResponse as element(ns0:Simulapagodechqporcompensacion_ValidateResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $simulapagodechqporcompensacion_ValidateResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $messageId in $simulapagodechqporcompensacion_ValidateResponse/Status/messageId
                return
                    <messageId>{ data($messageId) }</messageId>
            }
            {
                for $successIndicator in $simulapagodechqporcompensacion_ValidateResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $application in $simulapagodechqporcompensacion_ValidateResponse/Status/application
                return
                    <application>{ data($application) }</application>
            }
            {
                for $messages in $simulapagodechqporcompensacion_ValidateResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                let $result :=
                    for $DATETIME in $simulapagodechqporcompensacion_ValidateResponse/FICOINWARDCLEARINGType/gDATETIME/DATETIME
                    return
                        <valueDate>{ data($DATETIME) }</valueDate>
                return
                    $result[1]
            }
        </ns1:ResponseHeader>
};

declare variable $simulapagodechqporcompensacion_ValidateResponse as element(ns0:Simulapagodechqporcompensacion_ValidateResponse) external;

xf:simulaPagoChequeCompensacionHeaderOut($simulapagodechqporcompensacion_ValidateResponse)]]></con:xquery>
    <con:dependency location="../../../../Business_Resources/compensacion/resources/XMLSchema_1569843523.xsd">
        <con:schema ref="Middleware/Business_Resources/compensacion/resources/XMLSchema_1569843523"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>