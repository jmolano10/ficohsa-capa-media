xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaSaldosTarjetaCredito" element="ns0:consultaSaldosTarjetaCredito" location="../../../../Business_Resources/tarjetaCredito/ConsultaSaldosTarjetaCredito/consultaSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultarSaldos" location="../../../BusinessServices/ABKPA/transaccionesTCOnline/wsdl/WSDL.asmx.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace ns1 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/consultaSaldosTCPAIn1/";

declare function xf:consultaSaldosTCPAIn1($consultaSaldosTarjetaCredito as element(ns0:consultaSaldosTarjetaCredito))
    as element(ns1:consultarSaldos) {
        <ns1:consultarSaldos>
            <ns1:noTarjetaCredito>{ data($consultaSaldosTarjetaCredito/CARD_NUMBER) }</ns1:noTarjetaCredito>
        </ns1:consultarSaldos>
};

declare variable $consultaSaldosTarjetaCredito as element(ns0:consultaSaldosTarjetaCredito) external;

xf:consultaSaldosTCPAIn1($consultaSaldosTarjetaCredito)