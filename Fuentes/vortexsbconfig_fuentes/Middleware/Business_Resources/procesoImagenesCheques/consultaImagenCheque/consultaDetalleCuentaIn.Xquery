<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaDetallesCuenta" location="../../ConsultasCuenta/Resources/consultasGeneralesCuentasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/procesoImagenesCheques/consultaImagenCheque/consultaDetalleCuentaIn/";

declare function xf:consultaDetalleCuentaIn($accountNumber as xs:string)
    as element(ns0:consultaDetallesCuenta) {
        &lt;ns0:consultaDetallesCuenta>
            &lt;ACCOUNT_NUMBER>{ $accountNumber }&lt;/ACCOUNT_NUMBER>
        &lt;/ns0:consultaDetallesCuenta>
};

declare variable $accountNumber as xs:string external;

xf:consultaDetalleCuentaIn($accountNumber)</con:xquery>
    <con:dependency location="../../ConsultasCuenta/Resources/consultasGeneralesCuentasTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/ConsultasCuenta/Resources/consultasGeneralesCuentasTypes"/>
    </con:dependency>
</con:xqueryEntry>