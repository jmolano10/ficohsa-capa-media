xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/MovilGetCardsInfo/xsd/movilGetCardsInfo_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:movilGetCardsInfoResponse" location="../../MovilDigitizationCards/xsd/movilDigitizationCardsTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MovilGetCardsInfo/xq/movilGetCardsInfoOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/movilDigitizationCardsTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/movilGetCardsInfo";

declare function xf:movilGetCardsInfoOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:movilGetCardsInfoResponse) {
        <ns1:movilGetCardsInfoResponse>
            <REQUEST_ID>{ data($outputParameters/ns0:PV_REQUESTID) }</REQUEST_ID>
            <RETURN_CODE>{ data($outputParameters/ns0:PV_RETURNCODE) }</RETURN_CODE>
            <ERROR_DESCRIPTION>{ data($outputParameters/ns0:PV_ERRORDESCRIPTION) }</ERROR_DESCRIPTION>
            <CARD_NUMBER>{ data($outputParameters/ns0:PV_CARDNUMBER) }</CARD_NUMBER>
            <INSTITUTION_CODE>{ data($outputParameters/ns0:PV_INSTITUTIONCODE) }</INSTITUTION_CODE>
            <STATUS>{ data($outputParameters/ns0:PV_STATUS) }</STATUS>
            <STATUS_INFO>{ data($outputParameters/ns0:PV_STATUSINFO) }</STATUS_INFO>
        </ns1:movilGetCardsInfoResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:movilGetCardsInfoOut($outputParameters)