<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaSaldosTarjetaCreditoGT" element="ns0:consultaSaldosTarjetaCredito" location="../../../../Business_Resources/tarjetaCredito/ConsultaSaldosTarjetaCredito/consultaSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:sjConsultaSaldosTC" location="../../../BusinessServices/SJS/consultaSaldosTC/xsd/sjConsultaSaldosTC.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSaldosTC";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/consultaSaldosTCSjInGT/";

declare function xf:consultaSaldosTCSjInGT($consultaSaldosTarjetaCreditoGT as element(ns0:consultaSaldosTarjetaCredito))
    as element(ns1:sjConsultaSaldosTC) {
        &lt;ns1:sjConsultaSaldosTC>
            &lt;CARD_NUMBER>{ data($consultaSaldosTarjetaCreditoGT/CARD_NUMBER) }&lt;/CARD_NUMBER>
        &lt;/ns1:sjConsultaSaldosTC>
};

declare variable $consultaSaldosTarjetaCreditoGT as element(ns0:consultaSaldosTarjetaCredito) external;

xf:consultaSaldosTCSjInGT($consultaSaldosTarjetaCreditoGT)</con:xquery>
    <con:dependency location="../../../../Business_Resources/tarjetaCredito/ConsultaSaldosTarjetaCredito/consultaSaldosTarjetaCreditoTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/tarjetaCredito/ConsultaSaldosTarjetaCredito/consultaSaldosTarjetaCreditoTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/SJS/consultaSaldosTC/xsd/sjConsultaSaldosTC.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/SJS/consultaSaldosTC/xsd/sjConsultaSaldosTC"/>
    </con:dependency>
</con:xqueryEntry>