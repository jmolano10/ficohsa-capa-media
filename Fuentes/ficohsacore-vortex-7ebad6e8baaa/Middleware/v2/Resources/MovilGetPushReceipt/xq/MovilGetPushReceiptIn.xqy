xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$movilGetPushReceipt" element="ns1:movilGetPushReceipt" location="../../MovilDigitizationCards/xsd/movilDigitizationCardsTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MovilGetPushReceipt/xsd/movilGetPushReceipt_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/movilDigitizationCardsTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/movilGetPushReceipt";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MovilGetPushReceipt/xq/MovilGetPushReceiptIn/";

declare function xf:MovilGetPushReceiptIn($movilGetPushReceipt as element(ns1:movilGetPushReceipt))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CARDNUMBER>{ data($movilGetPushReceipt/CARD_NUMBER) }</ns0:PV_CARDNUMBER>
        </ns0:InputParameters>
};

declare variable $movilGetPushReceipt as element(ns1:movilGetPushReceipt) external;

xf:MovilGetPushReceiptIn($movilGetPushReceipt)