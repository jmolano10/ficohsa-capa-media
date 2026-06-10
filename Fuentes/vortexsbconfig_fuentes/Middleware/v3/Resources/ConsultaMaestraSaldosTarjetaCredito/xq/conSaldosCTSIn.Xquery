<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaMaestraSaldosTarjetaCredito" element="ns0:consultaMaestraSaldosTarjetaCredito" location="../xsd/consultaMaestraSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../../v2/BusinessServices/MasterData/conSaldosCTS/xsd/consultaSaldosCTS_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaMaestraSaldosTarjetaCreditoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaSaldosCTS";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaMaestraSaldosTarjetaCredito/xq/conSaldosCTSIn/";

declare function xf:conSaldosCTSIn($consultaMaestraSaldosTarjetaCredito as element(ns0:consultaMaestraSaldosTarjetaCredito),
    $pais as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:Pais>{ $pais }</ns1:Pais>
            <ns1:Org>{ data($consultaMaestraSaldosTarjetaCredito/ORG) }</ns1:Org>
            <ns1:NumTarjeta>{ fn-bea:pad-left(string($consultaMaestraSaldosTarjetaCredito/CARD_NUMBER/text()),19,'0')}</ns1:NumTarjeta>
        </ns1:InputParameters>
};

declare variable $consultaMaestraSaldosTarjetaCredito as element(ns0:consultaMaestraSaldosTarjetaCredito) external;
declare variable $pais as xs:string external;

xf:conSaldosCTSIn($consultaMaestraSaldosTarjetaCredito,
    $pais)]]></con:xquery>
    <con:dependency location="../xsd/consultaMaestraSaldosTarjetaCreditoTypes.xsd">
        <con:schema ref="Middleware/v3/Resources/ConsultaMaestraSaldosTarjetaCredito/xsd/consultaMaestraSaldosTarjetaCreditoTypes"/>
    </con:dependency>
    <con:dependency location="../../../../v2/BusinessServices/MasterData/conSaldosCTS/xsd/consultaSaldosCTS_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MasterData/conSaldosCTS/xsd/consultaSaldosCTS_sp"/>
    </con:dependency>
</con:xqueryEntry>