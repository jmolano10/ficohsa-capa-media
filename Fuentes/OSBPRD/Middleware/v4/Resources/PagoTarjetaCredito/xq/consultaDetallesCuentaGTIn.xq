(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCredito" element="ns1:pagoTarjetaCredito" location="../xsd/pagoTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDetallesCuenta" location="../../../../v2/Resources/ConsultaDetallesCuenta/xsd/consultaDetallesCuentaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoTarjetaCredito/xq/consultaDetallesCuentaGTIn/";

declare function xf:consultaDetallesCuentaGTIn($pagoTarjetaCredito as element(ns1:pagoTarjetaCredito))
    as element(ns0:consultaDetallesCuenta) {
        <ns0:consultaDetallesCuenta>
            <ACCOUNT_NUMBER>{ data($pagoTarjetaCredito/DEBIT_ACCOUNT) }</ACCOUNT_NUMBER>
        </ns0:consultaDetallesCuenta>
};

declare variable $pagoTarjetaCredito as element(ns1:pagoTarjetaCredito) external;

xf:consultaDetallesCuentaGTIn($pagoTarjetaCredito)