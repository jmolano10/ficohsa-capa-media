<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaSaldosTarjetaCredito1" element="ns0:consultaSaldosTarjetaCredito" location="../xsd/consultaSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:sjConsultaSaldosTC" location="../../../BusinessServices/SJS/consultaSaldosTC/xsd/sjConsultaSaldosTC.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSaldosTC";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/consultaSaldosTCSjIn/";

declare function xf:consultaSaldosTCSjIn($consultaSaldosTarjetaCredito1 as element(ns0:consultaSaldosTarjetaCredito))
    as element(ns1:sjConsultaSaldosTC) {
        &lt;ns1:sjConsultaSaldosTC>
            &lt;CARD_NUMBER>{ data($consultaSaldosTarjetaCredito1/CARD_NUMBER) }&lt;/CARD_NUMBER>
        &lt;/ns1:sjConsultaSaldosTC>
};

declare variable $consultaSaldosTarjetaCredito1 as element(ns0:consultaSaldosTarjetaCredito) external;

xf:consultaSaldosTCSjIn($consultaSaldosTarjetaCredito1)</con:xquery>
    <con:dependency location="../xsd/consultaSaldosTarjetaCreditoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xsd/consultaSaldosTarjetaCreditoTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/SJS/consultaSaldosTC/xsd/sjConsultaSaldosTC.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/SJS/consultaSaldosTC/xsd/sjConsultaSaldosTC"/>
    </con:dependency>
</con:xqueryEntry>