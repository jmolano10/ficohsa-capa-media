<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$sjConsultaSaldosTC1" element="ns2:sjConsultaSaldosTC" location="../xsd/sjConsultaSaldosTC.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InformacionTarjeta" location="../../../../../Business_Resources/tarjetaCredito/Resources/TarjetaDeCredito.wsdl" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaSaldosTC/xq/sjConsultaDatosTCIn/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSaldosTC";
declare namespace ns1 = "http://tempuri.org/";
declare namespace ns0 = "http://tempuri2.org/";

declare function xf:sjConsultaDatosTCIn($sjConsultaSaldosTC1 as element(ns2:sjConsultaSaldosTC))
    as element(ns1:InformacionTarjeta) {
        &lt;ns1:InformacionTarjeta>
        	&lt;ns1:noTarjetaCredito>{ data($sjConsultaSaldosTC1/CARD_NUMBER) }&lt;/ns1:noTarjetaCredito>
        &lt;/ns1:InformacionTarjeta>
};

declare variable $sjConsultaSaldosTC1 as element(ns2:sjConsultaSaldosTC) external;

xf:sjConsultaDatosTCIn($sjConsultaSaldosTC1)</con:xquery>
    <con:dependency location="../xsd/sjConsultaSaldosTC.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/SJS/consultaSaldosTC/xsd/sjConsultaSaldosTC"/>
    </con:dependency>
    <con:dependency location="../../../../../Business_Resources/tarjetaCredito/Resources/TarjetaDeCredito.wsdl">
        <con:wsdl ref="Middleware/Business_Resources/tarjetaCredito/Resources/TarjetaDeCredito"/>
    </con:dependency>
</con:xqueryEntry>