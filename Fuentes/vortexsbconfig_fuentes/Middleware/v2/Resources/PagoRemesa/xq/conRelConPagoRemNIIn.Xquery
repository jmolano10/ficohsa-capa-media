<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoRemesas" element="ns1:pagoRemesas" location="../xsd/pagoRemesas.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/consultaRelConPagoNI/xsd/consultaRelConPago_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesasTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRelConPago";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRemesa/xq/conRelConPagoRemNIIn/";

declare function xf:conRelConPagoRemNIIn($pagoRemesas as element(ns1:pagoRemesas))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CODIGOCONTRATO>{ data($pagoRemesas/REMITTER_ID) }</ns0:PV_CODIGOCONTRATO>
            <ns0:PV_CLAVEREMESA>{ data($pagoRemesas/REMITTANCE_ID) }</ns0:PV_CLAVEREMESA>
        </ns0:InputParameters>
};

declare variable $pagoRemesas as element(ns1:pagoRemesas) external;

xf:conRelConPagoRemNIIn($pagoRemesas)]]></con:xquery>
    <con:dependency location="../xsd/pagoRemesas.xsd">
        <con:schema ref="Middleware/v2/Resources/PagoRemesa/xsd/pagoRemesas"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/consultaRelConPagoNI/xsd/consultaRelConPago_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/consultaRelConPagoNI/xsd/consultaRelConPago_sp"/>
    </con:dependency>
</con:xqueryEntry>