<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/MovilCheckAvailableCards/xsd/movilCheckAvailableCards_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:movilCheckAvailableCardsResponse" location="../../MovilDigitizationCards/xsd/movilDigitizationCardsTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/movilCheckAvailableCards";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/movilDigitizationCardsTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MovilCheckAvailableCards/xq/movilCheckAvailableCardsOut/";

declare function xf:movilCheckAvailableCardsOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:movilCheckAvailableCardsResponse) {
        &lt;ns0:movilCheckAvailableCardsResponse>
        	&lt;FLAG>{ data($outputParameters/ns1:PV_FLAG) }&lt;/FLAG>
        &lt;/ns0:movilCheckAvailableCardsResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:movilCheckAvailableCardsOut($outputParameters)</con:xquery>
    <con:dependency location="../../../BusinessServices/MovilCheckAvailableCards/xsd/movilCheckAvailableCards_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MovilCheckAvailableCards/xsd/movilCheckAvailableCards_sp"/>
    </con:dependency>
    <con:dependency location="../../MovilDigitizationCards/xsd/movilDigitizationCardsTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/MovilDigitizationCards/xsd/movilDigitizationCardsTypes"/>
    </con:dependency>
</con:xqueryEntry>