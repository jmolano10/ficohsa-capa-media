<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../../../../Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaPasivosCliente/sjConsultaTarjetaCredito/consultaSaldosTarjetaCreditoHeaderOut/";

declare function xf:consultaSaldosTarjetaCreditoHeaderOut()
as element(ns0:ResponseHeader) {
    &lt;ns0:ResponseHeader>
        &lt;successIndicator>SUCCESS&lt;/successIndicator>
    &lt;/ns0:ResponseHeader>
};


xf:consultaSaldosTarjetaCreditoHeaderOut()</con:xquery>
    <con:dependency location="../../../../../Resources/esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>