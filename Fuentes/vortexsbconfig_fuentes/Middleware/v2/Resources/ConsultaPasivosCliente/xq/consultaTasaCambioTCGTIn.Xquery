<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/consultaTasaCambio/xsd/ConsultaTasaCambio_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaTasaCambio";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaPasivosCliente/xq/consultaTasaCambioTCIn/";

declare function xf:consultaTasaCambioTCIn()
as element(ns0:InputParameters) {
    <ns0:InputParameters>
        <ns0:FROM_CURRENCY>GTQ</ns0:FROM_CURRENCY>
        <ns0:TO_CURRENCY>USD</ns0:TO_CURRENCY>
    </ns0:InputParameters>
};


xf:consultaTasaCambioTCIn()]]></con:xquery>
    <con:dependency location="../../../BusinessServices/ABKGT/consultaTasaCambio/xsd/ConsultaTasaCambio_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKGT/consultaTasaCambio/xsd/ConsultaTasaCambio_sp"/>
    </con:dependency>
</con:xqueryEntry>