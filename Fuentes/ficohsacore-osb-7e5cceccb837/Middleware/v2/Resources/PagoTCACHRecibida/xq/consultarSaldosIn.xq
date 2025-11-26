(:: pragma bea:global-element-parameter parameter="$pagoTCACHRecibida" element="ns1:pagoTCACHRecibida" location="../xsd/pagoTCACHRecibida.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultarSaldosVasa" location="../../../BusinessServices/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns0 = "http://alcance.local/wsinfotarjetas/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTCACHRecibida";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoTCACHRecibida/xq/consultarSaldosIn/";

declare function xf:consultarSaldosIn($pagoTCACHRecibida as element(ns1:pagoTCACHRecibida))
    as element(ns0:ConsultarSaldosVasa) {
        <ns0:ConsultarSaldosVasa>
            <ns0:noTarjetaCredito>{ data($pagoTCACHRecibida/CREDIT_CARD_NUMBER) }</ns0:noTarjetaCredito>
        </ns0:ConsultarSaldosVasa>
};

declare variable $pagoTCACHRecibida as element(ns1:pagoTCACHRecibida) external;

xf:consultarSaldosIn($pagoTCACHRecibida)