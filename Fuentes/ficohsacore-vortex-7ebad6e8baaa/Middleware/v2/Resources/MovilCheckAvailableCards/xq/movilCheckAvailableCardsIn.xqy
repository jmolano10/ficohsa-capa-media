xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$movilCheckAvailableCards" element="ns1:movilCheckAvailableCards" location="../../MovilDigitizationCards/xsd/movilDigitizationCardsTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MovilCheckAvailableCards/xsd/movilCheckAvailableCards_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/movilDigitizationCardsTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/movilCheckAvailableCards";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MovilCheckAvailableCards/xq/movilCheckAvailableCardsIn/";

declare function xf:movilCheckAvailableCardsIn($movilCheckAvailableCards as element(ns1:movilCheckAvailableCards))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CODIGOCLIENTE>{ data($movilCheckAvailableCards/CODIGO_CLIENTE) }</ns0:PV_CODIGOCLIENTE>
            <ns0:PV_PAIS>{ data($movilCheckAvailableCards/PAIS) }</ns0:PV_PAIS>
        </ns0:InputParameters>
};

declare variable $movilCheckAvailableCards as element(ns1:movilCheckAvailableCards) external;

xf:movilCheckAvailableCardsIn($movilCheckAvailableCards)