xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaSaldosTarjetaCredito1" element="ns0:consultaSaldosTarjetaCredito" location="../xsd/consultaSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultarSaldos" location="../../../BusinessServices/ABKGT/transaccionesTCOnline/wsdl/WSDL.asmx.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace ns1 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/consultaSaldosTCGTOnlineIn/";

declare function xf:consultaSaldosTCGTOnlineIn($consultaSaldosTarjetaCredito1 as element(ns0:consultaSaldosTarjetaCredito))
    as element(ns1:consultarSaldos) {
        <ns1:consultarSaldos>
            <ns1:noTarjetaCredito>{ data($consultaSaldosTarjetaCredito1/CARD_NUMBER) }</ns1:noTarjetaCredito>
        </ns1:consultarSaldos>
};

declare variable $consultaSaldosTarjetaCredito1 as element(ns0:consultaSaldosTarjetaCredito) external;

xf:consultaSaldosTCGTOnlineIn($consultaSaldosTarjetaCredito1)