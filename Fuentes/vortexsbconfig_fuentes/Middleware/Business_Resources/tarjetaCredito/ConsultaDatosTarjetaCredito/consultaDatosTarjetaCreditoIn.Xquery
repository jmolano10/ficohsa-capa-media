<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDatosTarjetaCredito1" element="ns0:consultaDatosTarjetaCredito" location="consultaDatosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns1:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InformacionTarjeta" location="../Resources/TarjetaDeCredito.wsdl" ::)

declare namespace ns2 = "http://tempuri.org/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/PagoTarjetaCredito/ConsultaDatosTarjetaCredito/consultaDatosTarjetaCreditoIn/";

declare function xf:consultaDatosTarjetaCreditoIn($consultaDatosTarjetaCredito1 as element(ns0:consultaDatosTarjetaCredito),
    $autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader))
    as element(ns2:InformacionTarjeta) {
        &lt;ns2:InformacionTarjeta>
            &lt;ns2:noTarjetaCredito>{ data($consultaDatosTarjetaCredito1/CARD_NUMBER) }&lt;/ns2:noTarjetaCredito>
        &lt;/ns2:InformacionTarjeta>
};

declare variable $consultaDatosTarjetaCredito1 as element(ns0:consultaDatosTarjetaCredito) external;
declare variable $autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader) external;

xf:consultaDatosTarjetaCreditoIn($consultaDatosTarjetaCredito1,
    $autenticacionRequestHeader1)</con:xquery>
    <con:dependency location="consultaDatosTarjetaCreditoTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/tarjetaCredito/ConsultaDatosTarjetaCredito/consultaDatosTarjetaCreditoTypes"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/Business_Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
    <con:dependency location="../Resources/TarjetaDeCredito.wsdl">
        <con:wsdl ref="Middleware/Business_Resources/tarjetaCredito/Resources/TarjetaDeCredito"/>
    </con:dependency>
</con:xqueryEntry>