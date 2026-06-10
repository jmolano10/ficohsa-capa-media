<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaSaldosTC1" element="ns1:sjConsultaSaldosTC" location="../xsd/sjConsultaSaldosTC.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultarSaldos" location="../../../../../Business_Resources/tarjetaCredito/Resources/TarjetaDeCredito.wsdl" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSaldosTC";
declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaSaldosTC/xq/sjConsultaSaldosTCIn/";

declare function xf:sjConsultaSaldosTCIn($sjConsultaSaldosTC1 as element(ns1:sjConsultaSaldosTC))
    as element(ns0:consultarSaldos) {
        &lt;ns0:consultarSaldos>
            &lt;ns0:noTarjetaCredito>{ data($sjConsultaSaldosTC1/CARD_NUMBER) }&lt;/ns0:noTarjetaCredito>
        &lt;/ns0:consultarSaldos>
};

declare variable $sjConsultaSaldosTC1 as element(ns1:sjConsultaSaldosTC) external;

xf:sjConsultaSaldosTCIn($sjConsultaSaldosTC1)</con:xquery>
    <con:dependency location="../xsd/sjConsultaSaldosTC.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/SJS/consultaSaldosTC/xsd/sjConsultaSaldosTC"/>
    </con:dependency>
    <con:dependency location="../../../../../Business_Resources/tarjetaCredito/Resources/TarjetaDeCredito.wsdl">
        <con:wsdl ref="Middleware/Business_Resources/tarjetaCredito/Resources/TarjetaDeCredito"/>
    </con:dependency>
</con:xqueryEntry>