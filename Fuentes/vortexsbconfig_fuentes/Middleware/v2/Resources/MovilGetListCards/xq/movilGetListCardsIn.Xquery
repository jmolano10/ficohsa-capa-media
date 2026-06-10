<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$movilGetListCards" element="ns1:movilGetListCards" location="../../MovilDigitizationCards/xsd/movilDigitizationCardsTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MovilGetCardsList/xsd/movilGetListCards_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/movilDigitizationCardsTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/movilGetListCards";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MovilGetListCards/xq/movilGetListCardsIn/";

declare function xf:movilGetListCardsIn($movilGetListCards as element(ns1:movilGetListCards))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CODIGOCLIENTE>{ data($movilGetListCards/CODIGO_CLIENTE) }</ns0:PV_CODIGOCLIENTE>
            <ns0:PV_PAIS>{ data($movilGetListCards/PAIS) }</ns0:PV_PAIS>
            <ns0:PV_WALLETREQUESTOR>{ data($movilGetListCards/WALLET_REQUEST) }</ns0:PV_WALLETREQUESTOR>
        </ns0:InputParameters>
};

declare variable $movilGetListCards as element(ns1:movilGetListCards) external;

xf:movilGetListCardsIn($movilGetListCards)]]></con:xquery>
    <con:dependency location="../../MovilDigitizationCards/xsd/movilDigitizationCardsTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/MovilDigitizationCards/xsd/movilDigitizationCardsTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/MovilGetCardsList/xsd/movilGetListCards_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MovilGetCardsList/xsd/movilGetListCards_sp"/>
    </con:dependency>
</con:xqueryEntry>