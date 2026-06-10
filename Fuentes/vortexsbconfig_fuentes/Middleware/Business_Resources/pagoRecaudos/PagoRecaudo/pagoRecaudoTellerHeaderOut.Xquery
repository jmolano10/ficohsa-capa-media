<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:schema-type-parameter parameter="$status" type="ns0:Status" location="../Resources/XMLSchema_-258408779.xsd" ::)
(:: pragma bea:schema-type-parameter parameter="$tELLERType" type="ns0:TELLERType" location="../Resources/XMLSchema_-258408779.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTellerHeaderOut/";

declare function xf:pagoRecaudoTellerHeaderOut($status as element(),
    $tELLERType as element())
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $VALUEDATE2 in $tELLERType/VALUEDATE2
                return
                    <valueDate>{ data($VALUEDATE2) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $status as element() external;
declare variable $tELLERType as element() external;

xf:pagoRecaudoTellerHeaderOut($status,
    $tELLERType)]]></con:xquery>
    <con:dependency location="../Resources/XMLSchema_-258408779.xsd">
        <con:schema ref="Middleware/Business_Resources/pagoRecaudos/Resources/XMLSchema_-258408779"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/Business_Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>