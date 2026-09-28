(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCredito1" element="ns1:pagoTarjetaCredito" location="pagoTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultarSaldosVasa" location="../../../v2/BusinessServices/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns0 = "http://alcance.local/wsinfotarjetas/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/PagoTarjetaCredito/consultaSaldoTarjetaCreditoIn/";

declare function xf:consultaSaldoTarjetaCreditoIn($pagoTarjetaCredito1 as element(ns1:pagoTarjetaCredito))
    as element(ns0:ConsultarSaldosVasa) {
        <ns0:ConsultarSaldosVasa>
            <ns0:noTarjetaCredito>{ data($pagoTarjetaCredito1/CREDIT_CARD_NUMBER) }</ns0:noTarjetaCredito>
        </ns0:ConsultarSaldosVasa>
};

declare variable $pagoTarjetaCredito1 as element(ns1:pagoTarjetaCredito) external;

xf:consultaSaldoTarjetaCreditoIn($pagoTarjetaCredito1)