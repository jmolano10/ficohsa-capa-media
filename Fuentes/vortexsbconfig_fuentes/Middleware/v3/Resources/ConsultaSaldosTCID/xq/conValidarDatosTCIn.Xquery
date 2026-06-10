<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaSaldosTarjetaCredito" element="ns0:consultaSaldosTarjetaCredito" location="../../ConsultaMaestraSaldosTarjetaCredito/xsd/consultaMaestraSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../../v2/BusinessServices/MasterDataHN/conValidarDatosTC/xsd/conValidarDatosTC_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaMaestraSaldosTarjetaCreditoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conValidarDatosTC";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaSaldosTCID/xq/conValidarDatosTCIn/";

declare function xf:conValidarDatosTCIn($consultaSaldosTarjetaCredito as element(ns0:consultaSaldosTarjetaCredito),
    $codigoPais as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:Pais>{ $codigoPais }</ns1:Pais>
            <ns1:NumCliente>{ data($consultaSaldosTarjetaCredito/CARD_HOLDER_ID) }</ns1:NumCliente>
            <ns1:NumTarjeta>{ data($consultaSaldosTarjetaCredito/LAST_DIGITS_CARD) }</ns1:NumTarjeta>
        </ns1:InputParameters>
};

declare variable $consultaSaldosTarjetaCredito as element(ns0:consultaSaldosTarjetaCredito) external;
declare variable $codigoPais as xs:string external;

xf:conValidarDatosTCIn($consultaSaldosTarjetaCredito,
    $codigoPais)]]></con:xquery>
    <con:dependency location="../../ConsultaMaestraSaldosTarjetaCredito/xsd/consultaMaestraSaldosTarjetaCreditoTypes.xsd">
        <con:schema ref="Middleware/v3/Resources/ConsultaMaestraSaldosTarjetaCredito/xsd/consultaMaestraSaldosTarjetaCreditoTypes"/>
    </con:dependency>
    <con:dependency location="../../../../v2/BusinessServices/MasterDataHN/conValidarDatosTC/xsd/conValidarDatosTC_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MasterDataHN/conValidarDatosTC/xsd/conValidarDatosTC_sp"/>
    </con:dependency>
</con:xqueryEntry>