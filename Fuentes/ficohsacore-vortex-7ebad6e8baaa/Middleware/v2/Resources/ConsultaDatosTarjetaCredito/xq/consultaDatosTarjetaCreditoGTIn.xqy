xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaDatosTarjetaCredito" element="ns2:consultaDatosTarjetaCredito" location="../../../../Business_Resources/tarjetaCredito/ConsultaDatosTarjetaCredito/consultaDatosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InformacionTarjeta" location="../../../BusinessServices/ALCN/tarjetaCredito/wsdl/TarjetaDeCredito.wsdl" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatosTarjetaCredito/xq/consultaDatosTarjetaCreditoGTIn/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace ns1 = "http://tempuri.org/";

declare function xf:consultaDatosTarjetaCreditoGTIn($consultaDatosTarjetaCredito as element(ns2:consultaDatosTarjetaCredito))
    as element(ns1:InformacionTarjeta) {
        <ns1:InformacionTarjeta>
            <ns1:noTarjetaCredito>{ data($consultaDatosTarjetaCredito/CARD_NUMBER) }</ns1:noTarjetaCredito>
        </ns1:InformacionTarjeta>
};

declare variable $consultaDatosTarjetaCredito as element(ns2:consultaDatosTarjetaCredito) external;

xf:consultaDatosTarjetaCreditoGTIn($consultaDatosTarjetaCredito)