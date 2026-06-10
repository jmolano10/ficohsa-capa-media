<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCredito" element="ns1:pagoTarjetaCredito" location="../xsd/pagoTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDetallesCuenta" location="../../../../v2/Resources/ConsultaDetallesCuenta/xsd/consultaDetallesCuentaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoTarjetaCredito/xq/consultaDetallesCuentaGTIn/";

declare function xf:consultaDetallesCuentaGTIn($pagoTarjetaCredito as element(ns1:pagoTarjetaCredito))
    as element(ns0:consultaDetallesCuenta) {
        &lt;ns0:consultaDetallesCuenta>
            &lt;ACCOUNT_NUMBER>{ data($pagoTarjetaCredito/DEBIT_ACCOUNT) }&lt;/ACCOUNT_NUMBER>
        &lt;/ns0:consultaDetallesCuenta>
};

declare variable $pagoTarjetaCredito as element(ns1:pagoTarjetaCredito) external;

xf:consultaDetallesCuentaGTIn($pagoTarjetaCredito)</con:xquery>
    <con:dependency location="../xsd/pagoTarjetaCreditoTypes.xsd">
        <con:schema ref="Middleware/v4/Resources/PagoTarjetaCredito/xsd/pagoTarjetaCreditoTypes"/>
    </con:dependency>
    <con:dependency location="../../../../v2/Resources/ConsultaDetallesCuenta/xsd/consultaDetallesCuentaTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaDetallesCuenta/xsd/consultaDetallesCuentaTypes"/>
    </con:dependency>
</con:xqueryEntry>