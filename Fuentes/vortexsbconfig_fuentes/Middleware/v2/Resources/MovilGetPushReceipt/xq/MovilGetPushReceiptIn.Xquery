<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$movilGetPushReceipt" element="ns1:movilGetPushReceipt" location="../../MovilDigitizationCards/xsd/movilDigitizationCardsTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MovilGetPushReceipt/xsd/movilGetPushReceipt_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/movilDigitizationCardsTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/movilGetPushReceipt";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MovilGetPushReceipt/xq/MovilGetPushReceiptIn/";

declare function xf:MovilGetPushReceiptIn($movilGetPushReceipt as element(ns1:movilGetPushReceipt))
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:PV_CARDNUMBER>{ data($movilGetPushReceipt/CARD_NUMBER) }&lt;/ns0:PV_CARDNUMBER>
        &lt;/ns0:InputParameters>
};

declare variable $movilGetPushReceipt as element(ns1:movilGetPushReceipt) external;

xf:MovilGetPushReceiptIn($movilGetPushReceipt)</con:xquery>
    <con:dependency location="../../MovilDigitizationCards/xsd/movilDigitizationCardsTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/MovilDigitizationCards/xsd/movilDigitizationCardsTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/MovilGetPushReceipt/xsd/movilGetPushReceipt_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MovilGetPushReceipt/xsd/movilGetPushReceipt_sp"/>
    </con:dependency>
</con:xqueryEntry>