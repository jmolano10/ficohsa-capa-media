<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaEstadoLoteResponse" element="ns1:ConsultaEstadoLoteResponse" location="../../../BusinessServices/TENGO/PagoMasivoBilletera/xsd/Services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaEstadoLoteBilleteraResponse" location="../../PagosMasivosBilletera/xsd/pagosMasivosBilleteraTypes.xsd" ::)

declare namespace ns1 = "http://main/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoLoteBilletera/xq/consultaEstadoLoteBilleteraOut/";

declare function xf:consultaEstadoLoteBilleteraOut($consultaEstadoLoteResponse as element(ns1:ConsultaEstadoLoteResponse))
    as element(ns0:consultaEstadoLoteBilleteraResponse) {
        <ns0:consultaEstadoLoteBilleteraResponse>
            <BATCH_DATE>{ data($consultaEstadoLoteResponse/return/fecha) }</BATCH_DATE>
            <DEBIT_WALLET>{ data($consultaEstadoLoteResponse/return/debBilletera) }</DEBIT_WALLET>
            <DEBIT_WALLET_NAME>{ data($consultaEstadoLoteResponse/return/nombreTitular) }</DEBIT_WALLET_NAME>
            <STATUS>{ data($consultaEstadoLoteResponse/return/codEstado) }</STATUS>
            <STATUS_DESCRIPTION>{ data($consultaEstadoLoteResponse/return/desEstado) }</STATUS_DESCRIPTION>
            <TOTAL_AMOUNT>{ data($consultaEstadoLoteResponse/return/montoTotal) }</TOTAL_AMOUNT>
            <TOTAL_AMOUNT_ERROR>{ data($consultaEstadoLoteResponse/return/montoError) }</TOTAL_AMOUNT_ERROR>
            <NUMBER_OF_TRANSACTIONS>{ data($consultaEstadoLoteResponse/return/numTrx) }</NUMBER_OF_TRANSACTIONS>
            <NUMBER_OF_TRANSACTIONS_SUCCESS>{ data($consultaEstadoLoteResponse/return/numTrxSuccess) }</NUMBER_OF_TRANSACTIONS_SUCCESS>
            <NUMBER_OF_TRANSACTIONS_ERROR>{ data($consultaEstadoLoteResponse/return/numTrxError) }</NUMBER_OF_TRANSACTIONS_ERROR>
        </ns0:consultaEstadoLoteBilleteraResponse>
};

declare variable $consultaEstadoLoteResponse as element(ns1:ConsultaEstadoLoteResponse) external;

xf:consultaEstadoLoteBilleteraOut($consultaEstadoLoteResponse)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/TENGO/PagoMasivoBilletera/xsd/Services.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/TENGO/PagoMasivoBilletera/xsd/Services"/>
    </con:dependency>
    <con:dependency location="../../PagosMasivosBilletera/xsd/pagosMasivosBilleteraTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/PagosMasivosBilletera/xsd/pagosMasivosBilleteraTypes"/>
    </con:dependency>
</con:xqueryEntry>