(:: pragma bea:global-element-parameter parameter="$movilGetCardsInfo" element="ns1:movilGetCardsInfo" location="../../MovilDigitizationCards/xsd/movilDigitizationCardsTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MovilGetCardsInfoV2/xsd/movilGetCardsInfo_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/movilDigitizationCardsTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/movilGetCardsInfo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MovilGetCardsInfo/xq/movilGetCardsInfoV2In/";

declare function xf:movilGetCardsInfoV2In($movilGetCardsInfo as element(ns1:movilGetCardsInfo))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_NUMBER>{ data($movilGetCardsInfo/NUMBER) }</ns0:PV_NUMBER>
            <ns0:PV_PRODUCTTYPE>{ data($movilGetCardsInfo/PRODUCT_TYPE) }</ns0:PV_PRODUCTTYPE>
            <ns0:PV_CLIENTNUMBER>{ data($movilGetCardsInfo/CUSTOMER_NUMBER) }</ns0:PV_CLIENTNUMBER>
            <ns0:PV_PAIS>{ data($movilGetCardsInfo/COUNTRY_CODE) }</ns0:PV_PAIS>
            <ns0:PV_WALLETREQUESTOR>{ data($movilGetCardsInfo/WALLET_REQUEST) }</ns0:PV_WALLETREQUESTOR>
        </ns0:InputParameters>
};

declare variable $movilGetCardsInfo as element(ns1:movilGetCardsInfo) external;

xf:movilGetCardsInfoV2In($movilGetCardsInfo)