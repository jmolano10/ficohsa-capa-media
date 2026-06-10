<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDetalleLoteBilletera" element="ns0:consultaDetalleLoteBilletera" location="../xsd/pagosMasivosBilleteraPuenteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDetalleLoteBilletera" location="../../../BusinessServices/TENGO/PagoMasivoBilleteraPuente/xsd/PagosMasivosBilletera_1.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraPuenteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagosMasivosBilleteraPuente/xq/consultaDetalleLoteBilleteraPuenteIn/";

declare function xf:consultaDetalleLoteBilleteraPuenteIn($consultaDetalleLoteBilletera as element(ns0:consultaDetalleLoteBilletera))
    as element(ns1:consultaDetalleLoteBilletera) {
        <ns1:consultaDetalleLoteBilletera>
            <USERNAME>{ data($consultaDetalleLoteBilletera/USERNAME) }</USERNAME>
            <BANK_BATCH_ID>{ data($consultaDetalleLoteBilletera/BANK_BATCH_ID) }</BANK_BATCH_ID>
        </ns1:consultaDetalleLoteBilletera>
};

declare variable $consultaDetalleLoteBilletera as element(ns0:consultaDetalleLoteBilletera) external;

xf:consultaDetalleLoteBilleteraPuenteIn($consultaDetalleLoteBilletera)]]></con:xquery>
    <con:dependency location="../xsd/pagosMasivosBilleteraPuenteTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/PagosMasivosBilleteraPuente/xsd/pagosMasivosBilleteraPuenteTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/TENGO/PagoMasivoBilleteraPuente/xsd/PagosMasivosBilletera_1.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/TENGO/PagoMasivoBilleteraPuente/xsd/PagosMasivosBilletera_1"/>
    </con:dependency>
</con:xqueryEntry>