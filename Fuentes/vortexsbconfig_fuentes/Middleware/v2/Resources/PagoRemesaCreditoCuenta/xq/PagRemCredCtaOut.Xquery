<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoRemesaCreditoCuenta1" element="ns0:pagoRemesaCreditoCuenta" location="../../../../Business_Resources/remesas/PagoRemesaCreditoCuenta/pagoRemesaCreditoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:pagoRemesaCreditoCuentaResponse" location="../../../../Business_Resources/remesas/PagoRemesaCreditoCuenta/pagoRemesaCreditoCuentaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesaCreditoCuentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRemesaCreditoCuenta/xq/PagRemCredCtaOut/";

declare function xf:PagRemCredCtaOut($pagoRemesaCreditoCuenta1 as element(ns0:pagoRemesaCreditoCuenta))
    as element(ns0:pagoRemesaCreditoCuentaResponse) {
        &lt;ns0:pagoRemesaCreditoCuentaResponse>
            &lt;REMITTANCE_ID>{ data($pagoRemesaCreditoCuenta1/REMITTANCE_ID) }&lt;/REMITTANCE_ID>
        &lt;/ns0:pagoRemesaCreditoCuentaResponse>
};

declare variable $pagoRemesaCreditoCuenta1 as element(ns0:pagoRemesaCreditoCuenta) external;

xf:PagRemCredCtaOut($pagoRemesaCreditoCuenta1)</con:xquery>
    <con:dependency location="../../../../Business_Resources/remesas/PagoRemesaCreditoCuenta/pagoRemesaCreditoCuentaTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/remesas/PagoRemesaCreditoCuenta/pagoRemesaCreditoCuentaTypes"/>
    </con:dependency>
</con:xqueryEntry>