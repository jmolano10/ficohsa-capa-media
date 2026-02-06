xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaSaldosTarjetaCredito1" element="ns1:consultaSaldosTarjetaCredito" location="consultaSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultarSaldos" location="../Resources/TarjetaDeCredito.wsdl" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/ConsultaSaldosTarjetaCredito/consultaSaldosTarjetaCreditoIn/";

declare function xf:consultaSaldosTarjetaCreditoIn($consultaSaldosTarjetaCredito1 as element(ns1:consultaSaldosTarjetaCredito))
    as element(ns0:consultarSaldos) {
        <ns0:consultarSaldos>
            <ns0:noTarjetaCredito>{ data($consultaSaldosTarjetaCredito1/CARD_NUMBER) }</ns0:noTarjetaCredito>
        </ns0:consultarSaldos>
};

declare variable $consultaSaldosTarjetaCredito1 as element(ns1:consultaSaldosTarjetaCredito) external;

xf:consultaSaldosTarjetaCreditoIn($consultaSaldosTarjetaCredito1)