<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$movilGetCardsEncrypted" element="ns1:movilGetCardsEncrypted" location="../../MovilDigitizationCards/xsd/movilDigitizationCardsTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MovilGetCardsEncrypted/xsd/movilGetCardsEncrypted_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MovilGetCardsEncrypted/xq/movilGetCardsEncryptedIn/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/movilDigitizationCardsTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/movilGetCardsEncrypted";

declare function xf:movilGetCardsEncryptedIn($movilGetCardsEncrypted as element(ns1:movilGetCardsEncrypted))
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:PV_CARDNUMBER>{ data($movilGetCardsEncrypted/CARD_NUMBER) }&lt;/ns0:PV_CARDNUMBER>
        &lt;/ns0:InputParameters>
};

declare variable $movilGetCardsEncrypted as element(ns1:movilGetCardsEncrypted) external;

xf:movilGetCardsEncryptedIn($movilGetCardsEncrypted)</con:xquery>
    <con:dependency location="../../MovilDigitizationCards/xsd/movilDigitizationCardsTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/MovilDigitizationCards/xsd/movilDigitizationCardsTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/MovilGetCardsEncrypted/xsd/movilGetCardsEncrypted_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MovilGetCardsEncrypted/xsd/movilGetCardsEncrypted_sp"/>
    </con:dependency>
</con:xqueryEntry>