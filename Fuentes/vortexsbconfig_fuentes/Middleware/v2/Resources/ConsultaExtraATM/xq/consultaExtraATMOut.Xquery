<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaExtrafinanciamientoDisponibleResponse1" element="ns0:consultaExtrafinanciamientoDisponibleResponse" location="../../ConsultaExtrafinanciamientoDisponible/xsd/consultaExtrafinanciamientoDisponibleTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaExtraATMResponse" location="../xsd/consultaExtraATMTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaExtrafinanciamientoDisponibleTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaExtraATMTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaExtraATM/xq/consultaExtraATMOut/";

declare function xf:consultaExtraATMOut($consultaExtrafinanciamientoDisponibleResponse1 as element(ns0:consultaExtrafinanciamientoDisponibleResponse))
    as element(ns1:consultaExtraATMResponse) {
        <ns1:consultaExtraATMResponse>
            <CUSTOMER_NAME>{ data($consultaExtrafinanciamientoDisponibleResponse1/CUSTOMER_NAME) }</CUSTOMER_NAME>
            <AVAILABLE_AMOUNT>{ data($consultaExtrafinanciamientoDisponibleResponse1/AVAILABLE_AMOUNT) }</AVAILABLE_AMOUNT>
            <INTEREST_RATE>{ data($consultaExtrafinanciamientoDisponibleResponse1/INTEREST_RATE) }</INTEREST_RATE>
            <OFFER_TYPE>{ data($consultaExtrafinanciamientoDisponibleResponse1/OFFER_TYPE) }</OFFER_TYPE>
        </ns1:consultaExtraATMResponse>
};

declare variable $consultaExtrafinanciamientoDisponibleResponse1 as element(ns0:consultaExtrafinanciamientoDisponibleResponse) external;

xf:consultaExtraATMOut($consultaExtrafinanciamientoDisponibleResponse1)]]></con:xquery>
    <con:dependency location="../../ConsultaExtrafinanciamientoDisponible/xsd/consultaExtrafinanciamientoDisponibleTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaExtrafinanciamientoDisponible/xsd/consultaExtrafinanciamientoDisponibleTypes"/>
    </con:dependency>
    <con:dependency location="../xsd/consultaExtraATMTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaExtraATM/xsd/consultaExtraATMTypes"/>
    </con:dependency>
</con:xqueryEntry>