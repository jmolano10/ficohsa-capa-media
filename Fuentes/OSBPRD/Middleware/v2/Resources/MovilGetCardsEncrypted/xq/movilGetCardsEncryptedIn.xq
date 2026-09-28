xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$movilGetCardsEncrypted" element="ns1:movilGetCardsEncrypted" location="../../MovilDigitizationCards/xsd/movilDigitizationCardsTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MovilGetCardsEncrypted/xsd/movilGetCardsEncrypted_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MovilGetCardsEncrypted/xq/movilGetCardsEncryptedIn/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/movilDigitizationCardsTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/movilGetCardsEncrypted";

declare function xf:movilGetCardsEncryptedIn($movilGetCardsEncrypted as element(ns1:movilGetCardsEncrypted))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CARDNUMBER>{ data($movilGetCardsEncrypted/CARD_NUMBER) }</ns0:PV_CARDNUMBER>
        </ns0:InputParameters>
};

declare variable $movilGetCardsEncrypted as element(ns1:movilGetCardsEncrypted) external;

xf:movilGetCardsEncryptedIn($movilGetCardsEncrypted)