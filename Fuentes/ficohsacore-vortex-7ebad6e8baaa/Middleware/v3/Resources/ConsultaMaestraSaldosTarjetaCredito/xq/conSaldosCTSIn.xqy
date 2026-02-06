xquery version "2004-draft";
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
    $pais)