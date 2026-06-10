<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaEstadoLoteBilletera" element="ns0:consultaEstadoLoteBilletera" location="../xsd/pagosMasivosBilleteraPuenteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaEstadoLoteBilletera" location="../../../BusinessServices/TENGO/PagoMasivoBilleteraPuente/xsd/PagosMasivosBilletera_1.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraPuenteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagosMasivosBilleteraPuente/xq/consultaEstadoLoteBilleteraPuenteIn/";

declare function xf:consultaEstadoLoteBilleteraPuenteIn($consultaEstadoLoteBilletera as element(ns0:consultaEstadoLoteBilletera))
    as element(ns1:consultaEstadoLoteBilletera) {
        <ns1:consultaEstadoLoteBilletera>
            <USERNAME>{ data($consultaEstadoLoteBilletera/USERNAME) }</USERNAME>
            <DEBIT_WALLET>{ data($consultaEstadoLoteBilletera/DEBIT_WALLET) }</DEBIT_WALLET>
            <BANK_BATCH_ID>{ data($consultaEstadoLoteBilletera/BANK_BATCH_ID) }</BANK_BATCH_ID>
        </ns1:consultaEstadoLoteBilletera>
};

declare variable $consultaEstadoLoteBilletera as element(ns0:consultaEstadoLoteBilletera) external;

xf:consultaEstadoLoteBilleteraPuenteIn($consultaEstadoLoteBilletera)]]></con:xquery>
    <con:dependency location="../xsd/pagosMasivosBilleteraPuenteTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/PagosMasivosBilleteraPuente/xsd/pagosMasivosBilleteraPuenteTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/TENGO/PagoMasivoBilleteraPuente/xsd/PagosMasivosBilletera_1.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/TENGO/PagoMasivoBilleteraPuente/xsd/PagosMasivosBilletera_1"/>
    </con:dependency>
</con:xqueryEntry>