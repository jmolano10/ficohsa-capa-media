<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaSaldosTarjetaCredito1" element="ns1:consultaSaldosTarjetaCredito" location="../../ConsultaMaestraSaldosTarjetaCredito/xsd/consultaMaestraSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ConsultaNoTC/xsd/CONSULTANUMEROTC_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/CONSULTANUMEROTC";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMaestraSaldosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaSaldosTCID/xq/ConsultaNumeroTC_In/";

declare function xf:ConsultaNumeroTC_In($consultaSaldosTarjetaCredito1 as element(ns1:consultaSaldosTarjetaCredito))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:identidad>{ data($consultaSaldosTarjetaCredito1/CARD_HOLDER_ID) }</ns0:identidad>
            <ns0:tarjeta>{ data($consultaSaldosTarjetaCredito1/LAST_DIGITS_CARD) }</ns0:tarjeta>
        </ns0:InputParameters>
};

declare variable $consultaSaldosTarjetaCredito1 as element(ns1:consultaSaldosTarjetaCredito) external;

xf:ConsultaNumeroTC_In($consultaSaldosTarjetaCredito1)]]></con:xquery>
    <con:dependency location="../../ConsultaMaestraSaldosTarjetaCredito/xsd/consultaMaestraSaldosTarjetaCreditoTypes.xsd">
        <con:schema ref="Middleware/v3/Resources/ConsultaMaestraSaldosTarjetaCredito/xsd/consultaMaestraSaldosTarjetaCreditoTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ConsultaNoTC/xsd/CONSULTANUMEROTC_sp.xsd">
        <con:schema ref="Middleware/v3/BusinessServices/ConsultaNoTC/xsd/CONSULTANUMEROTC_sp"/>
    </con:dependency>
</con:xqueryEntry>