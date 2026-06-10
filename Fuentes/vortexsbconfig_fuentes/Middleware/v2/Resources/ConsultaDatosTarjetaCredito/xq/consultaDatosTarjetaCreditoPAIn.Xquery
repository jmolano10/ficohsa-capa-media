<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaDatosTarjetaCredito" element="ns2:consultaDatosTarjetaCredito" location="../../../../Business_Resources/tarjetaCredito/ConsultaDatosTarjetaCredito/consultaDatosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InformacionTarjeta" location="../../../BusinessServices/ALCN/tarjetaCredito/wsdl/TarjetaDeCredito.wsdl" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatosTarjetaCredito/xq/consultaDatosTarjetaCreditoPAIn/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace ns1 = "http://tempuri.org/";

declare function xf:consultaDatosTarjetaCreditoPAIn($consultaDatosTarjetaCredito as element(ns2:consultaDatosTarjetaCredito))
    as element(ns1:InformacionTarjeta) {
        &lt;ns1:InformacionTarjeta>
            &lt;ns1:noTarjetaCredito>{ data($consultaDatosTarjetaCredito/CARD_NUMBER) }&lt;/ns1:noTarjetaCredito>
        &lt;/ns1:InformacionTarjeta>
};

declare variable $consultaDatosTarjetaCredito as element(ns2:consultaDatosTarjetaCredito) external;

xf:consultaDatosTarjetaCreditoPAIn($consultaDatosTarjetaCredito)</con:xquery>
    <con:dependency location="../../../../Business_Resources/tarjetaCredito/ConsultaDatosTarjetaCredito/consultaDatosTarjetaCreditoTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/tarjetaCredito/ConsultaDatosTarjetaCredito/consultaDatosTarjetaCreditoTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ALCN/tarjetaCredito/wsdl/TarjetaDeCredito.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/ALCN/tarjetaCredito/wsdl/TarjetaDeCredito"/>
    </con:dependency>
</con:xqueryEntry>