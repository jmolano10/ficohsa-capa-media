(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCredito" element="ns0:pagoTarjetaCredito" location="../../xsds/PagoTarjetaCredito/PagoTarjetaCredito.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InformacionTarjeta" location="../../wsdls/Alcance.wsdl" ::)

declare namespace ns1 = "http://tempuri.org/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCredito";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoTarjetaCredito/ConsultaInformacionTarjetaIn/";

declare function xf:ConsultaInformacionTarjetaIn($pagoTarjetaCredito as element(ns0:pagoTarjetaCredito))
    as element(ns1:InformacionTarjeta) {
        <ns1:InformacionTarjeta>
            <ns1:noTarjetaCredito>{ data($pagoTarjetaCredito/CREDIT_CARD_NUMBER) }</ns1:noTarjetaCredito>
        </ns1:InformacionTarjeta>
};

declare variable $pagoTarjetaCredito as element(ns0:pagoTarjetaCredito) external;

xf:ConsultaInformacionTarjetaIn($pagoTarjetaCredito)