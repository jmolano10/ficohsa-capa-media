<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaMaestraSaldosTarjetaCredito1" element="ns1:consultaMaestraSaldosTarjetaCredito" location="../xsd/consultaMaestraSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../v2/BusinessServices/MasterDataGT/conMaestroSaldos/xsd/ConsultaMaestroSaldosTarjetaCredito_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaMaestroSaldosTarjetaCredito";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMaestraSaldosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaMaestraSaldosTarjetaCredito/xq/conMaestroSaldosTCGTIn/";

declare function xf:conMaestroSaldosTCGTIn(
	$cardNumber as xs:string,
	$codigoPais as xs:string,
    $org as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ data($codigoPais) }</ns0:Pais>
            <ns0:Org>{ data($org) }</ns0:Org>
            <ns0:NumTarjeta>{ data($cardNumber) }</ns0:NumTarjeta>
        </ns0:InputParameters>
};

declare variable $cardNumber as xs:string external;
declare variable $codigoPais as xs:string external;
declare variable $org as xs:string external;

xf:conMaestroSaldosTCGTIn($cardNumber, 
	$codigoPais, 
	$org)]]></con:xquery>
    <con:dependency location="../xsd/consultaMaestraSaldosTarjetaCreditoTypes.xsd">
        <con:schema ref="Middleware/v3/Resources/ConsultaMaestraSaldosTarjetaCredito/xsd/consultaMaestraSaldosTarjetaCreditoTypes"/>
    </con:dependency>
    <con:dependency location="../../../../v2/BusinessServices/MasterDataGT/conMaestroSaldos/xsd/ConsultaMaestroSaldosTarjetaCredito_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MasterDataGT/conMaestroSaldos/xsd/ConsultaMaestroSaldosTarjetaCredito_sp"/>
    </con:dependency>
</con:xqueryEntry>