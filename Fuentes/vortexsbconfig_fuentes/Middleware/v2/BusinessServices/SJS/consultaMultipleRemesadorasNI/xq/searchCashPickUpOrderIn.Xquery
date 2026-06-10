<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaMultipleRemesadorasNI" element="ns1:sjConsultaMultipleRemesadorasNI" location="../xsd/sjConsultaMultipleRemesadorasNI.xsd" ::)
(:: pragma bea:global-element-return element="ns0:searchCashPickUpOrderRequest" location="../../../Remesas/RIANI/searchCashPickUpOrder/wsdl/searchCashPickUpOrder.wsdl" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleRemesadorasNI";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/riaMoneyTransferTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleRemesadorasNI/xq/searchCashPickUpOrderIn/";

declare function xf:searchCashPickUpOrderIn($sjConsultaMultipleRemesadorasNI as element(ns1:sjConsultaMultipleRemesadorasNI),
    $riaAgentId as xs:string,
    $subscriptionKey as xs:string)
    as element(ns0:searchCashPickUpOrderRequest) {
        <ns0:searchCashPickUpOrderRequest>
            <ns0:HeaderParams>
                <ns0:riaCallerCorrelationId>{ fn-bea:uuid() }</ns0:riaCallerCorrelationId>
                <ns0:riaCallDateTimeLocal>{ fn-bea:dateTime-to-string-with-format('yyyyMMddHHmmss', adjust-dateTime-to-timezone(current-dateTime(), ())) }</ns0:riaCallDateTimeLocal>
                <ns0:riaAgentId>{ $riaAgentId }</ns0:riaAgentId>
                <ns0:ocpApimSubscriptionKey>{ $subscriptionKey }</ns0:ocpApimSubscriptionKey>
            </ns0:HeaderParams>
            <ns0:BeneAmount>0</ns0:BeneAmount>
            <ns0:CorrespLocID>0</ns0:CorrespLocID>
            <ns0:DateTimeLocal>{ fn-bea:dateTime-to-string-with-format('yyyyMMddHHmmss', adjust-dateTime-to-timezone(current-dateTime(), ())) }</ns0:DateTimeLocal>
            <ns0:DateTimeUTC>{ fn-bea:dateTime-to-string-with-format('yyyyMMddHHmmss', adjust-dateTime-to-timezone(current-dateTime(), ())) }</ns0:DateTimeUTC>
            <ns0:PIN>{ data($sjConsultaMultipleRemesadorasNI/ns1:REMITTANCE_ID) }</ns0:PIN>
        </ns0:searchCashPickUpOrderRequest>
};

declare variable $sjConsultaMultipleRemesadorasNI as element(ns1:sjConsultaMultipleRemesadorasNI) external;
declare variable $riaAgentId as xs:string external;
declare variable $subscriptionKey as xs:string external;

xf:searchCashPickUpOrderIn($sjConsultaMultipleRemesadorasNI,
    $riaAgentId,
    $subscriptionKey)]]></con:xquery>
    <con:dependency location="../xsd/sjConsultaMultipleRemesadorasNI.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/SJS/consultaMultipleRemesadorasNI/xsd/sjConsultaMultipleRemesadorasNI"/>
    </con:dependency>
    <con:dependency location="../../../Remesas/RIANI/searchCashPickUpOrder/wsdl/searchCashPickUpOrder.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/Remesas/RIANI/searchCashPickUpOrder/wsdl/searchCashPickUpOrder"/>
    </con:dependency>
</con:xqueryEntry>