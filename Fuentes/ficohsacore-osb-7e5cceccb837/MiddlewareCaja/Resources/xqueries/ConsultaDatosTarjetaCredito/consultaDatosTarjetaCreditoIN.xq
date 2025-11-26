xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaDatosTarjetaCredito1" element="ns2:consultaDatosTarjetaCredito" location="../../xsds/ConsultaDatosTarjetaCredito/consultaDatosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InformacionTarjeta" location="../../wsdls/TarjetaDeCredito.wsdl" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaDatosTarjetaCredito/consultaDatosTarjetaCreditoIn/";
declare namespace ns0 = "http://tempuri2.org/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace ns1 = "http://tempuri.org/";

declare function xf:consultaDatosTarjetaCreditoIn($consultaDatosTarjetaCredito1 as element(ns2:consultaDatosTarjetaCredito))
    as element(ns1:InformacionTarjeta) {
        <ns1:InformacionTarjeta>
            <ns1:noTarjetaCredito>{ data($consultaDatosTarjetaCredito1/CARD_NUMBER) }</ns1:noTarjetaCredito>
        </ns1:InformacionTarjeta>
};

declare variable $consultaDatosTarjetaCredito1 as element(ns2:consultaDatosTarjetaCredito) external;

xf:consultaDatosTarjetaCreditoIn($consultaDatosTarjetaCredito1)
