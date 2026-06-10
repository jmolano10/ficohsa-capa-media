<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaBIN" element="ns0:consultaBIN" location="../../OperacionesTarjetaDebito/xsd/operacionesTarjetaDebitoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/consultaBin/xsd/consultaBin_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesTarjetaDebitoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaBin";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaBIN/xq/consultaBinGTIn/";

declare function xf:consultaBinGTIn($consultaBIN as element(ns0:consultaBIN))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_COMPANY>{ data($consultaBIN/COMPANY) }</ns1:PV_COMPANY>
            <ns1:PV_STATUS>{ data($consultaBIN/STATUS) }</ns1:PV_STATUS>
        </ns1:InputParameters>
};

declare variable $consultaBIN as element(ns0:consultaBIN) external;

xf:consultaBinGTIn($consultaBIN)]]></con:xquery>
    <con:dependency location="../../OperacionesTarjetaDebito/xsd/operacionesTarjetaDebitoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/OperacionesTarjetaDebito/xsd/operacionesTarjetaDebitoTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABKGT/consultaBin/xsd/consultaBin_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKGT/consultaBin/xsd/consultaBin_sp"/>
    </con:dependency>
</con:xqueryEntry>