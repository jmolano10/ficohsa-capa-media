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
        </ns0:InputParameters>
};

declare variable $movilGetListCards as element(ns1:movilGetListCards) external;

xf:movilGetListCardsIn($movilGetListCards)